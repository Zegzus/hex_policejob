RegisterNetEvent('hex_policejob:pokazgodziny')
AddEventHandler('hex_policejob:pokazgodziny', function(value)
    local godziny = lib.inputDialog('Sprawdzanie godzin', {'Wpisz imię i nazwisko'})
    TriggerServerEvent('hex_policejob:sprawdzgodziny', godziny[1])
end)

RegisterNetEvent('hex_policejob:delgodziny')
AddEventHandler('hex_policejob:delgodziny', function(value)
    local dgodziny = lib.inputDialog('Usuwanie godzin', {'Wpisz imię i nazwisko'})
    TriggerServerEvent('hex_policejob:usungodziny', dgodziny[1])
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer, isNew, skin)
    ESX.PlayerData = xPlayer
    if ESX.PlayerData.job.name == 'police' then
        TriggerServerEvent('hex_policejob:startsluzby')
    end
end)