RegisterCommand("ui-r", function()
    exports['qb-core']:DrawText('Clearing UI .', 'left')
    Wait(1000)
    exports['qb-core']:DrawText('Clearing UI ..', 'left')
    Wait(1000)
    exports['qb-core']:DrawText('Clearing UI ...', 'left')
    Wait(1000)
    print("111111111")
    --SetNuiFocus(false, false)
    --SetUIFocus(false, false)
    print("222222222222")
    exports['qb-core']:DrawText('UI Cleared !', 'left')
    Wait(1000)
    print("333333333333")
    exports['qb-core']:HideText()
    exports['qb-core']:HideText("success")
    SetNuiFocus(false, false)
    SetUIFocus(false, false)
end)


RegisterCommand("anim-r", function()
    exports['qb-core']:DrawText('Stopping Animation .', 'left')
    Wait(1000)
    exports['qb-core']:DrawText('Stopping Animation ..', 'left')
    Wait(1000)
    exports['qb-core']:DrawText('Stopping Animation ...', 'left')
    Wait(1000)
    ClearPedTasks(GetPlayerPed(-1))
    ClearPedTasks(PlayerPedId())
    exports['qb-core']:DrawText('Animation Cleared !', 'left')
    Wait(1000)
    exports['qb-core']:HideText()
    exports['qb-core']:HideText("anim")
    
end)
