RegisterNetEvent('hex_policejob:zakuj')
AddEventHandler('hex_policejob:zakuj', function(target)
	TriggerClientEvent('hex_policejob:zakuj', target)
    local akcja = 'zakuł/rozkuł'
    logiKajdanki(source, target, akcja)
end)

RegisterNetEvent('hex_policejob:przenies')
AddEventHandler('hex_policejob:przenies', function(target)
	TriggerClientEvent('hex_policejob:przenies', target, source)
    local akcja = 'przeniósł'
    logiKajdanki(source, target, akcja)
end)

RegisterNetEvent('hex_policejob:doauta')
AddEventHandler('hex_policejob:doauta', function(target)
	TriggerClientEvent('hex_policejob:doauta', target)
    local akcja = 'wsadził do auta'
        logiKajdanki(source, target, akcja)
end)

RegisterNetEvent('hex_policejob:zauta')
AddEventHandler('hex_policejob:zauta', function(target)
	TriggerClientEvent('hex_policejob:zauta', target)
    local akcja = 'wyciągnął z auta'
    logiKajdanki(source, target, akcja)
end)

function logiKajdanki(source, target, akcja)
    local nadajacy = GetPlayerName(source)
    local nadajacyhex = GetPlayerIdentifier(source)
    local kto = GetPlayerName(target)
    local ktohex = GetPlayerIdentifier(target)
    local data = os.date('*t')
    if data.month < 10 then data.month = '0' .. tostring(data.month) end
    if data.day < 10 then data.day = '0' .. tostring(data.day) end
    if data.hour < 10 then data.hour = '0' .. tostring(data.hour) end
    if data.min < 10 then data.min = '0' .. tostring(data.min) end
    if data.sec < 10 then data.sec = '0' .. tostring(data.sec) end
    local data = (''..data.day .. '.' .. data.month .. '.' .. data.year .. ' - ' .. data.hour .. ':' .. data.min .. ':' .. data.sec..'')
    local embed = {
          {
            ["color"] = 16753920,
            ["title"] = 'Kajdanki',
            ["description"] = 'Gracz  ' .. nadajacy .. ':' .. nadajacyhex.. ' ' ..akcja.. ' ' .. kto .. ':' .. ktohex,
            ["footer"] = {
                ["text"] = data,
            },
          }
      }
  
    PerformHttpRequest(PremiaWebhook, function(err, text, headers) end, 'POST', json.encode({username = 'Justice Roleplay', embeds = embed}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterCommand({'pusc'}, 'user', function(xPlayer)
    xPlayer.triggerEvent('hex_policejob:unprzenies')
end, false)

ESX.RegisterUsableItem('kajdanki', function(playerId)
    TriggerClientEvent('hex_policejob:zakujcl', playerId)
end)
