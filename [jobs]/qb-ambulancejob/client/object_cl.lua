local QBCore = exports["qb-core"]:GetCoreObject()
local ObjectList = {}

RegisterNetEvent('qb-ambulance:client:spawnTent', function()
    QBCore.Functions.Progressbar("spawn_object", "Spawn Object", 2500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("qb-ambulance:server:spawnObject", "tent")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        QBCore.Functions.Notify("Cancel...", "error")
    end)
end)

RegisterNetEvent('qb-ambulance:client:spawnObject', function(objectId, type, player)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
    local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 0.5)
    local spawnedObj = CreateObject(Config.Objects[type].model, x, y, z, true, false, false)
    PlaceObjectOnGroundProperly(spawnedObj)
    SetEntityHeading(spawnedObj, heading)
    FreezeEntityPosition(spawnedObj, Config.Objects[type].freeze)
    ObjectList[objectId] = {
        id = objectId,
        object = spawnedObj,
        coords = vector3(x, y, z - 0.3),
    }
end)

function Removetent()
    local player = PlayerId()
    local plyPed = GetPlayerPed(player)
    local plyPos = GetEntityCoords(plyPed, false)
    local propdelsp = GetClosestObjectOfType(plyPos.x, plyPos.y, plyPos.z - 2.0, 200.0, GetHashKey("prop_gazebo_03"), false, 0, 0)
    TriggerServerEvent("qb-ambulance:server:removebattent")
    if propdelsp ~= 0 then
        SetEntityAsMissionEntity(propdelsp, true, true)
        DeleteObject(propdelsp)
        SetEntityAsNoLongerNeeded(propdelsp)
    end
end

RegisterNetEvent("qb-ambulance:client:removetent", function()
    Removetent()
end)

CreateThread(function()
    exports["qb-target"]:AddTargetModel(1186722212, {
        options = {
            {
                type = "client",
                event = "qb-ambulance:client:removetent",
                icon = "fa fa-circle",
                label = "Remove Spike",
                job = "ambulance",
            },
        },
    distance = 2.0
    })
end)

RegisterCommand('rprop', function(source)
    local player = PlayerId()
    local plyPed = GetPlayerPed(player)
    local plyPos = GetEntityCoords(plyPed, false)
    local propdelsp = GetClosestObjectOfType(plyPos.x, plyPos.y, plyPos.z - 2.0, 200.0, GetHashKey("prop_tool_pickaxe"), false, 0, 0)
    if propdelsp ~= 0 then
        SetEntityAsMissionEntity(propdelsp, true, true)
        DeleteObject(propdelsp)
        SetEntityAsNoLongerNeeded(propdelsp)
    end
end)