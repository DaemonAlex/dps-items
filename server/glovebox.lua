local seats = Config.Glovebox.seats

exports.ox_inventory:registerHook('openInventory', function(payload)
    local src = payload.source
    if Items.isStaff(src) then return end

    local ped = GetPlayerPed(src)
    local veh = GetVehiclePedIsIn(ped, false)
    if veh == 0 then return end

    for seat in pairs(seats) do
        if GetPedInVehicleSeat(veh, seat) == ped then return end
    end

    Items.notify(src, Config.Text.glovebox)
    return false
end, { typeFilter = { glovebox = true } })
