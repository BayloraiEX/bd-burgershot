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
MLO - https://www.gta5-mods.com/maps/mlo-burgershot-2023-add-on-sp-fivem

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
    bs_bag                       = { name = 'bs_bag', label = 'Paper Bag', weight = 0, type = 'item', image = 'bs_bag.png', unique = false, useable = true, shouldClose = true, description = 'To go bag by Burgershot'},
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
    bs_rimjob                    = { name = 'bs_rimjob', label = 'Rim Rob', weight = 10, type = 'item', image = 'bs_creampie.png', unique = false, useable = true, shouldClose = true, description = 'Burgershots famous rim job.'},
    bs_sprunk                    = { name = 'bs_sprunk', label = 'Sprunk', weight = 10, type = 'item', image = 'bs_sprunk.png', unique = false, useable = true, shouldClose = true, description = 'Thirsty Thirsty'},
    bs_strawberryshake           = { name = 'bs_strawberryshake', label = 'Strawberry Milkshake', weight = 10, type = 'item', image = 'bs_strawberryshake.png', unique = false, useable = true, shouldClose = true},
    bs_torpedo                   = { name = 'bs_torpedo', label = 'Torpedo Sandwich', weight = 25, type = 'item', image = 'bs_torpedo', unique = false, useable = true, shouldClose = true, description = 'Burgershots famous Torpedo Sandwich'},
    bs_vanillashake              = { name = 'bs_vanillashake', label = 'Vanilla Milkshake', weight = 10, type = 'item', image = 'bs_vanillashake.png', unique = false, useable = true, shouldClose = true},
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