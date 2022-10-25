local ESX = nil


TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)


RegisterServerEvent("annakin:removeauto")
AddEventHandler("annakin:removeauto", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(Config.item, 1)
end)
ESX.RegisterUsableItem(Config.item, function(source)	
	TriggerClientEvent("annakin:autofarm",source)
end)