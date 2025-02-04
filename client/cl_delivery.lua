local QBCore = exports['qb-core']:GetCoreObject()

local deliveryBlip = nil
local inJob = false

----- | CREATING MODEL SPAWN | -----
local function FetchModel(model)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(model) do
        Wait(100)
    end
end

local LocalNPCs = {}

local function GetLocalNPC(index)
    return LocalNPCs[index]
end

local function CreateLocalNPC(index)
    if (LocalNPCs[index]) then
        DestroyLocalNPC(index)
    end

    LocalNPCs[index] = {}
    local cfg = Config.BurgershotDeliveryPed[index]

    FetchModel(cfg.BurgershotDeliveryPedModel)

    ----- | CREATING PED | -----
    local BurgershotDeliveryPed = CreatePed(1, cfg.BurgershotDeliveryPedModel, cfg.BurgershotDeliveryPedLocation, false, true)
    FreezeEntityPosition(BurgershotDeliveryPed, true)
    SetEntityInvincible(BurgershotDeliveryPed, true)
    SetBlockingOfNonTemporaryEvents(BurgershotDeliveryPed, true)
    SetPedComponentVariation(BurgershotDeliveryPed, 3, 0, 0, 1)
    SetPedComponentVariation(BurgershotDeliveryPed, 4, 0, 0, 1)
    SetPedComponentVariation(BurgershotDeliveryPed, 6, 0, 0, 1)
    SetPedComponentVariation(BurgershotDeliveryPed, 0, 1, 0, 1)
    if Config.TargetSystem == 'qb' then
        ----- | CREATING TARGET FOR PED | -----
        exports['qb-target']:AddTargetEntity(BurgershotDeliveryPed, {
            options = {
                {
                    type = "client",
                    event = "bd-burgershot:client:DeliveryStartAlert",
                    icon = "fa-solid fa-truck-ramp-box",
                    label = "Delivery Start",
                    job = Config.Jobname
                },
            },
            distance = 1.5,
        })
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:addLocalEntity(BurgershotDeliveryPed, {
            {
                name = 'burgershot_delivery',
                event = 'bd-burgershot:client:DeliveryStartAlert',
                icon = 'fa-solid fa-truck-ramp-box',
                label = 'Delivery Start',
                groups = {
                    Config.Jobname
                },
            }
        })
    end
    LocalNPCs[index].BurgershotDeliveryPed = BurgershotDeliveryPed
end

local function DestroyLocalNPC(index)
    if (LocalNPCs[index]) then
        DeleteEntity(LocalNPCs[index].BurgershotDeliveryPed)
        LocalNPCs[index] = nil
    end
end

----- | CHECKS IF PLAYER IS CERTAIN DISTANCE FROM PED MODEL | -----
Citizen.CreateThread(function()
    while true do
        local wait = 1000
        local ped = PlayerPedId() 
        local pcoords = GetEntityCoords(ped)
        for i=1, 1 do 
            local cfg = Config.BurgershotDeliveryPed[i]
            local coords = vector3(cfg.BurgershotDeliveryPedLocation)
            local dist = #(pcoords - coords)
            local BurgershotDeliveryPed = GetLocalNPC(i)
            if dist < cfg.BurgershotDeliveryRenderDistance then 
                if (GetLocalNPC(i) == nill) then 
                  CreateLocalNPC(i)
                end 
            else 
                DestroyLocalNPC(i)
            end 
        end
      Wait(wait)
    end
end)

----- | CREATING ALERT MENU | -----
RegisterNetEvent('bd-burgershot:client:DeliveryStartAlert', function()
    if inJob == false then
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
        if burgeralert == 'confirm'  then
            TriggerEvent('bd-burgershot:client:RecieveDelivery')
        elseif burgeralert == 'cancel' then
            lib.notify({
                id = 'burger_shot',
                title = 'Burgershot',
                description = 'You declined the delivery',
                showDuration = false,
                position = 'top',
                style = {
                    backgroundColor = '#141517',
                    color = '#F08080',
                    ['.description'] = {
                      color = '#909296'
                    }
                },
                icon = 'burger',
                iconColor = '#F08080'
            })
        end
    elseif inJob == true then
        lib.notify({
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You already have a delivery started, Check your GPS',
            showDuration = false,
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#F08080',
                ['.description'] = {
                  color = '#909296'
                }
            },
            icon = 'burger',
            iconColor = '#F08080'
        })
    end
end)

----- | CREATING THE DELIVERY LOGICS | -----

local function DeliveryAnim()
    if lib.progressCircle({
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
    then -- if progressCircle is going then
        -- do this
    else
        lib.notify({
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'Canceled',
            showDuration = false,
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#F08080',
                ['.description'] = {
                  color = '#909296'
                }
            },
            icon = 'burger',
            iconColor = '#F08080'
        })
    end
end

----- | RECIEVED THE DELIVERY | -----
RegisterNetEvent('bd-burgershot:client:RecieveDelivery', function()
    local route = math.random(1, #Config.DeliveryLocations["deliveryroute"])
    local randomRoute = Config.DeliveryLocations["deliveryroute"][math.random(1, #Config.DeliveryLocations["deliveryroute"])].coords
    deliveryBlip = AddBlipForCoord(randomRoute.x, randomRoute.y, randomRoute.z)
    SetBlipDisplay(deliveryBlip, 4)
    SetBlipScale(deliveryBlip, 0.7)
    SetBlipSprite(deliveryBlip, 280)
    SetBlipColour(deliveryBlip, 6)
    SetBlipAsShortRange(deliveryBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Customer")
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)
    inJob = true
    TriggerServerEvent('bd-burgershot:server:RecieveBags')
    lib.notify({
        id = 'burger_shot',
        title = 'Burgershot',
        description = 'Delivery Started! Check your GPS for the marked location',
        showDuration = false,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#F08080',
            ['.description'] = {
              color = '#909296'
            }
        },
        icon = 'burger',
        iconColor = '#F08080'
    })
    if Config.TargetSystem == 'qb' then
        exports['qb-target']:AddCircleZone("BurgershotDelivery", randomRoute, 1.0, {
            name = "BurgershotDelivery",
            debugPoly = false,
        }, {
            options = {
                {
                    type = "client",
                    event = "bd-burgershot:client:CompleteDelivery",
                    icon = "fa-solid fa-bag-shopping",
                    label = 'Place on door step',
                    job = Config.Jobname
                },
            },
            distance = 2.5
        })
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:addBoxZone({
            coords = randomRoute,
            name = 'burgerdelivery',
            size = vec3(1, 1, 1),
            rotation = 45,
            options = {
                {
                    event = 'bd-burgershot:client:CompleteDelivery',
                    icon = 'fa-solid fa-bag-shopping',
                    label = 'Place On Door Step',
                    groups = {
                        Config.Jobname
                    },
                }
            }
        })
    end
    print(randomRoute)
end)

----- | COMPLETING DELIVERY | -----
RegisterNetEvent('bd-burgershot:client:CompleteDelivery', function()
    DeliveryAnim()
    RemoveBlip(deliveryBlip)
    inJob = false
    if Config.TargetSystem == 'qb' then
        --
        exports['qb-target']:RemoveZone("BurgershotDelivery")
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:removeZone('burgerdelivery')
    end
    TriggerServerEvent('bd-burgershot:server:FinishDelivery')
    TriggerServerEvent('bd-burgershot:server:FinishDeliveryPay')
    lib.notify({
        id = 'burger_shot',
        title = 'Burgershot',
        description = 'Customer has recieved there order!',
        showDuration = false,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#F08080',
            ['.description'] = {
              color = '#909296'
            }
        },
        icon = 'burger',
        iconColor = '#F08080'
    })
end)