local QBCore = exports['qb-core']:GetCoreObject()

local activeDeliveries = {}

local function AddBags(src, amount)
    if Config.InventorySystem == 'ox' then
        exports.ox_inventory:AddItem(src, 'bs_bag', amount)
    elseif Config.InventorySystem == 'qb' then
        exports['qb-inventory']:AddItem(src, 'bs_bag', amount, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['bs_bag'], 'add', amount)
    end
end

local function RemoveBags(src, amount)
    if Config.InventorySystem == 'ox' then
        exports.ox_inventory:RemoveItem(src, 'bs_bag', amount, false)
    elseif Config.InventorySystem == 'qb' then
        exports['qb-inventory']:RemoveItem(src, 'bs_bag', amount, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['bs_bag'], 'remove')
    end
end

RegisterNetEvent('bd-burgershot:server:RecieveBags', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.name ~= Config.Jobname then return end
    if activeDeliveries[src] then return end

    local bags = math.random(Config.MinBag, Config.MaxBag)
    activeDeliveries[src] = bags
    AddBags(src, bags)
end)

RegisterNetEvent('bd-burgershot:server:FinishDelivery', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.name ~= Config.Jobname then return end

    local bags = activeDeliveries[src]
    if not bags then return end
    activeDeliveries[src] = nil

    RemoveBags(src, bags)

    local totalPay = math.random(Config.MinPay, Config.MaxPay)

    if Config.PayWorker then
        local playerTotal = math.floor(totalPay * Config.PlayerPercent / 100)
        local businessTotal = totalPay - playerTotal
        Player.Functions.AddMoney('bank', playerTotal, 'Delivery-Tip')
        exports['nfs-billing']:depositSociety(Config.SocietyAccount, businessTotal)
        exports['bd-burgershot']:LogBossTransaction('in', businessTotal, 'Delivery payout')
    else
        exports['nfs-billing']:depositSociety(Config.SocietyAccount, totalPay)
        exports['bd-burgershot']:LogBossTransaction('in', totalPay, 'Delivery payout')
    end
end)

AddEventHandler('playerDropped', function()
    activeDeliveries[source] = nil
end)
