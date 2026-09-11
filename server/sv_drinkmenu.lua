local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory

local DrinkById = {}
for _, drink in ipairs(Config.Drinks) do
    DrinkById[drink.id] = drink
end

local function Notify(src, description)
    lib.notify(src, {
        id = 'burger_shot',
        title = 'Burgershot',
        description = description,
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
end

local function GetItemLabel(item)
    if Config.InventorySystem == 'ox' then
        local data = ox_inventory:Items(item)
        return data and data.label or item
    else
        local data = QBCore.Shared.Items[item]
        return data and data.label or item
    end
end

local function GetItemCount(src, Player, item)
    if Config.InventorySystem == 'ox' then
        return ox_inventory:GetItemCount(src, item)
    else
        local invItem = Player.Functions.GetItemByName(item)
        return invItem and invItem.amount or 0
    end
end

-- Ingredients can be defined per-drink (id) or shared across a whole
-- category - id takes priority when both would otherwise apply.
local function GetDrinkIngredients(drink)
    if not Config.DrinkIngredients then return nil end
    return Config.DrinkIngredients[drink.id] or Config.DrinkIngredients[drink.category]
end

-- Drinks with no matching id/category entry in Config.DrinkIngredients
-- require nothing, so this always succeeds for them.
local function GetMissingIngredients(src, Player, drink)
    local ingredients = GetDrinkIngredients(drink)
    if not ingredients then return true, nil end

    local missing = {}
    for _, ing in ipairs(ingredients) do
        local count = GetItemCount(src, Player, ing.item)
        if count < ing.amount then
            missing[#missing + 1] = ('%dx %s (have %d)'):format(ing.amount, GetItemLabel(ing.item), count)
        end
    end

    if #missing == 0 then
        return true, nil
    end

    return false, 'You are missing: ' .. table.concat(missing, ', ')
end

lib.callback.register('bd-burgershot:server:CanMakeDrink', function(source, drinkId)
    local drink = DrinkById[drinkId]
    if not drink then return false, 'That drink does not exist.' end

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false, 'Something went wrong.' end
    if Player.PlayerData.job.name ~= Config.Jobname then return false, 'You are not on duty.' end

    return GetMissingIngredients(source, Player, drink)
end)

RegisterNetEvent('bd-burgershot:server:MakeDrink', function(drinkId)
    local src = source
    local drink = DrinkById[drinkId]
    if not drink then return end

    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if Player.PlayerData.job.name ~= Config.Jobname then return end

    local canMake, missingMsg = GetMissingIngredients(src, Player, drink)
    if not canMake then
        Notify(src, missingMsg)
        return
    end

    local ingredients = GetDrinkIngredients(drink)
    if ingredients then
        for _, ing in ipairs(ingredients) do
            if Config.InventorySystem == 'ox' then
                ox_inventory:RemoveItem(src, ing.item, ing.amount)
            else
                Player.Functions.RemoveItem(ing.item, ing.amount)
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[ing.item], 'remove', ing.amount)
            end
        end
    end

    if Config.InventorySystem == 'ox' then
        ox_inventory:AddItem(src, drink.item, drink.amount)
    elseif Config.InventorySystem == 'qb' then
        exports['qb-inventory']:AddItem(src, drink.item, drink.amount, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[drink.item], 'add', drink.amount)
    end

    Notify(src, ('You have %s %dx %s'):format(drink.verb, drink.amount, drink.label))
end)
