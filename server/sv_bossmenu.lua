local QBCore = exports['qb-core']:GetCoreObject()

local function Notify(src, description, color)
    lib.notify(src, {
        id = 'burger_shot',
        title = 'Burgershot',
        description = description,
        showDuration = false,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = color or '#F08080',
            ['.description'] = { color = '#909296' }
        },
        icon = 'user-tie',
        iconColor = color or '#F08080'
    })
end

local function GetBossPlayer(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return nil, 'Something went wrong.' end
    if Player.PlayerData.job.name ~= Config.Jobname then return nil, 'You are not employed here.' end
    if not Player.PlayerData.job.isboss then return nil, 'You do not have management permissions.' end
    return Player, nil
end

local function GetSocietyBalance()
    local ok, balance = pcall(function()
        if Config.BankSystem == 'renewed' then
            return exports['Renewed-Banking']:getAccountMoney(Config.SocietyAccount)
        elseif Config.BankSystem == 'qb' then
            return exports['qb-management']:GetAccount(Config.SocietyAccount)
        elseif Config.BankSystem == 'nfs' then
            return exports['nfs-billing']:getSocietyBalance(Config.SocietyAccount)
        end
    end)
    return tonumber(balance) or 0
end

local function LogTransaction(txType, amount, description)
    if txType ~= 'in' and txType ~= 'out' then return end
    amount = tonumber(amount) or 0
    if amount <= 0 then return end

    exports.oxmysql:insert('INSERT INTO burgershot_transactions (type, amount, description) VALUES (?, ?, ?)', {
        txType, amount, description or ''
    })
end

exports('LogBossTransaction', LogTransaction)

exports('GetSocietyBalance', GetSocietyBalance)

local function FetchTransactions(limit)
    return exports.oxmysql:executeSync(
        'SELECT type, amount, description, created_at FROM burgershot_transactions ORDER BY id DESC LIMIT ?',
        { limit or 25 }
    ) or {}
end

local function GetJobGrades()
    local grades = {}
    local jobGrades = QBCore.Shared.Jobs[Config.Jobname] and QBCore.Shared.Jobs[Config.Jobname].grades or {}
    local maxGrade = 0
    for level, grade in pairs(jobGrades) do
        local lvl = tonumber(level)
        grades[#grades + 1] = { level = lvl, name = grade.name, isboss = grade.isboss or false }
        if lvl > maxGrade then maxGrade = lvl end
    end
    table.sort(grades, function(a, b) return a.level < b.level end)
    return grades, maxGrade
end

local function GetGradeName(level)
    local jobGrades = QBCore.Shared.Jobs[Config.Jobname] and QBCore.Shared.Jobs[Config.Jobname].grades or {}
    local grade = jobGrades[tostring(level)]
    return grade and grade.name or ('Grade ' .. tostring(level))
end

local function BuildJobObject(jobName, gradeLevel)
    local jobData = QBCore.Shared.Jobs[jobName]
    if not jobData then return nil end
    local gradeData = jobData.grades[tostring(gradeLevel)]
    if not gradeData then return nil end
    return {
        id = jobName,
        name = jobName,
        label = jobData.label,
        payment = gradeData.payment,
        onduty = false,
        isboss = gradeData.isboss or false,
        grade = { name = gradeData.name, level = gradeLevel },
    }
end

local function SafeDecode(raw)
    if type(raw) == 'table' then return raw end
    if type(raw) ~= 'string' then return {} end
    local ok, decoded = pcall(json.decode, raw)
    return ok and decoded or {}
end

local function FetchEmployeesFromDB()
    local rows = exports.oxmysql:executeSync('SELECT citizenid, charinfo, job FROM players', {})
    local employees = {}
    for _, row in ipairs(rows or {}) do
        local job = SafeDecode(row.job)
        if job and job.name == Config.Jobname then
            local charinfo = SafeDecode(row.charinfo)
            local gradeLevel = (job.grade and job.grade.level) or 0

            local TargetPlayer = QBCore.Functions.GetPlayerByCitizenId(row.citizenid)
            local online = TargetPlayer ~= nil
            local onduty = online and (TargetPlayer.PlayerData.job.onduty and true or false) or false

            employees[#employees + 1] = {
                citizenid = row.citizenid,
                name = charinfo and (('%s %s'):format(charinfo.firstname or '?', charinfo.lastname or '')) or row.citizenid,
                grade = gradeLevel,
                gradeName = (job.grade and job.grade.name) or GetGradeName(gradeLevel),
                online = online,
                onduty = onduty,
            }
        end
    end
    table.sort(employees, function(a, b) return a.grade > b.grade end)
    return employees
end

local function UpdateEmployeeJobInDB(citizenid, jobName, gradeLevel)
    local jobObj = BuildJobObject(jobName, gradeLevel)
    if not jobObj then return false end
    exports.oxmysql:update('UPDATE players SET job = ? WHERE citizenid = ?', { json.encode(jobObj), citizenid })
    return true
end

local function BuildBossPayload(ok, err)
    local grades, maxGrade = GetJobGrades()

    local activeSupplyOrder = nil
    local ok2, result = pcall(function() return exports['bd-burgershot']:GetActiveSupplyOrder() end)
    if ok2 then activeSupplyOrder = result end

    local stock = { containers = {}, items = {} }
    local ok3, result3 = pcall(function() return exports['bd-burgershot']:GetStockData() end)
    if ok3 and result3 then stock = result3 end

    return {
        ok = ok,
        error = err,
        employees = FetchEmployeesFromDB(),
        grades = grades,
        maxGrade = maxGrade,
        balance = GetSocietyBalance(),
        transactions = FetchTransactions(25),
        supplyMenu = Config.SupplyOrderItems,
        activeSupplyOrder = activeSupplyOrder,
        stock = stock,
    }
end

lib.callback.register('bd-burgershot:server:GetBossMenuData', function(source)
    local Player, err = GetBossPlayer(source)
    if not Player then return { ok = false, error = err } end
    return BuildBossPayload(true, nil)
end)

lib.callback.register('bd-burgershot:server:BossHire', function(source, targetServerId)
    local Player, err = GetBossPlayer(source)
    if not Player then return BuildBossPayload(false, err) end

    targetServerId = tonumber(targetServerId)
    if not targetServerId then return BuildBossPayload(false, 'Enter a valid server ID.') end

    local TargetPlayer = QBCore.Functions.GetPlayer(targetServerId)
    if not TargetPlayer then return BuildBossPayload(false, 'That player is not online.') end

    if TargetPlayer.PlayerData.job.name == Config.Jobname then
        return BuildBossPayload(false, 'That player already works here.')
    end

    if not TargetPlayer.Functions.SetJob(Config.Jobname, 0) then
        return BuildBossPayload(false, 'Failed to hire that player.')
    end
    TargetPlayer.Functions.Save()

    Notify(targetServerId, ('You have been hired at %s!'):format(
        (QBCore.Shared.Jobs[Config.Jobname] and QBCore.Shared.Jobs[Config.Jobname].label) or 'Burgershot'
    ), '#8fd694')
    Notify(source, 'Employee hired.', '#8fd694')

    return BuildBossPayload(true, nil)
end)

lib.callback.register('bd-burgershot:server:BossFire', function(source, citizenid)
    local Player, err = GetBossPlayer(source)
    if not Player then return BuildBossPayload(false, err) end
    if not citizenid then return BuildBossPayload(false, 'Missing employee.') end

    local TargetPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if TargetPlayer then
        TargetPlayer.Functions.SetJob('unemployed', 0)
        TargetPlayer.Functions.Save()
        Notify(TargetPlayer.PlayerData.source, 'You have been let go from Burgershot.')
    else
        UpdateEmployeeJobInDB(citizenid, 'unemployed', 0)
    end

    Notify(source, 'Employee fired.', '#8fd694')
    return BuildBossPayload(true, nil)
end)

local function ChangeGrade(source, citizenid, delta)
    local Player, err = GetBossPlayer(source)
    if not Player then return BuildBossPayload(false, err) end
    if not citizenid then return BuildBossPayload(false, 'Missing employee.') end

    local _, maxGrade = GetJobGrades()

    local TargetPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    local currentGrade

    if TargetPlayer then
        currentGrade = TargetPlayer.PlayerData.job.grade.level
    else
        local rows = exports.oxmysql:executeSync('SELECT job FROM players WHERE citizenid = ?', { citizenid })
        local job = rows and rows[1] and SafeDecode(rows[1].job)
        currentGrade = (job and job.grade and job.grade.level) or 0
    end

    local newGrade = math.max(0, math.min(maxGrade, currentGrade + delta))
    if newGrade == currentGrade then
        return BuildBossPayload(false, delta > 0 and 'Already at the highest grade.' or 'Already at the lowest grade.')
    end

    if TargetPlayer then
        TargetPlayer.Functions.SetJob(Config.Jobname, newGrade)
        TargetPlayer.Functions.Save()
        Notify(TargetPlayer.PlayerData.source, ('You have been %s to %s.'):format(
            delta > 0 and 'promoted' or 'demoted', GetGradeName(newGrade)
        ), '#8fd694')
    else
        UpdateEmployeeJobInDB(citizenid, Config.Jobname, newGrade)
    end

    Notify(source, delta > 0 and 'Employee promoted.' or 'Employee demoted.', '#8fd694')
    return BuildBossPayload(true, nil)
end

lib.callback.register('bd-burgershot:server:BossPromote', function(source, citizenid)
    return ChangeGrade(source, citizenid, 1)
end)

lib.callback.register('bd-burgershot:server:BossDemote', function(source, citizenid)
    return ChangeGrade(source, citizenid, -1)
end)