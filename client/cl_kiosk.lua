local QBCore = exports['qb-core']:GetCoreObject()

local kioskOpen = false

local ImageBase = (Config.InventorySystem == 'ox')
    and 'nui://ox_inventory/web/images/'
    or 'nui://qb-inventory/html/images/'

local function BuildMenuWithImages()
    local menu = {}
    for _, cat in ipairs(Config.MenuItems) do
        local items = {}
        for _, entry in ipairs(cat.items) do
            items[#items + 1] = {
                label = entry.label,
                price = entry.price,
                image = entry.item and (ImageBase .. entry.item .. '.png') or nil,
            }
        end
        menu[#menu + 1] = { category = cat.category, items = items }
    end
    return menu
end

local function GetWorkerName()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local charinfo = PlayerData and PlayerData.charinfo
    if charinfo and charinfo.firstname then
        return ('%s %s'):format(charinfo.firstname, charinfo.lastname or '')
    end
    return GetPlayerName(PlayerId())
end

RegisterNetEvent('bd-burgershot:client:OpenKiosk', function()
    if kioskOpen then return end
    kioskOpen = true

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openKiosk',
        menu = BuildMenuWithImages(),
        playerName = GetWorkerName()
    })
end)

local function CloseKiosk()
    if not kioskOpen then return end
    kioskOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'closeKiosk' })
end

RegisterNUICallback('closeKiosk', function(_, cb)
    CloseKiosk()
    cb({})
end)

RegisterNUICallback('submitOrder', function(data, cb)
    CloseKiosk()

    if data and data.items and #data.items > 0 and tonumber(data.total) and tonumber(data.total) > 0 and tonumber(data.customerId) then
        TriggerServerEvent('bd-burgershot:server:createTicket', data.items, data.total, data.customerId)
    else
        lib.notify({
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'Order was empty or missing a customer ID, nothing was rung up.',
            showDuration = false,
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#F08080',
                ['.description'] = { color = '#909296' }
            },
            icon = 'receipt',
            iconColor = '#F08080'
        })
    end

    cb({})
end)

CreateThread(function()
    while true do
        Wait(0)
        if kioskOpen then
            if IsControlJustReleased(0, 322) then
                CloseKiosk()
            end
        else
            Wait(250)
        end
    end
end)

lib.callback.register('bd-burgershot:client:confirmOrder', function(data)
    return lib.alertDialog({
        header = data.header,
        content = data.content,
        centered = true,
        cancel = true,
        labels = { confirm = 'Pay', cancel = 'Deny' },
    })
end)