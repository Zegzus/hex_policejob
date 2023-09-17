RegisterServerEvent('hex_policejob:lspd', function()
    local xPlayers = ESX.GetExtendedPlayers('job', 'police')
    local lspd = 0

    for i = 1, #xPlayers do
        lspd = lspd+1
    end

    if lspd == 1 then
        TriggerClientEvent('ox_lib:notify', source,  {
            title = 'Policjant',
            description = 'Na służbie obecnie jest '..lspd .. ' policjant',
            type = 'info'
        })
    else
        TriggerClientEvent('ox_lib:notify', source,  {
            title = 'Policjant',
            description = 'Na służbie obecnie jest '..lspd .. ' policjantów',
            type = 'info'
        })
    end
end)