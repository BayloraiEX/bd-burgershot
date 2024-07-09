local QBCore = exports['qb-core']:GetCoreObject()

----- | CREATING GARAGE MENU | -----
lib.registerContext({
    id = 'burgershot_garage',
    title = 'Burgershot Garage',
    options = {
        {
            title = 'Burgershot Bike',
            description = 'Pull out Burgershots Bike',
            icon = 'motorcycle',
            event = 'bd-burgershot:client:spawnBike'
        },
        {
            title = 'Burgershot Electric Bike',
            description = 'Pull out Burgershots Bike 2',
            icon = 'motorcycle',
            event = 'bd-burgershot:client:spawnBike2'
        },
    },
})

----- | REGISTER CONTEXT MENU TO "bd-burgershot:client:garageMenu" | -----
RegisterNetEvent('bd-burgershot:client:garageMenu', function()
    lib.showContext('burgershot_garage')
end)

----- | CREATING GARAGE MENU1 | -----
lib.registerContext({
    id = 'burgershot_garage1',
    title = 'Burgershot Garage',
    options = {
        {
            title = 'Burgershot Van',
            description = 'Pull out Burgershots Van',
            icon = 'van-shuttle',
            event = 'bd-burgershot:client:spawnVan'
        },
        {
            title = 'Burgershot Bike',
            description = 'Pull out Burgershots Bike',
            icon = 'motorcycle',
            event = 'bd-burgershot:client:spawnBike'
        },
        {
            title = 'Burgershot Electric Bike',
            description = 'Pull out Burgershots Bike 2',
            icon = 'motorcycle',
            event = 'bd-burgershot:client:spawnBike2'
        },
    },
})

----- | REGISTER CONTEXT MENU TO "bd-burgershot:client:garageMenu1" | -----
RegisterNetEvent('bd-burgershot:client:garageMenu1', function()
    lib.showContext('burgershot_garage1')
end)

----- | CREATING GARAGE MENU2 | -----
lib.registerContext({
    id = 'burgershot_garage2',
    title = 'Burgershot Garage',
    options = {
        {
            title = 'Burgershot Van',
            description = 'Pull out Burgershots Van',
            icon = 'van-shuttle',
            event = 'bd-burgershot:client:spawnVan'
        },
        {
            title = 'Burgershot Car',
            description = 'Pull out Burgershots Car',
            icon = 'car',
            event = 'bd-burgershot:client:spawnCar'
        },
        {
            title = 'Burgershot Bike',
            description = 'Pull out Burgershots Bike',
            icon = 'motorcycle',
            event = 'bd-burgershot:client:spawnBike'
        },
        {
            title = 'Burgershot Electric Bike',
            description = 'Pull out Burgershots Bike 2',
            icon = 'motorcycle',
            event = 'bd-burgershot:client:spawnBike2'
        },
    },
})

----- | REGISTER CONTEXT MENU TO "bd-burgershot:client:garageMenu2" | -----
RegisterNetEvent('bd-burgershot:client:garageMenu2', function()
    lib.showContext('burgershot_garage2')
end)

----- | CREATING THE STORE LOGIC FOR VEHICLES | -----
RegisterNetEvent('bd-burgershot:client:storeGarage', function()
    local veh = QBCore.Functions.GetClosestVehicle()
    if DecorExistOn((veh), "t_vehicle") then
        QBCore.Functions.DeleteVehicle(veh)
        lib.notify({
            id = 'burgershot_garage',
            title = 'Burgershots Garage',
            description = 'You returned the vehicle.',
            showDuration = false,
            position = 'top-right',
            style = {
                backgroundColor = '#141517',
                color = '#F08080',
                ['.description'] = {
                  color = '#909296'
                }
            },
            icon = 'square-parking',
            iconColor = '#F08080'
        })
    else
        lib.notify({
            id = 'burgershot_garage',
            title = 'Burgershots Garage',
            description = 'This is not a work vehicle.',
            showDuration = false,
            position = 'top-right',
            style = {
                backgroundColor = '#141517',
                color = '#F08080',
                ['.description'] = {
                  color = '#909296'
                }
            },
            icon = 'square-parking',
            iconColor = '#F08080'
        })
    end
end)

----- | CREATING CAR SPAWN | -----
RegisterNetEvent('bd-burgershot:client:spawnCar', function(carvehicle)
    local carvehicle = Config.CarVehicle
    local carcoords = Config.CarSpawn
    QBCore.Functions.SpawnVehicle(carvehicle, function(carveh)
        SetVehicleNumberPlateText(carveh, "BURGER")
        DecorSetFloat(carveh, "t_vehicle", 1)
        SetEntityAsMissionEntity(carveh, true, true)
        TaskWarpPedIntoVehicle(PlayerPedId(), carveh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(carveh))
        SetVehicleEngineOn(carveh, true, true)
        CurrentPlate = QBCore.Functions.GetPlate(carveh)
        SetVehicleFuelLevel(carveh, 500.0)
        SetVehicleDirtLevel(carveh, 0)
    end, carcoords, true)
end)

----- | CREATING BIKE SPAWN | -----
RegisterNetEvent('bd-burgershot:client:spawnBike', function(bikevehicle)
    local bikevehicle = Config.BikeVehicle
    local bikecoords = Config.BikeSpawn
    QBCore.Functions.SpawnVehicle(bikevehicle, function(bikeveh)
        SetVehicleNumberPlateText(bikevehicle, "BURGER")
        DecorSetFloat(bikeveh, "t_vehicle", 1)
        SetEntityAsMissionEntity(bikeveh, true, true)
        TaskWarpPedIntoVehicle(PlayerPedId(), bikeveh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(bikeveh))
        SetVehicleEngineOn(bikeveh, true, true)
        CurrentPlate = QBCore.Functions.GetPlate(bikeveh)
        SetVehicleFuelLevel(bikeveh, 275.0)
        SetVehicleDirtLevel(bikeveh, 0)
    end, bikecoords, true)
end)

----- | CREATING BIKE2 SPAWN | -----
RegisterNetEvent('bd-burgershot:client:spawnBike2', function(bike2vehicle)
    local bike2vehicle = Config.Bike2Vehicle
    local bike2coords = Config.Bike2Spawn
    QBCore.Functions.SpawnVehicle(bike2vehicle, function(bike2veh)
        SetVehicleNumberPlateText(bike2vehicle, "BURGER")
        DecorSetFloat(bike2veh, "t_vehicle", 1)
        SetEntityAsMissionEntity(bike2veh, true, true)
        TaskWarpPedIntoVehicle(PlayerPedId(), bike2veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(bike2veh))
        SetVehicleEngineOn(bike2veh, true, true)
        CurrentPlate = QBCore.Functions.GetPlate(bike2veh)
        SetVehicleFuelLevel(bike2veh, 275.0)
        SetVehicleDirtLevel(bike2veh, 0)
    end, bike2coords, true)
end)

----- | CREATING VAN SPAWN | -----
RegisterNetEvent('bd-burgershot:client:spawnVan', function(vanvehicle)
    local vanvehicle = Config.VanVehicle
    local vancoords = Config.VanSpawn
    QBCore.Functions.SpawnVehicle(vanvehicle, function(vanveh)
        SetVehicleNumberPlateText(vanveh, "BURGER")
        DecorSetFloat(vanveh, "t_vehicle", 1)
        SetEntityAsMissionEntity(vanveh, true, true)
        TaskWarpPedIntoVehicle(PlayerPedId(), vanveh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vanveh))
        SetVehicleEngineOn(vanveh, true, true)
        CurrentPlate = QBCore.Functions.GetPlate(vanveh)
        SetVehicleFuelLevel(vanveh, 1000.0)
        SetVehicleDirtLevel(vanveh, 0)
    end, vancoords, true)
end)
