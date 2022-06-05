
local successCb
local failCb
local resultReceived = false

RegisterNUICallback('ThermiteResult', function(data, cb)
    -- exports['exo-inventory']:ToggleHotBar(true) Toggle so that inventory doesnt work.. this was something I made on my own server.. 
    SetNuiFocus(false, false)
    resultReceived = true
    if data.success then
        successCb()
    else
        failCb()
    end
    cb('ok')
    -- TriggerEvent('progressbar:client:ToggleBusyness', false) -- To check if another progressbar is running
end)

--[[RegisterCommand('thermite', function(source, args)
    -- Please check the parameters below for exports
    exports["memorygame"]:thermiteminigame(10, 3, 3, 10,
    function() -- success
        TriggerEvent('DoLongHudText', 'good work :)', 1)
    end,
    function() -- failure
        TriggerEvent('DoLongHudText', 'maybe next time :(', 2)
    end)
end)]]

exports('thermiteminigame', function(correctBlocks, incorrectBlocks, timetoShow, timetoLose, success, fail)
    -- correctBlocks = Number of correct blocks the player needs to click
    -- incorrectBlocks = number of incorrect blocks after which the game will fail
    -- timetoShow = time in secs for which the right blocks will be shown
    -- timetoLose = maximum time after timetoshow expires for player to select the right blocks
    resultReceived = false
    successCb = success
    failCb = fail
    -- exports['exo-inventory']:ToggleHotBar(false) Toggle so that inventory doesnt work.. this was something I made on my own server.. 
    SetNuiFocus(true, true)
    if exports['tnj-buffs']:HasBuff("intelligence") then
        SendNUIMessage({
            action = "Start",
            correct = correctBlocks - 3,
            incorrect = incorrectBlocks,
            showtime = timetoShow,
            losetime = timetoLose + timetoShow,
        })
    else
        SendNUIMessage({
            action = "Start",
            correct = correctBlocks,
            incorrect = incorrectBlocks,
            showtime = timetoShow,
            losetime = timetoLose + timetoShow,
        })
    end
end)
RegisterCommand('thermite', function(source, args)
    -- Please check the parameters below for exports
    exports["memorygame"]:thermiteminigame(10, 3, 3, 10,
    function() -- success
        print("success")
    end,
    function() -- failure
        print("failure")
    end)
end)

RegisterCommand('buff', function(source, args)
    -- Please check the parameters below for exports
    exports['tnj-buffs']:AddBuff("intelligence", 150000)
    
end)

