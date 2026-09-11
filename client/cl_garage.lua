local QBCore = exports['qb-core']:GetCoreObject()

local function Notify(description)
    lib.notify({
        id = 'burgershot_garage',
        title = 'Burgershots Garage',
        description = description,
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

local function OpenGarageMenu()
    local grade = QBCore.Functions.GetPlayerData().job.grade.level
    local options = {}

    for i, veh in ipairs(Config.GarageVehicles) do
        if grade >= (veh.minGrade or 0) then
            options[#options + 1] = {
                title = veh.label,
                description = veh.description,
                icon = veh.icon,
                event = 'bd-burgershot:client:spawnGarageVehicle',
                args = i,
            }
        end
    end

    lib.registerContext({
        id = 'burgershot_garage',
        title = 'Burgershot Garage',
        options = options,
    })
    lib.showContext('burgershot_garage')
end

RegisterNetEvent('bd-burgershot:client:garageMenu', OpenGarageMenu)
RegisterNetEvent('bd-burgershot:client:garageMenu1', OpenGarageMenu)
RegisterNetEvent('bd-burgershot:client:garageMenu2', OpenGarageMenu)

RegisterNetEvent('bd-burgershot:client:spawnGarageVehicle', function(index)
    local veh = Config.GarageVehicles[index]
    if not veh then return end

    QBCore.Functions.SpawnVehicle(veh.model, function(spawned)
        SetVehicleNumberPlateText(spawned, Config.VehiclePlate)
        DecorSetFloat(spawned, 't_vehicle', 1)
        SetEntityAsMissionEntity(spawned, true, true)
        TaskWarpPedIntoVehicle(PlayerPedId(), spawned, -1)
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(spawned))
        SetVehicleEngineOn(spawned, true, true)
        SetVehicleFuelLevel(spawned, veh.fuel or 100.0)
        SetVehicleDirtLevel(spawned, 0.0)
    end, veh.spawn, true)
end)

RegisterNetEvent('bd-burgershot:client:storeGarage', function()
    local veh = QBCore.Functions.GetClosestVehicle()
    if DecorExistOn(veh, 't_vehicle') then
        QBCore.Functions.DeleteVehicle(veh)
        if Config.KeySystem == 'wasabi' then
            exports.wasabi_carlock:RemoveKey(Config.VehiclePlate)
        end
        Notify('You returned the vehicle.')
    else
        Notify('This is not a work vehicle.')
    end
end)
