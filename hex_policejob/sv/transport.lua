local zestaw1 = {'weapon_combatpistol', 'weapon_ceramicpistol', 'weapon_heavypistol'}
local zestaw2 = {'weapon_specialcarbine', 'weapon_combatpdw', 'weapon_carbinerifle', 'weapon_pumpshotgun'}
local zestaw3 = {'flashbang', 'weapon_nightstick', 'weapon_flashlight', 'weapon_smokegrenade', 'smokegrenade'}

RegisterServerEvent('hex_policejob:dodaitembagaj', function(blacha)
    local tablica = blacha
    exports.ox_inventory:SetSlotCount('trunk' .. tablica, 100)
    for k,v in pairs(zestaw1) do
        exports.ox_inventory:AddItem('trunk' .. tablica, v, 20)
    end
end)

RegisterServerEvent('hex_policejob:dodaitembagaj2', function(blacha)
    local tablica = blacha
    exports.ox_inventory:SetSlotCount('trunk' .. tablica, 100)
    for k,v in pairs(zestaw2) do
        exports.ox_inventory:AddItem('trunk' .. tablica, v, 10)
    end
end)

RegisterServerEvent('hex_policejob:dodaitembagaj3', function(blacha)
    local tablica = blacha
    exports.ox_inventory:SetSlotCount('trunk' .. tablica, 100)
    for k,v in pairs(zestaw3) do
        exports.ox_inventory:AddItem('trunk' .. tablica, v, 20)
    end
end)