local QBCore = exports['qb-core']:GetCoreObject()

----- | MAKE ECOLA | -----
RegisterNetEvent('bd-burgershot:server:MakeEcola', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    exports['qb-inventory']:AddItem(src, 'bs_ecola', 2, false, false)
    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_ecola'], 'add', 2)
    lib.notify(source, {
        id = 'burger_shot',
        title = 'Burgershot',
        description = 'You have poured 2x Ecola',
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
----- | MAKE ECOLALIGHT | -----
RegisterNetEvent('bd-burgershot:server:MakeEcolaLight', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    exports['qb-inventory']:AddItem(src, 'bs_ecola1', 2, false, false)
    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_ecola1'], 'add', 2)
    lib.notify(source, {
        id = 'burger_shot',
        title = 'Burgershot',
        description = 'You have poured 2x Ecola Light',
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
----- | MAKE SPRUNK | -----
RegisterNetEvent('bd-burgershot:server:MakeSprunk', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    exports['qb-inventory']:AddItem(src, 'bs_sprunk', 2, false, false)
    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_sprunk'], 'add', 2)
    lib.notify(source, {
        id = 'burger_shot',
        title = 'Burgershot',
        description = 'You have poured 2x Sprunk',
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
----- | MAKE ORANG-O-TANG | -----
RegisterNetEvent('bd-burgershot:server:MakeOrangoTang', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    exports['qb-inventory']:AddItem(src, 'bs_orangotang', 2, false, false)
    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_orangotang'], 'add', 2)
    lib.notify(source, {
        id = 'burger_shot',
        title = 'Burgershot',
        description = 'You have poured 2x Orang-O-Tang',
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
----- | MAKE COFFEE | -----
RegisterNetEvent('bd-burgershot:server:MakeCoffee', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    exports['qb-inventory']:AddItem(src, 'bs_coffee', 2, false, false)
    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_coffee'], 'add', 2)
    lib.notify(source, {
        id = 'burger_shot',
        title = 'Burgershot',
        description = 'You have poured 2x Coffee',
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
----- | MAKE VANILLA SHAKE | -----
RegisterNetEvent('bd-burgershot:server:MakeVanillaShake', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    exports['qb-inventory']:AddItem(src, 'bs_vanillashake', 2, false, false)
    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_vanillashake'], 'add', 2)
    lib.notify(source, {
        id = 'burger_shot',
        title = 'Burgershot',
        description = 'You have poured 2x Vanilla Milkshake',
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
----- | MAKE STRAWBERRY SHAKE | -----
RegisterNetEvent('bd-burgershot:server:MakeStrawberryShake', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    exports['qb-inventory']:AddItem(src, 'bs_strawberryshake', 2, false, false)
    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_strawberryshake'], 'add', 2)
    lib.notify(source, {
        id = 'burger_shot',
        title = 'Burgershot',
        description = 'You have poured 2x Strawberry Milkshake',
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
----- | MAKE CHOCOLATE SHAKE | -----
RegisterNetEvent('bd-burgershot:server:MakeChocolateShake', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    exports['qb-inventory']:AddItem(src, 'bs_chocolateshake', 2, false, false)
    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_chocolateshake'], 'add', 2)
    lib.notify(source, {
        id = 'burger_shot',
        title = 'Burgershot',
        description = 'You have poured 2x Chocolate Milkshake',
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
----- | MAKE COOKIES N CREAM SHAKE | -----
RegisterNetEvent('bd-burgershot:server:MakeCookiesnCreamShake', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    exports['qb-inventory']:AddItem(src, 'bs_cookiesncreamshake', 2, false, false)
    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_cookiesncreamshake'], 'add', 2)
    lib.notify(source, {
        id = 'burger_shot',
        title = 'Burgershot',
        description = 'You have poured 2x Cookies N Cream Milkshake',
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