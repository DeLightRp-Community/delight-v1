QBCore = exports['qb-core']:GetCoreObject()
local Blips = {}
RegisterNetEvent('qb-blips:client:updateBlips', function(data)
    if not QBCore or not QBCore.Functions.GetPlayerData().job then
        return
    end
    
    for _, blip in pairs(Blips) do
        RemoveBlip(blip)
    end

    Blips = {}

    local job = QBCore.Functions.GetPlayerData().job.name
    if job ~= 'police' and job ~= 'ambulance' then
        return
    end

    for _, player in pairs(data) do
        local ped = GetPlayerPed(GetPlayerFromServerId(player[1]))

        blip = AddBlipForEntity(ped)
        SetBlipSprite(blip, 1)
        SetBlipScale(blip, 0.8)
        if player[2] == 'police' then
            SetBlipColour(blip, 3)
            SetBlipShowCone(blip, true)
        else
            SetBlipColour(blip, 59)
        end
        SetBlipAsShortRange(blip, true)
        SetBlipDisplay(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(player[3])
        EndTextCommandSetBlipName(blip)

        table.insert(Blips, blip)
    end
end)