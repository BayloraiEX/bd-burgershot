local QBCore = exports['qb-core']:GetCoreObject()

if Config.TargetSystem == 'ox' then
    ----- | CREATING COOK MENU TARGET | -----
    exports.ox_target:addBoxZone({
		coords = vector4(-1202.75, -897.33, 14.0, 303.63),
		size = vec3(1, 1, 1),
		rotation = 45,
		debug = drawZones,
		options = {
			{
				name = 'burgershot:cookmenu',
				event = 'bd-burgershot:client:OpenCookMenu',
				icon = 'fa-solid fa-fire-burner',
				label = 'Cook Menu',
                groups = {
                    Config.Jobname
                },
			},
		}
	})
    ----- | CREATING FRYER MENU TARGET | -----
    exports.ox_target:addBoxZone({
		coords = vector4(-1202.02, -898.64, 13.69, 308.93),
		size = vec3(1, 1, 1),
		rotation = 45,
		debug = drawZones,
		options = {
			{
				name = 'burgershot:cookmenu',
				event = 'bd-burgershot:client:OpenFryerMenu',
				icon = 'fa-solid fa-fire-burner',
				label = 'Fryer Menu',
                groups = {
                    Config.Jobname
                },
			},
		}
	})
elseif Config.TargetSystem == 'qb' then
    ----- | CREATING COOK MENU TARGET | -----
    exports['qb-target']:AddBoxZone("BurgershotCookMenu", vector3(-1202.93, -897.46, 14.0), 0.9, 0.9, {
        name = "BurgershotCookMenu",
        heading = 300.45,
        debugPoly = false,
        minZ = 14.0 - 2,
        maxZ = 14.0 + 2,
    }, {
        options = {
            {
                type = "client",
                event = "bd-burgershot:client:OpenCookMenu",
                icon = "fa-solid fa-fire-burner",
                label = "Cook Menu",
                job = Config.Jobname
            },
        },
        distance = 1.5
    })
    ----- | CREATING FRYER MENU TARGET | -----
    exports['qb-target']:AddBoxZone("BurgershotFryerMenu", vector3(-1201.45, -899.0, 14.0), 0.9, 0.9, {
        name = "BurgershotFryerMenu",
        heading = 300.45,
        debugPoly = false,
        minZ = 14.0 - 2,
        maxZ = 14.0 + 2,
    }, {
        options = {
            {
                type = "client",
                event = "bd-burgershot:client:OpenFryerMenu",
                icon = "fa-solid fa-fire-burner",
                label = "Fryer Menu",
                job = Config.Jobname
            },
        },
        distance = 1.5
    })
end
lib.registerContext({
    id = 'burgershot_cooks',
    title = 'Cooking Menu',
    options = {
        {
            title = 'Burgers & Wraps',
            description = 'All our Burgers, Sandwiches and Wraps',
            menu = 'burgershot_burgers',
        },
        {
            title = 'Deserts',
            description = 'All our desert items',
            menu = 'burgershot_extras',
        },
    },
})
RegisterNetEvent('bd-burgershot:client:OpenCookMenu', function()
    lib.showContext('burgershot_cooks')
end)
lib.registerContext({
    id = 'burgershot_burgers',
    title = 'Main Menu',
    menu = 'burgershot_cooks',
    options = {
        {
            title = 'Bleeder Burger',
            description = 'Make 2x Bleeder Burgers',
            event = 'bd-burgershot:client:MakeBleeder',
            icon = 'burger',
            iconColor = '#EC213A'
        },
        {
            title = 'Moneyshot Burger',
            description = 'Make 2x Moneyshot Burgers',
            event = 'bd-burgershot:client:MakeMoneyshot',
            icon = 'burger',
            iconColor = '#EC213A'
        },
        {
            title = 'Heartstopper Burger',
            description = 'Make 2x Heartstopper Burgers',
            event = 'bd-burgershot:client:MakeHeartstopper',
            icon = 'burger',
            iconColor = '#EC213A'
        },
        {
            title = 'Torpedo Sandwich',
            description = 'Make 2x Torpedo Sandwiches',
            event = 'bd-burgershot:client:MakeTorpedo',
            icon = 'bread-slice',
            iconColor = '#EC213A'
        },
        {
            title = 'Meatfree Burger',
            description = 'Make 2x Meatfree Burgers',
            event = 'bd-burgershot:client:MakeMeatFree',
            icon = 'burger',
            iconColor = '#EC213A'
        },
        {
            title = 'Chicken Wrap',
            description = 'Make 2x Chicken Wraps',
            event = 'bd-burgershot:client:MakeChickenWrap',
            icon = 'bread-slice',
            iconColor = '#EC213A'
        },
    },
})
lib.registerContext({
    id = 'burgershot_extras',
    title = 'Deserts',
    menu = 'burgershot_cooks',
    options = {
        {
            title = 'Rimjob',
            description = 'Make 2x Rimjobs',
            event = 'bd-burgershot:client:MakeRimJob',
            icon = 'cookie',
            iconColor = '#EC213A'
        },
        {
            title = 'Apple Creampie',
            description = 'Make 2x Apple Creampies',
            event = 'bd-burgershot:client:MakeCreamPie',
            icon = 'cookie',
            iconColor = '#EC213A'
        },
    },
})
---------------------------------------------------------------------------------------------------------------
lib.registerContext({
    id = 'burgershot_fryer',
    title = 'Fryer Menu',
    options = {
        {
            title = 'Fries',
            description = 'Make 2x Fries',
            event = 'bd-burgershot:client:MakeFries',
            icon = 'drumstick-bite',
            iconColor = '#EC213A'
        },
        {
            title = 'Onion Rings',
            description = 'Make 2x Onion Rings',
            event = 'bd-burgershot:client:MakeOnionRings',
            icon = 'drumstick-bite',
            iconColor = '#EC213A'
        },
        {
            title = 'Chicken Nuggets',
            description = 'Make 2x Chicken Nuggets',
            event = 'bd-burgershot:client:MakeChickenNuggets',
            icon = 'drumstick-bite',
            iconColor = '#EC213A'
        },
    },
})
RegisterNetEvent('bd-burgershot:client:OpenFryerMenu', function()
    lib.showContext('burgershot_fryer')
end)
------|--------------------|------
----- | CREATING THE FOODS | -----
------|--------------------|------
RegisterNetEvent('bd-burgershot:client:MakeBleeder', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "grilling", 0.2)
    if lib.progressCircle({
        duration = 2000, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the drink pour )
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
        },
        anim = {
            dict = 'amb@prop_human_bbq@male@idle_a',
            clip = 'idle_a',
            scenario = 'amb@prop_human_bbq@male@idle_a'
        },
    }) then
        TriggerServerEvent('bd-burgershot:server:MakeBleeder')
    else
    end
end)
RegisterNetEvent('bd-burgershot:client:MakeMoneyshot', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "grilling", 0.2)
    if lib.progressCircle({
        duration = 2000, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the drink pour )
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
        },
        anim = {
            dict = 'amb@prop_human_bbq@male@idle_a',
            clip = 'idle_a',
            scenario = 'amb@prop_human_bbq@male@idle_a'
        },
    }) then
        TriggerServerEvent('bd-burgershot:server:MakeMoneyshot')
    else
    end
end)
RegisterNetEvent('bd-burgershot:client:MakeHeartstopper', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "grilling", 0.2)
    if lib.progressCircle({
        duration = 2000, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the drink pour )
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
        },
        anim = {
            dict = 'amb@prop_human_bbq@male@idle_a',
            clip = 'idle_a',
            scenario = 'amb@prop_human_bbq@male@idle_a'
        },
    }) then
        TriggerServerEvent('bd-burgershot:server:MakeHeartstopper')
    else
    end
end)
RegisterNetEvent('bd-burgershot:client:MakeTorpedo', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "grilling", 0.2)
    if lib.progressCircle({
        duration = 2000, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the drink pour )
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
        },
        anim = {
            dict = 'amb@prop_human_bbq@male@idle_a',
            clip = 'idle_a',
            scenario = 'amb@prop_human_bbq@male@idle_a'
        },
    }) then
        TriggerServerEvent('bd-burgershot:server:MakeTorpedo')
    else
    end
end)
RegisterNetEvent('bd-burgershot:client:MakeMeatFree', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "grilling", 0.2)
    if lib.progressCircle({
        duration = 2000, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the drink pour )
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
        },
        anim = {
            dict = 'amb@prop_human_bbq@male@idle_a',
            clip = 'idle_a',
            scenario = 'amb@prop_human_bbq@male@idle_a'
        },
    }) then
        TriggerServerEvent('bd-burgershot:server:MakeMeatFree')
    else
    end
end)
RegisterNetEvent('bd-burgershot:client:MakeChickenWrap', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "grilling", 0.2)
    if lib.progressCircle({
        duration = 2000, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the drink pour )
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
        },
        anim = {
            dict = 'amb@prop_human_bbq@male@idle_a',
            clip = 'idle_a',
            scenario = 'amb@prop_human_bbq@male@idle_a'
        },
    }) then
        TriggerServerEvent('bd-burgershot:server:MakeChickenWrap')
    else
    end
end)
RegisterNetEvent('bd-burgershot:client:MakeCreamPie', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "grilling", 0.2)
    if lib.progressCircle({
        duration = 2000, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the drink pour )
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
        },
        anim = {
            dict = 'amb@prop_human_bbq@male@idle_a',
            clip = 'idle_a',
            scenario = 'amb@prop_human_bbq@male@idle_a'
        },
    }) then
        TriggerServerEvent('bd-burgershot:server:MakeCreamPie')
    else
    end
end)
RegisterNetEvent('bd-burgershot:client:MakeRimJob', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "grilling", 0.2)
    if lib.progressCircle({
        duration = 2000, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the drink pour )
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
        },
        anim = {
            dict = 'amb@prop_human_bbq@male@idle_a',
            clip = 'idle_a',
            scenario = 'amb@prop_human_bbq@male@idle_a'
        },
    }) then
        TriggerServerEvent('bd-burgershot:server:MakeRimJob')
    else
    end
end)
RegisterNetEvent('bd-burgershot:client:MakeFries', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "deepfry", 0.1)
    if lib.progressCircle({
        duration = 1600, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the drink pour )
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
        TriggerServerEvent('bd-burgershot:server:MakeFries')
    else
    end
end)
RegisterNetEvent('bd-burgershot:client:MakeOnionRings', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "deepfry", 0.1)
    if lib.progressCircle({
        duration = 1600, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the drink pour )
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
        TriggerServerEvent('bd-burgershot:server:MakeOnionRings')
    else
    end
end)
RegisterNetEvent('bd-burgershot:client:MakeChickenNuggets', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "deepfry", 0.1)
    if lib.progressCircle({
        duration = 1600, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the drink pour )
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
        TriggerServerEvent('bd-burgershot:server:MakeChickenNuggets')
    else
    end
end)