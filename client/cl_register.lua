local QBCore = exports['qb-core']:GetCoreObject()

if Config.TargetSystem == 'qb' then
    -- REGISTER 1 --
    exports['qb-target']:AddBoxZone("BurgershotRegister", vector3(-1196.27, -891.53, 14.0), 0.9, 0.9, {
        name = "BurgershotRegister",
        heading = 335.05,
        debugPoly = false,
        minZ = 14.0 - 2,
        maxZ = 14.0 + 2,
    }, {
        options = {
            {
                type = "client",
                event = "bd-burgershot:client:Bill",
                icon = "fa-solid fa-cash-register",
                label = "Register",
                job = Config.Jobname,
            },
        },
        distance = 2.5
    })
    -- REGISTER 2 --
    exports['qb-target']:AddBoxZone("BurgershotRegister2", vector3(-1194.92, -893.48, 14.0), 0.9, 0.9, {
        name = "BurgershotRegister",
        heading = 335.05,
        debugPoly = false,
        minZ = 14.0 - 2,
        maxZ = 14.0 + 2,
    }, {
        options = {
            {
                type = "client",
                event = "bd-burgershot:client:Bill",
                icon = "fa-solid fa-cash-register",
                label = "Register",
                job = Config.Jobname,
            },
        },
        distance = 2.5
    })
    -- REGISTER 3 --
    exports['qb-target']:AddBoxZone("BurgershotRegister3", vector3(-1193.3, -895.05, 14.0), 0.9, 0.9, {
        name = "BurgershotRegister",
        heading = 335.05,
        debugPoly = false,
        minZ = 14.0 - 2,
        maxZ = 14.0 + 2,
    }, {
        options = {
            {
                type = "client",
                event = "bd-burgershot:client:Bill",
                icon = "fa-solid fa-cash-register",
                label = "Register",
                job = Config.Jobname,
            },
        },
        distance = 2.5
    })
elseif Config.TargetSystem == 'ox' then
    -- REGISTER 1 --
    exports.ox_target:addBoxZone({
		coords = vector4(-1196.16, -891.37, 14.06, 305.83),
		size = vec3(1, 1, 1),
		rotation = 45,
		options = {
			{
				name = 'burgershot_register1',
				event = 'bd-burgershot:client:Bill',
				icon = 'fa-solid fa-cash-register',
				label = 'Register',
				groups = {
					Config.Jobname
				},
			},
		}
	})
    -- REGISTER 2 --
    exports.ox_target:addBoxZone({
		coords = vector4(-1194.59, -893.21, 14.0, 305.16),
		size = vec3(1, 1, 1),
		rotation = 45,
		options = {
			{
				name = 'burgershot_register2',
				event = 'bd-burgershot:client:Bill',
				icon = 'fa-solid fa-cash-register',
				label = 'Register',
				groups = {
					Config.Jobname
				},
			},
		}
	})
    -- REGISTER 3 --
    exports.ox_target:addBoxZone({
		coords = vector4(-1193.22, -895.13, 14.0, 34.0),
		size = vec3(1, 1, 1),
		rotation = 45,
		options = {
			{
				name = 'burgershot_register3',
				event = 'bd-burgershot:client:Bill',
				icon = 'fa-solid fa-cash-register',
				label = 'Register',
				groups = {
					Config.Jobname
				},
			},
		}
	})
end

RegisterNetEvent("bd-burgershot:client:Bill", function()
    local bill = lib.inputDialog('Burgershot Register', {
        { type = 'input', label = 'Citizen ID', description = 'Players Citizen ID', icon = 'id-card'},
        { type = 'number', label = 'Bill Amount', description = 'How much to charge customer', icon = 'dollar-sign'}
    })
    if bill ~= nil then -- If the bill is NOT equal to nothing 
        if bill[1] == nil or bill[2] == nil then
            return
        end
        -- If the bill is NOT equal to nothing then do the below
        TriggerServerEvent('bd-burgershot:server:billPlayer', bill[1], bill[2])
    end
end)

RegisterNetEvent("bd-burgershot:client:BillAlert", function(playerId, amount)
    local biller = QBCore.Functions.GetPlayer(source)
    local billed = QBCore.Functions.GetPlayer(tonumber(playerId))
    local amount = tonumber(amount)

    local alert = lib.alertDialog(billed.PlayerData.source, {
        header = 'Burgershot Bill',
        content = 'Would you like to Accept or Deny this purchase?',
        centered = true,
        cancel = true,
        labels = {
            confirm = 'Accept',
            cancel = 'Deny',
        },
    })
    if alert == 'confirm' then
        lib.notify(biller, {
            title = 'Burgershot',
            description = 'You charged a customer.',
            type = 'success'
        })
        lib.notify(billed, {
            title = 'Burgershot',
            description = 'You have been charged $'..amount..' fore your order.',
            type = 'success'
        })
    elseif alert == 'cancel' then
        lib.notify(biller, {
            title = 'Burgershot',
            description = 'Customer has denied the bill.',
            type = 'warning'
        })
        lib.notify(billed, {
            title = 'Burgershot',
            description = 'You have denied the bill from Burgershot',
            type = 'success'
        })
    end
end)