CreateThread(function()
    local b = Config.Blip
    local blip = AddBlipForCoord(b.coords.x, b.coords.y, b.coords.z)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, b.scale)
    SetBlipSprite(blip, b.sprite)
    SetBlipColour(blip, b.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(b.label)
    EndTextCommandSetBlipName(blip)
end)

local function AddTargetZone(zone)
    local size = zone.size or vec3(1, 1, 2)
    local jobOnly = zone.jobOnly ~= false

    if Config.TargetSystem == 'ox' then
        exports.ox_target:addBoxZone({
            coords = vec3(zone.coords.x, zone.coords.y, zone.coords.z),
            size = size,
            rotation = zone.coords.w,
            debug = Config.DebugZones,
            options = {
                {
                    name = zone.name,
                    event = zone.event,
                    onSelect = zone.onSelect,
                    icon = zone.icon,
                    label = zone.label,
                    groups = jobOnly and { Config.Jobname } or nil,
                },
            },
        })
    elseif Config.TargetSystem == 'qb' then
        exports['qb-target']:AddBoxZone(zone.name, vec3(zone.coords.x, zone.coords.y, zone.coords.z), size.x, size.y, {
            name = zone.name,
            heading = zone.coords.w,
            debugPoly = Config.DebugZones,
            minZ = zone.coords.z - size.z,
            maxZ = zone.coords.z + size.z,
        }, {
            options = {
                {
                    type = 'client',
                    event = zone.event,
                    action = zone.onSelect,
                    icon = zone.icon,
                    label = zone.label,
                    job = jobOnly and Config.Jobname or nil,
                },
            },
            distance = 2.0,
        })
    end
end

AddTargetZone({
    name = 'burgershot_duty',
    coords = Config.Locations.ClockIn.coords,
    size = Config.Locations.ClockIn.size,
    label = 'Clock In/Out',
    icon = 'fa-solid fa-clipboard-user',
    event = 'bd-burgershot:client:ToggleDuty',
})

AddTargetZone({
    name = 'burgershot_bossmenu',
    coords = Config.Locations.BossMenu,
    label = 'Boss Menu',
    icon = 'fa-solid fa-user-tie',
    event = 'bd-burgershot:client:OpenBossMenu',
})

for _, station in ipairs(Config.Locations.Stations) do
    AddTargetZone({
        name = station.name,
        coords = station.coords,
        label = station.label,
        icon = station.icon,
        event = station.event,
    })
end

for i, coords in ipairs(Config.Locations.Registers) do
    AddTargetZone({
        name = ('burgershot_register%d'):format(i),
        coords = coords,
        label = 'Register',
        icon = 'fa-solid fa-cash-register',
        event = 'bd-burgershot:client:OpenKiosk',
    })
end

for _, stash in ipairs(Config.Locations.Stashes) do
    AddTargetZone({
        name = ('burgershot_stash_%s'):format(stash.id),
        coords = stash.coords,
        size = stash.size,
        label = stash.label,
        icon = stash.icon,
        jobOnly = stash.jobOnly,
        onSelect = function()
            TriggerEvent('bd-burgershot:client:OpenStash', stash.id)
        end,
    })
end
