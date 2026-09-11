--[[
  ____              _                 _                       
 | __ )  __ _ _   _| | ___  _ __ __ _(_)                      
 |  _ \ / _` | | | | |/ _ \| '__/ _` | |                      
 | |_) | (_| | |_| | | (_) | | | (_| | |                      
 |____/ \__,_|\__, |_|\___/|_|  \__,_|_|                  _   
 |  _ \  _____|___/___| | ___  _ __  _ __ ___   ___ _ __ | |_ 
 | | | |/ _ \ \ / / _ \ |/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __|
 | |_| |  __/\ V /  __/ | (_) | |_) | | | | | |  __/ | | | |_ 
 |____/ \___| \_/ \___|_|\___/| .__/|_| |_| |_|\___|_| |_|\__|
                              |_|                             
--]] 
Config = {}
Config.InventorySystem = 'ox' -- Supports 'qb' & 'ox'
Config.TargetSystem = 'ox' -- Supports 'qb' & 'ox'
Config.KeySystem = 'wasabi' -- Supports 'wasabi' & 'qbx'
Config.BankSystem = 'nfs' -- Supports 'renewed' 'qb' 'nfs'

Config.SocietyAccount = 'society_burgershot'
Config.Jobname = 'burgershot'
Config.DebugZones = false

Config.Blip = {
    coords = vector3(-1187.93, -891.36, 13.89),
    sprite = 536,
    color = 6,
    scale = 0.5,
    label = 'Burgershot',
}

Config.Locations = {
    ClockIn = {
        coords = vector4(-1177.18, -896.96, 13.93, 31.42),
        size = vec3(1.9, 1.9, 2.0),
    },
    BossMenu = vector4(-1198.16, -898.63, 13.6, 300.0),
    Stations = {
        {
            name = 'burgershot_cookmenu',
            coords = vector4(-1186.62, -900.86, 14.09, 303.63),
            label = 'Cook Menu',
            icon = 'fa-solid fa-fire-burner',
            event = 'bd-burgershot:client:OpenCookMenu',
        },
        {
            name = 'burgershot_fryermenu',
            coords = vector4(-1187.73, -899.44, 14.09, 308.93),
            label = 'Fryer Menu',
            icon = 'fa-solid fa-fire-burner',
            event = 'bd-burgershot:client:OpenFryerMenu',
        },
        {
            name = 'burgershot_prepmenu',
            coords = vector4(-1185.29, -901.91, 13.71, 300.00),
            label = 'Prep Station',
            icon = 'fa-solid fa-utensils',
            event = 'bd-burgershot:client:OpenPrepMenu',
        },
        {
            name = 'burgershot_drinkmenu',
            coords = vector4(-1191.47, -897.67, 14.0, 271.33),
            label = 'Drink Menu',
            icon = 'fa-solid fa-faucet',
            event = 'bd-burgershot:client:OpenDrinkMenu',
        },
    },
    Registers = {
        vector4(-1187.45, -893.74, 14.04, 304.05),
        vector4(-1188.96, -894.76, 14.04, 304.05),
        vector4(-1190.43, -895.76, 14.02, 304.05),
    },
    Stashes = {
        {
            id = 'bfrontTray1',
            coords = vector4(-1187.9, -894.01, 14.13, 292.65),
            label = 'Tray',
            icon = 'fa-solid fa-equals',
            jobOnly = false,
            ox = { label = 'Counter', slots = 5, weight = 5000 },
            qb = { label = 'Burger Counter1', slots = 15, weight = 50000 },
        },
        {
            id = 'bfrontTray2',
            coords = vector4(-1189.55, -895.03, 13.95, 1.55),
            label = 'Tray',
            icon = 'fa-solid fa-equals',
            jobOnly = false,
            ox = { label = 'Counter', slots = 5, weight = 5000 },
            qb = { label = 'Burger Counter2', slots = 15, weight = 50000 },
        },
        {
            id = 'bfrontTray3',
            coords = vector4(-1191.15, -896.06, 13.95, 124.23),
            label = 'Tray',
            icon = 'fa-solid fa-equals',
            jobOnly = false,
            ox = { label = 'Tray', slots = 5, weight = 5000 },
            qb = { label = 'Burger Tray', slots = 15, weight = 50000 },
        },
        {
            id = 'bjobFridge',
            coords = vector4(-1184.08, -900.96, 14.06, 302.81),
            label = 'Fridge',
            icon = 'fa-solid fa-temperature-empty',
            jobOnly = true,
            ox = { label = 'Fridge', slots = 50, weight = 750000 },
            qb = { label = 'Burger Fridge', slots = 50, weight = 750000 },
        },
        {
            id = 'bjobHeater',
            coords = vector4(-1187.83, -896.74, 14.21, 223.05),
            label = 'Heater',
            icon = 'fa-solid fa-temperature-arrow-up',
            jobOnly = true,
            size = vec3(2, 2, 2),
            ox = { label = 'Heater', slots = 25, weight = 250000 },
            qb = { label = 'Burger Heater', slots = 25, weight = 250000 },
        },
        {
            id = 'bbackStorage',
            coords = vector4(-1192.51, -899.65, 13.94, 293.61),
            label = 'Storage',
            icon = 'fa-solid fa-boxes',
            jobOnly = true,
            ox = { label = 'Storage', slots = 75, weight = 1000000 },
            qb = { label = 'Burger Storage', slots = 75, weight = 1000000 },
        },
    },
}

Config.Drinks = {
    { id = 'ecola',         item = 'bs_ecola',              label = 'Ecola',                    category = 'softdrinks', sound = 'watermachine',      duration = 2000, amount = 2, verb = 'poured' },
    { id = 'ecolalight',    item = 'bs_ecola1',             label = 'Ecola Light',              category = 'softdrinks', sound = 'watermachine',      duration = 2000, amount = 2, verb = 'poured' },
    { id = 'sprunk',        item = 'bs_sprunk',             label = 'Sprunk',                   category = 'softdrinks', sound = 'watermachine',      duration = 2000, amount = 2, verb = 'poured' },
    { id = 'orangotang',    item = 'bs_orangotang',         label = 'Orang-O-Tang',             category = 'softdrinks', sound = 'watermachine',      duration = 2000, amount = 2, verb = 'poured' },
    { id = 'coffee',        item = 'bs_coffee',             label = 'Coffee',                   category = 'coffee',     sound = 'coffee_pour',       duration = 1500, amount = 2, verb = 'poured' },
    { id = 'vanilla',       item = 'bs_vanillashake',       label = 'Vanilla Milkshake',        category = 'milkshakes', sound = 'milkshake_machine', duration = 1500, amount = 2, verb = 'made' },
    { id = 'chocolate',     item = 'bs_chocolateshake',     label = 'Chocolate Milkshake',      category = 'milkshakes', sound = 'milkshake_machine', duration = 1500, amount = 2, verb = 'made' },
    { id = 'strawberry',    item = 'bs_strawberryshake',    label = 'Strawberry Milkshake',     category = 'milkshakes', sound = 'milkshake_machine', duration = 1500, amount = 2, verb = 'made' },
    { id = 'cookiesncream', item = 'bs_cookiesncreamshake', label = 'Cookies N Cream Milkshake', category = 'milkshakes', sound = 'milkshake_machine', duration = 1500, amount = 2, verb = 'made' },
}

Config.DrinkIngredients = {
    -- Coffee: one requirement shared by everything in the category
    coffee = {
        { item = 'bs_coffee_beans', amount = 1 },
    },
    -- Milkshakes: one requirement shared by everything in the category
    milkshakes = {
        { item = 'bs_milkshake_mix', amount = 1 },
    },
    -- Soft drinks: each has its own specific mix
    ecola = {
        { item = 'bs_ecola_mix', amount = 1 },
    },
    ecolalight = {
        { item = 'bs_lightecola_mix', amount = 1 },
    },
    sprunk = {
        { item = 'bs_sprunk_mix', amount = 1 },
    },
    orangotang = {
        { item = 'bs_orangesoda_mix', amount = 1 },
    },
}

Config.BurgershotGaragePed = {
  {
      BurgershotGaragePedModel = 'mp_m_waremech_01',
      BurgershotGaragePedLocation = vector4(-1175.54, -896.08, 12.85, 303.47),
      BurgershotGarageRenderDistance = 12,
  }
}

Config.VehiclePlate = 'BURGER'
Config.GarageVehicles = {
    {
        label = 'Burgershot Van',
        description = 'Pull out Burgershots Van',
        icon = 'van-shuttle',
        model = 'burgervan',
        spawn = vector4(-1171.58, -894.93, 13.87, 27.1),
        fuel = 1000.0,
        minGrade = 2,
    },
    {
        label = 'Burgershot Car',
        description = 'Pull out Burgershots Car',
        icon = 'car',
        model = 'stalion2',
        spawn = vector4(-1168.41, -895.57, 13.94, 28.42),
        fuel = 500.0,
        minGrade = 4,
    },
    {
        label = 'Burgershot Bike',
        description = 'Pull out Burgershots Bike',
        icon = 'motorcycle',
        model = 'burgershotbike',
        spawn = vector4(-1172.3, -898.99, 13.79, 303.34),
        fuel = 275.0,
        minGrade = 0,
    },
    {
        label = 'Burgershot Electric Bike',
        description = 'Pull out Burgershots Bike 2',
        icon = 'motorcycle',
        model = 'burgerbike2',
        spawn = vector4(-1169.82, -895.78, 13.9, 33.88),
        fuel = 275.0,
        minGrade = 0,
    },
}

Config.BurgershotDeliveryPed = {
  {
    BurgershotDeliveryPedModel = 'a_m_y_business_03',
    BurgershotDeliveryPedLocation = vector4(-1200.13, -902.10, 12.79, 306.18),
    BurgershotDeliveryRenderDistance = 7,
  }
}

Config.DeliveryLocations = {
  ['deliveryroute'] = {
    [1] = {
      name = "1",
      coords = vector4(-952.48, -1077.58, 2.67, 34.72), -- VESPUCCI CANALS / INVENTION CT
    },
    [2] = {
      name = "2",
      coords = vector4(-1043.36, -1580.35, 5.03, 34.72), -- LA PUERTA / BAY CITY AVE
    },
    [3] = {
      name = "3",
      coords = vector4(-1447.65, -537.27, 34.74, 36.38), -- Del Perro Heights Apartment
    },
    [4] = {
      name = "4",
      coords = vector4(-706.09, -1036.47, 16.41, 36.38), -- Across from south rockford appartments
    },
    [5] = {
      name = "5",
      coords = vector4(-702.82, -1023.36, 16.42, 298.18), -- Across from south rockford appartments
    },
  }
}

Config.MinBag = 1 -- Min amount of food bags for order
Config.MaxBag = 3 -- Max amount of food bags for order

Config.MinPay = 25 -- Min amount of pay per delivery
Config.MaxPay = 100 -- Max amount of pay per delivery

Config.PayWorker = true -- Toggles if the player should recieve a pay or not
Config.PlayerPercent = 30 -- The percent the player gets of the total cost

Config.MenuItems = {
    {
        category = 'Meals',
        items = {
          { label = 'Bleeder Combo', price = 15, item = 'bs_bleeder_combo' },
          { label = 'Moneyshot Combo', price = 20, item = 'bs_moneyshot_combo' },
          { label = 'Heartstopper Combo', price = 25, item = 'bs_heartstopper_combo' },
          { label = 'Torpedo Combo', price = 20, item = 'bs_torpedo_combo' },
          { label = 'Meatfree Combo', price = 15, item = 'bs_meatfree_combo' },
          { label = 'Chicken Wrap Combo', price = 20, item = 'bs_chickenwrap_combo' },
        }
    },
    {
        category = 'Burgers & Wraps',
        items = {
            { label = 'Bleeder Burger',         price = 12, item = 'bs_bleeder' },
            { label = 'Moneyshot Burger',       price = 14, item = 'bs_moneyshot' },
            { label = 'Heartstopper Burger',    price = 15, item = 'bs_heartstopper' },
            { label = 'Torpedo Sandwich',       price = 11, item = 'bs_torpedo' },
            { label = 'Meatfree Burger',        price = 10, item = 'bs_meatfree' },
            { label = 'Chicken Wrap',           price = 9,  item = 'bs_chickenwrap' },
        }
    },
    {
        category = 'Sides',
        items = {
            { label = 'Fries',             price = 4, item = 'bs_fries' },
            { label = 'Onion Rings',       price = 5, item = 'bs_onionrings' },
            { label = 'Chicken Nuggets',   price = 6, item = 'bs_nuggets' },
            { label = 'Salad',             price = 5, item = 'bs_salad' },
        }
    },
    {
        category = 'Deserts',
        items = {
            { label = 'Rimjob',            price = 5, item = 'bs_rimjob' },
            { label = 'Apple Creampie',    price = 5, item = 'bs_creampie' },
        }
    },
    {
        category = 'Soft Drinks',
        items = {
            { label = 'Ecola',              price = 3, item = 'bs_ecola' },
            { label = 'Ecola Light',        price = 3, item = 'bs_ecola1' },
            { label = 'Sprunk',             price = 3, item = 'bs_sprunk' },
            { label = 'Orang-O-Tang',       price = 3, item = 'bs_orangotang' },
        }
    },
    {
        category = 'Coffee',
        items = {
            { label = 'Coffee', price = 3, item = 'bs_coffee' },
        }
    },
    {
        category = 'Milkshakes',
        items = {
            { label = 'Vanilla Milkshake',              price = 5, item = 'bs_vanillashake' },
            { label = 'Chocolate Milkshake',             price = 5, item = 'bs_chocolateshake' },
            { label = 'Strawberry Milkshake',            price = 5, item = 'bs_strawberryshake' },
            { label = 'Cookies N Cream Milkshake',       price = 5, item = 'bs_cookiesncreamshake' },
        }
    },
}

Config.Recipes = {
    bs_lettuce_sliced = {
        label = 'Lettuce Slices',
        amount = 1,
        station = 'prep',
        ingredients = {
            { item = 'farm_lettuce', amount = 1 },
        },
    },
    bs_chopped_onion = {
        label = 'Raw Onion Rings',
        amount = 1,
        station = 'prep',
        ingredients = {
            { item = 'farm_onion', amount = 1 },
        },
    },
    bs_tomato_slice = {
        label = 'Tomato Slices',
        amount = 1,
        station = 'prep',
        ingredients = {
            { item = 'farm_tomato', amount = 1 },
        },
    },
    bs_sliced_potato = {
        label = 'Sliced Potatoes',
        amount = 1,
        station = 'prep',
        ingredients = {
            { item = 'farm_potato', amount = 1 },
        },
    },
    bs_bleeder = {
        label = 'Bleeder Burgers',
        amount = 2,
        station = 'grill',
        ingredients = {
            { item = 'bs_patty',   amount = 2 },
            { item = 'bs_lettuce_sliced', amount = 4 },
            { item = 'bs_cheese',  amount = 2 },
            { item = 'bs_bun',     amount = 2 },
        }
    },
    bs_moneyshot = {
        label = 'Moneyshot Burgers',
        amount = 2,
        station = 'grill',
        ingredients = {
            { item = 'bs_patty',  amount = 4 },
            { item = 'bs_bacon',  amount = 4 },
            { item = 'bs_cheese', amount = 2 },
            { item = 'bs_bun',    amount = 2 },
        }
    },
    bs_heartstopper = {
        label = 'Heartstopper Burgers',
        amount = 2,
        station = 'grill',
        ingredients = {
            { item = 'bs_patty',  amount = 6 },
            { item = 'bs_bacon',  amount = 4 },
            { item = 'bs_cheese', amount = 4 },
            { item = 'bs_bun',    amount = 6 },
        }
    },
    bs_torpedo = {
        label = 'Torpedo Sandwiches',
        amount = 2,
        station = 'grill',
        ingredients = {
            { item = 'bs_patty',   amount = 2 },
            { item = 'bs_lettuce_sliced', amount = 2 },
            { item = 'bs_tomato_slice',  amount = 2 },
            { item = 'bs_bun',     amount = 2 },
        }
    },
    bs_meatfree = {
        label = 'Meatfree Burgers',
        amount = 2,
        station = 'grill',
        ingredients = {
            { item = 'bs_beanpatty', amount = 2 },
            { item = 'bs_lettuce_sliced',   amount = 2 },
            { item = 'bs_tomato_slice',    amount = 2 },
            { item = 'bs_bun',       amount = 2 },
        }
    },
    bs_chickenwrap = {
        label = 'Chicken Wraps',
        amount = 2,
        station = 'grill',
        ingredients = {
            { item = 'bs_rawchicken', amount = 2 },
            { item = 'bs_lettuce_sliced',      amount = 2 },
            { item = 'bs_tomato_slice',       amount = 2 },
            { item = 'bs_tortilla',     amount = 2 },
        }
    },
    bs_fries = {
        label = 'Fries',
        amount = 2,
        station = 'fryer',
        ingredients = {
            { item = 'bs_sliced_potato', amount = 4 },
        }
    },
    bs_onionrings = {
        label = 'Onion Rings',
        amount = 2,
        station = 'fryer',
        ingredients = {
            { item = 'bs_chopped_onion', amount = 4 },
        }
    },
    bs_nuggets = {
        label = 'Chicken Nuggets',
        amount = 2,
        station = 'fryer',
        ingredients = {
            { item = 'bs_rawchicken', amount = 4 },
        }
    },
    bs_creampie = {
        label = 'Apple Creampies',
        amount = 2,
        station = 'grill',
        ingredients = {
            { item = 'bs_dough', amount = 2 },
            { item = 'farm_apple', amount = 4 },
        }
    },
    bs_rimjob = {
        label = 'Rimjobs',
        amount = 2,
        station = 'grill',
        ingredients = {
            { item = 'bs_dough',        amount = 2 },
        }
    },
}

Config.SupplyOrderItems = {
    {
        category = 'Produce',
        items = {
            { label = 'Lettuce',  price = 15, item = 'farm_lettuce', amount = 10 },
            { label = 'Tomatoes', price = 15, item = 'farm_tomato',  amount = 10 },
            { label = 'Onions',   price = 12, item = 'farm_onion',   amount = 10 },
            { label = 'Potatoes', price = 12, item = 'farm_potato',  amount = 10 },
            { label = 'Apples',   price = 12, item = 'farm_apple',   amount = 10 },
        }
    },
    {
        category = 'Meat & Dairy',
        items = {
            { label = 'Patties',       price = 25, item = 'bs_patty',      amount = 10 },
            { label = 'Bacon',         price = 25, item = 'bs_bacon',      amount = 10 },
            { label = 'Cheese Slices', price = 18, item = 'bs_cheese',     amount = 10 },
            { label = 'Raw Chicken',   price = 25, item = 'bs_rawchicken', amount = 10 },
            { label = 'Bean Patties',  price = 18, item = 'bs_beanpatty',  amount = 10 },
        }
    },
    {
        category = 'Bakery',
        items = {
            { label = 'Buns',      price = 10, item = 'bs_bun',      amount = 10 },
            { label = 'Tortillas', price = 10, item = 'bs_tortilla', amount = 10 },
            { label = 'Dough',     price = 10, item = 'bs_dough',    amount = 10 },
        }
    },
    {
        category = 'Extras',
        items = {
            { label = 'Milkshake Mix',    price = 15, item = 'bs_milkshake_mix',  amount = 10 },
        }
    },
    {
        category = 'Drink Mixes',
        items = {
            { label = 'Ecola Mix',        price = 15, item = 'bs_ecola_mix',      amount = 10 },
            { label = 'Ecola Light Mix',  price = 15, item = 'bs_lightecola_mix', amount = 10 },
            { label = 'Sprunk Mix',       price = 15, item = 'bs_sprunk_mix',     amount = 10 },
            { label = 'Orang-O-Tang Mix', price = 15, item = 'bs_orangesoda_mix',     amount = 10 },
            { label = 'Coffee Beans',     price = 15, item = 'bs_coffee_beans',    amount = 10 },
        }
    },
}

-- Multiple possible pickup spots for the supply van - a random one is chosen every time an order is placed.
Config.SupplyVanSpawns = {
    vector4(1219.5218505859, -3203.8029785156, 5.5782237052917, 194.77864074707),    -- Port of LS
}

Config.SupplyVanModel = 'burgervan' -- vehicle spawned for the supply run
Config.SupplyDropzone = vector4(-1171.58, -894.93, 13.87, 27.1) -- where the van gets unloaded back at Burgershot
