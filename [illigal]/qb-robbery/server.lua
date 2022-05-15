local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("blue_laptop", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('qb-robbery:useitem', src)
    
end)


QBCore.Functions.CreateUseableItem("thermite", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('qb-robbery:bossdoor', src)
    
end)
