function obiektylogi(source, obiekt, pozycja)
    local nadajacy = GetPlayerName(source)
    local nadajacyhex = GetPlayerIdentifier(source)
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
            ["title"] = 'Stawianie obiektów',
            ["description"] = 'Gracz  ' .. nadajacy .. ':' .. nadajacyhex.. ' postawił obiekt ' .. obiekt .. " na koordach " .. pozycja,
            ["footer"] = {
                ["text"] = data,
            },
          }
      }
  
    PerformHttpRequest(ObiektWebhook, function(err, text, headers) end, 'POST', json.encode({username = 'Justice Roleplay', embeds = embed}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('hex_policejob:obiektlog', function(obiekt, pozycja)
    obiektylogi(source, obiekt, pozycja)
end)