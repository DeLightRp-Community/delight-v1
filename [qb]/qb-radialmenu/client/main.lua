QBCore = exports['qb-core']:GetCoreObject()
PlayerData = QBCore.Functions.GetPlayerData() -- Setting this for when you restart the resource in game
local inRadialMenu = false

local jobIndex = nil
local vehicleIndex = nil
local radioIndex = nil

local DynamicMenuItems = {}
local FinalMenuItems = {}
-- Functions

local function deepcopy(orig) -- modified the deep copy function from http://lua-users.org/wiki/CopyTable
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if not orig.canOpen or orig.canOpen() then
            local toRemove = {}
            copy = {}
            for orig_key, orig_value in next, orig, nil do
                if type(orig_value) == 'table' then
                    if not orig_value.canOpen or orig_value.canOpen() then
                        copy[deepcopy(orig_key)] = deepcopy(orig_value)
                    else
                        toRemove[orig_key] = true
                    end
                else
                    copy[deepcopy(orig_key)] = deepcopy(orig_value)
                end
            end
            for i=1, #toRemove do table.remove(copy, i) --[[ Using this to make sure all indexes get re-indexed and no empty spaces are in the radialmenu ]] end
            if copy and next(copy) then setmetatable(copy, deepcopy(getmetatable(orig))) end
        end
    elseif orig_type ~= 'function' then
        copy = orig
    end
    return copy
end

local function getNearestVeh()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

local function AddOption(data, id)
    
    local menuID = id ~= nil and id or (#DynamicMenuItems + 1)
    DynamicMenuItems[menuID] = deepcopy(data)
    return menuID
end

local function RemoveOption(id)
    DynamicMenuItems[id] = nil
end

local function SetupJobMenu()
    local JobMenu = {
        id = 'jobinteractions',
        title = 'Work',
        icon = 'briefcase',
        items = {}
    }
    if Config.JobInteractions[PlayerData.job.name] and next(Config.JobInteractions[PlayerData.job.name]) then
        JobMenu.items = Config.JobInteractions[PlayerData.job.name]
    end

    if #JobMenu.items == 0 then
        if jobIndex then
            RemoveOption(jobIndex)
            jobIndex = nil
        end
    else
        jobIndex = AddOption(JobMenu, jobIndex)
    end
end

local function SetupVehicleMenu()
    local VehicleMenu = {
        id = 'vehicle',
        title = 'Vehicle',
        icon = 'car',
        items = {}
    }

    local ped = PlayerPedId()
    local Vehicle = GetVehiclePedIsIn(ped) ~= 0 and GetVehiclePedIsIn(ped) or getNearestVeh()
    if Vehicle ~= 0 then
        VehicleMenu.items[#VehicleMenu.items+1] = Config.VehicleDoors
        if Config.EnableExtraMenu then VehicleMenu.items[#VehicleMenu.items+1] = Config.VehicleExtras end

        if IsPedInAnyVehicle(ped) then
            RemoveOption(vehicleIndex)
            vehicleIndex = AddOption(VehicleMenu, vehicleIndex)
            -- local seatIndex = #VehicleMenu.items+1
            -- VehicleMenu.items[seatIndex] = deepcopy(Config.VehicleSeats)

            -- local seatTable = {
            --     [1] = Lang:t("options.driver_seat"),
            --     [2] = Lang:t("options.passenger_seat"),
            --     [3] = Lang:t("options.rear_left_seat"),
            --     [4] = Lang:t("options.rear_right_seat"),
            -- }

            -- local AmountOfSeats = GetVehicleModelNumberOfSeats(GetEntityModel(Vehicle))
            -- for i = 1, AmountOfSeats do
            --     local newIndex = #VehicleMenu.items[seatIndex].items+1
            --     VehicleMenu.items[seatIndex].items[newIndex] = {
            --         id = i - 2,
            --         title = seatTable[i] or Lang:t("options.other_seats"),
            --         icon = 'caret-up',
            --         type = 'client',
            --         event = 'qb-radialmenu:client:ChangeSeat',
            --         shouldClose = false,
            --     }
            -- end
        else
            RemoveOption(vehicleIndex)
        end 
    end
end

local function SetupRadioMenu()
    local RadioMenu = {
        id = 'radio',
        title = 'Radio',
        icon = 'radio-tuner',
        items = {
            {
                id = 'radioon',
                title = 'Turn On',
                icon = 'power-off',
                type = 'client',
                event = 'zerio-radio:client:onbabat',
                shouldClose = true
            }, {
                id = 'radiooff',
                title = 'Turn Off',
                icon = 'power-off',
                type = 'client',
                event = 'zerio-radio:client:onRadioDrop',
                shouldClose = true
            }, {
                id = 'joinradio1',
                title = 'CH 1',
                icon = 'radio',
                type = 'client',
                event = 'zerio-radio:client:JoinRadioChannel1',
                shouldClose = true
            }, {
                id = 'joinradio2',
                title = 'CH 2',
                icon = 'radio',
                type = 'client',
                event = 'zerio-radio:client:JoinRadioChannel2',
                shouldClose = true
            }, {
                id = 'joinradio3',
                title = 'CH 3',
                icon = 'radio',
                type = 'client',
                event = 'zerio-radio:client:JoinRadioChannel3',
                shouldClose = true
            }, {
                id = 'joinradio4',
                title = 'CH 4',
                icon = 'radio',
                type = 'client',
                event = 'zerio-radio:client:JoinRadioChannel4',
                shouldClose = true
            }, {
                id = 'joinradio5',
                title = 'CH 5',
                icon = 'radio',
                type = 'client',
                event = 'zerio-radio:client:JoinRadioChannel5',
                shouldClose = true
            }, {
                id = 'joinradio6',
                title = 'CH 6',
                icon = 'radio',
                type = 'client',
                event = 'zerio-radio:client:JoinRadioChannel6',
                shouldClose = true
            }, {
                id = 'joinradio7',
                title = 'CH 7',
                icon = 'radio',
                type = 'client',
                event = 'zerio-radio:client:JoinRadioChannel7',
                shouldClose = true
            }, {
                id = 'joinradio8',
                title = 'CH 8',
                icon = 'radio',
                type = 'client',
                event = 'zerio-radio:client:JoinRadioChannel8',
                shouldClose = true
            }, {
                id = 'joinradio9',
                title = 'CH 9',
                icon = 'radio',
                type = 'client',
                event = 'zerio-radio:client:JoinRadioChannel9',
                shouldClose = true
            }, {
                id = 'joinradio10',
                title = 'CH 10',
                icon = 'radio',
                type = 'client',
                event = 'zerio-radio:client:JoinRadioChannel10',
                shouldClose = true
            },
        }   
    }

    local player = QBCore.Functions.GetPlayerData()
    local jobName = player.job.name
    -- print(json.encode(player.job))
    if (jobName == "police" or jobName == "ambulance") and player.job.onduty then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
                if #RadioMenu.items == 0 then
                    if radioIndex then
                        RemoveOption(radioIndex)
                        vehicleIndex = nil
                    end
                else
                    radioIndex = AddOption(RadioMenu, radioIndex)
                end
            else
                if radioIndex then
                    RemoveOption(radioIndex)
                    vehicleIndex = nil
                end
            end    
        end, "radio")
    else
        if radioIndex then
            RemoveOption(radioIndex)
            vehicleIndex = nil
        end
    end

    
    
    
end

local function SetupSubItems()
    SetupJobMenu()
    SetupVehicleMenu()
    SetupRadioMenu()
end

local function selectOption(t, t2)
    for k, v in pairs(t) do
        if v.items then
            local found, hasAction, val = selectOption(v.items, t2)
            if found then return true, hasAction, val end
        else
            if v.id == t2.id and ((v.event and v.event == t2.event) or v.action) and (not v.canOpen or v.canOpen()) then
                return true, v.action, v
            end
        end
    end
    return false
end

local function IsPoliceOrEMS()
    return (PlayerData.job.name == "police" or PlayerData.job.name == "ambulance")
end

local function IsDowned()
    return (PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"])
end

local function SetupRadialMenu()
    FinalMenuItems = {}
    if (IsDowned() and IsPoliceOrEMS()) then
            FinalMenuItems = {
                [1] = {
                    id = 'emergencybutton2',
                    title = Lang:t("options.emergency_button"),
                    icon = 'exclamation-circle',
                    type = 'client',
                    event = 'police:client:SendPoliceEmergencyAlert',
                    shouldClose = true,
                },
            }
    else
        SetupSubItems()
        FinalMenuItems = deepcopy(Config.MenuItems)
        for _, v in pairs(DynamicMenuItems) do
            FinalMenuItems[#FinalMenuItems+1] = v
        end

    end
end

local function setRadialState(bool, sendMessage, delay)
    -- Menuitems have to be added only once

    if bool then
        TriggerEvent('qb-radialmenu:client:onRadialmenuOpen')
        SetupRadialMenu()
    else
        TriggerEvent('qb-radialmenu:client:onRadialmenuClose')
    end

    SetNuiFocus(bool, bool)
    if sendMessage then
        SendNUIMessage({
            action = "ui",
            radial = bool,
            items = FinalMenuItems
        })
    end
    if delay then Wait(500) end
    inRadialMenu = bool
end

-- Command

RegisterCommand('radialmenu', function()
    if ((IsDowned() and IsPoliceOrEMS()) or not IsDowned()) and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() and not inRadialMenu then
        setRadialState(true, true)
        SetCursorLocation(0.5, 0.5)
    end
end)

RegisterKeyMapping('radialmenu', Lang:t("general.command_description"), 'keyboard', 'F1')

-- Events

-- Sets the metadata when the player spawns
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

-- Sets the playerdata to an empty table when the player has quit or did /logout
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

-- This will update all the PlayerData that doesn't get updated with a specific event other than this like the metadata
RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent('qb-radialmenu:client:noPlayers', function()
    QBCore.Functions.Notify(Lang:t("error.no_people_nearby"), 'error', 2500)
end)

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())
    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end
	return closestPlayer, closestDistance
end

RegisterNetEvent('qb-radialmenu:client:giveCarKey', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 1.5 then
        local PlayerId = GetPlayerServerId(player)
        local plate = QBCore.Functions.GetPlate(GetVehiclePedIsIn(PlayerPedId(), true))
        TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', plate, PlayerId)
        -- QBCore.Functions.Notify("You Give Vehicle Key to Player", "error")
    else
        QBCore.Functions.Notify("Get close to the car", "error")
    end
end)

RegisterNetEvent('qb-radialmenu:client:setExtra', function(data)
    local string = data.id
    local replace = string:gsub("extra", "")
    local extra = tonumber(replace)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    if veh ~= nil then
        if GetPedInVehicleSeat(veh, -1) == ped then
            SetVehicleAutoRepairDisabled(veh, true) -- Forces Auto Repair off when Toggling Extra [GTA 5 Niche Issue]
            if DoesExtraExist(veh, extra) then
                if IsVehicleExtraTurnedOn(veh, extra) then
                    SetVehicleExtra(veh, extra, 1)
                    QBCore.Functions.Notify(Lang:t("error.extra_deactivated", {extra = extra}), 'error', 2500)
                else
                    SetVehicleExtra(veh, extra, 0)
                    QBCore.Functions.Notify(Lang:t("success.extra_activated", {extra = extra}), 'success', 2500)
                end
            else
                QBCore.Functions.Notify(Lang:t("error.extra_not_present", {extra = extra}), 'error', 2500)
            end
        else
            QBCore.Functions.Notify(Lang:t("error.not_driver"), 'error', 2500)
        end
    end
end)

RegisterNetEvent('qb-radialmenu:trunk:client:Door', function(plate, door, open)
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if veh ~= 0 then
        local pl = QBCore.Functions.GetPlate(veh)
        if pl == plate then
            if open then
                SetVehicleDoorOpen(veh, door, false, false)
            else
                SetVehicleDoorShut(veh, door, false)
            end
        end
    end
end)

RegisterNetEvent('qb-radialmenu:client:ChangeSeat', function(data)
    local Veh = GetVehiclePedIsIn(PlayerPedId())
    local IsSeatFree = IsVehicleSeatFree(Veh, data.id)
    local speed = GetEntitySpeed(Veh)
    local HasHarnass = exports['qb-smallresources']:HasHarness()
    if not HasHarnass then
        local kmh = speed * 3.6
        if IsSeatFree then
            if kmh <= 100.0 then
                SetPedIntoVehicle(PlayerPedId(), Veh, data.id)
                QBCore.Functions.Notify(Lang:t("info.switched_seats", {seat = data.title}))
            else
                QBCore.Functions.Notify(Lang:t("error.vehicle_driving_fast"), 'error')
            end
        else
            QBCore.Functions.Notify(Lang:t("error.seat_occupied"), 'error')
        end
    else
        QBCore.Functions.Notify(Lang:t("error.race_harness_on"), 'error')
    end
end)

-- NUI Callbacks

RegisterNUICallback('closeRadial', function(data)
    setRadialState(false, false, data.delay)
end)

RegisterNUICallback('selectItem', function(data)
    local itemData = data.itemData
    local found, action, data = selectOption(FinalMenuItems, itemData)

    if data and found then
        if action then
            action(data)
        elseif data.type == 'client' then
            TriggerEvent(data.event, data)
        elseif data.type == 'server' then
            TriggerServerEvent(data.event, data)
        elseif data.type == 'command' then
            ExecuteCommand(data.event)
        elseif data.type == 'qbcommand' then
            TriggerServerEvent('QBCore:CallCommand', data.event, data)
        end
    end
end)

exports('AddOption', AddOption)
exports('RemoveOption', RemoveOption)
