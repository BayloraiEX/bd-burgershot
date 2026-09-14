# bd-burgershot
- Detailed Burgershot job with QBCORE using ox_lib
- Updated to the latest QBCore

# SUPPORT OR QUESTIONS
DISCORD - https://discord.gg/hya9t8XfH8

# VIDEO SHOWCASE
VIDEO - https://youtu.be/dDIrMdZ5Wik

# DEPENDENCIES
- qb-core
- ox_lib
- qb_target

# RESOURCES
MLO - https://www.gta5-mods.com/maps/gtaiv-burgershot-interior-sp-and-fivem

# INSTALLATION
- Start after [qb]
EAMPLE:
- ensure [qb]
- ensure bd-burgershot

# JOB
- Copy and paste into your qb-core --> shared --> jobs.lua
```
burgershot = {
		label = 'Burgershot',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Janitor', payment = 30 },
			['1'] = { name = 'Employee', payment = 40 },
			['2'] = { name = 'Sr-Employee', payment = 50 },
			['3'] = { name = 'Ast-Manager', payment = 60 },
			['4'] = { name = 'Manager', isboss = true, payment = 75 },
			['5'] = { name = 'CEO', isboss = true, payment = 90 },
		},
	},
```

# ITEMS
- Copy and paste into your qb-core --> shared --> items.lua
```
-- BURGERSHOT ITEMS --
    farm_apple                   = { name = 'farm_apple', label = 'Apple', weight = 1, type = 'item', image = 'farm_apple.png', unique = false, useable = false, shouldClose = true, description = 'Freshly Picked Apple'},
    farm_lettuce                 = { name = 'farm_lettuce', label = 'Lettuce', weight = 1, type = 'item', image = 'farm_lettuce.png', unique = false, useable = false, shouldClose = true, description = 'Fresh Lettuce'},
    farm_onion                   = { name = 'farm_onion', label = 'Onion', weight = 1, type = 'item', image = 'farm_onionn.png', unique = false, useable = false, shouldClose = true, description = 'Fresh 	Onion'},
    farm_potato                  = { name = 'farm_potato', label = 'Potato', weight = 1, type = 'item', image = 'farm_potato.png', unique = false, useable = false, shouldClose = true, description = 'Fresh Potato'},
    farm_tomato                  = { name = 'farm_tomato', label = 'Tomato', weight = 1, type = 'item', image = 'farm_tomato.png', unique = false, useable = false, shouldClose = true, description = 'Fresh Tomato'},
    bs_bag                       = { name = 'bs_bag', label = 'Paper Bag', weight = 0, type = 'item', image = 'bs_bag.png', unique = false, useable = true, shouldClose = true, description = 'To go bag by Burgershot'},
    bs_delivery_bag              = { name = 'bs_delivery_bag', label = 'BS Delivery Bag', weight = 0, type = 'item', image = 'bs_delivery_bag.png', unique = false, useable = true, shouldClose = true, description = 'Burgershots Delivery Bag'},
    bs_bleeder                   = { name = 'bs_bleeder', label = 'Bleeder Burger', weight = 25, type = 'item', image = 'bs_bleeder.png', unique = false, useable = true, shouldClose = true, description = 'Bleed like the bleeder'},
    bs_chickenwrap               = { name = 'bs_chickenwrap', label = 'Chicken Wrap', weight = 25, type = 'item', image = 'bs_chickenwrap.png', unique = false, useable = true, shouldClose = true, description = 'Burgershots famous Chicken Wrap'},
    bs_chocolateshake            = { name = 'bs_chocolateshake', label = 'Chocolate Milkshake', weight = 10, type = 'item', image = 'bs_chocolateshake.png', unique = false, useable = true, shouldClose = true, description = 'Choccy Choccy!'},
    bs_coffee                    = { name = 'bs_coffee', label = 'Coffee', weight = 10, type = 'item', image = 'bs_coffee.png', unique = false, useable = true, shouldClose = true, description = 'Tired? chug this back'},
    bs_cookiesncreamshake        = { name = 'bs_cookiesncreamshake', label = 'Cookies N Cream Milkshake', weight = 10, type = 'item', image = 'bs_cookiesncreamshake.png', unique = false, useable = true, shouldClose = true, description = 'Cookies N Cream!'},
    bs_creampie                  = { name = 'bs_creampie', label = 'Apple Cream Pie', weight = 10, type = 'item', image = 'bs_creampie.png', unique = false, useable = true, shouldClose = true, description = 'Apple Filled Cream Pie'},
    bs_ecola                     = { name = 'bs_ecola', label = 'Ecola', weight = 10, type = 'item', image = 'bs_ecola.png', unique = false, useable = true, shouldClose = true, description = 'Thirsty Thirsty'},
    bs_ecola1                    = { name = 'bs_ecola1', label = 'Ecola Light', weight = 10, type = 'item', image = 'bs_ecola1.png', unique = false, useable = true, shouldClose = true, description = 'Thirsty Thirsty'},
    bs_fries                     = { name = 'bs_fries', label = 'Fries', weight = 25, type = 'item', image = 'bs_fries.png', unique = false, useable = true, shouldClose = true, description = 'Perfectly Salted Fries'},
    bs_heartstopper              = { name = 'bs_heartstopper', label = 'Heart Stopper', weight = 45, type = 'item', image = 'bs_heartstopper.png', unique = false, useable = true, shouldClose = true, description = 'Heart is racing? Eat a heart stopper!'},
    bs_meatfree                  = { name = 'bs_meatfree', label = 'Meat Free Burger', weight = 25, type = 'item', image = 'bs_meatfree.png', unique = false, useable = true, shouldClose = true, description = 'Who gets fast food without the meat?'},
    bs_moneyshot                 = { name = 'bs_moneyshot', label = 'Moneyshot Burger', weight = 25, type = 'item', image = 'bs_moneyshot.png', unique = false, useable = true, shouldClose = true, description = 'Los Santos Rated #1 Burger!'},
    bs_nuggets                   = { name = 'bs_nuggets', label = 'Chiccy Nuggets', weight = 25, type = 'item', image = 'bs_nuggets.png', unique = false, useable = true, shouldClose = true, description = 'Chiccy Nuggies!!'},
    bs_onionrings                = { name = 'bs_onionrings', label = 'Onion Rings', weight = 25, type = 'item', image = 'bs_onionrings.png', unique = false, useable = true, shouldClose = true, description = 'Deep Fries Onions!'},
    bs_orangotang                = { name = 'bs_orangotang', label = 'Orang-O-Tang', weight = 10, type = 'item', image = 'bs_orangotang.png', unique = false, useable = true, shouldClose = true, description = 'Thirsty Thirsty'},
    bs_rimjob                    = { name = 'bs_rimjob', label = 'Rim Rob', weight = 10, type = 'item', image = 'bs_rimjob.png', unique = false, useable = true, shouldClose = true, description = 'Burgershots famous rim job.'},
    bs_sprunk                    = { name = 'bs_sprunk', label = 'Sprunk', weight = 10, type = 'item', image = 'bs_sprunk.png', unique = false, useable = true, shouldClose = true, description = 'Thirsty Thirsty'},
    bs_strawberryshake           = { name = 'bs_strawberryshake', label = 'Strawberry Milkshake', weight = 10, type = 'item', image = 'bs_strawberryshake.png', unique = false, useable = true, shouldClose = true},
    bs_torpedo                   = { name = 'bs_torpedo', label = 'Torpedo Sandwich', weight = 25, type = 'item', image = 'bs_torpedo', unique = false, useable = true, shouldClose = true, description = 'Burgershots famous Torpedo Sandwich'},
    bs_vanillashake              = { name = 'bs_vanillashake', label = 'Vanilla Milkshake', weight = 10, type = 'item', image = 'bs_vanillashake.png', unique = false, useable = true, shouldClose = true},
    bs_salad                     = { name = 'bs_salad', label = 'BS Salad', weight = 25, type = 'item', image = 'bs_salad.png', unique = false, useable = true, shouldClose = true, description = 'Burgershots Vegan Salad'},
    bs_coffee_beans              = { name = 'bs_coffee_beans', label = 'Coffee Beans', weight = 75, type = 'item', image = 'bs_coffee_beans.png', unique = false, useable = false, shouldClose = true, description = 'Fresh Coffee Beans'},
    bs_ecola_mix                 = { name = 'bs_ecola_mix', label = 'Ecola Mix', weight = 1, type = 'item', image = 'bs_ecola_mix.png', unique = false, useable = false, shouldClose = true, description = 'Ecola Soda Mix'},
    bs_lightecola_mix            = { name = 'bs_lightecola_mix', label = 'Light Ecola Mix', weight = 75, type = 'item', image = 'bs_lightecola_mix.png', unique = false, useable = false, shouldClose = true, description = 'Light Ecola Soda Mix'},
    bs_sprunk_mix                = { name = 'bs_sprunk_mix', label = 'Sprunk Mix', weight = 1, type = 'item', image = 'bs_sprunk_mix.png', unique = false, useable = false, shouldClose = true, description = 'Sprunk Soda Mix'},
    bs_orangesoda_mix              = { name = 'bs_orangesoda_mix', label = 'OrangoTang Mix', weight = 75, type = 'item', image = 'bs_orangesoda_mix.png', unique = false, useable = false, shouldClose = true, description = 'OrangoTang Mix'},
    bs_milkshake_mix                 = { name = 'bs_milkshake_mix', label = 'Milkshake Mix', weight = 1, type = 'item', image = 'bs_milkshake_mix.png', unique = false, useable = false, shouldClose = true, description = 'Milkshake Mix'},
    bs_dough            = { name = 'bs_dough', label = 'Dough', weight = 75, type = 'item', image = 'bs_dough.png', unique = false, useable = false, shouldClose = true, description = 'Dough'},
    bs_apple                = { name = 'bs_apple', label = 'Apple', weight = 1, type = 'item', image = 'bs_apple.png', unique = false, useable = false, shouldClose = true, description = 'Apple'},
    bs_patty            = { name = 'bs_patty', label = 'Burgershot Patty', weight = 75, type = 'item', image = 'bs_patty.png', unique = false, useable = false, shouldClose = true, description = 'Burgershot Patty'},
    bs_beanpatty                = { name = 'bs_beanpatty', label = 'Burgershot Bean Patty', weight = 1, type = 'item', image = 'bs_beanpatty.png', unique = false, useable = false, shouldClose = true, description = 'Burgershot Bean Patty'},
    bs_lettuce_sliced            = { name = 'bs_lettuce_sliced', label = 'Sliced Lettuce', weight = 75, type = 'item', image = 'bs_lettuce_sliced.png', unique = false, useable = false, shouldClose = true, description = 'Sliced Lettuce'},
    bs_tomato_slice                = { name = 'bs_tomato_slice', label = 'Tomato Slice', weight = 1, type = 'item', image = 'bs_tomato_slice.png', unique = false, useable = false, shouldClose = true, description = 'Tomato Slice'},
    bs_cheese            = { name = 'bs_cheese', label = 'Cheese Slice', weight = 75, type = 'item', image = 'bs_cheese.png', unique = false, useable = false, shouldClose = true, description = 'Cheese Slice'},
    bs_bun                = { name = 'bs_bun', label = 'Burger Bun', weight = 1, type = 'item', image = 'bs_bun.png', unique = false, useable = false, shouldClose = true, description = 'Burger Bun'},
    bs_tortilla            = { name = 'bs_tortilla', label = 'Tortilla', weight = 75, type = 'item', image = 'bs_tortilla.png', unique = false, useable = false, shouldClose = true, description = 'Tortilla'},
    bs_bacon                = { name = 'bs_bacon', label = 'Bacon', weight = 1, type = 'item', image = 'bs_bacon.png', unique = false, useable = false, shouldClose = true, description = 'Bacon'},
    bs_rawchicken            = { name = 'bs_rawchicken', label = 'Raw Chicken', weight = 75, type = 'item', image = 'bs_rawchicken.png', unique = false, useable = false, shouldClose = true, description = 'Raw Chicken'},
    bs_sliced_potato            = { name = 'bs_sliced_potato', label = 'Sliced Potatoes', weight = 75, type = 'item', image = 'bs_sliced_potato.png', unique = false, useable = false, shouldClose = true, description = 'Sliced Potatoes'},
    bs_chopped_onion                = { name = 'bs_chopped_onion', label = 'Chopped Onion', weight = 1, type = 'item', image = 'bs_chopped_onion.png', unique = false, useable = false, shouldClose = true, description = 'Chopped Onion'},
```

# For Ox_inventory *
```
----- | Burgershot Items | -----
    -- Ingredients
    ['bs_coffee_beans'] = {
        label = 'Coffee Beans',
        weight = 75,
    },
    ['bs_ecola_mix'] = {
        label = 'Ecola Mix',
        weight = 1,
    },
    ['bs_lightecola_mix'] = {
        label = 'Light Ecola Mix',
        weight = 1,
    },
    ['bs_sprunk_mix'] = {
        label = 'Sprunk Mix',
        weight = 1,
    },
    ['bs_orangesoda_mix'] = {
        label = 'OrangoTang Mix',
        weight = 1,
    },
    ['bs_milkshake_mix'] = {
        label = 'Milkshake Mix',
        weight = 5,
    },
    ['bs_dough'] = {
        label = 'Dough',
        weight = 1,
    },
    ['bs_apple'] = {
        label = 'Apple',
        weight = 1,
    },
    ['bs_patty'] = {
        label = 'Burgershot Patty',
        weight = 5,
    },
    ['bs_beanpatty'] = {
        label = 'Burgershot Bean Patty',
        weight = 5,
    },
    ['bs_lettuce_sliced'] = {
        label = 'Sliced Lettuce',
        weight = 1,
    },
    ['bs_tomato_slice'] = {
        label = 'Tomato Slice',
        weight = 1,
    },
    ['bs_cheese'] = {
        label = 'Cheese Slice',
        weight = 1,
    },
    ['bs_bun'] = {
        label = 'Burger Bun',
        weight = 1,
    },
    ['bs_tortilla'] = {
        label = 'Tortilla',
        weight = 1,
    },
    ['bs_bacon'] = {
        label = 'Bacon',
        weight = 1,
    },
    ['bs_rawchicken'] = {
        label = 'Raw Chicken',
        weight = 1,
    },
    ['bs_sliced_potato'] = {
        label = 'Sliced Potatoes',
        weight = 1,
    },
    ['bs_chopped_onion'] = {
        label = 'Chopped Onion',
        weight = 1,
    },
    -- Drinks
    ['bs_coffee'] = {
        label = 'BS Coffee',
        weight = 10,
        client = {
            status = { thirst = 750000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_food_bs_coffee`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_vanillashake'] = {
        label = 'BS Vanilla Shake',
        weight = 10,
        client = {
            status = { thirst = 750000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_bs_cup`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_chocolateshake'] = {
        label = 'BS Chocolate Shake',
        weight = 10,
        client = {
            status = { thirst = 750000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_bs_cup`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_strawberryshake'] = {
        label = 'BS Strawberry Shake',
        weight = 10,
        client = {
            status = { thirst = 750000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_bs_cup`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_cookiesncreamshake'] = {
        label = 'BS Cookies N Cream Shake',
        weight = 10,
        client = {
            status = { thirst = 750000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_bs_cup`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_sprunk'] = {
        label = 'BS Sprunk',
        weight = 10,
        client = {
            status = { thirst = 750000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_bs_cup`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_orangotang'] = {
        label = 'BS Orang-O-Tang',
        weight = 10,
        client = {
            status = { thirst = 750000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_bs_cup`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_ecola1'] = {
        label = 'BS Ecola Light',
        weight = 10,
        client = {
            status = { thirst = 750000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `v_62_ecolacup01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_ecola'] = {
        label = 'BS Ecola',
        weight = 10,
        client = {
            status = { thirst = 750000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `v_62_ecolacup002`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    -- Burgers / Sandwiches
    ['bs_moneyshot'] = {
        label = 'BS Moneyshot Burger',
        weight = 10,
        client = {
            status = { hunger = 600000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop' },
            prop = { model = 'prop_cs_burger_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_heartstopper'] = {
        label = 'BS Heartstopper Burger',
        weight = 10,
        client = {
            status = { hunger = 800000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop' },
            prop = { model = 'prop_cs_burger_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_bleeder'] = {
        label = 'BS Bleeder Burger',
        weight = 10,
        client = {
            status = { hunger = 600000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop' },
            prop = { model = 'v_ret_ml_chips4', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_torpedo'] = {
        label = 'BS Torpedo Sandwich',
        weight = 10,
        client = {
            status = { hunger = 700000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop' },
            prop = { model = 'v_ret_ml_chips4', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_chickenwrap'] = {
        label = 'BS Chicken Wrap',
        weight = 10,
        client = {
            status = { hunger = 600000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop' },
            prop = { model = 'v_ret_ml_chips4', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_meatfree'] = {
        label = 'BS Meat Free Burger',
        weight = 10,
        client = {
            status = { hunger = 600000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop' },
            --prop = { model = 'prop_cs_burger_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    -- Sides
    ['bs_onionrings'] = {
        label = 'BS Onion Rings',
        weight = 10,
        client = {
            status = { hunger = 500000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop' },
            prop = { model = 'prop_food_bs_chips', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_nuggets'] = {
        label = 'BS Chicken Nuggys',
        weight = 10,
        client = {
            status = { hunger = 500000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop' },
            prop = { model = 'prop_food_bs_chips', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_salad'] = {
        label = 'BS Salad',
        weight = 10,
        client = {
            status = { hunger = 500000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop' },
            prop = { model = 'prop_cs_burger_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_fries'] = {
        label = 'BS Fries',
        weight = 10,
        client = {
            status = { hunger = 500000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop' },
            prop = { model = 'prop_food_bs_chips', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    -- Deserts
    ['bs_rimjob'] = {
        label = 'BS Rimjob',
        weight = 10,
        client = {
            status = { hunger = 300000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop' },
            prop = { model = 'prop_donut_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    ['bs_creampie'] = {
        label = 'BS Creampie',
        weight = 10,
        client = {
            status = { hunger = 300000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop' },
            prop = { model = 'v_ret_ml_chips4', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
        }
    },
    -- Extras
    ['bs_delivery_bag'] = {
        label = 'BS Delivery Bag',
        weight = 10,
    },
    ['bs_bag'] = {
        label = 'BS To-Go Bag',
        weight = 1,
    },
    -- Raw Farm Items
    ['farm_tomato'] = {
        label = 'Tomato',
        weight = 1,
    },
    ['farm_potato'] = {
        label = 'Potato',
        weight = 1,
    },
    ['farm_onion'] = {
        label = 'Onion',
        weight = 1,
    },
    ['farm_lettuce'] = {
        label = 'Lettuce',
        weight = 1,
    },
    ['farm_apple'] = {
        label = 'Apple',
        weight = 1,
    },
```

# SMALLRESOURCES
- Copy and paste into your qb-smallresources --> config.lua
```
eat = {
        --BURGERSHOT ITEMS--
        ['bs_bleeder'] = math.random(60, 80),
        ['bs_chickenwrap'] = math.random(60, 80),
        ['bs_creampie'] = math.random(25, 50),
        ['bs_fries'] = math.random(50, 70),
        ['bs_heartstopper'] = math.random(90, 100),
        ['bs_meatfree'] = math.random(50, 70),
        ['bs_moneyshot'] = math.random(60, 80),
        ['bs_nuggets'] = math.random(60, 80),
        ['bs_onionrings'] = math.random(50, 70),
        ['bs_rimjob'] = math.random(25, 50),
        ['bs_torpedo'] = math.random(60, 80),
        ['bs_chocolateshake'] = math.random(5, 15),
        ['bs_cookiesncreamshake'] = math.random(5, 15),
        ['bs_strawberryshake'] = math.random(5, 15),
        ['bs_vanillashake'] = math.random(5, 15),
    },
    drink = {
        --BUGERSHOT ITEM--
        ['bs_coffee'] = math.random(50, 70),
        ['bs_ecola'] = math.random(60, 80),
        ['bs_ecola1'] = math.random(60, 80),
        ['bs_sprunk'] = math.random(60, 80),
        ['bs_orangotang'] = math.random(60, 80),
        ['bs_chocolateshake'] = math.random(25, 50),
        ['bs_cookiesncreamshake'] = math.random(25, 50),
        ['bs_strawberryshake'] = math.random(25, 50),
        ['bs_vanillashake'] = math.random(25, 50),
    },
```

# INVENTORY
- Copy and paste the images from the images folder into your qb-inventory --> html --> images
 - And your done :D unless you want to make sure you have all the sounds working then you got one more step

# SOUNDS
- Copy and paste the sounds from the sounds folder into interact-sound --> client --> html --> sounds
- Now this part isn't that important but there is a couple sounds that the default doesnt have that i added ( coffee pouring for example )
 - Ok now your actually done setting it all up, If you got any questions or concerns dont forget to join the discord above <3

