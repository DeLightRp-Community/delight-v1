local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-bobcat:server:getCops', function(source, cb)
	local cops = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                cops = cops + 1
            end
        end
	end
	cb(cops)
end)

RegisterServerEvent("qb-particleserver")
AddEventHandler("qb-particleserver", function(method)
    TriggerClientEvent("qb-ptfxparticle", -1, method)
end)

RegisterServerEvent("qb-particleserversec")
AddEventHandler("qb-particleserversec", function(method)
    TriggerClientEvent("qb-ptfxparticlesec", -1, method)
end)


QBCore.Functions.CreateUseableItem("yellow_laptop", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent("qb-bobcatthirddoor", source)
		TriggerClientEvent('QBCore:Notify', source, "Door Unlocked.", "success")
end)

QBCore.Functions.CreateUseableItem("thermitec", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('lighter') ~= nil then
        TriggerClientEvent("qb-minigamedoor2", source)
    else
        TriggerClientEvent('QBCore:Notify', source, "You are missing something to light the thermite..", "error")
    end
end)

QBCore.Functions.CreateUseableItem("thermite", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('lighter') ~= nil then
        TriggerClientEvent("qb-firstdoor", source)
        TriggerClientEvent("qb-seconddoor", source)
        
    else
        TriggerClientEvent('QBCore:Notify', source, "You are missing something to light the thermite..", "error")
    end
end)


local ItemTable = {
    "weapon_combatpistol",
    "weapon_assaultrifle_mk2",
    "weapon_smg",
    "weapon_heavypistol",
    "weapon_carbinerifle",
    "weapon_machinepistol",
    "weapon_pistol_mk2",
}

RegisterServerEvent("qb-bobcat:server:loot")
AddEventHandler("qb-bobcat:server:loot", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for i = 1, math.random(1, 8), 1 do
        local randItem = ItemTable[math.random(1, #ItemTable)]
        Player.Functions.AddItem(randItem, 1)
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add')
        Citizen.Wait(500)
    end
end)	