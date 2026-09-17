local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = Config.InventorySystem == 'ox' and exports.ox_inventory or nil

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
        icon = 'truck',
        iconColor = color or '#F08080'
    })
end

local SupplyItemLookup = {}
for _, cat in ipairs(Config.SupplyOrderItems) do
    for _, entry in ipairs(cat.items) do
        SupplyItemLookup[entry.item] = entry
    end
end

local activeOrder = nil

local function GetBossPlayer(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return nil, 'Something went wrong.' end
    if Player.PlayerData.job.name ~= Config.Jobname then return nil, 'You are not employed here.' end
    if not Player.PlayerData.job.isboss then return nil, 'You do not have management permissions.' end
    return Player, nil
end

local function WithdrawSociety(amount)
    local ok, result = pcall(function()
        if Config.BankSystem == 'qb' then
            return exports['qb-banking']:RemoveMoney(Config.SocietyAccount, amount)
        elseif Config.BankSystem == 'renewed' then
            return exports['Renewed-Banking']:removeAccountMoney(Config.SocietyAccount, amount)
        elseif Config.BankSystem == 'nfs' then
            return exports['nfs-billing']:withdrawSociety(Config.SocietyAccount, amount)
        end
    end)
    return ok and result ~= false
end

local function DepositSociety(amount)
    local ok, result = pcall(function()
        if Config.BankSystem == 'qb' then
            return exports['qb-banking']:AddMoney(Config.SocietyAccount, amount)
        elseif Config.BankSystem == 'renewed' then
            return exports['Renewed-Banking']:addAccountMoney(Config.SocietyAccount, amount)
        elseif Config.BankSystem == 'nfs' then
            return exports['nfs-billing']:depositSociety(Config.SocietyAccount, amount)
        end
    end)
    return ok and result ~= false
end

local function GetOnDutyBurgershotPlayers()
    local players = {}
    for _, playerId in ipairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
        if Player and Player.PlayerData.job.name == Config.Jobname then
            players[#players + 1] = Player.PlayerData.source
        end
    end
    return players
end

lib.callback.register('bd-burgershot:server:BossOrderSupplies', function(source, cart)
    local Player, err = GetBossPlayer(source)
    if not Player then return { ok = false, error = err } end

    if activeOrder then
        return { ok = false, error = 'There is already a supply order in progress.' }
    end

    if type(cart) ~= 'table' or #cart == 0 then
        return { ok = false, error = 'Your cart is empty.' }
    end

    local lines, total = {}, 0
    for _, line in ipairs(cart) do
        local def = line and SupplyItemLookup[line.item]
        local qty = def and tonumber(line.qty) or 0
        if def and qty > 0 then
            total = total + (def.price * qty)
            lines[#lines + 1] = {
                item = def.item,
                label = def.label,
                qty = qty,
                amount = def.amount * qty,
            }
        end
    end

    if #lines == 0 or total <= 0 then
        return { ok = false, error = 'Your cart is invalid.' }
    end

    local balance = exports['bd-burgershot']:GetSocietyBalance()
    if balance < total then
        return { ok = false, error = ('Insufficient funds. Balance: $%d, order total: $%d.'):format(balance, total) }
    end

    if not WithdrawSociety(total) then
        return { ok = false, error = 'Something went wrong taking payment from the society account.' }
    end

    local orderId = ('SO-%05d'):format(math.random(0, 99999))

    local descLines = {}
    for _, line in ipairs(lines) do
        descLines[#descLines + 1] = ('%dx %s'):format(line.qty, line.label)
    end
    local summary = table.concat(descLines, ', ')

    exports['bd-burgershot']:LogBossTransaction('out', total, ('Supply Order #%s - %s'):format(orderId, summary))

    local area = Config.SupplyVanSpawns[math.random(1, #Config.SupplyVanSpawns)]

    activeOrder = {
        id = orderId,
        lines = lines,
        total = total,
        orderedBy = Player.PlayerData.citizenid,
        pedCoords = area.pedCoords,
        vehicleCoords = area.vehicleCoords,
        claimed = false,
        claimedBy = nil,
    }

    for _, playerSrc in ipairs(GetOnDutyBurgershotPlayers()) do
        TriggerClientEvent('bd-burgershot:client:SupplyOrderReady', playerSrc, {
            id = orderId,
            pedCoords = area.pedCoords,
            dropzone = Config.SupplyDropzone,
            summary = summary,
        })
    end

    Notify(source, ('Order #%s placed for $%d. A supply van is on its way to a pickup point.'):format(orderId, total), '#8fd694')

    return { ok = true, orderId = orderId }
end)

RegisterNetEvent('bd-burgershot:server:ClaimSupplyVan', function(orderId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or Player.PlayerData.job.name ~= Config.Jobname then return end
    if not activeOrder or activeOrder.id ~= orderId or activeOrder.claimed then return end

    activeOrder.claimed = true
    activeOrder.claimedBy = src

    TriggerClientEvent('bd-burgershot:client:SupplyVanClaimed', -1, orderId, src)
    TriggerClientEvent('bd-burgershot:client:SpawnSupplyVan', src, activeOrder.vehicleCoords, Config.SupplyDropzone)
end)

RegisterNetEvent('bd-burgershot:server:CancelSupplyOrder', function(orderId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or Player.PlayerData.job.name ~= Config.Jobname then return end
    if not activeOrder or activeOrder.id ~= orderId or activeOrder.claimed then return end

    local refunded = DepositSociety(activeOrder.total)
    if refunded then
        exports['bd-burgershot']:LogBossTransaction('in', activeOrder.total, ('Supply Order #%s cancelled - refund'):format(orderId))
        Notify(src, ('You declined order #%s. It has been cancelled and the society was refunded $%d.'):format(orderId, activeOrder.total), '#F08080')
    else
        Notify(src, ('You declined order #%s. It has been cancelled, but the refund failed - notify an admin.'):format(orderId), '#F08080')
    end

    local orderedByPlayer = QBCore.Functions.GetPlayerByCitizenId(activeOrder.orderedBy)
    if orderedByPlayer and orderedByPlayer.PlayerData.source ~= src then
        Notify(orderedByPlayer.PlayerData.source, ('Supply order #%s was declined and has been cancelled.'):format(orderId), '#F08080')
    end

    for _, playerSrc in ipairs(GetOnDutyBurgershotPlayers()) do
        TriggerClientEvent('bd-burgershot:client:SupplyOrderCancelled', playerSrc, orderId)
    end

    activeOrder = nil
end)

RegisterNetEvent('bd-burgershot:server:CompleteSupplyOrder', function(orderId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or Player.PlayerData.job.name ~= Config.Jobname then return end
    if not activeOrder or activeOrder.id ~= orderId or not activeOrder.claimed or activeOrder.claimedBy ~= src then return end

    for _, line in ipairs(activeOrder.lines) do
        if Config.InventorySystem == 'ox' then
            ox_inventory:AddItem(src, line.item, line.amount)
        else
            Player.Functions.AddItem(line.item, line.amount, false, false)
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[line.item], 'add', line.amount)
        end
    end

    Notify(src, ('Supplies unloaded! Order #%s delivered.'):format(orderId), '#8fd694')

    for _, playerSrc in ipairs(GetOnDutyBurgershotPlayers()) do
        TriggerClientEvent('bd-burgershot:client:SupplyOrderFinished', playerSrc, orderId)
    end

    activeOrder = nil
end)

exports('GetActiveSupplyOrder', function()
    return activeOrder
end)
