local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('qb-digitalden:HackTry', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local ticket = Player.Functions.GetItemByName('ticket')
    
    if ticket ~= nil or Player.job.name == "digitalden" then
        local minigame = exports["minigame-fleeca"]:HackingFleeca(50000,1)
        if minigame then
            TriggerClientEvent('QBCore:Notify', source, 'Good job!', 'success')
            Player.Functions.RemoveItem("ticket", 1)
        else
            TriggerClientEvent('QBCore:Notify', source, 'Try Again ', 'error')
            Player.Functions.RemoveItem("ticket", 1)
        end

    else
        TriggerClientEvent('QBCore:Notify', source, 'No Access Get Ticket', 'error')
    end
    
end)