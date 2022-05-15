local MinigameActive = false
local SuccessTrigger = nil
local FailTrigger = nil
--number shoud  -1 number this mean if you put 5 show 6 number
--tyimer should be in second
RegisterCommand('testcode', function()
    StartMinigame({
        success = 'test:success',
        fail = 'test:fail',
        numbers=11,
        timer=5
    })
end)


RegisterNetEvent('test:success')
AddEventHandler('test:success', function()
     print('success')
end)

RegisterNetEvent('test:fail')
AddEventHandler('test:fail', function()
    print('fail')
end)

function StartMinigame(data)
    if MinigameActive then return end
    print('MUSA')
    if data ~= nil then
        SuccessTrigger = data.success
        FailTrigger = data.fail

        SetNuiFocus(true, true)
        SendNUIMessage({action = 'start',timer=data.timer,numbers=data.numbers})
        MinigameActive = true
    end
end

exports('StartMinigame', StartMinigame)

RegisterNUICallback('success', function(data, cb)
    SetNuiFocus(false, false)
    MinigameActive = false
    TriggerEvent(SuccessTrigger)

    SuccessTrigger = nil
    FailTrigger = nil
    cb('ok')
end)

RegisterNUICallback('fail', function(data, cb)
    SetNuiFocus(false, false)
    MinigameActive = false
    TriggerEvent(FailTrigger)
    SuccessTrigger = nil
    FailTrigger = nil
    cb('ok')
end)