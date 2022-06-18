local QBCore = exports['qb-core']:GetCoreObject()
local uiOpen = false
local currentRegister   = 0
local currentSafe = 0
local copsCalled = false
local CurrentCops = 0
local PlayerJob = {}
local onDuty = false
local usingAdvanced = false

CreateThread(function()
    Wait(1000)
    if QBCore.Functions.GetPlayerData().job ~= nil and next(QBCore.Functions.GetPlayerData().job) then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

CreateThread(function()
    while true do
        Wait(1000 * 60 * 5)
        if copsCalled then
            copsCalled = false
        end
    end
end)


-- CreateThread(function()
--     while true do
--         Wait(1)
        
--         Wait(100)
        
--     end
-- end)

local models = {
    'prop_till_01',
}
exports['qb-target']:AddTargetModel(models, {
    options = { -- This is your options table, in this table all the options will be specified for the target to accept
      {
        icon = 'fa-solid fa-screwdriver',
        label = 'Rob Register',
        action = function(entity)
            if IsPedAPlayer(entity) then return false end 
            TriggerEvent('qb-storerobbery:UseLockpick',false)
          
        end,
        canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
          if IsPedAPlayer(entity) then return false end -- This will return false if the entity interacted with is a player and otherwise returns true
          local propExistAndDamage=false
            if IsPedAPlayer(entity) then return false end 
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local sani = GetClosestObjectOfType(pos, 2.0, GetHashKey('prop_till_01'), false)
            if DoesEntityExist(sani) then
                hpProp = GetEntityHealth(sani)
                if hpProp < 1000 then
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)
                    local inRange = false
                    for k, v in pairs(Config.Registers) do
                        local dist = #(pos - Config.Registers[k][1].xyz)
                        if dist <= 1 then
                            inRange = true
                            Config.Registers[k].propExistAndDamage = true
                            print(Config.Registers[k].propExistAndDamage)
                            return true
                        end
                    end 
                end
            end
        end,
        },
    },
    distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
})

--[[CreateThread(function()
    Wait(1000)
    setupRegister()
    setupSafes()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false
        for k, v in pairs(Config.Registers) do
            local dist = #(pos - Config.Registers[k][1].xyz)
            if dist <= 1 and Config.Registers[k].robbed then
                inRange = true
                DrawText3Ds(Config.Registers[k][1].xyz, 'The Cash Register Is Empty')
            end
        end
        if not inRange then
            Wait(2000)
        end
        Wait(3)
    end
end)]]

--[[CreateThread(function()
    while true do
        Wait(1)
        local inRange = false
        if QBCore ~= nil then
            local pos = GetEntityCoords(PlayerPedId())
            for safe,_ in pairs(Config.Safes) do
                local dist = #(pos - Config.Safes[safe][1].xyz)
                if dist < 3 then
                    inRange = true
                    if dist < 1.0 then
                        if not Config.Safes[safe].robbed then
                            DrawText3Ds(Config.Safes[safe][1].xyz, '~g~E~w~ - Try Combination')
                            if IsControlJustPressed(0, 38) then
                                if CurrentCops >= Config.MinimumStoreRobberyPolice then
                                    currentSafe = safe
                                    if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
                                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                                    end
                                    if math.random(100) <= 50 then
                                        TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                                    end
                                    if Config.Safes[safe].type == "keypad" then
                                        SendNUIMessage({
                                            action = "openKeypad",
                                        })
                                        SetNuiFocus(true, true)
                                    else
                                        QBCore.Functions.TriggerCallback('qb-storerobbery:server:getPadlockCombination', function(combination)
                                            TriggerEvent("safe_cracker:StartMinigame", combination)
                                        end, safe)
                                    end

                                    if not copsCalled then
                                        local pos = GetEntityCoords(PlayerPedId())
					local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
                                        local street1 = GetStreetNameFromHashKey(s1)
                                        local street2 = GetStreetNameFromHashKey(s2)
                                        local streetLabel = street1
                                        if street2 ~= nil then
                                            streetLabel = streetLabel .. " " .. street2
                                        end
                                        TriggerServerEvent("qb-storerobbery:server:callCops", "safe", currentSafe, streetLabel, pos)
                                        copsCalled = true
                                    end
                                else
                                    QBCore.Functions.Notify("Not Enough Police (".. Config.MinimumStoreRobberyPolice .." Required)", "error")
                                end
                            end
                        else
                            DrawText3Ds(Config.Safes[safe][1].xyz, 'Safe Opened')
                        end
                    end
                end
            end
        end

        if not inRange then
            Wait(2000)
        end
    end
end)]]

local CurrentZone=nil


Citizen.CreateThread(function()
    while true do 
        Wait(500)
        local inRange = false
        if QBCore ~= nil then
            local pos = GetEntityCoords(PlayerPedId())
            for safe,_ in pairs(Config.Safes) do
                local dist = GetDistanceBetweenCoords(pos, Config.Safes[safe].x, Config.Safes[safe].y, Config.Safes[safe].z)
                if dist < 3 then
                    inRange = true
                    if dist < 1.0 then
                        if not Config.Safes[safe].robbed then
                            if not robberyIsOnCooldown then
                                currentSafe = safe
                                --DrawText3Ds(Config.Safes[safe].x, Config.Safes[safe].y, Config.Safes[safe].z, '~g~E~w~ - Insert Combination')
                                exports["qb-target"]:AddCircleZone("StoreSafe"..safe, vector3(Config.Safes[safe].x, Config.Safes[safe].y, Config.Safes[safe].z), 0.80, {
                                    name="StoreSafe"..safe,
                                    -- debugPoly=true,
                                    useZ=true,
                                    }, {
                                        options = {
                                            {
                                                action = function(entity) -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                                                    if IsPedAPlayer(entity) then return false end -- This will return false if the entity interacted with is a player and otherwise returns true
                                                    TriggerEvent('qb-storerobbery:client:safe', safe) -- Triggers a client event called testing:event and sends the argument 'test' with it
                                                end,
                                                icon = "fas fa-clipboard",
                                                label = "Crack Safe",
                                            },
                                            {
                                                action = function(entity) -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                                                    if IsPedAPlayer(entity) then return false end -- This will return false if the entity interacted with is a player and otherwise returns true
                                                    TriggerEvent('qb-storerobbery:client:safecheck', safe) -- Triggers a client event called testing:event and sends the argument 'test' with it
                                                end,
                                                icon = "fas fa-clipboard",
                                                label = "Check Safe",
                                            },
                                        },
                                        distance = 1.5
                                })
                        else

                            exports['qb-core']:DrawText('Safe is Open.', 'left')

                        end
                    else
                        exports['qb-core']:DrawText('Safe opened ..', 'left')
                    end
                else
                    exports['qb-core']:HideText("storerob")
                end
            end
        end
    end
    end
end)


local tasking = true
local timer = 300
function starttimer(currentSafe)
    timer = Config.Safes[currentSafe].timer
    Citizen.CreateThread(function()
        while true do
            if timer > 0  then
                timer = timer - 1
            else 
                timer = 0
                break
            end
            Citizen.Wait(1000)
        end
    end)
end

RegisterNetEvent('qb-storerobbery:client:safecheck', function(currentSafe)
    
    if Config.Safes[currentSafe].robbed or Config.Safes[currentSafe].robbed == 0 then
        if timer > 0 then
            
            
            local min = math.ceil(timer / 60)
            QBCore.Functions.Notify("You Need To Wait " .. min .. " More Minutes.", "error")
            
        else
            
            TriggerServerEvent("qb-storerobbery:server:SafeReward", currentSafe)
            currentSafe = 0
            timer = 10
            takeAnim()
            copsCalled = false
            
        end
    else
        QBCore.Functions.Notify("You Need To Crack Safe First ...", "error")
    end
end)

RegisterNetEvent('qb-storerobbery:client:safe', function(currentSafe)
    local pos = GetEntityCoords(PlayerPedId())
    if not Config.Safes[currentSafe].robbed then
        if CurrentCops >= Config.MinimumStoreRobberyPolice then
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                if result then
                    if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                    end
                    if math.random(1, 100) <= 50 then
                        TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 3))
                    end
                    exports["memorygame"]:thermiteminigame(10, 3, 3, 10,
                    function() -- success
                        TriggerEvent("storerob:success")
                    end,
                    function() -- failure
                        TriggerEvent("storerob:fail")
                    end)

                    if not copsCalled then
                        -- local pos = GetEntityCoords(PlayerPedId())
                        local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
                        local street1 = GetStreetNameFromHashKey(s1)
                        local street2 = GetStreetNameFromHashKey(s2)
                        local streetLabel = street1
                        if street2 ~= nil then 
                            streetLabel = streetLabel .. " " .. street2
                        end
                        if copsCalled == false then
                            --TriggerEvent('dispatch:storeRobbery', 'Store Robbery: Safe Cracking In Progress')
                            exports['ps-dispatch']:StoreSafeRobbery(currentSafe)
                            copsCalled = true
                        end
                    end
                else
                    QBCore.Functions.Notify("You Are Missing An Item", "error")
                end
            end, "safe_cracker")
        else
            QBCore.Functions.Notify("Not enough police", "error")
        end
    else
        QBCore.Functions.Notify("Safe Is Robbed", "error")
    end
end)

RegisterNetEvent('storerob:success')
AddEventHandler('storerob:success', function()
    QBCore.Functions.Notify("Crack SuccessFull", "success")
    QBCore.Functions.Notify("Wait For Safe To Be Opened", "error")
    TriggerServerEvent("qb-storerobbery:server:setSafeStatus", currentSafe)
    print("timer start")
    starttimer(currentSafe)
    print("timer start2")
    --triggerCooldown()
    TriggerServerEvent("QBCore:Server:RemoveItem", "safe_cracker", 1)
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["safe_cracker"], "remove")
end)

RegisterNetEvent('storerob:fail')
AddEventHandler('storerob:fail', function()
     TriggerServerEvent("QBCore:Server:RemoveItem", "safe_cracker", 1)
     TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["safe_cracker"], "remove")
end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    onDuty = true
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = true
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('qb-storerobbery:UseLockpick', function(isAdvanced)
    usingAdvanced = isAdvanced
    for k, v in pairs(Config.Registers) do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = #(pos - Config.Registers[k][1].xyz)
        if dist <= 1 and not Config.Registers[k].robbed then
            if CurrentCops >= Config.MinimumStoreRobberyPolice then
                -- print(usingAdvanced)
                if usingAdvanced then
                    uiOpen = bool
                    currentRegister = k
                    if not IsWearingHandshoes() then
                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                    end
                    if not copsCalled then
                        exports['ps-dispatch']:StoreRobbery(v.camId)
			            -- local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
                        -- local street1 = GetStreetNameFromHashKey(s1)
                        -- local street2 = GetStreetNameFromHashKey(s2)
                        -- local streetLabel = street1
                        -- if street2 ~= nil then
                        --     streetLabel = streetLabel .. " " .. street2
                        -- end
                        -- TriggerServerEvent("qb-storerobbery:server:callCops", "cashier", currentRegister, streetLabel, pos)
                        -- copsCalled = true
                    end
                    local time = math.random(1,2)
                    local circles = math.random(4,5)
                    local success = exports['qb-lock']:StartLockPickCircle(circles, time, success)
                    if success then
                        TriggerEvent('qb-storerobbery:success')
                    else
                        TriggerEvent('qb-storerobbery:fail')
                    end
                else
                    uiOpen = bool
                    currentRegister = k
                    if not IsWearingHandshoes() then
                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                    end

                    if not copsCalled then
                        exports['ps-dispatch']:StoreRobbery(v.camId)
			            -- local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
                        -- local street1 = GetStreetNameFromHashKey(s1)
                        -- local street2 = GetStreetNameFromHashKey(s2)
                        -- local streetLabel = street1
                        -- if street2 ~= nil then
                        --     streetLabel = streetLabel .. " " .. street2
                        -- end
                        -- TriggerServerEvent("qb-storerobbery:server:callCops", "cashier", currentRegister, streetLabel, pos)
                        -- copsCalled = true
                    end
                    local time = math.random(1,2)
                    local circles = math.random(4,5)
                    local success = exports['qb-lock']:StartLockPickCircle(circles, time, success)
                    if success then
                        TriggerEvent('qb-storerobbery:success')
                    else
                        TriggerEvent('qb-storerobbery:fail')
                    end
                end

            else
                QBCore.Functions.Notify("Not Enough Police (2 Required)", "error")
            end
        end
    end
end)

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true

    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

function setupRegister()
    QBCore.Functions.TriggerCallback('qb-storerobbery:server:getRegisterStatus', function(Registers)
        for k, v in pairs(Registers) do
            Config.Registers[k].robbed = Registers[k].robbed
        end
    end)
end

function setupSafes()
    QBCore.Functions.TriggerCallback('qb-storerobbery:server:getSafeStatus', function(Safes)
        for k, v in pairs(Safes) do
            Config.Safes[k].robbed = Safes[k].robbed
        end
    end)
end

DrawText3Ds = function(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end



function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(100)
    end
end

function takeAnim()
    local ped = PlayerPedId()
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        Wait(100)
    end
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
    Wait(2500)
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
end

local openingDoor = false

RegisterNetEvent('qb-storerobbery:success', function()
    if currentRegister ~= 0 then
        -- lockpick(false)
        TriggerServerEvent('qb-storerobbery:server:setRegisterStatus', currentRegister)
        local lockpickTime = 25000
        LockpickDoorAnim(lockpickTime)
        QBCore.Functions.Progressbar("search_register", "Emptying The Register..", lockpickTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "veh@break_in@0h@p_m_one@",
            anim = "low_force_entry_ds",
            flags = 16,
        }, {}, {}, function() -- Done
            openingDoor = false
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('qb-storerobbery:server:takeMoney', currentRegister, true)
            currentRegister = 0
        end, function() -- Cancel
            openingDoor = false
            ClearPedTasks(PlayerPedId())
            QBCore.Functions.Notify("Process canceled..", "error")
            currentRegister = 0
        end)
        CreateThread(function()
            while openingDoor do
                TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                Wait(10000)
            end
        end)
    else
        SendNUIMessage({
            action = "kekw",
        })
    end
end)

function LockpickDoorAnim(time)
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(2000)
            time = time - 2
            TriggerServerEvent('qb-storerobbery:server:takeMoney', currentRegister, false)
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

RegisterNUICallback('callcops', function()
    TriggerEvent("police:SetCopAlert")
end)

RegisterNetEvent('safe_cracker:EndMinigame', function(won)
    if currentSafe ~= 0 then
        if won then
            if currentSafe ~= 0 then
                if not Config.Safes[currentSafe].robbed then
                    SetNuiFocus(false, false)
                    TriggerServerEvent("qb-storerobbery:server:SafeReward", currentSafe)
                    TriggerServerEvent("qb-storerobbery:server:setSafeStatus", currentSafe)
                    currentSafe = 0
                    takeAnim()
                end
            else
                SendNUIMessage({
                    action = "kekw",
                })
            end
        end
    end
    copsCalled = false
end)

RegisterNUICallback('PadLockSuccess', function()
    if currentSafe ~= 0 then
        if not Config.Safes[currentSafe].robbed then
            SendNUIMessage({
                action = "kekw",
            })
        end
    else
        SendNUIMessage({
            action = "kekw",
        })
    end
end)

RegisterNUICallback('PadLockClose', function()
    SetNuiFocus(false, false)
    copsCalled = false
end)

RegisterNUICallback("CombinationFail", function(data, cb)
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
end)

RegisterNUICallback('qb-storerobbery:fail', function()
    if usingAdvanced then
        if math.random(1, 100) < 20 then
            TriggerServerEvent("QBCore:Server:RemoveItem", "advancedlockpick", 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["advancedlockpick"], "remove")
        end
    else
        if math.random(1, 100) < 40 then
            TriggerServerEvent("QBCore:Server:RemoveItem", "lockpick", 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["lockpick"], "remove")
        end
    end
    if (IsWearingHandshoes() and math.random(1, 100) <= 25) then
        local pos = GetEntityCoords(PlayerPedId())
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
        QBCore.Functions.Notify("You Broke The Lock Pick")
    end
    -- lockpick(false)
end)

RegisterNUICallback('exit', function()
    -- lockpick(false)
end)

RegisterNUICallback('TryCombination', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-storerobbery:server:isCombinationRight', function(combination)
        if tonumber(data.combination) ~= nil then
            if tonumber(data.combination) == combination then
                TriggerServerEvent("qb-storerobbery:server:SafeReward", currentSafe)
                TriggerServerEvent("qb-storerobbery:server:setSafeStatus", currentSafe)
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = false,
                })
                currentSafe = 0
                takeAnim()
            else
                TriggerEvent("police:SetCopAlert")
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = true,
                })
                currentSafe = 0
            end
        end
    end, currentSafe)
end)

RegisterNetEvent('qb-storerobbery:client:setRegisterStatus', function(batch, val)
    -- Has to be a better way maybe like adding a unique id to identify the register
    if(type(batch) ~= "table") then
        Config.Registers[batch] = val
    else
        for k, v in pairs(batch) do
            Config.Registers[k] = batch[k]
        end
    end
end)

RegisterNetEvent('qb-storerobbery:client:setSafeStatus', function(safe, bool)
    Config.Safes[safe].robbed = bool
end)

RegisterNetEvent('qb-storerobbery:client:robberyCall', function(type, key, streetLabel, coords)
    if PlayerJob.name == "police" and onDuty then
        local cameraId = 4
        if type == "safe" then
            cameraId = Config.Safes[key].camId
        else
            cameraId = Config.Registers[key].camId
        end
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        TriggerServerEvent('police:server:policeAlert', 'Storerobbery in progress')

        local transG = 250
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 458)
        SetBlipColour(blip, 1)
        SetBlipDisplay(blip, 4)
        SetBlipAlpha(blip, transG)
        SetBlipScale(blip, 1.0)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("10-31 | Shop Robbery")
        EndTextCommandSetBlipName(blip)
        while transG ~= 0 do
            Wait(180 * 4)
            transG = transG - 1
            SetBlipAlpha(blip, transG)
            if transG == 0 then
                SetBlipSprite(blip, 2)
                RemoveBlip(blip)
                return
            end
        end
    end
end)
