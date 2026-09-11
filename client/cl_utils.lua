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

    local cfg = Config.BurgershotGaragePed[index]
    FetchModel(cfg.BurgershotGaragePedModel)

    local ped = CreatePed(1, cfg.BurgershotGaragePedModel, cfg.BurgershotGaragePedLocation, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    if Config.TargetSystem == 'qb' then
        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    type = 'client',
                    event = 'bd-burgershot:client:garageMenu',
                    icon = 'fa-solid fa-warehouse',
                    label = 'Garage',
                    job = Config.Jobname,
                },
                {
                    type = 'client',
                    event = 'bd-burgershot:client:storeGarage',
                    icon = 'fa-solid fa-square-parking',
                    label = 'Store Vehicle',
                    job = Config.Jobname,
                },
            },
            distance = 1.5,
        })
    elseif Config.TargetSystem == 'ox' then
        exports.ox_target:addLocalEntity(ped, {
            {
                name = 'burgershot_garageped',
                event = 'bd-burgershot:client:garageMenu',
                icon = 'fa-solid fa-warehouse',
                label = 'Garage',
                groups = { Config.Jobname },
            },
            {
                name = 'burgershot_storegarage',
                event = 'bd-burgershot:client:storeGarage',
                icon = 'fa-solid fa-square-parking',
                label = 'Store Vehicle',
                groups = { Config.Jobname },
            },
        })
    end

    LocalNPCs[index] = { ped = ped }
end

CreateThread(function()
    while true do
        local pcoords = GetEntityCoords(PlayerPedId())
        for i = 1, #Config.BurgershotGaragePed do
            local cfg = Config.BurgershotGaragePed[i]
            local dist = #(pcoords - vector3(cfg.BurgershotGaragePedLocation.x, cfg.BurgershotGaragePedLocation.y, cfg.BurgershotGaragePedLocation.z))
            if dist < cfg.BurgershotGarageRenderDistance then
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

CreateThread(function()
    DecorRegister('t_vehicle', 1)
end)

RegisterNetEvent('bd-burgershot:client:ToggleDuty', function()
    TriggerServerEvent('QBCore:ToggleDuty')
end)
