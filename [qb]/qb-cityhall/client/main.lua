local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local isLoggedIn = LocalPlayer.state.isLoggedIn
local playerPed = PlayerPedId()
local playerCoords = GetEntityCoords(playerPed)
local closestCityhall = nil
local closestDrivingSchool = nil
local inCityhallPage = false
local inRangeCityhall = false
local inRangeDrivingSchool = false
local pedsSpawned = false
local table_clone = table.clone
local blips = {}

-- Functions

local function getClosestHall()
    local distance = #(playerCoords - Config.Cityhalls[1].coords)
    local closest = 1
    for i = 1, #Config.Cityhalls do
        local hall = Config.Cityhalls[i]
        local dist = #(playerCoords - hall.coords)
        if dist < distance then
            distance = dist
            closest = i
        end
    end
    return closest
end

local function getClosestSchool()
    local distance = #(playerCoords - Config.DrivingSchools[1].coords)
    local closest = 1
    for i = 1, #Config.DrivingSchools do
        local school = Config.DrivingSchools[i]
        local dist = #(playerCoords - school.coords)
        if dist < distance then
            distance = dist
            closest = i
        end
    end
    return closest
end

local function setCityhallPageState(bool, message)
    if message then
        local action = bool and "open" or "close"
        SendNUIMessage({
            action = action
        })
    end
    SetNuiFocus(bool, bool)
    inCityhallPage = bool
    if not Config.UseTarget or bool then return end
    inRangeCityhall = false
end

local function createBlips()
    for i = 1, #Config.Cityhalls do
        local hall = Config.Cityhalls[i]
        if hall.showBlip then
            blips[#blips+1] = QBCore.Functions.CreateBlip(hall.coords, hall.blipData.sprite, hall.blipData.display, hall.blipData.scale, hall.blipData.colour, true, hall.blipData.title)
        end
    end
    for i = 1, #Config.DrivingSchools do
        local school = Config.DrivingSchools[i]
        if school.showBlip then
            blips[#blips+1] = QBCore.Functions.CreateBlip(school.coords, school.blipData.sprite, school.blipData.display, school.blipData.scale, school.blipData.colour, true, school.blipData.title)
        end
    end
end

local function deleteBlips()
    if not next(blips) then return end
    for i = 1, #blips do
        local blip = blips[i]
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    blips = {}
end

local function spawnPeds()
    if not Config.Peds or not next(Config.Peds) or pedsSpawned then return end
    for i = 1, #Config.Peds do
        local current = Config.Peds[i]
        current.model = type(current.model) == 'string' and joaat(current.model) or current.model
        RequestModel(current.model)
        while not HasModelLoaded(current.model) do
            Wait(0)
        end
        local ped = CreatePed(0, current.model, current.coords.x, current.coords.y, current.coords.z, current.coords.w, false, false)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, current.scenario, true)
        current.pedHandle = ped
        if Config.UseTarget then
            local opts = nil
            if current.drivingschool then
                opts = {
                    label = 'Take Driving Lessons',
                    icon = 'fa-solid fa-car-side',
                    action = function()
                        TriggerServerEvent('qb-cityhall:server:sendDriverTest', Config.DrivingSchools[closestDrivingSchool].instructors)
                    end
                }
            elseif current.cityhall then
                opts = {
                    label = 'Open Cityhall',
                    icon = 'fa-solid fa-city',
                    action = function()
                        inRangeCityhall = true
                        setCityhallPageState(true, true)
                    end
                }
            end
            if opts then
                exports['qb-target']:AddTargetEntity(ped, {
                    options = {opts},
                    distance = 2.0
                })
            end
        else
            local options = current.zoneOptions
            if options then
                local zone = BoxZone:Create(current.coords.xyz, options.length, options.width, {
                    name = "zone_cityhall_"..ped,
                    heading = current.coords.w,
                    debugPoly = false
                })
                zone:onPlayerInOut(function(inside)
                    if isLoggedIn and closestCityhall and closestDrivingSchool then
                        if inside then
                            if current.drivingschool then
                                inRangeDrivingSchool = true
                                exports['qb-core']:DrawText('[E] Take Driving Lessons')
                            elseif current.cityhall then
                                inRangeCityhall = true
                                exports['qb-core']:DrawText('[E] Open Cityhall')
                            end
                        else
                            exports['qb-core']:HideText("cityhall")
                            if current.drivingschool then
                                inRangeDrivingSchool = false
                            elseif current.cityhall then
                                inRangeCityhall = false
                            end
                        end
                    end
                end)
            end
        end
    end
    pedsSpawned = true
end

local function deletePeds()
    if not Config.Peds or not next(Config.Peds) or not pedsSpawned then return end
    for i = 1, #Config.Peds do
        local current = Config.Peds[i]
        if current.pedHandle then
            DeletePed(current.pedHandle)
        end
    end
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    isLoggedIn = true
    spawnPeds()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    isLoggedIn = false
    deletePeds()
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent('qb-cityhall:client:getIds', function()
    TriggerServerEvent('qb-cityhall:server:getIDs')
end)

RegisterNetEvent('qb-cityhall:client:sendDriverEmail', function(charinfo)
    SetTimeout(math.random(2500, 4000), function()
        local gender = Lang:t('email.mr')
        if PlayerData.charinfo.gender == 1 then
            gender = Lang:t('email.mrs')
        end
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Lang:t('email.sender'),
            subject = Lang:t('email.subject'),
            message =  Lang:t('email.message', {gender = gender, lastname = charinfo.lastname, firstname = charinfo.firstname, phone = charinfo.phone}),
            button = {}
        })
    end)
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    deleteBlips()
    deletePeds()
end)

-- NUI Callbacks

RegisterNUICallback('close', function()
    setCityhallPageState(false, false)
    if not Config.UseTarget and inRangeCityhall then exports['qb-core']:DrawText('[E] Open Cityhall') end -- Reopen interaction when you're still inside the zone
end)

RegisterNUICallback('requestId', function(id)
    local license = Config.Cityhalls[closestCityhall].licenses[id.type]
    if inRangeCityhall and license and id.cost == license.cost then
        TriggerServerEvent('qb-cityhall:server:requestId', id.type, id.cost)
        QBCore.Functions.Notify(('You have received your %s for $%s'):format(license.label, id.cost), 'success', 3500)
    else
        QBCore.Functions.Notify(Lang:t('error.not_in_range'), 'error')
    end
end)

RegisterNUICallback('requestLicenses', function(_, cb)
    local licensesMeta = PlayerData.metadata["licences"]
    local availableLicenses = table_clone(Config.Cityhalls[closestCityhall].licenses)
    for license, data in pairs(availableLicenses) do
        if data.metadata and not licensesMeta[data.metadata] then
            availableLicenses[license] = nil
        end
    end
    cb(availableLicenses)
end)

RegisterNUICallback('applyJob', function(job)
    if inRangeCityhall then
        TriggerServerEvent('qb-cityhall:server:ApplyJob', job, Config.Cityhalls[closestCityhall].coords)
    else
        QBCore.Functions.Notify(Lang:t('error.not_in_range'), 'error')
    end
end)

-- Threads

CreateThread(function()
    while true do
        if isLoggedIn then
            playerPed = PlayerPedId()
            playerCoords = GetEntityCoords(playerPed)
            closestCityhall = getClosestHall()
            closestDrivingSchool = getClosestSchool()
        end
        Wait(1000)
    end
end)

CreateThread(function()
    createBlips()
    spawnPeds()
    QBCore.Functions.TriggerCallback('qb-cityhall:server:receiveJobs', function(result)
        SendNUIMessage({
            action = 'setJobs',
            jobs = result
        })
    end)
    if not Config.UseTarget then
        while true do
            local sleep = 1000
            if isLoggedIn and closestCityhall and closestDrivingSchool then
                if inRangeCityhall then
                    if not inCityhallPage then
                        sleep = 0
                        if IsControlJustPressed(0, 38) then
                            setCityhallPageState(true, true)
                            exports['qb-core']:KeyPressed()
                            Wait(500)
                            exports['qb-core']:HideText("cityhall")
                            sleep = 1000
                        end
                    end
                elseif inRangeDrivingSchool then
                    sleep = 0
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('qb-cityhall:server:sendDriverTest', Config.DrivingSchools[closestDrivingSchool].instructors)
                        sleep = 5000
                        exports['qb-core']:KeyPressed()
                        Wait(500)
                        exports['qb-core']:HideText("cityhall")
                    end
                end
            end
            Wait(sleep)
        end
    end
end)
