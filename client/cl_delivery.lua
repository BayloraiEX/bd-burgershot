local QBCore = exports['qb-core']:GetCoreObject()

local deliveryBlip = nil
local inJob = false
local deliveryDoorCoords = nil

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

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
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

local function PlayKnock(doorCoords)
    local ped = PlayerPedId()
    local cfg = Config.DeliveryCutscene

    local pcoords = GetEntityCoords(ped)
    local heading = GetHeadingFromVector_2d(doorCoords.x - pcoords.x, doorCoords.y - pcoords.y)
    SetEntityHeading(ped, heading)

    FetchModel(cfg.BagProp)
    local bagProp = CreateObject(GetHashKey(cfg.BagProp), pcoords.x, pcoords.y, pcoords.z, false, false, false)
    local rHand = GetEntityBoneIndexByName(ped, 'SKEL_R_HAND')
    AttachEntityToEntity(bagProp, ped, rHand, 0.03, 0.02, 0.0, -90.0, 0.0, 0.0, true, true, false, true, 1, true)

    local ok, completed = pcall(lib.progressCircle, {
        duration = cfg.KnockDuration,
        position = 'bottom',
        label = 'Knocking on the door...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = cfg.KnockAnim.dict,
            clip = cfg.KnockAnim.clip,
        },
    })

    if not ok then
        print(('[bd-burgershot] knock animation failed to play: %s'):format(tostring(completed)))
    end

    if not ok or not completed then
        ClearPedTasks(ped)
        DeleteEntity(bagProp)
        SetModelAsNoLongerNeeded(cfg.BagProp)
        return false, nil, nil
    end

    return true, bagProp, heading
end

local function PlayHandoff(doorCoords, bagProp, playerHeading)
    local ped = PlayerPedId()
    local cfg = Config.DeliveryCutscene

    local customerModel = cfg.CustomerPedModels[math.random(1, #cfg.CustomerPedModels)]
    FetchModel(customerModel)

    local customerHeading = (playerHeading + 180.0) % 360.0
    local customer = CreatePed(4, GetHashKey(customerModel), doorCoords.x, doorCoords.y, doorCoords.z, customerHeading, false, false)
    SetEntityAlpha(customer, 0, false)
    SetBlockingOfNonTemporaryEvents(customer, true)
    SetEntityInvincible(customer, true)
    FreezeEntityPosition(customer, true)

    -- "door opens"
    SetEntityAlpha(customer, 255, false)

    local cam = nil
    if cfg.UseCamera then
        local camCoords = GetOffsetFromEntityInWorldCoords(ped, 1.1, -0.9, 0.6)
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamCoord(cam, camCoords.x, camCoords.y, camCoords.z)
        SetCamFov(cam, 45.0)
        PointCamAtCoord(cam, (doorCoords.x + GetEntityCoords(ped).x) / 2, (doorCoords.y + GetEntityCoords(ped).y) / 2, doorCoords.z + 0.5)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)
    end

    LoadAnimDict(cfg.HandoverAnim.customer.dict)
    TaskPlayAnim(customer, cfg.HandoverAnim.customer.dict, cfg.HandoverAnim.customer.clip, 3.0, -3.0, cfg.HandoverDuration, 0, 0.0, false, false, false)

    CreateThread(function()
        Wait(cfg.HandoverDuration - 500)
        if DoesEntityExist(bagProp) and DoesEntityExist(customer) then
            local lHand = GetEntityBoneIndexByName(customer, 'SKEL_L_HAND')
            AttachEntityToEntity(bagProp, customer, lHand, 0.03, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
        end
    end)

    LoadAnimDict(cfg.HandoverAnim.player.dict)
    local ok, err = pcall(lib.progressCircle, {
        duration = cfg.HandoverDuration,
        position = 'bottom',
        label = 'Handing over the order...',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = cfg.HandoverAnim.player.dict,
            clip = cfg.HandoverAnim.player.clip,
        },
    })

    if not ok then
        print(('[bd-burgershot] handover animation failed to play: %s'):format(tostring(err)))
        ClearPedTasks(ped)
    end

    if cam then
        RenderScriptCams(false, true, 500, true, true)
        DestroyCam(cam, false)
    end

    DeleteEntity(bagProp)
    SetModelAsNoLongerNeeded(cfg.BagProp)

    ClearPedTasksImmediately(customer)
    SetEntityAlpha(customer, 0, false)
    Wait(200)
    DeleteEntity(customer)
    SetModelAsNoLongerNeeded(customerModel)
end

local function DeliveryAnim(doorCoords)
    local cfg = Config.DeliveryCutscene

    if not cfg.Enabled then
        return lib.progressCircle({
            duration = 3000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = { car = true, move = true, combat = true },
        })
    end

    local knocked, bagProp, heading = PlayKnock(doorCoords)
    if not knocked then
        return false
    end

    PlayHandoff(doorCoords, bagProp, heading)
    return true
end

RegisterNetEvent('bd-burgershot:client:RecieveDelivery', function()
    local routes = Config.DeliveryLocations['deliveryroute']
    local randomRoute = routes[math.random(1, #routes)].coords
    deliveryDoorCoords = randomRoute

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

    if not DeliveryAnim(deliveryDoorCoords) then
        Notify('Canceled')
        return
    end

    RemoveBlip(deliveryBlip)
    deliveryBlip = nil
    deliveryDoorCoords = nil
    inJob = false

    if Config.TargetSystem == 'qb' then
        exports['qb-target']:RemoveZone('BurgershotDelivery')
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:removeZone('burgerdelivery')
    end

    TriggerServerEvent('bd-burgershot:server:FinishDelivery')
    Notify('Customer has recieved there order!')
end)
