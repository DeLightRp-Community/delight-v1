local QBCore = exports["qb-core"]:GetCoreObject()

QBCore.Functions.CreateUseableItem("spikestrip", function(src)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.PlayerData.job.name == 'police' then
        xPlayer.Functions.RemoveItem("spikestrip", 1)
        TriggerClientEvent("loaf_spikestrips:placeSpikestrip", src)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["spikestrip"], "remove")
    end
end)

RegisterNetEvent("loaf_spikestrips:removedSpike", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        xPlayer.Functions.AddItem("spikestrip", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["spikestrip"], "add")
    end
end)  