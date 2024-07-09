local QBCore = exports['qb-core']:GetCoreObject()
Playerjob = {}

----- | CREATING BURGERSHOT BLIP | -----
CreateThread(function()
    BurgershotBlip = AddBlipForCoord(-1187.93, -891.36, 13.89)
    SetBlipDisplay(BurgershotBlip, 4)
    SetBlipScale(BurgershotBlip, 0.5)
    SetBlipSprite(BurgershotBlip, 536)
    SetBlipColour(BurgershotBlip, 6)
    SetBlipAsShortRange(BurgershotBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Burgershot")
    EndTextCommandSetBlipName(BurgershotBlip)
end)

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
    local cfg = Config.BurgershotGaragePed[index]

    FetchModel(cfg.BurgershotGaragePedModel)

    ----- | CREATING PED | -----
    local BurgershotGaragePed = CreatePed(1, cfg.BurgershotGaragePedModel, cfg.BurgershotGaragePedLocation, false, true)
    FreezeEntityPosition(BurgershotGaragePed, true)
    SetEntityInvincible(BurgershotGaragePed, true)
    SetBlockingOfNonTemporaryEvents(BurgershotGaragePed, true)
    local Player = QBCore.Functions.GetPlayerData()
    local jobRank = Player.job.grade.level
    local jobName = Config.Jobname
    local playerGrade = QBCore.Functions.GetPlayerData().job.grade.level
    ----- | CREATING TARGET FOR PED | -----
    if playerGrade <= 1 then
        exports['qb-target']:AddTargetEntity(BurgershotGaragePed, {
            options = {
                {
                    type = "client",
                    event = "bd-burgershot:client:garageMenu", -- has bike and van
                    icon = "fa-solid fa-warehouse",
                    label = "Garage",
                    job = Config.Jobname
                },
                {
                    type = "client",
                    event = "bd-burgershot:client:storeGarage",
                    icon = "fa-solid fa-square-parking",
                    label = "Store Vehicle",
                    job = Config.Jobname
                },
            },
            distance = 1.5,
        })
    elseif playerGrade == 2 or playerGrade == 3 then
        exports['qb-target']:AddTargetEntity(BurgershotGaragePed, {
            options = {
                {
                    type = "client",
                    event = "bd-burgershot:client:garageMenu1", -- has bike, van, and car.
                    icon = "fa-solid fa-warehouse",
                    label = "Garage",
                    job = Config.Jobname
                },
                {
                    type = "client",
                    event = "bd-burgershot:client:storeGarage",
                    icon = "fa-solid fa-square-parking",
                    label = "Store Vehicle",
                    job = Config.Jobname
                },
            },
            distance = 1.5,
        })
    elseif playerGrade >= 4 then
        exports['qb-target']:AddTargetEntity(BurgershotGaragePed, {
            options = {
                {
                    type = "client",
                    event = "bd-burgershot:client:garageMenu2", -- has bike, car, van and new van
                    icon = "fa-solid fa-warehouse",
                    label = "Garage",
                    job = Config.Jobname
                },
                {
                    type = "client",
                    event = "bd-burgershot:client:storeGarage",
                    icon = "fa-solid fa-square-parking",
                    label = "Store Vehicle",
                    job = Config.Jobname
                },
            },
            distance = 1.5,
        })
    end
    LocalNPCs[index].BurgershotGaragePed = BurgershotGaragePed
end

local function DestroyLocalNPC(index)
    if (LocalNPCs[index]) then
        DeleteEntity(LocalNPCs[index].BurgershotGaragePed)
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
            local cfg = Config.BurgershotGaragePed[i]
            local coords = vector3(cfg.BurgershotGaragePedLocation)
            local dist = #(pcoords - coords)
            local BurgershotGaragePed = GetLocalNPC(i)
            if dist < cfg.BurgershotGarageRenderDistance then 
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

CreateThread(function()
    DecorRegister("t_vehicle", 1)
end)
----- | SETTING THE CLOCK IN/OUT TARGET | -----
exports['qb-target']:AddBoxZone("BurgershotClock", vector3(-1192.99, -898.32, 15.16), 1.9, 1.9, {
    name = "BurgershotClock",
    heading = 122.6,
    debugPoly = false,
    minZ = 15.16 - 2,
    maxZ = 15.16 + 2,
},{
    options = {
        {
            type = "client",
            event = "bd-burgershot:client:ToggleDuty",
            icon = "fa-solid fa-clipboard-user",
            label = 'Clock In/Out',
            job = Config.Jobname
        },
    },
    distance = 1.5
})
RegisterNetEvent('bd-burgershot:client:ToggleDuty', function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)
