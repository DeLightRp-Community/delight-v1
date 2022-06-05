local noClipEnabled = false
local ent
local Invisible = nil
local noClipCam = nil

local speed = 1.0
local maxSpeed = 32.0
local minY, maxY = -150.0, 160.0

local inputRotEnabled = false

function toggleNoclip()
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        local inVehicle = false

        if veh ~= 0 then
            inVehicle = true
            ent = veh
        else
            ent = ped
        end

        local pos = GetEntityCoords(ent)
        local rot = GetEntityRotation(ent)

        noClipCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos, 0.0, 0.0, rot.z, 75.0, true, 2)
        AttachCamToEntity(noClipCam, ent, 0.0, 0.0, 0.0, true)
        RenderScriptCams(true, false, 3000, true, false)

        FreezeEntityPosition(ent, true)
        SetEntityCollision(ent, false, false)
        SetEntityAlpha(ent, 0)
        SetPedCanRagdoll(ped, false)
        SetEntityVisible(ent, false)
        if not inVehicle then
        ClearPedTasksImmediately(ped)
        end

        if inVehicle then
        FreezeEntityPosition(ped, true)
        SetEntityCollision(ped, false, false)
        SetEntityAlpha(ped, 0)
        SetEntityVisible(ped, false)
        end
        while noClipEnabled do
        Wait(0)
        local _, fv, _, _ = GetCamMatrix(noClipCam)

        if IsDisabledControlPressed(2, 17) then -- MWheelUp
            speed = math.min(speed + 0.1, maxSpeed)
        elseif IsDisabledControlPressed(2, 16) then -- MWheelDown
            speed = math.max(0.1, speed - 0.1)
        end

        local multiplier = 1.0;

        if IsDisabledControlPressed(2, 209) then
            multiplier = 2.0
        elseif IsDisabledControlPressed(2, 19) then
            multiplier = 4.0
        elseif IsDisabledControlPressed(2, 36) then
            multiplier = 0.25
        end

        -- Forward and Backward
        if IsDisabledControlPressed(2, 32) then -- W
            local setpos = GetEntityCoords(ent) + fv * (speed * multiplier)
            SetEntityCoordsNoOffset(ent, setpos)
            if not inVehicle then
            SetEntityCoordsNoOffset(ped, setpos)
            end
        elseif IsDisabledControlPressed(2, 33) then -- S
            local setpos = GetEntityCoords(ent) - fv * (speed * multiplier)
            SetEntityCoordsNoOffset(ent, setpos)
            if not inVehicle then
            SetEntityCoordsNoOffset(ped, setpos)
            end
        end

        -- Left and Right
        if IsDisabledControlPressed(2, 34) then -- A
            local setpos = GetOffsetFromEntityInWorldCoords(ent, -speed * multiplier, 0.0, 0.0)
            SetEntityCoordsNoOffset(ent, setpos.x, setpos.y, GetEntityCoords(ent).z)
            if not inVehicle then
            SetEntityCoordsNoOffset(ped, setpos.x, setpos.y, GetEntityCoords(ent).z)
            end
        elseif IsDisabledControlPressed(2, 35) then -- D
            local setpos = GetOffsetFromEntityInWorldCoords(ent, speed * multiplier, 0.0, 0.0)
            SetEntityCoordsNoOffset(ent, setpos.x, setpos.y, GetEntityCoords(ent).z)
            if not inVehicle then
            SetEntityCoordsNoOffset(ped, setpos.x, setpos.y, GetEntityCoords(ent).z)
            end
        end

        -- Up and Down
        if IsDisabledControlPressed(2, 22) then -- E
            local setpos = GetOffsetFromEntityInWorldCoords(ent, 0.0, 0.0, multiplier * speed / 2)
            SetEntityCoordsNoOffset(ent, setpos)
            if not inVehicle then
            SetEntityCoordsNoOffset(ped, setpos)
            end
        elseif IsDisabledControlPressed(2, 52) then
            local setpos = GetOffsetFromEntityInWorldCoords(ent, 0.0, 0.0, multiplier * -speed / 2) -- Q
            SetEntityCoordsNoOffset(ent, setpos)
            if not inVehicle then
            SetEntityCoordsNoOffset(ped, setpos)
            end
        end

        local camrot = GetCamRot(noClipCam, 2)
        SetEntityHeading(ent, (360 + camrot.z) % 360.0)

        SetEntityVisible(ent, false)
        if inVehicle then
            SetEntityVisible(ped, false)
        end

        DisableControlAction(2, 32, true)
        DisableControlAction(2, 33, true)
        DisableControlAction(2, 34, true)
        DisableControlAction(2, 35, true)
        DisableControlAction(2, 36, true)
        DisableControlAction(2, 12, true)
        DisableControlAction(2, 13, true)
        DisableControlAction(2, 14, true)
        DisableControlAction(2, 15, true)
        DisableControlAction(2, 16, true)
        DisableControlAction(2, 17, true)

        DisablePlayerFiring(PlayerId(), true)
        end

        DestroyCam(noClipCam, false)
        noClipCam = nil
        RenderScriptCams(false, false, 3000, true, false)
        FreezeEntityPosition(ent, false)
        SetEntityCollision(ent, true, true)
        ResetEntityAlpha(ent)
        SetPedCanRagdoll(ped, true)
        SetEntityVisible(ent, not Invisible)
        ClearPedTasksImmediately(ped)

        if inVehicle then
        FreezeEntityPosition(ped, false)
        SetEntityCollision(ped, true, true)
        ResetEntityAlpha(ped)
        SetEntityVisible(ped, true)
        SetPedIntoVehicle(ped, ent, -1)
        end
    end)
end

function checkInputRotation()
    CreateThread(function()
        while inputRotEnabled do
            while noClipCam == nil do
                Wait(0)
            end

            while IsPauseMenuActive() do
                Wait(0)
            end
    
            local axisX = GetDisabledControlNormal(0, 1)
            local axisY = GetDisabledControlNormal(0, 2)

            local sensitivity = GetProfileSetting(14) * 2

            if GetProfileSetting(15) == 0 --[[ Invert ]] then
                -- this is default inverse
                sensitivity = -sensitivity
            end
    
            if (math.abs(axisX) > 0) or (math.abs(axisY) > 0) then
                local rotation = GetCamRot(noClipCam, 2)
                local rotz = rotation.z + (axisX * sensitivity)
        
                local yValue = (axisY * sensitivity)
        
                local rotx = rotation.x
        
                if rotx + yValue > minY and rotx + yValue < maxY then
                    rotx = rotation.x + yValue
                end
        
                SetCamRot(noClipCam, rotx, rotation.y, rotz, 2)
            end
    
            Wait(0)
        end
    end)
end

RegisterNetEvent('qb-admin:client:ToggleNoClip', function()
    toggleNoClipMode()
end)

function toggleNoClipMode(forceMode)
	if forceMode ~= nil then
		noClipEnabled = forceMode
		inputRotEnabled = noClipEnabled
	else
		noClipEnabled = not noClipEnabled
		inputRotEnabled = noClipEnabled
        TriggerServerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Set NoClip to **%s**",
        GetPlayerName(PlayerId()), Admin.citizenid, Admin.source, noClipEnabled))
	end
    if noClipEnabled and inputRotEnabled then
        toggleNoclip()
        checkInputRotation()
    end
end
