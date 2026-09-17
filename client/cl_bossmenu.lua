local bossMenuOpen = false

local function Notify(description, color)
    lib.notify({
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

RegisterNetEvent('bd-burgershot:client:OpenBossMenu', function()
    if bossMenuOpen then return end

    local payload = lib.callback.await('bd-burgershot:server:GetBossMenuData', false)
    if not payload or not payload.ok then
        Notify(payload and payload.error or 'You do not have permission to access this.')
        return
    end

    bossMenuOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openBossMenu',
        employees = payload.employees,
        grades = payload.grades,
        maxGrade = payload.maxGrade,
        balance = payload.balance,
        transactions = payload.transactions,
        supplyMenu = payload.supplyMenu,
        activeSupplyOrder = payload.activeSupplyOrder,
        stock = payload.stock
    })
end)

local function CloseBossMenu()
    if not bossMenuOpen then return end
    bossMenuOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'closeBossMenu' })
end

RegisterNUICallback('closeBossMenu', function(_, cb)
    CloseBossMenu()
    cb({})
end)

RegisterNUICallback('bossHire', function(data, cb)
    local payload = lib.callback.await('bd-burgershot:server:BossHire', false, data and data.serverId)
    cb(payload or { ok = false, error = 'No response from server.' })
end)

RegisterNUICallback('bossFire', function(data, cb)
    local payload = lib.callback.await('bd-burgershot:server:BossFire', false, data and data.citizenid)
    cb(payload or { ok = false, error = 'No response from server.' })
end)

RegisterNUICallback('bossPromote', function(data, cb)
    local payload = lib.callback.await('bd-burgershot:server:BossPromote', false, data and data.citizenid)
    cb(payload or { ok = false, error = 'No response from server.' })
end)

RegisterNUICallback('bossDemote', function(data, cb)
    local payload = lib.callback.await('bd-burgershot:server:BossDemote', false, data and data.citizenid)
    cb(payload or { ok = false, error = 'No response from server.' })
end)

RegisterNUICallback('bossDeposit', function(data, cb)
    local payload = lib.callback.await('bd-burgershot:server:BossDeposit', false, data and data.amount, data and data.account)
    cb(payload or { ok = false, error = 'No response from server.' })
end)

RegisterNUICallback('bossWithdraw', function(data, cb)
    local payload = lib.callback.await('bd-burgershot:server:BossWithdraw', false, data and data.amount, data and data.account)
    cb(payload or { ok = false, error = 'No response from server.' })
end)

RegisterNUICallback('bossOrderSupplies', function(data, cb)
    local payload = lib.callback.await('bd-burgershot:server:BossOrderSupplies', false, data and data.cart)
    cb(payload or { ok = false, error = 'No response from server.' })
end)

RegisterNUICallback('bossRefreshStock', function(_, cb)
    local payload = lib.callback.await('bd-burgershot:server:GetBossMenuData', false)
    cb(payload or { ok = false, error = 'No response from server.' })
end)

CreateThread(function()
    while true do
        Wait(0)
        if bossMenuOpen then
            if IsControlJustReleased(0, 322) then
                CloseBossMenu()
            end
        else
            Wait(250)
        end
    end
end)
