local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "atous" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

--duty
RegisterNetEvent('qb-ottos:ToggleDuty', function()
    onDuty = not onDuty
    TriggerServerEvent("QBCore:ToggleDuty")
end)

--stash

RegisterNetEvent('qb-ottos:stash', function()
    TriggerEvent("inventory:client:SetCurrentStash", "atousstash")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "atousstash", {
        maxweight = 2000000,
        slots = 350,
    })
end)

--target

CreateThread(function()
    exports['qb-target']:AddBoxZone("atousstash", vector3(836.96, -808.26, 26.33), 1.5, 0.5, {
        name = "atousstash",
        heading=0,
        --debugPoly=true,
        minZ=23.33,
        maxZ=27.33,
    }, {
        options = {
            {
                event = "qb-ottos:stash",
                icon = "fas fa-box",
                label = "Stash",
                job = "atous",
            },
        },
        distance = 2.5
    })
    exports['qb-target']:AddBoxZone("atous-duty", vector3(834.26, -823.81, 26.33), 0.5, 0.5, {
        name="atous-duty",
        heading=0,
        --debugPoly=true,
        minZ=22.73,
        maxZ=26.73
    }, {
        options = {
            {
                event = "qb-ottos:ToggleDuty",
                icon = "far fa-clipboard",
                label = "Toggle Duty",
                job = "atous",
            },
        },
        distance = 2.5
    })
end)


