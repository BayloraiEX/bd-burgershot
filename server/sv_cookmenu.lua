local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory

if Config.InventorySystem == 'ox' then
    -- MAKE BLEEDER --
    RegisterNetEvent('bd-burgershot:server:MakeBleeder', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        ox_inventory:AddItem(src, 'bs_bleeder', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Bleeder Burgers',
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
    -- MAKE MONEYSHOT --
    RegisterNetEvent('bd-burgershot:server:MakeMoneyshot', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        ox_inventory:AddItem(src, 'bs_moneyshot', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Moneyshot Burgers',
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
    -- MAKE HEARTSTOPPER --
    RegisterNetEvent('bd-burgershot:server:MakeHeartstopper', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        ox_inventory:AddItem(src, 'bs_heartstopper', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Heartstopper Burgers',
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
    -- MAKE TORPEDO --
    RegisterNetEvent('bd-burgershot:server:MakeTorpedo', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        ox_inventory:AddItem(src, 'bs_torpedo', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Torpedo Sandwiches',
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
    -- MAKE NEETFREE BURGER --
    RegisterNetEvent('bd-burgershot:server:MakeMeatFree', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        ox_inventory:AddItem(src, 'bs_meatfree', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Meatfree Burgers',
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
    -- MAKE WRAP --
    RegisterNetEvent('bd-burgershot:server:MakeChickenWrap', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        ox_inventory:AddItem(src, 'bs_chickenwrap', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Chicken Wraps',
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
    -- MAKE FRIES --
    RegisterNetEvent('bd-burgershot:server:MakeFries', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        ox_inventory:AddItem(src, 'bs_fries', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Fries',
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
    -- MAKE ONION RINGS --
    RegisterNetEvent('bd-burgershot:server:MakeOnionRings', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        ox_inventory:AddItem(src, 'bs_onionrings', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Onion Rings',
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
    -- MAKE NUGGETS --
    RegisterNetEvent('bd-burgershot:server:MakeChickenNuggets', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        ox_inventory:AddItem(src, 'bs_nuggets', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Chicken Nuggets',
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
    -- MAKE CREAMPIE --
    RegisterNetEvent('bd-burgershot:server:MakeCreamPie', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        ox_inventory:AddItem(src, 'bs_creampie', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have baked 2x Apple Cream Pies',
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
    -- MAKE RIMJOB --
    RegisterNetEvent('bd-burgershot:server:MakeRimJob', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        ox_inventory:AddItem(src, 'bs_rimjob', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have baked 2x Rim Jobs',
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
elseif Config.InventorySystem == 'qb' then
    -- MAKE BLEEDER --
    RegisterNetEvent('bd-burgershot:server:MakeBleeder', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        exports['qb-inventory']:AddItem(src, 'bs_bleeder', 2, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_bleeder'], 'add', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Bleeder Burgers',
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
    -- MAKE MONEYSHOT --
    RegisterNetEvent('bd-burgershot:server:MakeMoneyshot', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        exports['qb-inventory']:AddItem(src, 'bs_moneyshot', 2, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_moneyshot'], 'add', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Moneyshot Burgers',
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
    -- MAKE HEARTSTOPPER --
    RegisterNetEvent('bd-burgershot:server:MakeHeartstopper', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        exports['qb-inventory']:AddItem(src, 'bs_heartstopper', 2, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_heartstopper'], 'add', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Heartstopper Burgers',
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
    -- MAKE TORPEDO --
    RegisterNetEvent('bd-burgershot:server:MakeTorpedo', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        exports['qb-inventory']:AddItem(src, 'bs_torpedo', 2, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_torpedo'], 'add', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Torpedo Sandwiches',
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
    -- MAKE NEETFREE BURGER --
    RegisterNetEvent('bd-burgershot:server:MakeMeatFree', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        exports['qb-inventory']:AddItem(src, 'bs_meatfree', 2, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_meatfree'], 'add', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Meatfree Burgers',
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
    -- MAKE WRAP --
    RegisterNetEvent('bd-burgershot:server:MakeWrap', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        exports['qb-inventory']:AddItem(src, 'bs_chickenwrap', 2, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_chickenwrap'], 'add', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Chicken Wraps',
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
    -- MAKE FRIES --
    RegisterNetEvent('bd-burgershot:server:MakeFries', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        exports['qb-inventory']:AddItem(src, 'bs_fries', 2, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_fries'], 'add', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Fries',
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
    -- MAKE ONION RINGS --
    RegisterNetEvent('bd-burgershot:server:MakeOnionRings', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        exports['qb-inventory']:AddItem(src, 'bs_onionrings', 2, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_onionrings'], 'add', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Onion Rings',
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
    -- MAKE NUGGETS --
    RegisterNetEvent('bd-burgershot:server:MakeChickenNuggets', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        exports['qb-inventory']:AddItem(src, 'bs_nuggets', 2, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_nuggets'], 'add', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have grilled 2x Chicken Nuggets',
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
    -- MAKE CREAMPIE --
    RegisterNetEvent('bd-burgershot:server:MakeCreamPie', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        exports['qb-inventory']:AddItem(src, 'bs_creampie', 2, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_creampie'], 'add', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have baked 2x Apple Cream Pies',
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
    -- MAKE RIMJOB --
    RegisterNetEvent('bd-burgershot:server:MakeRimJob', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        exports['qb-inventory']:AddItem(src, 'bs_rimjob', 2, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_rimjob'], 'add', 2)
        lib.notify(source, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'You have baked 2x Rim Jobs',
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
end