local QBCore = exports['qb-core']:GetCoreObject()

local deliveryBlip = nil
local inJob = false

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
            ['.description'] = {
              color = '#909296'
            }
        },
        icon = 'burger',
        iconColor = color or '#F08080'
    })
end

local function FetchModel(model)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(model) do
        Wait(100)
    end
end

local LocalNPCs = {}

local function DestroyLocalNPC(index)
    if LocalNPCs[index] then
        DeleteEntity(LocalNPCs[index].ped)
        LocalNPCs[index] = nil
    end
end

local function CreateLocalNPC(index)
    if LocalNPCs[index] then
        DestroyLocalNPC(index)
    end

    local cfg = Config.BurgershotDeliveryPed[index]
    FetchModel(cfg.BurgershotDeliveryPedModel)

    local ped = CreatePed(1, cfg.BurgershotDeliveryPedModel, cfg.BurgershotDeliveryPedLocation, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedComponentVariation(ped, 3, 0, 0, 1)
    SetPedComponentVariation(ped, 4, 0, 0, 1)
    SetPedComponentVariation(ped, 6, 0, 0, 1)
    SetPedComponentVariation(ped, 0, 1, 0, 1)

    if Config.TargetSystem == 'qb' then
        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    type = 'client',
                    event = 'bd-burgershot:client:DeliveryStartAlert',
                    icon = 'fa-solid fa-truck-ramp-box',
                    label = 'Delivery Start',
                    job = Config.Jobname,
                },
            },
            distance = 1.5,
        })
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:addLocalEntity(ped, {
            {
                name = 'burgershot_delivery',
                event = 'bd-burgershot:client:DeliveryStartAlert',
                icon = 'fa-solid fa-truck-ramp-box',
                label = 'Delivery Start',
                groups = { Config.Jobname },
            },
        })
    end

    LocalNPCs[index] = { ped = ped }
end

CreateThread(function()
    while true do
        local pcoords = GetEntityCoords(PlayerPedId())
        for i = 1, #Config.BurgershotDeliveryPed do
            local cfg = Config.BurgershotDeliveryPed[i]
            local dist = #(pcoords - vector3(cfg.BurgershotDeliveryPedLocation.x, cfg.BurgershotDeliveryPedLocation.y, cfg.BurgershotDeliveryPedLocation.z))
            if dist < cfg.BurgershotDeliveryRenderDistance then
                if not LocalNPCs[i] then
                    CreateLocalNPC(i)
                end
            else
                DestroyLocalNPC(i)
            end
        end
        Wait(1000)
    end
end)

RegisterNetEvent('bd-burgershot:client:DeliveryStartAlert', function()
    if inJob then
        Notify('You already have a delivery started, Check your GPS')
        return
    end

    local burgeralert = lib.alertDialog({
        header = 'Burgershot Delivery',
        content = 'Are you sure you would like to start a delivery?',
        centered = true,
        size = 'xs',
        cancel = true,
        labels = {
            cancel = 'No',
            confirm = 'Yes',
        },
    })

    if burgeralert == 'confirm' then
        TriggerEvent('bd-burgershot:client:RecieveDelivery')
    else
        Notify('You declined the delivery')
    end
end)

local function DeliveryAnim()
    return lib.progressCircle({
        duration = 3000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = 'anim@mp_fireworks',
            scenario = 'anim@mp_fireworks',
            clip = 'place_firework_4_cone',
        },
    })
end

RegisterNetEvent('bd-burgershot:client:RecieveDelivery', function()
    local routes = Config.DeliveryLocations['deliveryroute']
    local randomRoute = routes[math.random(1, #routes)].coords

    deliveryBlip = AddBlipForCoord(randomRoute.x, randomRoute.y, randomRoute.z)
    SetBlipDisplay(deliveryBlip, 4)
    SetBlipScale(deliveryBlip, 0.7)
    SetBlipSprite(deliveryBlip, 280)
    SetBlipColour(deliveryBlip, 6)
    SetBlipAsShortRange(deliveryBlip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Customer')
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)

    inJob = true
    TriggerServerEvent('bd-burgershot:server:RecieveBags')
    Notify('Delivery Started! Check your GPS for the marked location')

    if Config.TargetSystem == 'qb' then
        exports['qb-target']:AddCircleZone('BurgershotDelivery', randomRoute, 1.0, {
            name = 'BurgershotDelivery',
            debugPoly = Config.DebugZones,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'bd-burgershot:client:CompleteDelivery',
                    icon = 'fa-solid fa-bag-shopping',
                    label = 'Place on door step',
                    job = Config.Jobname,
                },
            },
            distance = 2.5,
        })
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:addBoxZone({
            coords = randomRoute,
            name = 'burgerdelivery',
            size = vec3(1, 1, 1),
            rotation = 45,
            debug = Config.DebugZones,
            options = {
                {
                    event = 'bd-burgershot:client:CompleteDelivery',
                    icon = 'fa-solid fa-bag-shopping',
                    label = 'Place On Door Step',
                    groups = { Config.Jobname },
                },
            },
        })
    end
end)

RegisterNetEvent('bd-burgershot:client:CompleteDelivery', function()
    if not inJob then return end

    if not DeliveryAnim() then
        Notify('Canceled')
        return
    end

    RemoveBlip(deliveryBlip)
    deliveryBlip = nil
    inJob = false

    if Config.TargetSystem == 'qb' then
        exports['qb-target']:RemoveZone('BurgershotDelivery')
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:removeZone('burgerdelivery')
    end

    TriggerServerEvent('bd-burgershot:server:FinishDelivery')
    Notify('Customer has recieved there order!')
end)
