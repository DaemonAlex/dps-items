local W = Config.Watch
local bursts, lastAlert, serials = {}, {}, {}

local function alert(src, kind, msg)
    local key = ('%s:%s'):format(src or 0, kind)
    local now = os.time()
    if lastAlert[key] and now - lastAlert[key] < W.cooldown then return end
    lastAlert[key] = now
    print(('[dps-items] WATCH %s: %s'):format(kind, msg))
    lib.logger(src or 0, 'dps-items:watch', ('%s: %s'):format(kind, msg))
end

exports.ox_inventory:registerHook('swapItems', function(payload)
    local src = tonumber(payload.source)
    if not src or src <= 0 then return end

    local now = GetGameTimer()
    local b = bursts[src]
    if not b or now - b.start > W.burstWindowMs then
        bursts[src] = { start = now, n = 1 }
    else
        b.n = b.n + 1
        if b.n == W.burstCount then
            alert(src, 'burst', ('%s made %d inventory moves in %.1fs'):format(Items.playerLabel(src), b.n, W.burstWindowMs / 1000))
        end
    end

    local slot = payload.fromSlot
    if type(slot) == 'table' and W.cashItems[slot.name] and (payload.count or 0) >= W.bigCash
        and payload.toType == 'player' and payload.toInventory ~= payload.fromInventory then
        alert(src, 'bigcash', ('%s moved %s x%d to player %s'):format(Items.playerLabel(src), slot.name, payload.count, tostring(payload.toInventory)))
    end
end, {})

exports.ox_inventory:registerHook('createItem', function(payload)
    local item, meta = payload.item, payload.metadata
    local name = item and item.name

    if W.cashItems[name] and (payload.count or 0) >= W.bigCash then
        alert(0, 'bigcash', ('%s created %s x%d in %s'):format(payload.resource or '?', name, payload.count, tostring(payload.inventoryId)))
    end

    local serial = type(meta) == 'table' and meta.serial
    if serial and serial ~= 'POL' and name and name:find('^WEAPON_') then
        local seen = serials[serial]
        if seen and seen.inv ~= tostring(payload.inventoryId) then
            alert(0, 'dupeserial', ('%s serial %s created again by %s in %s (first seen in %s)'):format(name, serial, payload.resource or '?', tostring(payload.inventoryId), seen.inv))
        end
        serials[serial] = { inv = tostring(payload.inventoryId) }
    end
end, {})

AddEventHandler('playerDropped', function()
    bursts[source] = nil
end)
