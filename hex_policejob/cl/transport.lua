lib.registerContext({
    id = 'transportmenulspd',
    title = 'Menu zamówień',
    options = {
      {
        title = 'Zamów zestaw numer 1',
        description = 'Combat Pistol, Ceramic Pistol, Heavy Pistol',
        icon = 'circle',
        onSelect = function()
            zestaw = 1
            ZamowZestaw(zestaw)
        end,
      },
      {
        title = 'Zamów zestaw numer 2',
        description = 'PDW, M4, Karabinek specjalny, Shotgun',
        icon = 'circle',
        onSelect = function()
            zestaw = 2
            ZamowZestaw(zestaw)
        end,
      },
      {
        title = 'Zamów zestaw numer 3',
        description = 'Gaz łzawiący, Smoke, Flashbang, Taser, Latarka, Pałka policyjna',
        icon = 'circle',
        onSelect = function()
            zestaw = 3
            ZamowZestaw(zestaw)
        end,
      },
    }
})

function ZamowZestaw(zestaw)
    local Vehicle = CreateVehicle('speedo', vector3(1000.9417, -1560.6804, 30.7632), 359.5290, true, false)
    local tablica = GetVehicleNumberPlateText(Vehicle)
    blacha = tablica
    if zestaw == 1 then
        TriggerServerEvent('hex_policejob:dodaitembagaj', blacha)
    elseif zestaw == 2 then
        TriggerServerEvent('hex_policejob:dodaitembagaj2', blacha)
    elseif zestaw == 3 then
        TriggerServerEvent('hex_policejob:dodaitembagaj3', blacha)
    end
    TriggerEvent('ox_lib:notify', {
        title = 'Udaj się do zaznaczonej na GPS lokaliacji po samochód',
        description = '',
        type = 'info'
    })
    SetNewWaypoint(1000.9545, -1561.8148)
end