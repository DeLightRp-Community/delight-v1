QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('ems:chatMessage', function(data)
    if not QBCore or not QBCore.Functions.GetPlayerData().job or QBCore.Functions.GetPlayerData().job.name ~= 'ambulance' or not QBCore.Functions.GetPlayerData().job.onduty then
        return
    end

    TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message server" style="background-color: rgba(255, 0, 21, 0.75);"><b>EMS Chat - {0}:</b> {1}</div>',
        args = data
    })
end)

RegisterNetEvent('police:chatMessage', function(data)
    if not QBCore or not QBCore.Functions.GetPlayerData().job or QBCore.Functions.GetPlayerData().job.name ~= 'police' or not QBCore.Functions.GetPlayerData().job.onduty then
        return
    end

    TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message server" style="background-color: rgba(52, 67, 235, 0.75);"><b>Police Chat - {0}:</b> {1}</div>',
        args = data
    })
end)