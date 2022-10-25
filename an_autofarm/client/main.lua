
local ESX = nil
local obj = nil
local farmauto = false
local value = false
local closestobj = Config.PropJob

RegisterNetEvent("annakin:autofarm")
AddEventHandler("annakin:autofarm", function()
	if Config.removeitem then
		TriggerServerEvent("annakin:removeauto")
	end
	if not farmauto then
		farmauto = true
		exports['okokNotify']:Alert("AUTOFARM", "เปิดใช้งานออโต้ฟาร์ม", 3000, 'success') 		
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(1000)
				local playerPed = PlayerPedId()
				local playerCoords = GetEntityCoords(playerPed)       
					for i = 1, #closestobj do
						local ssss = GetClosestObjectOfType(playerCoords, 50.0, closestobj[i], false, false, false)
					if DoesEntityExist(ssss) then
						local entity = ssss		
						obj  = GetEntityCoords(entity)
					end		
				end
			end
		end)
	else
		farmauto = false
		ClearPedTasksImmediately(PlayerPedId())
		exports['okokNotify']:Alert("AUTOFARM", "ยกเลิกการใช้งานออโต้ฟาร์ม", 3000, 'error')
	end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(2000)

   		 if obj ~= nil and farmauto then		
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			TaskGoToCoordAnyMeans(playerPed,obj.x,obj.y,obj.z,5.0, 0, 0, 0, -50)	
			if  GetEntityHealth(PlayerPedId()) <= 0 then
				farmauto = false
				exports['okokNotify']:Alert("AUTOFARM", "ยกเลิกการใช้งานออโต้ฟาร์ม", 3000, 'error')
			end	   
		end
	end
end)
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1)
		if farmauto then
			if IsControlJustReleased(0, 73) then
				farmauto = false	
				exports['okokNotify']:Alert("AUTOFARM", "ยกเลิกการใช้งานออโต้ฟาร์ม", 3000, 'error')
			end
		else
			Citizen.Wait(1000)
		end
	end
end)