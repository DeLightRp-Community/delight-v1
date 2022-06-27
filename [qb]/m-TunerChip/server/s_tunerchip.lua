local QBCore = exports['qb-core']:GetCoreObject()

local tunedVehicles = {}

RegisterNetEvent('m-TunerChip:server:TuneStatus', function(plate, bool)
    if bool then
        tunedVehicles[plate] = bool
    else
        tunedVehicles[plate] = nil
    end
end)

QBCore.Functions.CreateCallback('m-TunerChip:server:HasChip', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local Chip = Ply.Functions.GetItemByName("tunerlaptop")

    if Chip ~= nil then
        cb(true)
    else
        DropPlayer(src, 'What are you doing?')
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('m-TunerChip:server:GetStatus', function(source, cb, plate)
    cb(tunedVehicles[plate])
end)

--========================================================== Tunerchip
QBCore.Functions.CreateUseableItem("tunerlaptop", function(source, item)
    TriggerClientEvent('m-TunerChip:client:openChip', source)
end)
