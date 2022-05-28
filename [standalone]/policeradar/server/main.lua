local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("radar", "Toggle speed radar :)", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "sheriff" and Player.PlayerData.job.onduty) then
        TriggerClientEvent("wk:toggleRadar", source)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "This command is for emergency services!")
    end
end)