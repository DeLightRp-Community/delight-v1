local QBCore = exports['qb-core']:GetCoreObject()

local Enabled = false


-- Refresh Menu --
CreateThread(function()
    while true do
        Wait(3000)
        TriggerServerEvent("nv:medic:refresh")
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(jobInfo)
    if Enabled then
        xPlayer = QBCore.Functions.GetPlayerData()
        if xPlayer.job.name ~= "ambulance" then
            SendNUIMessage({ ['action'] = "close" })
        end
    end
    
    TriggerServerEvent("nv:medic:refresh")
end)

RegisterNetEvent("nv:medic:open")
AddEventHandler("nv:medic:open", function(type)
    if type == 'toggle' then
        if Enabled then
            Enabled = false
            SendNUIMessage({ ['action'] = 'close' })
            print("close")
        else
            Enabled = true
            SendNUIMessage({ ['action'] = 'open' })
            print("open")
        end
    elseif type == 'drag' then
        SetNuiFocus(true, true)
        SendNUIMessage({ ['action'] = 'drag' })
    end
end)

RegisterNUICallback("CloseActives", function()
    print("Hellodadash")
    SetNuiFocus(false, false)
end)

RegisterNetEvent("nv:medic:refresh")
AddEventHandler("nv:medic:refresh", function(data)
    SendNUIMessage({ ['action'] = 'refresh', ['data'] = data })
end)

