ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Militia_Joboilone')
AddEventHandler('Militia_Joboilone', function(maxDistance, soundFile, soundVolume)
    TriggerClientEvent('Militia_Joboilone_a', -1, source, maxDistance, soundFile, soundVolume)
end)




RegisterServerEvent(Config.ServerEventname)
AddEventHandler(Config.ServerEventname, function(token)

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(Config.ItemName)
	local xItemCount = math.random(Config.ItemCount[1], Config.ItemCount[2])
	local _source = source
	local xItem2 = xPlayer.getInventoryItem(Config.x2)
	
		if exports.ox_inventory:CanCarryItem(source, Config.ItemName, xItemCount) == false then
			TriggerClientEvent("pNotify:SendNotification", source, {
				text = '<strong class="red-text">'..Config.ItemFull..'</strong>',
				type = "success",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			}) 
		else
			if exports.ox_inventory:GetItem(source, Config.x2, nil, true) > 0 then
				exports.ox_inventory:AddItem(source, Config.ItemName, xItemCount*2, nil, nil,nil)
				local sendToDiscord = 'ผู้เล่น ' ..xPlayer.name..  ' ได้ทำการเก็บ '  ..xItem.name..  ' จำนวน ' ..xItem.count.. ''
                TriggerEvent('azael_discordlogs:sendToDiscord', 'oil_r2', sendToDiscord, source, '^2')
			else
				exports.ox_inventory:AddItem(source, Config.ItemName, xItemCount, nil, nil,nil)
				local sendToDiscord = 'ผู้เล่น ' ..xPlayer.name..  ' ได้ทำการเก็บ '  ..xItem.name..  ' จำนวน ' ..xItem.count.. ''
                TriggerEvent('azael_discordlogs:sendToDiscord', 'oiltwo', sendToDiscord, source, '^2')
			end	
			
		-- Bonus
			if Config.ItemBonus ~= nil then
				for k,v in pairs(Config.ItemBonus) do
					if math.random(1, 100) <= v.Percent then
						exports.ox_inventory:AddItem(source, v.ItemName, v.ItemCount, nil, nil,nil)
					end
				end
			end
		end
end)