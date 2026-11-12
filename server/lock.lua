local lock = Config.Lock

local function isLocked(slot)
    if type(slot) ~= 'table' or not slot.name then return false end
    if lock.items[slot.name] then return true end
    return slot.metadata and slot.metadata[lock.metaKey] == true
end

exports.ox_inventory:registerHook('swapItems', function(payload)
    local slot = payload.fromSlot
    if not isLocked(slot) then return end
    if Items.isStaff(payload.source) then return end

    local action, toType = payload.action, payload.toType
    local leavingOwner = action == 'give'
        or toType == 'drop'
        or payload.toInventory == 'newdrop'
        or (toType == 'player' and payload.toInventory ~= payload.fromInventory)
        or (payload.fromType == 'player' and payload.fromInventory ~= payload.source)

    if not leavingOwner then return end

    Items.notify(payload.source, Config.Text.locked)
    return false
end, {})
