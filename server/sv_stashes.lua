local QBCore = exports['qb-core']:GetCoreObject()

local Stashes = {}
for _, stash in ipairs(Config.Locations.Stashes) do
    Stashes[stash.id] = stash
end

if Config.InventorySystem == 'ox' then
    local ox_inventory = exports.ox_inventory

    RegisterNetEvent('bd-burgershot:server:RegisterStash', function(stashId)
        local stash = Stashes[stashId]
        if not stash then return end
        ox_inventory:RegisterStash(stash.id, stash.ox.label, stash.ox.slots, stash.ox.weight, false)
    end)

elseif Config.InventorySystem == 'qb' then

    RegisterNetEvent('bd-burgershot:server:OpenStash', function(stashId)
        local src = source
        local stash = Stashes[stashId]
        if not stash then return end

        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end

        exports['qb-inventory']:OpenInventory(src, stash.qb.label, {
            maxweight = stash.qb.weight,
            slots = stash.qb.slots,
        })
    end)
end
