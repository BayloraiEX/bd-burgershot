local ox_inventory = Config.InventorySystem == 'ox' and exports.ox_inventory or nil

RegisterNetEvent('bd-burgershot:client:OpenStash', function(stashId)
    if type(stashId) ~= 'string' then return end

    if Config.InventorySystem == 'ox' then
        if ox_inventory:openInventory('stash', stashId) == false then
            TriggerServerEvent('bd-burgershot:server:RegisterStash', stashId)
            ox_inventory:openInventory('stash', stashId)
        end
    elseif Config.InventorySystem == 'qb' then
        TriggerServerEvent('bd-burgershot:server:OpenStash', stashId)
    end
end)
