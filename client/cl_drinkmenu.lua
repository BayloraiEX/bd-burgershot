local QBCore = exports['qb-core']:GetCoreObject()

if Config.InventorySystem == 'ox' then
    ----- | CREATING DRINK MENU TARGET | -----
    exports.ox_target:addBoxZone({
		coords = vector4(-1199.64, -895.56, 14.13, 271.33),
		size = vec3(1, 1, 1),
		rotation = 45,
		debug = drawZones,
		options = {
			{
				name = 'burgershot_drinkmenu',
				event = 'bd-burgershot:client:OpenDrinkMenu',
				icon = 'fa-solid fa-equals',
				label = 'Drink Menu',
                groups = {
                    Config.Jobname
                },
			},
		}
	})
elseif Config.InventorySystem == 'qb' then
    ----- | CREATING DRINK MENU TARGET | -----
    exports['qb-target']:AddBoxZone("BurgershotDrinkMenu", vector3(-1199.44, -895.52, 14.0), 0.9, 0.9, {
        name = "BurgershotDrinkMenu",
        heading = 300.45,
        debugPoly = false,
        minZ = 14.0 - 2,
        maxZ = 14.0 + 2,
    }, {
        options = {
            {
                type = "client",
                event = "bd-burgershot:client:OpenDrinkMenu",
                icon = "fa-solid fa-faucet",
                label = "Drink Menu",
                job = Config.Jobname
            },
        },
        distance = 1.5
    })
end
lib.registerContext({
    id = 'burgershot_drinks',
    title = 'Drink Menu',
    options = {
        {
            title = 'Soft Drinks',
            description = 'All our soft drink types',
            menu = 'burgershot_softdrinks',
        },
        {
            title = 'Coffee',
            description = 'All our coffee types',
            menu = 'burgershot_coffee',
        },
        {
            title = 'Milkshakes',
            description = 'My milkshakes bring all the boys/girls to the yard',
            menu = 'burgershot_milkshakes',
        },
    },
})
RegisterNetEvent('bd-burgershot:client:OpenDrinkMenu', function()
    lib.showContext('burgershot_drinks')
end)
lib.registerContext({
    id = 'burgershot_softdrinks',
    title = 'Soft Drinks',
    menu = 'burgershot_drinks',
    options = {
        {
            title = 'Ecola',
            description = 'Pour 2x Ecola',
            event = 'bd-burgershot:client:MakeEcola',
            icon = 'faucet-drip',
            iconColor = '#EC213A'
        },
        {
            title = 'Ecola Light',
            description = 'Pour 2x Ecola Light',
            event = 'bd-burgershot:client:MakeEcolaLight',
            icon = 'faucet-drip',
            iconColor = '#EC213A'
        },
        {
            title = 'Sprunk',
            description = 'Pour 2x Sprunk',
            event = 'bd-burgershot:client:MakeSprunk',
            icon = 'faucet-drip',
            iconColor = '#EC213A'
        },
        {
            title = 'Orang-O-Tang',
            description = 'Pour 2x Orang-O-Tang',
            event = 'bd-burgershot:client:MakeOrangoTang',
            icon = 'faucet-drip',
            iconColor = '#EC213A'
        },
    },
})
lib.registerContext({
    id = 'burgershot_coffee',
    title = 'Coffee',
    menu = 'burgershot_drinks',
    options = {
        {
            title = 'Coffee',
            description = 'Pour 2x Coffee',
            event = 'bd-burgershot:client:MakeCoffee',
            icon = 'mug-hot',
            iconColor = '#EC213A'
        },
    },
})
lib.registerContext({
    id = 'burgershot_milkshakes',
    title = 'Milkshakes',
    menu = 'burgershot_drinks',
    options = {
        {
            title = 'Vanilla Milkshake',
            description = 'Make 2x Vanilla Milkshake',
            event = 'bd-burgershot:client:MakeVanillaShake',
            icon = 'ice-cream',
            iconColor = '#EC213A'
        },
        {
            title = 'Chocolate Milkshake',
            description = 'Make 2x Chocolate Milkshake',
            event = 'bd-burgershot:client:MakeChocolateShake',
            icon = 'ice-cream',
            iconColor = '#EC213A'
        },
        {
            title = 'Strawberry Milkshake',
            description = 'Make 2x Strawberry Milkshake',
            event = 'bd-burgershot:client:MakeStrawberryShake',
            icon = 'ice-cream',
            iconColor = '#EC213A'
        },
        {
            title = 'Cookies N Cream Milkshake',
            description = 'Make 2x Cookies N Cream Milkshake',
            event = 'bd-burgershot:client:MakeCookiesnCreamShake',
            icon = 'ice-cream',
            iconColor = '#EC213A'
        },
    },
})
------|---------------------|------
----- | CREATING THE DRINKS | -----
------|---------------------|------
RegisterNetEvent('bd-burgershot:client:MakeEcola', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "watermachine", 0.2)
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
            dict = 'mini@repair',
            clip = 'fixing_a_player',
            scenario = 'mini@repair'
        },
    }) then
        TriggerServerEvent('bd-burgershot:server:MakeEcola')
    else
    end
end)

RegisterNetEvent('bd-burgershot:client:MakeEcolaLight', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "watermachine", 0.2)
    if lib.progressCircle({
        duration = 2000,
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
        TriggerServerEvent('bd-burgershot:server:MakeEcolaLight')
    else
    end
end)

RegisterNetEvent('bd-burgershot:client:MakeSprunk', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "watermachine", 0.2)
    if lib.progressCircle({
        duration = 2000,
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
        TriggerServerEvent('bd-burgershot:server:MakeSprunk')
    else
    end
end)

RegisterNetEvent('bd-burgershot:client:MakeOrangoTang', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "watermachine", 0.2)
    if lib.progressCircle({
        duration = 2000,
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
        TriggerServerEvent('bd-burgershot:server:MakeOrangoTang')
    else
    end
end)

-- COFFEE --
RegisterNetEvent('bd-burgershot:client:MakeCoffee', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "coffee_pour", 0.2)
    if lib.progressCircle({
        duration = 1500, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the coffee pour )
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
        TriggerServerEvent('bd-burgershot:server:MakeCoffee')
    else
    end
end)
-- MILKSHAKES --
RegisterNetEvent('bd-burgershot:client:MakeVanillaShake', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "milkshake_machine", 0.2)
    if lib.progressCircle({
        duration = 1500, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the coffee pour )
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
        TriggerServerEvent('bd-burgershot:server:MakeVanillaShake')
    else
    end
end)

RegisterNetEvent('bd-burgershot:client:MakeStrawberryShake', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "milkshake_machine", 0.2)
    if lib.progressCircle({
        duration = 1500, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the coffee pour )
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
        TriggerServerEvent('bd-burgershot:server:MakeStrawberryShake')
    else
    end
end)

RegisterNetEvent('bd-burgershot:client:MakeChocolateShake', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "milkshake_machine", 0.2)
    if lib.progressCircle({
        duration = 1500, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the coffee pour )
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
        TriggerServerEvent('bd-burgershot:server:MakeChocolateShake')
    else
    end
end)

RegisterNetEvent('bd-burgershot:client:MakeCookiesnCreamShake', function()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "milkshake_machine", 0.2)
    if lib.progressCircle({
        duration = 1500, -- If you change this the sound will play longer then the bar ( can just comment the sound out if you dont care bout hearing the coffee pour )
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
        TriggerServerEvent('bd-burgershot:server:MakeCookiesnCreamShake')
    else
    end
end)