local ownedLicenses 				= {}

RegisterNetEvent('hex_policejob:blip', function()
    blip = AddBlipForCoord(KomendaMission)
    SetBlipSprite(blip , 137)
    SetBlipScale(blip , 1.0)
    SetBlipColour(blip, 3)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Komenda LSPD")
    EndTextCommandSetBlipName(blip)
end)

exports.qtarget:AddBoxZone('bossmenu', vector3(447.3705, -974.3602, 29.9683), 2.8, 1.7, {
    name= 'bossmenu',
    heading=90.9534,
    debugPoly=false,
    minZ=29.9683,
    maxZ=31.57834,
    }, {
        options = {
            {
                icon = "fas fa-sign-in-alt",
                label = "Otwórz boss menu",
                action = function()  TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu) end) end
            },
            {
                icon = "fas fa-sign-in-alt",
                label = "Nadaj odznakę",
                action = function() local odznaka = lib.inputDialog('Nadawanie odznaki', {'Wpisz ID', 'Wpisz numer'}) 
                    TriggerServerEvent('hex_policejob:nadajodznake', odznaka[1], odznaka[2]) print(odznaka[2])end
            },
            {
                icon = "fas fa-sign-in-alt",
                label = "Nadaj premię",
                action = function()  local premia = lib.inputDialog('Nadawanie premii', {'Wpisz ID', 'Wpisz kwotę'})
                    TriggerServerEvent('hex_policejob:nadajpremie', premia[1], premia[2]) end
            },
            {
                icon = "fas fa-sign-in-alt",
                label = "Nadaj licencję",
                action = function()  lib.showContext('lickimenu') end
            },
            {
                icon = "fas fa-sign-in-alt",
                label = "Zamów broń",
                action = function()  lib.showContext('transportmenulspd') end
            },
            {
                icon = "fas fa-sign-in-alt",
                label = "Sprawdź godziny",
                action = function()  TriggerEvent('hex_policejob:pokazgodziny') end
            },
            {
                icon = "fas fa-sign-in-alt",
                label = "Usuń godziny",
                action = function()  TriggerEvent('hex_policejob:delgodziny') end
            },
        },
        distance = 1.5
})

exports.qtarget:AddBoxZone('szafka', vector3(461.4310, -978.3802, 29.6896), 1.5, 1, {
    name= 'szafka',
    heading=90.9534,
    debugPoly=false,
    minZ=28.97834,
    maxZ=32.07834,
    }, {
        options = {
            {
                icon = "fas fa-sign-in-alt",
                label = "Otwórz szafkę",
                action = function()  exports.ox_inventory:openInventory('stash', 'society_police') end
            },
        },
        distance = 1.5
})

exports.qtarget:AddBoxZone('zbrojownia', vector3(462.5666, -981.1403, 29.6896), 1, 2, {
    name= 'zbrojownia',
    heading=90.9534,
    debugPoly=false,
    minZ=28.97834,
    maxZ=31.97834,
    }, {
        options = {
            {
                icon = "fas fa-sign-in-alt",
                label = "Otwórz zbrojownię",
                action = function()   exports.ox_inventory:openInventory('stash', 'policezbrojownia') end,
            },
        },
        distance = 1.5
})