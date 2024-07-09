local QBCore = exports['qb-core']:GetCoreObject()

----- | CREATING INVENTORYS | -----
RegisterNetEvent('bd-burgershot:server:bfrontTray1', function(bfrontTray1)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local stashName = 'Burger Counter1'

    if Player then
        exports['qb-inventory']:OpenInventory(src, stashName, {
            maxweight = 50000,
            slots = 15,
        })
    end
end)

RegisterNetEvent('bd-burgershot:server:bfrontTray2', function(bfrontTray2)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local stashName = 'Burger Counter2'

    if Player then
        exports['qb-inventory']:OpenInventory(src, stashName, {
            maxweight = 50000,
            slots = 15,
        })
    end
end)

RegisterNetEvent('bd-burgershot:server:bfrontTray3', function(bfrontTray3)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local stashName = 'Burger Tray'

    if Player then
        exports['qb-inventory']:OpenInventory(src, stashName, {
            maxweight = 50000,
            slots = 15,
        })
    end
end)

RegisterNetEvent('bd-burgershot:server:bjobFridge', function(bjobFridge)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local stashName = 'Burger Fridge'

    if Player then
        exports['qb-inventory']:OpenInventory(src, stashName, {
            maxweight = 750000,
            slots = 50,
        })
    end
end)

RegisterNetEvent('bd-burgershot:server:bjobHeater', function(bjobHeater)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local stashName = 'Burger Heater'

    if Player then
        exports['qb-inventory']:OpenInventory(src, stashName, {
            maxweight = 250000,
            slots = 25,
        })
    end
end)

RegisterNetEvent('bd-burgershot:server:bbackStorage', function(bbackStorage)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local stashName = 'Burger Storage'

    if Player then
        exports['qb-inventory']:OpenInventory(src, stashName, {
            maxweight = 1000000,
            slots = 75,
        })
    end
end)
