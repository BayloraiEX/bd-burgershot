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

local function AddPedTarget(ped)
    if Config.TargetSystem == 'qb' then
        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    type = 'client',
                    event = 'bd-burgershot:client:TalkToSupplyPed',
                    icon = 'fa-solid fa-comments',
                    label = 'Talk to Driver',
                    job = Config.Jobname,
                },
            },
            distance = 2.5
        })
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:addLocalEntity(ped, {
            {
                event = 'bd-burgershot:client:TalkToSupplyPed',
                icon = 'fa-solid fa-comments',
                label = 'Talk to Driver',
                groups = { Config.Jobname },
            }
        })
    end
end

local function RemovePedTarget(ped)
    if Config.TargetSystem == 'qb' then
        exports['qb-target']:RemoveTargetEntity(ped)
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:removeLocalEntity(ped)
    end
end

local function SpawnOrderPed(coords)
    local model = Config.SupplyOrderPedModel or 'a_m_y_business_03'
    lib.requestModel(model)

    local ped = CreatePed(4, model, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
    SetEntityAsMissionEntity(ped, true, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    if Config.SupplyOrderPedScenario then
        TaskStartScenarioInPlace(ped, Config.SupplyOrderPedScenario, 0, true)
    end
    SetModelAsNoLongerNeeded(model)

    AddPedTarget(ped)

    return ped
end

local function DespawnOrderPed()
    if not pendingOrder then return end

    if pendingOrder.ped and DoesEntityExist(pendingOrder.ped) then
        RemovePedTarget(pendingOrder.ped)
        DeleteEntity(pendingOrder.ped)
        pendingOrder.ped = nil
    end

    if pendingOrder.blip then
        SetBlipRoute(pendingOrder.blip, false)
        RemoveBlip(pendingOrder.blip)
        pendingOrder.blip = nil
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
    DespawnOrderPed()
    RemoveDropzone(orderId)
    if pendingOrder and pendingOrder.dropBlip then
        RemoveBlip(pendingOrder.dropBlip)
    end
end

RegisterNetEvent('bd-burgershot:client:SupplyOrderReady', function(data)
    pendingOrder = { id = data.id, pedCoords = data.pedCoords, dropzone = data.dropzone, summary = data.summary }
    pendingOrder.ped = SpawnOrderPed(data.pedCoords)

    local blip = AddBlipForCoord(data.pedCoords.x, data.pedCoords.y, data.pedCoords.z)
    SetBlipSprite(blip, 477)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Supply Pickup')
    EndTextCommandSetBlipName(blip)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 5)
    pendingOrder.blip = blip

    Notify(('Supply order placed! Head to the marked location and speak to the driver. (%s)'):format(data.summary or ''), '#ffe14d')
    PushSupplyStatus('ready', data.id)
end)

RegisterNetEvent('bd-burgershot:client:TalkToSupplyPed', function()
    if not pendingOrder then return end

    local orderId = pendingOrder.id
    local alert = lib.alertDialog({
        header = 'Supply Order Ready',
        content = ('Your order (%s) has arrived. Load it up and take it back to Burgershot?'):format(pendingOrder.summary or orderId),
        centered = true,
        cancel = true,
        labels = { confirm = 'Accept', cancel = 'Decline' },
    })

    if not pendingOrder or pendingOrder.id ~= orderId then return end

    if alert == 'confirm' then
        TriggerServerEvent('bd-burgershot:server:ClaimSupplyVan', orderId)
    elseif alert == 'cancel' then
        TriggerServerEvent('bd-burgershot:server:CancelSupplyOrder', orderId)
    end
end)

RegisterNetEvent('bd-burgershot:client:SupplyVanClaimed', function(orderId, claimedBySrc)
    if not pendingOrder or pendingOrder.id ~= orderId then return end

    DespawnOrderPed()

    if claimedBySrc ~= GetPlayerServerId(PlayerId()) then
        Notify('Another employee is picking up this supply order.', '#ffe14d')
        pendingOrder = nil
    end

    PushSupplyStatus('claimed', orderId)
end)

RegisterNetEvent('bd-burgershot:client:SupplyOrderCancelled', function(orderId)
    if not pendingOrder or pendingOrder.id ~= orderId then return end

    DespawnOrderPed()
    pendingOrder = nil

    Notify('Supply order declined and cancelled.', '#F08080')
    PushSupplyStatus('cancelled', orderId)
end)

RegisterNetEvent('bd-burgershot:client:SpawnSupplyVan', function(vehicleCoords, dropzone)
    QBCore.Functions.SpawnVehicle(Config.SupplyVanModel, function(veh)
        SetVehicleNumberPlateText(veh, 'BURGER')
        SetEntityAsMissionEntity(veh, true, true)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        SetVehicleFuelLevel(veh, 1000.0)
        SetVehicleDirtLevel(veh, 0)
        supplyVeh = veh
    end, vehicleCoords, true)

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
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 2)
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
