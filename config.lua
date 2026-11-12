Config = {}

-- Staff with this ace skip the item lock and glovebox rule.
Config.AdminAce = 'dps.items.admin'

Config.Lock = {
    -- Always locked to the person who holds them.
    items = {
        id_card = true,
        driver_license = true,
        weaponlicense = true,
        lawyerpass = true,
    },
    -- Any item whose metadata has this key set to true is locked too (job-issued gear).
    metaKey = 'locked',
    -- Moving it into your own stash, house, trunk or glovebox is always fine.
}

Config.Glovebox = {
    -- -1 driver, 0 front passenger.
    seats = { [-1] = true, [0] = true },
}

Config.Watch = {
    -- Moves per player inside the window before it is flagged.
    burstCount = 25,
    burstWindowMs = 3000,
    -- Cash handed to another player or created by a script in one go.
    bigCash = 250000,
    cashItems = { money = true, black_money = true, markedbills = true },
    -- Seconds between repeat alerts of the same kind for the same player.
    cooldown = 60,
}

Config.Text = {
    locked = 'This is yours alone. It can\'t be dropped or handed over.',
    glovebox = 'Only the driver or front passenger can reach the glovebox.',
}
