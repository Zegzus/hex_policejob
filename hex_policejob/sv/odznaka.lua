RegisterServerEvent('hex_policejob:nadajodznake')
AddEventHandler('hex_policejob:nadajodznake', function(input1, input2)
    local xPlayer = ESX.GetPlayerFromId(input1)
    local jaka = input2
    local kto = xPlayer.getIdentifier(input1)
    print(input2)
    MySQL.update('UPDATE users SET odznaka = @jaka WHERE identifier = @kto', {['@jaka'] = jaka,['@kto'] = kto})
end)