RegisterServerEvent('hex_policejob:nadajpremie')
AddEventHandler('hex_policejob:nadajpremie', function(input1, input2)
    local ile = tonumber(input2)
    local komu = ESX.GetPlayerFromId(input1)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
        if ile > account.money then
            TriggerClientEvent('ox_lib:notify', source,  {
                title = 'Brak pieniędzy',
                description = 'Na koncie nie ma wystarczająco pieniędzy',
                type = 'error'
            })
        elseif ile <= account.money then
            account.removeMoney(ile)
            komu.addMoney(ile)
            logiPremie(source, ile, input1)
        end
    end)
end)

function logiPremie(source, ile, input1)
    local nadajacy = GetPlayerName(source)
    local nadajacyhex = GetPlayerIdentifier(source)
    local kto = GetPlayerName(input1)
    local ktohex = GetPlayerIdentifier(input1)
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
            ["title"] = 'Nadawanie premii',
            ["description"] = 'Gracz  ' .. nadajacy .. ':' .. nadajacyhex.. ' przelał graczowi ' .. kto .. ':' .. ktohex .. ' premię w wysokości ' .. ile .. "$",
            ["footer"] = {
                ["text"] = data,
            },
          }
      }
  
    PerformHttpRequest(PremiaWebhook, function(err, text, headers) end, 'POST', json.encode({username = 'Justice Roleplay', embeds = embed}), { ['Content-Type'] = 'application/json' })
end