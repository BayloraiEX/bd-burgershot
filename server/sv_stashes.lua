local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory

if Config.InventorySystem == 'ox' then
    -- TRAY 1 --
    RegisterNetEvent('ox:burgershotTray1', function()
        ox_inventory:RegisterStash('burgershotTray1', 'Counter', 5, 5000, true)
    end)
    -- TRAY 2 --
    RegisterNetEvent('ox:burgershotTray2', function()
        ox_inventory:RegisterStash('burgershotTray2', 'Counter', 5, 5000, true)
    end)
    -- TRAY 3 --
    RegisterNetEvent('ox:burgershotTray3', function()
        ox_inventory:RegisterStash('burgershotTray3', 'Tray', 5, 5000, true)
    end)
    -- FRIDGE --
    RegisterNetEvent('ox:burgershotFridge', function()
        ox_inventory:RegisterStash('burgershotFridge', 'Fridge', 50, 750000, true)
    end)
    -- HEATER --
    RegisterNetEvent('ox:burgershotHeater', function()
        ox_inventory:RegisterStash('burgershotHeater', 'Heater', 25, 250000, true)
    end)
    -- STORAGE --
    RegisterNetEvent('ox:burgershotStorage', function()
        ox_inventory:RegisterStash('burgershotStorage', 'Storage', 75, 1000000, true)
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
