local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent('qb-dumpsterstorage:open', function()
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    for i = 1, #Config.dumpsters do
        local Dumpster = GetClosestObjectOfType(PlayerCoords, 2.2, Config.dumpsters[i], false, false, false)
        if Dumpster then
            local DumpsterCoords = GetEntityCoords(Dumpster)
            if #(PlayerCoords - DumpsterCoords) < 2 then
                if DumpsterCoords.x < 0 then DumpsterX = -DumpsterCoords.x else DumpsterX = DumpsterCoords.x end
                if DumpsterCoords.y < 0 then DumpsterY = -DumpsterCoords.y else DumpsterY = DumpsterCoords.y end
                DumpsterX = round(DumpsterX, 2)
                DumpsterY = round(DumpsterY, 2)
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "Dumpster | "..DumpsterX.." | "..DumpsterY, {
                    maxweight = Config.weight,
                    slots = Config.slots,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "Dumpster | "..DumpsterX.." | "..DumpsterY)                        
            end
        end
    end
end)


CreateThread(function()
    local objects = {
        -1096777189,
        666561306,
        1437508529,
        -1426008804,
        -228596739,
        161465839,
        651101403,
        -58485588,
        218085040,
        -206690185,
        811169045,
        1329570871,
        1614656839,
    }
    exports['qb-target']:AddTargetModel(objects, {
        options = {
            {
                type = "client",
                event = "qb-dumpsterstorage:open",
                icon = "fas fa-dumpster",
                label = "Open Dumpester",
            },
        },
        distance = 2.5,
    })
end)
