local coreName = Config.coreName;
coreName = exports['qb-core']:GetCoreObject()
local cam, cam2 = nil, nil
cb = {}

-- [[ Functions ]] --
local function sendMessage(ttype, message,messageTitle)
    SendNUIMessage({
        action = 'message',
        messageType = ttype,
        messageText = message,
        messageTitle = messageTitle
    })
end

local function screenFadeIn()
    DoScreenFadeOut(500)
    DoScreenFadeIn(500)
end

local function showUi(bool)
    if bool then
        SetNuiFocus(true,true)
        SendNUIMessage({
            action = 'open',
            title = Config.welcomeTitle,
            description = Config.welcomeDesc,
            accentColor = Config.accentColor,
            succesColor = Config.successColor,
            errorColor = Config.errorColor,
            language = Config.JSlanguage,
        })
    else
        SetNuiFocus(false,false)
        SendNUIMessage({
            action = 'close',
            title = Config.welcomeTitle,
            description = Config.welcomeDesc,
            accentColor = Config.accentColor,
            succesColor = Config.successColor,
            errorColor = Config.errorColor,
            language = Config.JSlanguage,
        })
    end
end

local function beforePlayer()
    DoScreenFadeOut(500)
    Wait(2000)
    showUi(false)
end

local function afterPlayer(ped)
    FreezeEntityPosition(ped, false)
    Wait(500)
    DoScreenFadeIn(250)
end
---

--[[ Commands ]]
if Config.devMode then
    RegisterCommand('openUi', function ()
        TriggerServerEvent('jerzys_spawn:server:getAll')
        TriggerServerEvent('jerzys_spawn:server:checkAdmin')
        TriggerServerEvent('qb-multicharacter:server:loadUserData')
    end)
else
    print('no dev mode')
end

if Config.devMode then
    RegisterCommand('closeUi', function ()
        showUi(false)
    end)
end
RegisterCommand('updateUi', function ()
    TriggerServerEvent('jerzys_spawn:server:updateAll')
end)

--[[ Net Events ]]

RegisterNetEvent('qb-spawn:client:openUI', function (value)
    TriggerServerEvent('jerzys_spawn:server:getAll')
    TriggerServerEvent('jerzys_spawn:server:checkAdmin')
    SetEntityVisible(PlayerPedId(), false)
    DoScreenFadeOut(250)
    Wait(1000)
    Wait(500)
    SetEntityVisible(PlayerPedId(), true)
    DoScreenFadeIn(250)
end)

RegisterNetEvent('jerzys_spawn:client:pushData', function (data)
    local getData = json.encode(data)
    SetNuiFocus(true,true)
    coreName.Functions.TriggerCallback('qb-spawn:server:getOwnedApartments',function (houses,apartments)
        SendNUIMessage({
            action = 'open',
            getCoords = getData,
            title = Config.welcomeTitle,
            description = Config.welcomeDesc,
            accentColor = Config.accentColor,
            succesColor = Config.successColor,
            errorColor = Config.errorColor,
            language = Config.JSlanguage,
            apartments = apartments,
            houses = houses,
            god = getData.isAdmin
        })
    end)
end)

RegisterNetEvent('jerzys_spawn:client:enableDev', function ()
    SendNUIMessage({
        action = 'isAdmin'
    })
end)

RegisterNetEvent('jerzys_spawn:client:updateAll', function (data)
    local getData = json.encode(data)
    SetNuiFocus(true,true)
    SendNUIMessage({
        action = 'update',
        getCoords = getData,
    })
end)

RegisterNetEvent('jerzys_spawn:client:handle', function (data)
    sendMessage(data.type, data.message, data.title)
end)

--[[ NUI Callbacks ]] --
RegisterNUICallback('enterSpawn', function (data,cb)
    local d = data;
    local x = d.cordX
    local y = d.cordY
    local z = d.cordZ
    beforePlayer()
        SetEntityCoords(PlayerPedId(), x,y,z)
        FreezeEntityPosition(PlayerPedId(), false)
    afterPlayer()
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    cb('ok')
end)

RegisterNUICallback('generateNode', function (data, cb)
    TriggerServerEvent('jerzys_spawn:server:createNode', data)
    cb('ok')
end)

RegisterNUICallback('saveEdit', function(data, cb)
    TriggerServerEvent('jerzys_spawn:server:updateNode', data)
    cb('ok')
end)

RegisterNUICallback('deleteNode', function (data,cb)
    TriggerServerEvent('jerzys_spawn:server:deleteNode', data)
    cb('ok')
end)

RegisterNUICallback('updateCords', function (data,cb)
    TriggerServerEvent('jerzys_spawn:server:updateCords', data)
    cb('ok')
end)

RegisterNUICallback('notifySound', function (data,cb)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "monkeyopening", 0.3)
    cb('ok')
end)

RegisterNUICallback('hoverDotSound', function (data,cb)
    PlaySoundFrontend(-1,'NAV_UP_DOWN', 'HUD_FREEMODE_SOUNDSET', 0.3)
    cb('ok')
end)

RegisterNUICallback('closeUi', function (data,cb)
    showUi(false)
    cb('ok')
end)

RegisterNetEvent('qb-spawn:client:setupSpawns', function(cData, new, apps)
    if new then
        SendNUIMessage({
            action = "setupApp",
            locations = apps,
        })
    end
end)

RegisterNUICallback('getApartment', function(data)
    local player = PlayerPedId()
    local appaYeet = data.appType
    showUi(false)
    DoScreenFadeOut(500)
    Wait(5000)
    TriggerServerEvent("apartments:server:CreateApartment", appaYeet, Apartments.Locations[appaYeet].label)
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    FreezeEntityPosition(player, false)
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    SetCamActive(cam2, false)
    DestroyCam(cam2, true)
    SetEntityVisible(player, true)
end)

RegisterNUICallback('lastLocation', function (data,cb)
    local PlayerData = coreName.Functions.GetPlayerData()
    local x = PlayerData.position.x
    local y = PlayerData.position.y
    local z = PlayerData.position.z
    beforePlayer()
        SetEntityCoords(PlayerPedId(), x,y,z)
        FreezeEntityPosition(PlayerPedId(), false)
    afterPlayer()
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    cb('ok')
end)

RegisterNUICallback('spawnApartment', function (data,cb)
    -- QBCore.Functions.GetPlayerData(function(PlayerData)
    --     if PlayerData.metadata["injail"] > 0 then
    --         TriggerEvent("prison:client:Enter", PlayerData.metadata["injail"])
    --     else
    --         LeaveApartment(ClosestHouse)
    --     end
    -- end)
    local PlayerData = coreName.Functions.GetPlayerData()
    if PlayerData.metadata["injail"] > 0 then
        -- local PlayerData = coreName.Functions.GetPlayerData()
        local x = PlayerData.position.x
        local y = PlayerData.position.y
        local z = PlayerData.position.z
        beforePlayer()
            SetEntityCoords(PlayerPedId(), x,y,z)
            FreezeEntityPosition(PlayerPedId(), false)
        afterPlayer()
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        cb('ok')
    else
        local apId = data.apartment
        local apType = data.apartmentType
        print(apType,apId)
        TriggerEvent('qb-apartments:client:LastLocationHouse', apType,apId)
        beforePlayer()
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        showUi(false)
        screenFadeIn()
        cb('ok')
    end
    
end)
