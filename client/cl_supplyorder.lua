local QBCore = exports['qb-core']:GetCoreObject()

local pendingOrder = nil
local supplyVeh = nil

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
        icon = 'truck',
        iconColor = color or '#F08080'
    })
end

local function PushSupplyStatus(status, orderId)
    SendNUIMessage({
        action = 'supplyOrderUpdate',
        status = status,
        orderId = orderId,
    })
end

local function AddPickupZone(orderId, coords)
    if Config.TargetSystem == 'qb' then
        exports['qb-target']:AddBoxZone('BurgershotSupplyVan_' .. orderId, vector3(coords.x, coords.y, coords.z), 1.5, 1.5, {
            name = 'BurgershotSupplyVan_' .. orderId,
            heading = coords.w,
            debugPoly = false,
            minZ = coords.z - 2,
            maxZ = coords.z + 2,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'bd-burgershot:client:TryClaimSupplyVan',
                    icon = 'fa-solid fa-truck-ramp-box',
                    label = 'Load Supply Van',
                    job = Config.Jobname,
                },
            },
            distance = 2.5
        })
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:addBoxZone({
            coords = coords,
            name = 'burgershot_supplyvan_' .. orderId,
            size = vec3(2, 2, 2),
            rotation = coords.w,
            options = {
                {
                    event = 'bd-burgershot:client:TryClaimSupplyVan',
                    icon = 'fa-solid fa-truck-ramp-box',
                    label = 'Load Supply Van',
                    groups = { Config.Jobname },
                }
            }
        })
    end
end

local function RemovePickupZone(orderId)
    if Config.TargetSystem == 'qb' then
        exports['qb-target']:RemoveZone('BurgershotSupplyVan_' .. orderId)
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:removeZone('burgershot_supplyvan_' .. orderId)
    end
end

local function AddDropzone(orderId, coords)
    if Config.TargetSystem == 'qb' then
        exports['qb-target']:AddBoxZone('BurgershotSupplyDrop_' .. orderId, vector3(coords.x, coords.y, coords.z), 2.0, 2.0, {
            name = 'BurgershotSupplyDrop_' .. orderId,
            heading = coords.w,
            debugPoly = false,
            minZ = coords.z - 2,
            maxZ = coords.z + 2,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'bd-burgershot:client:CompleteSupplyOrder',
                    icon = 'fa-solid fa-dolly',
                    label = 'Unload Supplies',
                    job = Config.Jobname,
                },
            },
            distance = 2.5
        })
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:addBoxZone({
            coords = coords,
            name = 'burgershot_supplydrop_' .. orderId,
            size = vec3(2, 2, 2),
            rotation = coords.w,
            options = {
                {
                    event = 'bd-burgershot:client:CompleteSupplyOrder',
                    icon = 'fa-solid fa-dolly',
                    label = 'Unload Supplies',
                    groups = { Config.Jobname },
                }
            }
        })
    end
end

local function RemoveDropzone(orderId)
    if Config.TargetSystem == 'qb' then
        exports['qb-target']:RemoveZone('BurgershotSupplyDrop_' .. orderId)
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:removeZone('burgershot_supplydrop_' .. orderId)
    end
end

local function ClearOrderMarkers(orderId)
    RemovePickupZone(orderId)
    RemoveDropzone(orderId)
    if pendingOrder then
        if pendingOrder.blip then RemoveBlip(pendingOrder.blip) end
        if pendingOrder.dropBlip then RemoveBlip(pendingOrder.dropBlip) end
    end
end

RegisterNetEvent('bd-burgershot:client:SupplyOrderReady', function(data)
    pendingOrder = { id = data.id, spawnCoords = data.spawnCoords, dropzone = data.dropzone }
    AddPickupZone(data.id, data.spawnCoords)

    local blip = AddBlipForCoord(data.spawnCoords.x, data.spawnCoords.y, data.spawnCoords.z)
    SetBlipSprite(blip, 477)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Supply Pickup')
    EndTextCommandSetBlipName(blip)
    pendingOrder.blip = blip

    Notify(('Supply order placed! Head to the pickup point and load the van. (%s)'):format(data.summary or ''), '#ffe14d')
    PushSupplyStatus('ready', data.id)
end)

RegisterNetEvent('bd-burgershot:client:TryClaimSupplyVan', function()
    if not pendingOrder then return end
    TriggerServerEvent('bd-burgershot:server:ClaimSupplyVan', pendingOrder.id)
end)

RegisterNetEvent('bd-burgershot:client:SupplyVanClaimed', function(orderId, claimedBySrc)
    if not pendingOrder or pendingOrder.id ~= orderId then return end

    RemovePickupZone(orderId)
    if pendingOrder.blip then
        RemoveBlip(pendingOrder.blip)
        pendingOrder.blip = nil
    end

    if claimedBySrc ~= GetPlayerServerId(PlayerId()) then
        Notify('Another employee is picking up this supply order.', '#ffe14d')
        pendingOrder = nil
    end

    PushSupplyStatus('claimed', orderId)
end)

RegisterNetEvent('bd-burgershot:client:SpawnSupplyVan', function(spawnCoords, dropzone)
    QBCore.Functions.SpawnVehicle(Config.SupplyVanModel, function(veh)
        SetVehicleNumberPlateText(veh, 'BURGER')
        SetEntityAsMissionEntity(veh, true, true)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        SetVehicleFuelLevel(veh, 1000.0)
        SetVehicleDirtLevel(veh, 0)
        supplyVeh = veh
    end, spawnCoords, true)

    if not pendingOrder then return end
    pendingOrder.dropzone = dropzone

    local blip = AddBlipForCoord(dropzone.x, dropzone.y, dropzone.z)
    SetBlipSprite(blip, 478)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 2)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Unload Supplies')
    EndTextCommandSetBlipName(blip)
    pendingOrder.dropBlip = blip

    AddDropzone(pendingOrder.id, dropzone)
    Notify('Van loaded! Drive it back to Burgershot and unload the supplies.', '#8fd694')
end)

RegisterNetEvent('bd-burgershot:client:CompleteSupplyOrder', function()
    if not pendingOrder then return end
    local orderId = pendingOrder.id

    if lib.progressCircle({
        duration = 3000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_player',
            scenario = 'mini@repair'
        },
    }) then
        TriggerServerEvent('bd-burgershot:server:CompleteSupplyOrder', orderId)
        if supplyVeh and DoesEntityExist(supplyVeh) then
            DeleteEntity(supplyVeh)
            supplyVeh = nil
        end
    else
        Notify('Unload cancelled.', '#F08080')
    end
end)

RegisterNetEvent('bd-burgershot:client:SupplyOrderFinished', function(orderId)
    ClearOrderMarkers(orderId)
    if pendingOrder and pendingOrder.id == orderId then
        pendingOrder = nil
    end
    PushSupplyStatus('finished', orderId)
end)
