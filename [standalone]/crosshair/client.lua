local crossEnabled = false
local crossDisabled = false

RegisterCommand("crosshair", function()
    crossDisabled = not crossDisabled
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1200)
        local ped = PlayerPedId()

        if not crossDisabled and not crossEnabled and IsPedArmed(ped, 7) then
            crossEnabled = true
            SendNUIMessage("Show")
        elseif not IsPedArmed(PlayerPedId(), 7) or crossDisabled then
            crossEnabled = false
            SendNUIMessage("shit")
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        if IsPedArmed(ped, 7) then
            HideHudComponentThisFrame(14)
        end
        
    end
end)