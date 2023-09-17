dragStatus = {}

lib.registerContext({
    id = 'police_obiekty',
    title = 'Co chcesz zrobić?',
    options = {
        {
            title = 'Kolczatki',
          icon = 'road-spikes',
          onSelect = function()
            SpawnKolczatka()
          end,
        },
        {
            title = 'Barierki',
          icon = 'road-barrier',
          onSelect = function()
            SpawnBarierka()
          end,
        },
        {
            title = 'Pachołki',
          icon = 'caret-up',
          onSelect = function()
            SpawnPacholek()
          end,
        },
      }
})

lib.addRadialItem({
    {
      id = 'police',
      label = 'Policja',
      icon = 'handcuffs',
      onSelect = function()
        if ESX.PlayerData.job.name == 'police' then
            lib.showContext('police_obiekty')
        end
      end,
    },
})

function SpawnKolczatka()
    local pozycja = GetEntityCoords(PlayerPedId())
    local obiekt = 'p_ld_stinger_s'
    ESX.Game.SpawnObject('p_ld_stinger_s', pozycja, function(object)
        TriggerServerEvent('hex_policejob:obiektlog', obiekt, pozycja)
        exports.qtarget:AddTargetEntity(object, {
            options = {
                {
                    icon = "trash",
                    label = "Usuń obiekt",
                    action = function() TriggerEvent('hex_policejob:usunobiekt', object) end
                },
            },
            distance = 2
        })
    end)
end

function SpawnPacholek()
    local pozycja = GetEntityCoords(PlayerPedId())
    local obiekt = 'prop_mp_cone_01'
    ESX.Game.SpawnObject('prop_mp_cone_01', pozycja, function(object)
        TriggerServerEvent('hex_policejob:obiektlog', obiekt, pozycja)
        exports.qtarget:AddTargetEntity(object, {
            options = {
                {
                    icon = "trash",
                    label = "Usuń obiekt",
                    action = function() TriggerEvent('hex_policejob:usunobiekt', object) end
                },
            },
            distance = 2
        })
    end)
end

function SpawnBarierka()
    local pozycja = GetEntityCoords(PlayerPedId())
    local obiekt = 'prop_barrier_work05'
    ESX.Game.SpawnObject(obiekt, pozycja, function(object)
        TriggerServerEvent('hex_policejob:obiektlog', obiekt, pozycja)
        exports.qtarget:AddTargetEntity(object, {
            options = {
                {
                    icon = "fa-thin fa-trash",
                    label = "Usuń obiekt",
                    action = function() TriggerEvent('hex_policejob:usunobiekt', object) end
                },
            },
            distance = 2
        })
    end)
end

function Zakuj()
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 or closestPlayerDistance < 3.0 then
        TriggerServerEvent('hex_policejob:zakuj', GetPlayerServerId(closestPlayer))
    end
end

function Drag()
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 or closestPlayerDistance < 3.0 then
        TriggerServerEvent('hex_policejob:przenies', GetPlayerServerId(closestPlayer))
    end
end

function DoAuta()
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 or closestPlayerDistance < 3.0 then
        TriggerServerEvent('hex_policejob:doauta', GetPlayerServerId(closestPlayer))
    end
end

function ZAuta()
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 or closestPlayerDistance < 3.0 then
        TriggerServerEvent('hex_policejob:zauta', GetPlayerServerId(closestPlayer))
    end
end

function Przeszukaj()
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 or closestPlayerDistance < 3.0 then
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", GetPlayerServerId(closestPlayer))
    end
end

RegisterNetEvent('hex_policejob:usunobiekt', function(obiekt)
    ESX.Game.DeleteObject(obiekt)
end)

RegisterNetEvent('hex_policejob:zakuj')
AddEventHandler('hex_policejob:zakuj', function()
	zakuty = not zakuty
	local playerPed = PlayerPedId()
	if zakuty then
        if exports["k5_skillcheck"]:skillCheck("easy") then
            Citizen.Wait(1000)
                if exports["k5_skillcheck"]:skillCheck("normal")  then
                Citizen.Wait(1000)
                if exports["k5_skillcheck"]:skillCheck("normal") then
                    zakuty = false
		            ClearPedSecondaryTask(playerPed)
		            SetEnableHandcuffs(playerPed, false)
		            DisablePlayerFiring(playerPed, false)
		            SetPedCanPlayGestureAnims(playerPed, true)
		            DisplayRadar(true)
                else
                    RequestAnimDict('mp_arresting')
                    while not HasAnimDictLoaded('mp_arresting') do
                        Wait(100)
                    end
                    TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
                    RemoveAnimDict('mp_arresting')
                    SetEnableHandcuffs(playerPed, true)
                    DisablePlayerFiring(playerPed, true)
                    SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
                    SetPedCanPlayGestureAnims(playerPed, false)
                    DisplayRadar(false)
                end
            else
                RequestAnimDict('mp_arresting')
                while not HasAnimDictLoaded('mp_arresting') do
                    Wait(100)
                end
                TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
                RemoveAnimDict('mp_arresting')
                SetEnableHandcuffs(playerPed, true)
                DisablePlayerFiring(playerPed, true)
                SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
                SetPedCanPlayGestureAnims(playerPed, false)
                DisplayRadar(false)
            end
        else
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Wait(100)
            end
            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            RemoveAnimDict('mp_arresting')
            SetEnableHandcuffs(playerPed, true)
            DisablePlayerFiring(playerPed, true)
            SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
            SetPedCanPlayGestureAnims(playerPed, false)
            DisplayRadar(false)
        end
		--[[RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Wait(100)
		end
		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
		RemoveAnimDict('mp_arresting')
		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
		SetPedCanPlayGestureAnims(playerPed, false)
		DisplayRadar(false)]]
	else
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		DisplayRadar(true)
	end
end)

RegisterNetEvent('hex_policejob:odkuj')
AddEventHandler('hex_policejob:odkuj', function()
	if zakuty then
		local playerPed = PlayerPedId()
		zakuty = false
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		DisplayRadar(true)
	end
end)

RegisterNetEvent('hex_policejob:przenies')
AddEventHandler('hex_policejob:przenies', function(copId)
	if zakuty then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

CreateThread(function()
	local wasDragged
	while true do
		local Sleep = 1500

		if zakuty and dragStatus.isDragged then
			Sleep = 50
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(ESX.PlayerData.ped, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Wait(1000)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(ESX.PlayerData.ped, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(ESX.PlayerData.ped, true, false)
		end
	Wait(Sleep)
	end
end)

RegisterNetEvent('hex_policejob:doauta')
AddEventHandler('hex_policejob:doauta', function()
	if zakuty then
		local pedGracza = PlayerPedId()
		local auto, dystans = ESX.Game.GetClosestVehicle()

		if auto and dystans < 5 then
			local maxsiedzen, wolnesiedzenie = GetVehicleMaxNumberOfPassengers(auto)

			for i=maxsiedzen - 1, 0, -1 do
				if IsVehicleSeatFree(auto, i) then
					wolnesiedzenie = i
					break
				end
			end

			if wolnesiedzenie then
				TaskWarpPedIntoVehicle(pedGracza, auto, wolnesiedzenie)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('hex_policejob:zauta')
AddEventHandler('hex_policejob:zauta', function()
	local GetVehiclePedIsIn = GetVehiclePedIsIn
	local IsPedSittingInAnyVehicle = IsPedSittingInAnyVehicle
	local TaskLeaveVehicle = TaskLeaveVehicle
	if IsPedSittingInAnyVehicle(ESX.PlayerData.ped) then
		local auto = GetVehiclePedIsIn(ESX.PlayerData.ped, false)
		TaskLeaveVehicle(ESX.PlayerData.ped, auto, 64)
	end
end)

CreateThread(function()
	local DisableControlAction = DisableControlAction
	local IsEntityPlayingAnim = IsEntityPlayingAnim
	while true do
		local Sleep = 1000

		if zakuty then
			Sleep = 0
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(ESX.PlayerData.ped, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(ESX.PlayerData.ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
					RemoveAnimDict('mp_arresting')
				end)
			end
		end
	Wait(Sleep)
	end
end)

exports.ox_target:addGlobalPlayer({
    --[[{   
        num = 1,
        name = 'zakuj',
        onSelect = function(data) Zakuj() end,
        icon = 'fa-solid fa-people-robbery',
        label = 'Zakuj',
        distance = 2,   
        canInteract = function(entity)
        return ESX.PlayerData.job.name == 'police'
        end  
    },]]
    {   
        num = 2,
        name = 'przeszukaj',
        onSelect = function(data) Przeszukaj(data) end,
        icon = 'fa-solid fa-people-robbery',
        label = 'Przeszukaj',
        distance = 2,   
        canInteract = function(entity)
        return (IsPedCuffed(entity) or (IsPedDeadOrDying(entity, true))) and (not IsPedCuffed(PlayerPedId()))
        end  
    },
    {   
        num = 3,
        name = 'przenies',
        onSelect = function(data) Drag(data) end,
        icon = 'fa-solid fa-person-walking',
        label = 'Przenieś',
        distance = 2,   
        canInteract = function(entity)
        return (IsPedCuffed(entity) or (IsPedDeadOrDying(entity, true))) and (not IsPedCuffed(PlayerPedId()))
        end  
    },
    {   
        num = 4,
        name = 'wsadzdoauta',
        onSelect = function(data) DoAuta(data) end,
        icon = 'fa-solid fa-people-pulling',
        label = 'Wsadź do auta',
        distance = 2,   
        canInteract = function(entity)
        return (IsPedCuffed(entity) or (IsPedDeadOrDying(entity, true))) and (not IsPedCuffed(PlayerPedId()))
        end  
    },

})

exports.ox_target:addGlobalVehicle({
	{
		onSelect = function(data) ZAuta(data) end,
		icon = 'fa-solid fa-people-pulling',
		label = 'Wyciągnij z Pojazdu',
		num = 1,
        groups = {'police','sheriff'}, 

	},
})

RegisterNetEvent('hex_policejob:unprzenies', function()
    Drag()
end)

RegisterNetEvent('hex_policejob:zakujcl', function()
    Zakuj()
end)