local QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}

----- | CREATING INVENTORIES | -----
-- 1 
exports['qb-target']:AddBoxZone("BurgerShotFrontTray1", vector3(-1196.25, -890.73, 14.0), 0.9, 0.9, {
	name = "BurgerShotFrontTray1",
	heading = 347.27,
	debugPoly = false,
	minZ = 14.0 - 2,
	maxZ = 14.0 + 2,
}, {
	options = {
		{
            type = "client",
            event = "bd-burgershot:client:bfrontTray1",
			icon = "fa-solid fa-equals",
			label = "Burgershot Counter",
		},
	},
	distance = 2.5
})
RegisterNetEvent("bd-burgershot:client:bfrontTray1", function()
    TriggerServerEvent('bd-burgershot:server:bfrontTray1')
end)

-- 2 
exports['qb-target']:AddBoxZone("BurgershotFrontTray2", vector3(-1195.32, -892.17, 14.0), 0.9, 0.9, {
	name = "BurgershotFrontTray2",
	heading = 347.27,
	debugPoly = false,
	minZ = 14.0 - 2,
	maxZ = 14.0 + 2,
}, {
	options = {
		{
            type = "client",
            event = "bd-burgershot:client:bfrontTray2",
			icon = "fa-solid fa-equals",
			label = "Burgershot Counter",
		},
	},
	distance = 2.5
})
RegisterNetEvent("bd-burgershot:client:bfrontTray2", function()
    TriggerServerEvent('bd-burgershot:server:bfrontTray2')
end)

-- 3 
exports['qb-target']:AddBoxZone("BurgershotFrontTray3", vector3(-1193.81, -894.47, 14.0), 0.9, 0.9, {
	name = "BurgershotFrontTray3",
	heading = 347.27,
	debugPoly = false,
	minZ = 14.0 - 2,
	maxZ = 14.0 + 2,
}, {
	options = {
		{
            type = "client",
            event = "bd-burgershot:client:bfrontTray3",
			icon = "fa-solid fa-equals",
			label = "Burgershot Tray",
		},
	},
	distance = 2.5
})
RegisterNetEvent("bd-burgershot:client:bfrontTray3", function()
    TriggerServerEvent('bd-burgershot:server:bfrontTray3')
end)

-- FRIDGE --
exports['qb-target']:AddBoxZone("BurgershotJobFridge", vector3(-1203.61, -895.74, 14.0), 0.9, 0.9, {
	name = "BurgershotJobFridge",
	heading = 347.27,
	debugPoly = false,
	minZ = 14.0 - 2,
	maxZ = 14.0 + 2,
}, {
	options = {
		{
            type = "client",
            event = "bd-burgershot:client:bjobFridge",
			icon = "fa-solid fa-temperature-empty",
			label = "Fridge",
			job = Config.Jobname,
		},
	},
	distance = 2.5
})

RegisterNetEvent("bd-burgershot:client:bjobFridge", function()
    TriggerServerEvent('bd-burgershot:server:bjobFridge')
end)

-- HEATER --
exports['qb-target']:AddCircleZone("BurgershotJobHeater", vector3(-1197.82, -894.23, 14.0), 1.0, {
	name = "BurgershotJobHeater",
	debugPoly = false,
}, {
	options = {
		{
            type = "client",
            event = "bd-burgershot:client:bjobHeater",
			icon = "fa-solid fa-temperature-arrow-up",
			label = "Heater",
			job = Config.Jobname,
		},
	},
	distance = 2.5
})

RegisterNetEvent("bd-burgershot:client:bjobHeater", function()
    TriggerServerEvent('bd-burgershot:server:bjobHeater')
end)

--STORAGE--
exports['qb-target']:AddBoxZone("BurgerShotBackStorage", vector3(-1204.94, -893.77, 14.0), 0.9, 0.9, {
	name = "BurgerShotBackStorage",
	heading = 347.27,
	debugPoly = false,
	minZ = 14.0 - 2,
	maxZ = 14.0 + 2,
}, {
	options = {
		{
            type = "client",
            event = "bd-burgershot:client:bbackStorage",
			icon = "fa-solid fa-equals",
			label = "Back Storage",
			job = Config.Jobname,
		},
	},
	distance = 2.5
})
RegisterNetEvent("bd-burgershot:client:bbackStorage", function()
    TriggerServerEvent('bd-burgershot:server:bbackStorage')
end)
