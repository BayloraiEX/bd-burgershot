local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory
PlayerJob = {}
if Config.InventorySystem == 'qb' then
	-- FRONT TRAY 1 --
	RegisterNetEvent("bd-burgershot:client:bfrontTray1", function()
		TriggerServerEvent('bd-burgershot:server:bfrontTray1')
	end)
	-- FRONT TRAY 2 --
	RegisterNetEvent("bd-burgershot:client:bfrontTray2", function()
		TriggerServerEvent('bd-burgershot:server:bfrontTray2')
	end)
	-- FRONT TRAY 3 --
	RegisterNetEvent("bd-burgershot:client:bfrontTray3", function()
		TriggerServerEvent('bd-burgershot:server:bfrontTray3')
	end)
	-- FRIDGE --
	RegisterNetEvent("bd-burgershot:client:bjobFridge", function()
		TriggerServerEvent('bd-burgershot:server:bjobFridge')
	end)
	-- HEATER --
	RegisterNetEvent("bd-burgershot:client:bjobHeater", function()
		TriggerServerEvent('bd-burgershot:server:bjobHeater')
	end)
	-- STORAGE --
	RegisterNetEvent("bd-burgershot:client:bbackStorage", function()
		TriggerServerEvent('bd-burgershot:server:bbackStorage')
	end)
elseif Config.InventorySystem == 'ox' then
	-- FRONT TRAY 1 --
	RegisterNetEvent('bd-burgershot:client:bfrontTray1', function()
		if ox_inventory:openInventory('stash', 'bfrontTray1') == false then
			TriggerServerEvent('ox:bfrontTray1')
			ox_inventory:openInventory('stash', 'bfrontTray1')
		end
	end)
	-- FRONT TRAY 2 --
	RegisterNetEvent('bd-burgershot:client:bfrontTray2', function()
		if ox_inventory:openInventory('stash', 'bfrontTray2') == false then
			TriggerServerEvent('ox:bfrontTray2')
			ox_inventory:openInventory('stash', 'bfrontTray2')
		end
	end)
	-- FRONT TRAY 3 --
	RegisterNetEvent('bd-burgershot:client:bfrontTray3', function()
		if ox_inventory:openInventory('stash', 'bfrontTray3') == false then
			TriggerServerEvent('ox:bfrontTray3')
			ox_inventory:openInventory('stash', 'bfrontTray3')
		end
	end)
	-- FRIDGE --
	RegisterNetEvent('bd-burgershot:client:bjobFridge', function()
		if ox_inventory:openInventory('stash', 'bjobFridge') == false then
			TriggerServerEvent('ox:bjobFridge')
			ox_inventory:openInventory('stash', 'bjobFridge')
		end
	end)
	-- HEATER --
	RegisterNetEvent('bd-burgershot:client:bjobHeater', function()
		if ox_inventory:openInventory('stash', 'bjobHeater') == false then
			TriggerServerEvent('ox:bjobHeater')
			ox_inventory:openInventory('stash', 'bjobHeater')
		end
	end)
	-- STORAGE --
	RegisterNetEvent('bd-burgershot:client:bbackStorage', function()
		if ox_inventory:openInventory('stash', 'bbackStorage') == false then
			TriggerServerEvent('ox:bbackStorage')
			ox_inventory:openInventory('stash', 'bbackStorage')
		end
	end)
end
if Config.TargetSystem == 'ox' then
	-- FRONT TRAY 1 --
	exports.ox_target:addBoxZone({
		coords = vector4(-1196.45, -890.52, 14.04, 292.65),
		size = vec3(1, 1, 1),
		rotation = 45,
		debug = drawZones,
		options = {
			{
				name = 'burgershot_tray1',
				event = 'bd-burgershot:client:bfrontTray1',
				icon = 'fa-solid fa-equals',
				label = 'Counter',
			},
		}
	})
	-- FRONT TRAY 2 --
	exports.ox_target:addBoxZone({
		coords = vector4(-1195.29, -892.44, 14.11, 1.55),
		size = vec3(1, 1, 1),
		rotation = 45,
		debug = drawZones,
		options = {
			{
				name = 'burgershot_tray1',
				event = 'bd-burgershot:client:bfrontTray2',
				icon = 'fa-solid fa-equals',
				label = 'Counter',
			},
		}
	})
	-- FRONT TRAY 3 --
	exports.ox_target:addBoxZone({
		coords = vector4(-1193.87, -894.34, 14.47, 124.23),
		size = vec3(1, 1, 1),
		rotation = 45,
		debug = drawZones,
		options = {
			{
				name = 'burgershot_tray1',
				event = 'bd-burgershot:client:bfrontTray3',
				icon = 'fa-solid fa-equals',
				label = 'Tray',
			},
		}
	})
	-- FRIDGE --
	exports.ox_target:addBoxZone({
		coords = vector4(-1203.59, -895.77, 13.99, 302.81),
		size = vec3(1, 1, 1),
		rotation = 45,
		debug = drawZones,
		options = {
			{
				name = 'burgershot_fridge',
				event = 'bd-burgershot:client:bjobFridge',
				icon = 'fa-solid fa-temperature-empty',
				label = 'Fridge',
				groups = {
					burgershot = 0
				},
			},
		}
	})
	-- HEATER --
	exports.ox_target:addBoxZone({
		coords = vector4(-1197.89, -894.37, 14.04, 223.05),
		size = vec3(2, 2, 2),
		rotation = 45,
		debug = drawZones,
		options = {
			{
				name = 'burgershot_heater',
				event = 'bd-burgershot:client:bjobHeater',
				icon = 'fa-solid fa-temperature-arrow-up',
				label = 'Heater',
				groups = {
					burgershot = 0
				},
			},
		}
	})
	-- STORAGE --
	exports.ox_target:addBoxZone({
		coords = vector4(-1205.04, -893.61, 14.0, 293.61),
		size = vec3(1, 1, 1),
		rotation = 45,
		debug = drawZones,
		options = {
			{
				name = 'burgershot_storage',
				event = 'bd-burgershot:client:bbackStorage',
				icon = 'fa-solid fa-boxes',
				label = 'Storage',
				groups = {
					burgershot = 0
				},
			},
		}
	})
elseif Config.TargetSystem == 'qb' then
	-- FRONT TRAY 1 --
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
	-- FRONT TRAY 2 --
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
	-- FRONT TRAY 3 --
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
	-- STORAGE --
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
end
