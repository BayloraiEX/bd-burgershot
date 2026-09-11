local function Notify(description, color)
    lib.notify({
        id = 'burger_shot',
        title = 'Burgershot',
        description = description,
        showDuration = false,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = color or '#F08080',
            ['.description'] = {
              color = '#909296'
            }
        },
        icon = 'burger',
        iconColor = color or '#F08080'
    })
end

local function DescribeIngredients(product)
    local recipe = Config.Recipes[product]
    if not recipe then return '' end
    local parts = {}
    for _, ing in ipairs(recipe.ingredients) do
        parts[#parts + 1] = ('%dx %s'):format(ing.amount, ing.item)
    end
    return 'Needs: ' .. table.concat(parts, ', ')
end

local Menus = {
    {
        id = 'burgershot_cooks',
        title = 'Cooking Menu',
        options = {
            { title = 'Burgers & Wraps', description = 'All our Burgers, Sandwiches and Wraps', menu = 'burgershot_burgers' },
            { title = 'Deserts',         description = 'All our desert items',                  menu = 'burgershot_extras' },
        },
    },
    {
        id = 'burgershot_burgers',
        title = 'Main Menu',
        parent = 'burgershot_cooks',
        items = {
            { label = 'Bleeder Burger',      product = 'bs_bleeder',      icon = 'burger' },
            { label = 'Moneyshot Burger',    product = 'bs_moneyshot',    icon = 'burger' },
            { label = 'Heartstopper Burger', product = 'bs_heartstopper', icon = 'burger' },
            { label = 'Torpedo Sandwich',    product = 'bs_torpedo',      icon = 'bread-slice' },
            { label = 'Meatfree Burger',     product = 'bs_meatfree',     icon = 'burger' },
            { label = 'Chicken Wrap',        product = 'bs_chickenwrap',  icon = 'bread-slice' },
        },
    },
    {
        id = 'burgershot_extras',
        title = 'Deserts',
        parent = 'burgershot_cooks',
        items = {
            { label = 'Rimjob',         product = 'bs_rimjob',   icon = 'cookie' },
            { label = 'Apple Creampie', product = 'bs_creampie', icon = 'cookie' },
        },
    },
    {
        id = 'burgershot_fryer',
        title = 'Fryer Menu',
        items = {
            { label = 'Fries',           product = 'bs_fries',      icon = 'drumstick-bite' },
            { label = 'Onion Rings',     product = 'bs_onionrings', icon = 'drumstick-bite' },
            { label = 'Chicken Nuggets', product = 'bs_nuggets',    icon = 'drumstick-bite' },
        },
    },
    {
        id = 'burgershot_prep',
        title = 'Prep Station',
        items = {
            { label = 'Lettuce Slices',  product = 'bs_lettuce_sliced', icon = 'utensils' },
            { label = 'Tomato Slices',   product = 'bs_tomato_slice',   icon = 'utensils' },
            { label = 'Sliced Potatoes', product = 'bs_sliced_potato',  icon = 'utensils' },
            { label = 'Chopped Onion',   product = 'bs_chopped_onion',  icon = 'utensils' },
        },
    },
}

for _, menu in ipairs(Menus) do
    local options = menu.options
    if not options then
        options = {}
        for _, item in ipairs(menu.items) do
            options[#options + 1] = {
                title = item.label,
                description = DescribeIngredients(item.product),
                event = 'bd-burgershot:client:Cook',
                args = item.product,
                icon = item.icon,
                iconColor = '#EC213A',
            }
        end
    end

    lib.registerContext({
        id = menu.id,
        title = menu.title,
        menu = menu.parent,
        options = options,
    })
end

RegisterNetEvent('bd-burgershot:client:OpenCookMenu', function()
    lib.showContext('burgershot_cooks')
end)
RegisterNetEvent('bd-burgershot:client:OpenFryerMenu', function()
    lib.showContext('burgershot_fryer')
end)
RegisterNetEvent('bd-burgershot:client:OpenPrepMenu', function()
    lib.showContext('burgershot_prep')
end)

local CookingStations = {
    grill = {
        sound = 'grilling',
        volume = 0.2,
        anim = {
            dict = 'amb@prop_human_bbq@male@idle_a',
            clip = 'idle_a',
        },
        difficulty = 'easy',
        inputs = {'w', 'a', 's', 'd'},
    },
    fryer = {
        sound = 'deepfry',
        volume = 0.1,
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_player',
        },
        difficulty = 'easy',
        inputs = {'w', 'a', 's', 'd'},
    },
    prep = {
        sound = nil,
        volume = 0.1,
        anim = {
            dict = 'amb@world_human_hammering@male@base',
            clip = 'base',
        },
        difficulty = 'easy',
        inputs = {'w', 'a'},
    },
}

RegisterNetEvent('bd-burgershot:client:Cook', function(product)
    local recipe = Config.Recipes[product]
    if not recipe then return end

    local station = CookingStations[recipe.station]
    if not station then return end

    local canCook, missingMsg = lib.callback.await('bd-burgershot:server:CanCook', false, product)
    if not canCook then
        Notify(missingMsg)
        return
    end

    if station.sound then
        TriggerServerEvent('InteractSound_SV:PlayOnSource', station.sound, station.volume)
    end

    local ped = cache and cache.ped or PlayerPedId()
    lib.requestAnimDict(station.anim.dict)
    TaskPlayAnim(ped, station.anim.dict, station.anim.clip, 8.0, -8.0, -1, 1, 0, false, false, false)

    local success = lib.skillCheck(station.difficulty, station.inputs)

    ClearPedTasksImmediately(ped)

    TriggerServerEvent('bd-burgershot:server:FinishCooking', product, success and true or false)
end)
