Items = {}

function Items.isStaff(src)
    return src and src > 0 and IsPlayerAceAllowed(src, Config.AdminAce)
end

function Items.notify(src, text)
    if not src or src <= 0 then return end
    TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = text })
end

function Items.playerLabel(src)
    if not src or src <= 0 then return 'server' end
    return ('%s (%s)'):format(GetPlayerName(src) or 'unknown', src)
end
