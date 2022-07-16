local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-lapdance:buy')
AddEventHandler('qb-lapdance:buy', function()

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        Cost = 2000
        PlayerMoney = Player.PlayerData.money["cash"]

        if PlayerMoney >= Cost then
            if Player then
                Player.Functions.RemoveMoney("cash", Cost)
                TriggerClientEvent("qb-nightclub:bitch")
            else
                TriggerClientEvent('QBCore:Notify', src, "not enough money", "error", 1700)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "not enough money", "error", 1700)
        end


   
end)