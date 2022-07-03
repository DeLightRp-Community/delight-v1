QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback(Config.FolderName..':server:get:ingredient', function(source, cb, items)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local items = items
    local hasItems = true
    for k, v in pairs(items) do
        if Ply.Functions.GetItemByName(items[k].itemName) ~= nil then
            hasItems = hasItems and (Ply.Functions.GetItemByName(items[k].itemName).amount >= items[k].amount)
        else
            hasItems = hasItems and false 
        end
    end
    cb(hasItems)
end)

RegisterNetEvent(Config.FolderName..":server:cook")
AddEventHandler(Config.FolderName..":server:cook", function(items, giveitem)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    removedItems = {}
    local removed = true
    for k, v in pairs(items) do
        if Player.Functions.RemoveItem(items[k].itemName, items[k].amount) then
            table.insert(removedItems, {item = items[k].itemName, amount = items[k].amount})
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[v.itemName], "remove")
            removed = removed and true
        else
            removed = removed and false
        end
    end

    if removed then
        Player.Functions.AddItem(giveitem, 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[giveitem], "add")
    else
        for k, v in pairs(removedItems) do
            Player.Functions.AddItem(v.item, v.amount)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[v.item], "add")
        end
        TriggerClientEvent('QBCore:Notify', source, "Looks like you dropped some items!", "error")
    end
end)

QBCore.Functions.CreateUseableItem("specialp", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('qb-resturant:client:specialp', source)
        Player.Functions.RemoveItem('specialp', 1)
    end
end)

RegisterNetEvent('qb-resturant:shop:server', function()
    
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "pizza" and Player.PlayerData.job.grade.level >= 1 then
        
        TriggerClientEvent('qb-resturant:shop', src)

    else
        TriggerClientEvent('QBCore:Notify', source, "Looks like you Cant Access this part", "error")
    end
end)


