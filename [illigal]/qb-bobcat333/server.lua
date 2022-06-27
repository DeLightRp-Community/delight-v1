local QBCore = exports['qb-core']:GetCoreObject()

local cooldown = false
local looted = false
local looted2 = false
local looted3 = false
local pedSpawned = false

QBCore.Functions.CreateUseableItem('thermite', function(source) 
	TriggerClientEvent('sd-bobcat:startHeist', source) 
end) 

QBCore.Functions.CreateUseableItem('yellow_laptop', function(source)
    print('babat')
	TriggerClientEvent('sd-bobcat:openThirdDoor', source)
end) 

RegisterNetEvent('sd-bobcat:particles', function(method)
	TriggerClientEvent('sd-bobcat:ptfxparticle', -1, method)
end)

RegisterNetEvent('sd-bobcat:particles2', function(method)
	TriggerClientEvent('sd-bobcat:ptfxparticle2', -1, method)
end)

RegisterNetEvent('sd-bobcat:server:lootsync', function()
    TriggerClientEvent('sd-bobcat:client:lootsync', -1)
end)

RegisterNetEvent('sd-bobcat:server:vaultsync', function()
    TriggerClientEvent('sd-bobcat:client:vaultsync', -1)
end)

RegisterServerEvent('sd-bobcat:server:removecard', function()
	local Player = QBCore.Functions.GetPlayer(source)
	local ply = QBCore.Functions.GetPlayer(source)
	local hasCard = Player.Functions.GetItemByName("yellow_laptop")

	local chance = math.random(0,100)

		if Config.RemoveKeycardOnFail then

			if chance < Config.RemoveKeycardOnFailChance then
				if hasCard then

					Player.Functions.RemoveItem("yellow_laptop", 1)
					TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["yellow_laptop"], "remove")
	
				elseif Config.RemoveKeycardOnUse then

			if chance < Config.RemoveKeycardOnUseChance then
			    if hasCard then

					Player.Functions.RemoveItem("yellow_laptop", 1)
					TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["yellow_laptop"], "remove")

				end
			end
		end
	end
end

end)


RegisterServerEvent('sd-bobcat:giveRandomSmgs', function()
	local src = source 
	local Player = QBCore.Functions.GetPlayer(src)
	if not looted then
        looted = true
	for i = 1, math.random(5, 7), 1 do 
		local randomWeapon = Config.Smgs[math.random(1, #Config.Smgs)] --weapon circles
		local amount = math.random(1, 1) --weapon counts
		Player.Functions.AddItem(randomWeapon, amount)
	end
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomWeapon], 'add')
		Citizen.Wait(300)
	end 
end) 

RegisterNetEvent('sd-bobcat:server:smgsync', function()
    TriggerClientEvent('sd-bobcat:client:smgsync', -1)
end)

RegisterServerEvent('sd-bobcat:giveRandomExplosives', function()
	local src = source 
	local Player = QBCore.Functions.GetPlayer(src)
	if not looted2 then
        looted2 = true
	for i = 1, math.random(2, 3), 1 do 
		local randomWeapon = Config.Explosives[math.random(1, #Config.Explosives)] --weapon circles
		local amount = math.random(1, 1) --weapon counts
		Player.Functions.AddItem(randomWeapon, amount)
	end
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomWeapon], 'add')
		Citizen.Wait(300)
	end 
end) 

RegisterNetEvent('sd-bobcat:server:explosivesync', function()
    TriggerClientEvent('sd-bobcat:client:explosivesync', -1)
end)

RegisterServerEvent('sd-bobcat:giveRandomRifles', function()
	local src = source 
	local Player = QBCore.Functions.GetPlayer(src)
	if not looted3 then
        looted3 = true
	for i = 1, math.random(4, 6), 1 do 
		local randomWeapon = Config.Rifles[math.random(1, #Config.Rifles)] --weapon circles
		local amount = math.random(1, 1) --weapon counts
		Player.Functions.AddItem(randomWeapon, amount)
	end
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomWeapon], 'add')
		Citizen.Wait(300)
	end 
end) 

RegisterNetEvent('sd-bobcat:server:riflesync', function()
    TriggerClientEvent('sd-bobcat:client:riflesync', -1)
end)

QBCore.Functions.CreateCallback('sd-bobcat:server:getCops', function(source, cb)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

QBCore.Functions.CreateCallback('sd-bobcat:server:cooldown', function(source, cb)
	if cooldown then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('sd-bobcat:server:startCooldown', function()
	cooldown = true 
	local timer = Config.Cooldown * 60000
	while timer > 0 do 
		Wait(1000)
		timer = timer - 1000
		if timer == 0 then 
			print('cooldown finished')
			TriggerEvent('sd-bobcat:server:resetVault')
			cooldown = false 
		end 
	end
end)

RegisterNetEvent('sd-bobcat:server:resetVault', function()
	looted = false
    looted2 = false
    looted3 = false
	TriggerClientEvent('sd-bobcat:client:resetVault', -1)
end)

RegisterServerEvent("sd-bobcat:server:explodeVaultDoorSync", function() 
	TriggerClientEvent("SD-updateIpls", -1)
end)