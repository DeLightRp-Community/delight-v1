QBCore = exports['qb-core']:GetCoreObject()

local Blips = {}
RegisterServerEvent("qb-blips:server:updateBlips")
AddEventHandler("qb-blips:server:updateBlips", function()
    local players = QBCore.Functions.GetPlayers()
    Blips = {}
    for k, v in pairs(players) do
        local player = QBCore.Functions.GetPlayer(v)
        local hasradar = player.Functions.GetItemByName('signalradar') ~= nil and true or false
        if hasradar == true then
            local callsign = player.PlayerData.metadata["callsign"] ~= nil and player.PlayerData.metadata["callsign"] or "Police"
            if player.PlayerData.job.name == "police" and player.PlayerData.job.onduty then
                table.insert(Blips, {v, 'police', callsign})
            elseif player.PlayerData.job.name == "ambulance" and player.PlayerData.job.onduty then
                table.insert(Blips, {v, 'ambulance', callsign})
            end
        end
    end
    TriggerClientEvent('qb-blips:client:updateBlips', -1, Blips)
end)

QBCore.Commands.Add("setsign", "Set your callsign (call number)", {{name="name", help="Name of your callsign"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == 'ambulance' then
        Player.Functions.SetMetaData("callsign", table.concat(args, " "))
        --TriggerEvent('qb-policeActives:server:updateOfficers')
    end
end)

CreateThread(function()
    while true do
        TriggerEvent("qb-blips:server:updateBlips")
        Wait(25000)
    end
end)