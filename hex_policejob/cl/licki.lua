local ownedLicenses = {}

lib.registerContext({
    id = 'lickimenu',
    title = 'Menu licencji',
    options = {
      {
        title = 'Nadaj licencję waterunit',
        description = '',
        icon = 'circle',
        onSelect = function()
            local id = lib.inputDialog('Nadawanie licencji', {'Wpisz ID'})
            TriggerServerEvent('hex_policejob:waterunit', id[1])
        end,
      },
      {
        title = 'Nadaj licencję asu',
        description = '',
        icon = 'circle',
        onSelect = function()
            local id = lib.inputDialog('Nadawanie licencji', {'Wpisz ID'})
            TriggerServerEvent('hex_policejob:asu', id[1])
        end,
      },
      {
        title = 'Nadaj licencję haw',
        description = '',
        icon = 'circle',
        onSelect = function()
            local id = lib.inputDialog('Nadawanie licencji', {'Wpisz ID'})
            TriggerServerEvent('hex_policejob:haw', id[1])
        end,
      },
    }
})

RegisterNetEvent('hex_policejob:zaladujlicke')
AddEventHandler('hex_policejob:zaladujlicke', function(licenses)
	Licenses = licenses
end)

exports.qtarget:AddBoxZone('waterunitszafka', vector3(455.8331, -978.4069, 29.6896), 2, 1, {
    name= 'waterunitszafka',
    heading=90.9534,
    debugPoly=false,
    minZ=28.97834,
    maxZ=31.97834,
    }, {
        options = {
            {
                icon = "fas fa-sign-in-alt",
                label = "Otwórz szafkę",
                action = function()  exports.ox_inventory:openInventory('stash', 'policewu') end,
                canInteract = function()
                    for i = 1, #Licenses, 1 do
                        ownedLicenses[Licenses[i].type] = true
                    end
                    return ownedLicenses['waterunit']
                end
            },
        },
        distance = 1.5
})

exports.qtarget:AddBoxZone('hawlspd', vector3(456.6783, -983.8900, 29.6896), 2, 1, {
    name= 'hawlspd',
    heading=90.9534,
    debugPoly=false,
    minZ=28.97834,
    maxZ=31.97834,
    }, {
        options = {
            {
                icon = "fas fa-sign-in-alt",
                label = "Otwórz szafkę",
                action = function()   exports.ox_inventory:openInventory('stash', 'policehaw') end,
                canInteract = function()
                    for i = 1, #Licenses, 1 do
                        ownedLicenses[Licenses[i].type] = true
                    end
                    return ownedLicenses['haw']
                end
            },
        },
        distance = 1.5
})

exports.qtarget:AddBoxZone('lodkalspd', vector3(-836.7758, -1361.9690, 0.5070), 0.5, 0.5, {
    name= 'lodkalspd',
    heading=90.9534,
    debugPoly=false,
    minZ=0.27834,
    maxZ=3.97834,
    }, {
        options = {
            {
                icon = "fas fa-sign-in-alt",
                label = "Wyciągnij łódkę",
                action = function()  SpawnLodka() end,
                canInteract = function()
                    for i = 1, #Licenses, 1 do
                        ownedLicenses[Licenses[i].type] = true
                    end
                    return ownedLicenses['waterunit']
                end
            },
            {
                icon = "fas fa-sign-in-alt",
                label = "Schowaj łódkę",
                action = function()  DelLodka() end,
                canInteract = function()
                    for i = 1, #Licenses, 1 do
                        ownedLicenses[Licenses[i].type] = true
                    end
                    return ownedLicenses['waterunit']
                end
            },
        },
        distance = 1.5
})

function SpawnLodka()
    if ESX.Game.IsSpawnPointClear(vector3(-844.4278, -1361.3422, 0.2), 3) then
        ESX.Game.SpawnVehicle('predator', vector3(-844.4278, -1361.3422, 0.2), 100.0, function(vehicle)
        end)
    else
        TriggerEvent('ox_lib:notify', {
            title = 'Nie ma wolnego miejsca',
            description = '',
            type = 'error'
        })
    end
end

function DelLodka()
    local vehicle, dystans = ESX.Game.GetClosestVehicle(vector3(-844.4278, -1361.3422, 0.2))
    if dystans < 5.0 then
    ESX.Game.DeleteVehicle(vehicle)
    else
        TriggerEvent('ox_lib:notify', {
            title = 'Brak pojazdu w pobliżu',
            description = '',
            type = 'error'
        })
    end
end

exports.qtarget:AddBoxZone('helilspd', vector3(464.1319, -982.3683, 42.8919), 0.2, 1.8, {
    name= 'helilspd',
    heading=90.9534,
    debugPoly=false,
    minZ=42.27834,
    maxZ=44.97834,
    }, {
        options = {
            {
                icon = "fas fa-sign-in-alt",
                label = "Wyciągnij helikopter",
                action = function()  SpawnHeli() end,
                canInteract = function()
                    for i = 1, #Licenses, 1 do
                        ownedLicenses[Licenses[i].type] = true
                    end
                    return ownedLicenses['asu']
                end
            },
            {
                icon = "fas fa-sign-in-alt",
                label = "Schowaj helikopter",
                action = function()  DelHeli() end,
                canInteract = function()
                    for i = 1, #Licenses, 1 do
                        ownedLicenses[Licenses[i].type] = true
                    end
                    return ownedLicenses['asu']
                end
            },
        },
        distance = 1.5
})

function SpawnHeli()
    if ESX.Game.IsSpawnPointClear(vector3(449.1403, -981.2454, 43.6917), 3) then
        ESX.Game.SpawnVehicle('polmav', vector3(449.1403, -981.2454, 43.6917), 100.0, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, {
                modLivery = 2
               })
        end)
    else
        TriggerEvent('ox_lib:notify', {
            title = 'Nie ma wolnego miejsca',
            description = '',
            type = 'error'
        })
    end
end

function DelHeli()
    local vehicle, dystans = ESX.Game.GetClosestVehicle(vector3(449.1403, -981.2454, 43.6917))
    if dystans < 5.0 then
    ESX.Game.DeleteVehicle(vehicle)
    else
        TriggerEvent('ox_lib:notify', {
            title = 'Brak pojazdu w pobliżu',
            description = '',
            type = 'error'
        })
    end
end