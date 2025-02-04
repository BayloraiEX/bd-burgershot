local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory

if Config.InventorySystem == 'ox' then
    -- TRAY 1 --
    RegisterNetEvent('ox:bfrontTray1', function()
        ox_inventory:RegisterStash('bfrontTray1', 'Counter', 5, 5000, true)
    end)
    -- TRAY 2 --
    RegisterNetEvent('ox:bfrontTray2', function()
        ox_inventory:RegisterStash('bfrontTray2', 'Counter', 5, 5000, true)
    end)
    -- TRAY 3 --
    RegisterNetEvent('ox:bfrontTray3', function()
        ox_inventory:RegisterStash('bfrontTray3', 'Tray', 5, 5000, true)
    end)
    -- FRIDGE --
    RegisterNetEvent('ox:bjobFridge', function()
        ox_inventory:RegisterStash('bjobFridge', 'Fridge', 50, 750000, true)
    end)
    -- HEATER --
    RegisterNetEvent('ox:bjobHeater', function()
        ox_inventory:RegisterStash('bjobHeater', 'Heater', 25, 250000, true)
    end)
    -- STORAGE --
    RegisterNetEvent('ox:bbackStorage', function()
        ox_inventory:RegisterStash('bbackStorage', 'Storage', 75, 1000000, true)
    end)
elseif Config.InventorySystem == 'qb' then
    -- TRAY 1 --
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
    -- TRAY 2 --
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
    -- TRAY 3 --
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
    -- FRIDGE --
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
    -- HEATER --
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
    -- STORAGE --
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
end
