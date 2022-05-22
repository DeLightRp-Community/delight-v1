local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-fish:checkitem', function(source)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local fish = xPlayer.Functions.GetItemByName('fishingmackerel')
    local knife = xPlayer.Functions.GetItemByName('weapon_knife')

    if fish ~= nil and knife ~= nil then
        TriggerClientEvent("qb-fishing:skin", src)
    end
end)

RegisterServerEvent('fish:checkAndTakeDepo')
AddEventHandler('fish:checkAndTakeDepo', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveMoney("bank", 500)
end)

RegisterNetEvent('fish:returnDepo', function(data)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.AddMoney('cash', 500)
end)
