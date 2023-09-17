--[[ESX.RegisterCommand({'startc'}, 'user', function()
    start = os.time()
end, false)]]

RegisterServerEvent('hex_policejob:startsluzby', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local start = os.time()
    xPlayer.setMeta('sluzby', {sluzbas = start, sluzbak = 0})
end)

--[[ESX.RegisterCommand({'endc'}, 'user', function(xPlayer)
    local czas = os.time() - start
    MySQL.scalar('SELECT czas FROM playtime WHERE hex = ?', {xPlayer.getName()},
        function(result)
            if result ~= nil then
                local calyczas = result+czas
                MySQL.update('UPDATE playtime SET czas = @czas WHERE hex = @hex', {
		            ['@czas'] = calyczas,
		            ['@hex'] = xPlayer.getName()
	            })
            else
                MySQL.insert('INSERT INTO playtime (hex, czas) VALUES (?, ?)', {xPlayer.getName(), czas})
            end
    end)
end, false)]]

AddEventHandler('playerDropped', function(reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local czas = os.time() - xPlayer.getMeta('sluzby', 'sluzbas')
    if xPlayer.job.name == 'police' then
    MySQL.scalar('SELECT czas FROM godzinysluzba WHERE hex = ?', {xPlayer.getName()},
        function(result)
            if result ~= nil then
                local calyczas = result+czas
                MySQL.update('UPDATE godzinysluzba SET czas = @czas WHERE hex = @hex', {
		            ['@czas'] = calyczas,
		            ['@hex'] = xPlayer.getName()
	            })
            else
                MySQL.insert('INSERT INTO godzinysluzba (hex, czas) VALUES (?, ?)', {xPlayer.getName(), czas})
            end
    end)
    end
end)

RegisterServerEvent('hex_policejob:sprawdzgodziny', function(target)
    local gracz = source
    MySQL.scalar('SELECT czas FROM `godzinysluzba` WHERE hex = @hex',{['@hex'] = target},
        function(result)
            if result ~= nil then
                local czas = result/3600
                TriggerClientEvent('ox_lib:notify', gracz,  {
                    title = 'Służba',
                    description = target .. " spędził na służbie " .. czas .."h",
                    type = 'succes'
                })
            else 
                TriggerClientEvent('ox_lib:notify', gracz,  {
                    title = 'Bląd',
                    description = 'Nie masz takiego policjanta',
                    type = 'error'
                })
            end
    end)
end)

RegisterServerEvent('hex_policejob:usungodziny', function(target)
    MySQL.scalar('DELETE FROM `godzinysluzba` WHERE hex = @hex',{['@hex'] = target})
end)