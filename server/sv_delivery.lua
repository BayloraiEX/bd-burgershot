local QBCore = exports['qb-core']:GetCoreObject()

local src = source
local Player = QBCore.Functions.GetPlayer(src)
local totalbags = math.random(Config.MinBag, Config.MaxBag)

RegisterNetEvent('bd-burgershot:server:RecieveBags', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    exports['qb-inventory']:AddItem(src, 'bs_bag', totalbags, false, false)
    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_bag'], 'add', totalbags)
end)

RegisterNetEvent('bd-burgershot:server:FinishDelivery', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    exports['qb-inventory']:RemoveItem(src, 'bs_bag', totalbags, false)
    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['bs_bag'], 'remove')
end)

RegisterNetEvent('bd-burgershot:server:FinishDeliveryPay', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPay = math.random(Config.MinPay, Config.MaxPay) -- the amount you get inbetween the min and max set in config
    local PlayerPercent = Config.PlayerPercent -- setting the playerPercent to be whats in the config
    local playerTotal = totalPay*PlayerPercent/100 -- getting the % of the totalPay
    local businessTotal = playerTotal-totalPay -- getting the business amount after removing the playerPercent

    if Config.PayWorker == true then
        exports['qb-banking']:AddMoney('burgershot', businessTotal, 'Delivery-Work')
        Player.Functions.AddMoney('bank', playerTotal, 'Delivery-Tip')
    elseif Config.PayWorker == false then
        exports['qb-banking']:AddMoney('burgershot', businessTotal, 'Delivery-Tip')
    end
end)
