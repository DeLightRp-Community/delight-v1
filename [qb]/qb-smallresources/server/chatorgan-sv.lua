QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('mchat', 'EMS Chat', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player and (Player.PlayerData.job.name == 'ambulance' and Player.PlayerData.job.onduty) then
        TriggerClientEvent('ems:chatMessage', -1, {(Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname), table.concat(args, " ")})
    else
        TriggerClientEvent('chat:addMessage', src, {
            template = '<div class="chat-message server">SYSTEM: {0}</div>',
            args = { 'This command is for emergency services!' }
        })
    end
    
end)

QBCore.Commands.Add('pchat', 'Officers Chat', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local hasphone = Player.Functions.GetItemByName('phone') ~= nil and true or false
    
    if not Player.PlayerData.metadata["ishandcuffed"] and not Player.PlayerData.metadata["isdead"] then
        if hasphone == true then
            if Player and (Player.PlayerData.job.name == 'police' and Player.PlayerData.job.onduty) then
                TriggerClientEvent('police:chatMessage', -1, {(Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata.callsign .. ')'), table.concat(args, " ")})
            else
                TriggerClientEvent('chat:addMessage', src, {
                    template = '<div class="chat-message server">SYSTEM: {0}</div>',
                    args = { 'This command is for emergency services!' }
                })
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have a phone!", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You cant do it while you're dead/cuffed!", 'error')
    end
end)