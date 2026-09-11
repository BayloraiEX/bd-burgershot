local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('bd-burgershot:server:createTicket', function(orderItems, total, customerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.name ~= Config.Jobname then return end
    if type(orderItems) ~= 'table' or #orderItems == 0 then return end

    local function notifyWorker(description, color)
        lib.notify(src, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = description,
            showDuration = false,
            position = 'top',
            style = { backgroundColor = '#141517', color = color or '#F08080', ['.description'] = { color = '#909296' } },
            icon = 'receipt',
            iconColor = color or '#F08080'
        })
    end

    local customerSrc = tonumber(customerId)
    local CustomerPlayer = customerSrc and QBCore.Functions.GetPlayer(customerSrc) or nil
    if not customerSrc or not CustomerPlayer then
        notifyWorker('Invalid customer ID - make sure they are online and the ID is correct.')
        return
    end

    local lines, verifiedTotal = {}, 0
    for _, entry in ipairs(orderItems) do
        local label = tostring(entry.label or '')
        local qty = tonumber(entry.qty) or 0
        local price = tonumber(entry.price) or 0
        if label ~= '' and qty > 0 and price >= 0 then
            verifiedTotal += (qty * price)
            lines[#lines + 1] = ('%dx %s'):format(qty, label)
        end
    end

    if verifiedTotal <= 0 then
        notifyWorker('Order was invalid, nothing was rung up.')
        return
    end

    local description = table.concat(lines, ', ')
    local ticketId = ('BS-%05d'):format(math.random(0, 99999))

    notifyWorker(('Order #%s sent to customer (ID %d) for $%d. Waiting on their response...'):format(ticketId, customerSrc, verifiedTotal), '#ffe14d')

    local alert = lib.callback.await('bd-burgershot:client:confirmOrder', customerSrc, {
        header = 'Burgershot Order #' .. ticketId,
        content = ('Confirm your order for $%d?\n%s'):format(verifiedTotal, description),
    })

    if alert ~= 'confirm' then
        notifyWorker(('Order #%s was denied by the customer.'):format(ticketId))
        lib.notify(customerSrc, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'Order cancelled.',
            showDuration = false,
            position = 'top',
            style = { backgroundColor = '#141517', color = '#F08080', ['.description'] = { color = '#909296' } },
            icon = 'receipt',
            iconColor = '#F08080'
        })
        return
    end

    if not CustomerPlayer.Functions.RemoveMoney('bank', verifiedTotal) then
        notifyWorker(('Order #%s: customer\'s card was declined (insufficient funds).'):format(ticketId))
        lib.notify(customerSrc, {
            id = 'burger_shot',
            title = 'Burgershot',
            description = 'Not enough money in your bank.',
            showDuration = false,
            position = 'top',
            style = { backgroundColor = '#141517', color = '#F08080', ['.description'] = { color = '#909296' } },
            icon = 'receipt',
            iconColor = '#F08080'
        })
        return
    end
    exports['nfs-billing']:depositSociety(Config.SocietyAccount, verifiedTotal)
    exports['bd-burgershot']:LogBossTransaction('in', verifiedTotal, ('Order #%s - %s'):format(ticketId, description))

    notifyWorker(('Order #%s: customer paid $%d. Enjoy!'):format(ticketId, verifiedTotal), '#8fd694')
    lib.notify(customerSrc, {
        id = 'burger_shot',
        title = 'Burgershot',
        description = ('You paid $%d. Enjoy your meal!'):format(verifiedTotal),
        showDuration = false,
        position = 'top',
        style = { backgroundColor = '#141517', color = '#F08080', ['.description'] = { color = '#909296' } },
        icon = 'receipt',
        iconColor = '#F08080'
    })
end)