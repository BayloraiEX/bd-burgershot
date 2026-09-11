local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory

local function Notify(src, description, color)
    lib.notify(src, {
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

local function GetMissingIngredients(src, Player, recipe)
    local missing = {}
    for _, ing in ipairs(recipe.ingredients) do
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

lib.callback.register('bd-burgershot:server:CanCook', function(source, product)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false, 'Something went wrong.' end
    if Player.PlayerData.job.name ~= Config.Jobname then return false, 'You are not on duty.' end

    local recipe = Config.Recipes[product]
    if not recipe then return false, 'That item does not exist.' end

    return GetMissingIngredients(source, Player, recipe)
end)

RegisterNetEvent('bd-burgershot:server:FinishCooking', function(product, success)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.name ~= Config.Jobname then return end

    local recipe = Config.Recipes[product]
    if not recipe then return end

    local canCook, missingMsg = GetMissingIngredients(src, Player, recipe)
    if not canCook then
        Notify(src, missingMsg)
        return
    end

    for _, ing in ipairs(recipe.ingredients) do
        if Config.InventorySystem == 'ox' then
            ox_inventory:RemoveItem(src, ing.item, ing.amount)
        else
            Player.Functions.RemoveItem(ing.item, ing.amount)
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[ing.item], 'remove', ing.amount)
        end
    end

    if not success then
        Notify(src, ('You burnt the %s and had to throw it out.'):format(recipe.label))
        return
    end

    if Config.InventorySystem == 'ox' then
        ox_inventory:AddItem(src, product, recipe.amount)
    else
        Player.Functions.AddItem(product, recipe.amount, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[product], 'add', recipe.amount)
    end

    Notify(src, ('You have made %dx %s'):format(recipe.amount, recipe.label), '#8fd694')
end)