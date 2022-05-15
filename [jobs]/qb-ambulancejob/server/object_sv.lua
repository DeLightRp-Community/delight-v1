local QBCore = exports["qb-core"]:GetCoreObject()
local Objects = {}

local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

RegisterNetEvent('qb-ambulance:server:spawnObject', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("qb-ambulance:client:spawnObject", src, objectId, type, src)
end)

RegisterNetEvent("qb-ambulance:server:removebattent", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        xPlayer.Functions.AddItem("tent", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["tent"], "add")
    end
end)  

QBCore.Functions.CreateUseableItem("tent", function(src)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.PlayerData.job.name == 'ambulance' then
        xPlayer.Functions.RemoveItem("tent", 1)
        TriggerClientEvent("qb-ambulance:client:spawnTent", src)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["tent"], "remove")
    end
end)