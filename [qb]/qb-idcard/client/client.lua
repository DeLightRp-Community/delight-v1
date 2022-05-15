local openid = false
local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('qb-idcard:client:open', function(info,nui)
    if not openid then
        SetNuiFocusKeepInput(true)
        SetNuiFocus(true,false)
        SendNUIMessage({nui = nui,information = info})
        openid = true
    end
end)


local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())
    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end
	return closestPlayer, closestDistance
end

RegisterNetEvent('qb-idcard:client:policebadgeanim', function()
    local ped = PlayerPedId()
    local propname = "prop_fib_badge"
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(GetHashKey(propname), x, y, z + 0.2, true, true, true)
    local boneIndex = GetPedBoneIndex(ped, 28422)
    loadAnimDict("paper_1_rcm_alt1-9")
    AttachEntityToEntity(prop, ped, boneIndex, 0.12, 0.01, -0.06, -310.0, 10.0, 150.0, true, true, false, true, 1, true)
    TaskPlayAnim(ped, "paper_1_rcm_alt1-9", "player_one_dual-9", 3.0, -1, -1, 50, 0, false, false, false)
    Wait(3200)
    DeleteEntity(prop)
    ClearPedTasks(ped)
end)


RegisterNetEvent('qb-idcard:client:showbusinessCard', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local PlayerId = GetPlayerServerId(player)
        TriggerServerEvent('qb-idcard:server:showbusinesscard', PlayerId)
    else
        QBCore.Functions.Notify("No one nearby!", "error")
    end
end)

RegisterNUICallback("escape", function()
    SetNuiFocus(false)
    openid = false
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end