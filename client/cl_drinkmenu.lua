local DrinkById = {}
for _, drink in ipairs(Config.Drinks) do
    DrinkById[drink.id] = drink
end

local function Notify(description)
    lib.notify({
        id = 'burger_shot',
        title = 'Burgershot',
        description = description,
        showDuration = false,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#F08080',
            ['.description'] = { color = '#909296' }
        },
        icon = 'burger',
        iconColor = '#F08080'
    })
end

local function DescribeDrink(drink)
    local base = ('%s %dx %s'):format(drink.verb == 'made' and 'Make' or 'Pour', drink.amount, drink.label)

    local ingredients = Config.DrinkIngredients and (Config.DrinkIngredients[drink.id] or Config.DrinkIngredients[drink.category])
    if not ingredients then return base end

    local parts = {}
    for _, ing in ipairs(ingredients) do
        parts[#parts + 1] = ('%dx %s'):format(ing.amount, ing.item)
    end

    return ('%s (Needs: %s)'):format(base, table.concat(parts, ', '))
end

local Categories = {
    { id = 'softdrinks', title = 'Soft Drinks', description = 'All our soft drink types',                          icon = 'faucet-drip' },
    { id = 'coffee',     title = 'Coffee',      description = 'All our coffee types',                              icon = 'mug-hot' },
    { id = 'milkshakes', title = 'Milkshakes',  description = 'My milkshakes bring all the boys/girls to the yard', icon = 'ice-cream' },
}

local rootOptions = {}
for _, cat in ipairs(Categories) do
    local options = {}
    for _, drink in ipairs(Config.Drinks) do
        if drink.category == cat.id then
            options[#options + 1] = {
                title = drink.label,
                description = DescribeDrink(drink),
                event = 'bd-burgershot:client:MakeDrink',
                args = drink.id,
                icon = cat.icon,
                iconColor = '#EC213A',
            }
        end
    end

    lib.registerContext({
        id = 'burgershot_' .. cat.id,
        title = cat.title,
        menu = 'burgershot_drinks',
        options = options,
    })

    rootOptions[#rootOptions + 1] = {
        title = cat.title,
        description = cat.description,
        menu = 'burgershot_' .. cat.id,
    }
end

lib.registerContext({
    id = 'burgershot_drinks',
    title = 'Drink Menu',
    options = rootOptions,
})

RegisterNetEvent('bd-burgershot:client:OpenDrinkMenu', function()
    lib.showContext('burgershot_drinks')
end)

RegisterNetEvent('bd-burgershot:client:MakeDrink', function(drinkId)
    local drink = DrinkById[drinkId]
    if not drink then return end

    local canMake, missingMsg = lib.callback.await('bd-burgershot:server:CanMakeDrink', false, drinkId)
    if not canMake then
        Notify(missingMsg)
        return
    end

    -- Note: if you change duration the sound may play longer than the bar
    TriggerServerEvent('InteractSound_SV:PlayOnSource', drink.sound, 0.2)

    local finished = lib.progressCircle({
        duration = drink.duration,
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
            scenario = 'mini@repair',
        },
    })

    if finished then
        TriggerServerEvent('bd-burgershot:server:MakeDrink', drinkId)
    end
end)
