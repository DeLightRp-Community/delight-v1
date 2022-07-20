local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('mt-karting:server:checkTicket', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.GetItemByName('race_ticket') then
        Player.Functions.RemoveItem('race_ticket', 1)
        TriggerClientEvent("mt-karting:client:hasTicket",src)
    end
end)