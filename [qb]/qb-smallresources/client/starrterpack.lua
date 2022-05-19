RegisterNetEvent('qb-smallrecources:starterpack', function(data)
    QBCore.Functions.Progressbar("search_pack", "Searching The Gift Box ...", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "veh@break_in@0h@p_m_one@",
            anim = "low_force_entry_ds",
            flags = 16,
        }, {}, {}, function() -- Done
            
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("qb-smallrecources:rewardpack")
            
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
            QBCore.Functions.Notify("Process canceled..", "error")
        end)
end)