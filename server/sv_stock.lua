local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = Config.InventorySystem == 'ox' and exports.ox_inventory or nil

-- The two containers the "Stock" tab reports on, keyed by a short id used
-- in the NUI payload. Matched up against Config.Locations.Stashes by label
-- so this keeps working even if the stash coords/ids ever change.
local function FindStashByLabel(label)
    for _, stash in ipairs(Config.Locations.Stashes) do
        if stash.label == label then return stash end
    end
    return nil
end

local StockContainers = {
    { key = 'storage', label = 'Storage', stash = FindStashByLabel('Storage') },
    { key = 'fridge',  label = 'Fridge',  stash = FindStashByLabel('Fridge') },
}

-- Every unique ingredient referenced anywhere in Config.Recipes or
-- Config.DrinkIngredients - this is the full set of things staff need on
-- hand, whether that's a raw supply-order item (farm_lettuce), a prepped
-- item (bs_lettuce_slice), or a drink mix (bs_soda_mix).
local function GetCookIngredientList()
    local seen = {}
    local list = {}

    for _, recipe in pairs(Config.Recipes) do
        for _, ing in ipairs(recipe.ingredients) do
            if not seen[ing.item] then
                seen[ing.item] = true
                list[#list + 1] = ing.item
            end
        end
    end

    if Config.DrinkIngredients then
        for _, ingredients in pairs(Config.DrinkIngredients) do
            for _, ing in ipairs(ingredients) do
                if not seen[ing.item] then
                    seen[ing.item] = true
                    list[#list + 1] = ing.item
                end
            end
        end
    end

    return list
end

local CookIngredients = GetCookIngredientList()

local function GetItemLabel(item)
    if Config.InventorySystem == 'ox' then
        local data = ox_inventory:Items(item)
        return data and data.label or item
    else
        local data = QBCore.Shared.Items[item]
        return data and data.label or item
    end
end

-- Returns { [itemName] = count } for everything currently sitting in the
-- given stash config entry.
local function GetStashCounts(stash)
    local counts = {}
    if not stash then return counts end

    if Config.InventorySystem == 'ox' then
        -- Make sure the stash is actually registered before querying it -
        -- if nobody has opened it yet this session there's nothing cached.
        pcall(function()
            ox_inventory:RegisterStash(stash.id, stash.ox.label, stash.ox.slots, stash.ox.weight, false)
        end)

        local ok, items = pcall(function()
            return ox_inventory:GetInventoryItems(stash.id)
        end)

        if ok and items then
            for _, slotData in pairs(items) do
                if slotData and slotData.name then
                    counts[slotData.name] = (counts[slotData.name] or 0) + (slotData.count or 0)
                end
            end
        end
    elseif Config.InventorySystem == 'qb' then
        local ok, inv = pcall(function()
            return exports['qb-inventory']:GetInventory(stash.id)
        end)

        if ok and inv and inv.items then
            for _, slotData in pairs(inv.items) do
                if slotData and slotData.name then
                    counts[slotData.name] = (counts[slotData.name] or 0) + (slotData.amount or slotData.count or 0)
                end
            end
        end
    end

    return counts
end

local function BuildStockPayload()
    local countsByContainer = {}
    for _, entry in ipairs(StockContainers) do
        countsByContainer[entry.key] = GetStashCounts(entry.stash)
    end

    local items = {}
    for _, item in ipairs(CookIngredients) do
        local row = { item = item, label = GetItemLabel(item), counts = {}, total = 0 }
        for _, entry in ipairs(StockContainers) do
            local count = countsByContainer[entry.key][item] or 0
            row.counts[entry.key] = count
            row.total = row.total + count
        end
        items[#items + 1] = row
    end

    table.sort(items, function(a, b) return a.label < b.label end)

    local containers = {}
    for _, entry in ipairs(StockContainers) do
        containers[#containers + 1] = { key = entry.key, label = entry.label }
    end

    return { containers = containers, items = items }
end

exports('GetStockData', BuildStockPayload)
