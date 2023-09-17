Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1000)
      if ped == nil then
        TriggerEvent('hex_policejob:ped')
        TriggerEvent('hex_policejob:blip')
        ped = 1
      end
    end
end)

RegisterNetEvent('hex_policejob:ped')
AddEventHandler('hex_policejob:ped',function()
  local hash = GetHashKey('S_M_Y_Cop_01')
  local coords = vector4(441.0464, -978.8522, 29.6996, 182.8968)
  if not HasModelLoaded(hash) then
    
    RequestModel(hash)
    Wait(10)
  end
  while not HasModelLoaded(hash) do
    Wait(10)
  end
  local pedh = CreatePed(5, hash, coords, false, false)
  FreezeEntityPosition(pedh, true)
  SetEntityInvincible(pedh, true)
  SetBlockingOfNonTemporaryEvents(pedh, true)
  TaskStartScenarioInPlace(pedh, "WORLD_HUMAN_CLIPBOARD", 0, false)
  SetModelAsNoLongerNeeded(hash)

  exports.qtarget:AddTargetEntity(pedh, {
	options = {
		{
			icon = "fas fa-box-circle-check",
			label = "Sprawdź ilość policjantów",
			action = function()  TriggerServerEvent('hex_policejob:lspd') end
		},
	},
	distance = 2
})
end)