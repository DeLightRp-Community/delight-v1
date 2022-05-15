local cityPowerState = true

local lasers = {}

local lasersActive = false

local QBCore = exports['qb-core']:GetCoreObject()

function OpenPaletoDoor()
    TriggerServerEvent('qb-doorlock:server:updateState', "paleto-vault", false, false, false, true, false, false)
    local object = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
    local timeOut = 10
    local entHeading = Config.BigBanks["paleto"]["heading"].closed

    if object ~= 0 then
        SetEntityHeading(object, Config.BigBanks["paleto"]["heading"].open)
        
    end
end

function SpawnTrolleys(data, name)
    RequestModel("ch_prop_ch_cash_trolly_01c")
    while not HasModelLoaded("ch_prop_ch_cash_trolly_01c") do
        Citizen.Wait(1)
    end
    Trolley = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), -99.17, 6462.05, 31.63, 1, 1, 0)

    SetEntityHeading(Trolley, 42.54)
    local closePlayers = QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
end

local function activateLasers(b)
    for _, laser in pairs(lasers) do
        laser.setActive(b)

        laser.onPlayerHit(function(playerBeingHit, hitPos)
            if playerBeingHit then
                local ped = GetPlayerPed(-1)
                TriggerEvent("hospital:client:KillPlayer", ped)
                
            else
                print("kon laghe av")
            end
        end)
    end
end

local function Movement(b)
    for _, laser in pairs(lasers) do
        laser.setMoving(b)
    end
end

local function Visible(b)
    for _, laser in pairs(lasers) do
        laser.setVisible(b)
    end
end

local function getActive()
    for _, laser in pairs(lasers) do
        laser.getActive()
    end
end

function thermiteanime() -- Inside Door 
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 45.000038146972)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(-104.17, 6473.95, 31.63, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), -104.17, 6473.95, 31.63,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.4,  true,  true, true)

    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(2000)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    TriggerServerEvent("qb-particleserversec", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)

    TriggerServerEvent('qb-doorlock:server:updateState', "paleto-boss", false, false, false, true, false, false)
end



RegisterNetEvent('qb-robbery:darkmail')
AddEventHandler('qb-robbery:darkmail', function()
    Citizen.Wait(1000)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = "Paleto",
        subject = "Dark Mail",
        message = "Good Job: <br><br> Hi, </b><br><br> You Bypassed the hack wait around 1-5 minutes, im getting this vault door open.",
    })
end)


RegisterNetEvent('qb-robbery:useitem', function()
    local minigame = exports["minigame-fleeca"]:HackingFleeca(60000, 1)
    local ply = PlayerId()
    local dooropentime = 2000
    local dist = GetDistanceBetweenCoords(pos, 881.27, -2267.87, 32.44, 176.87)
    
    QBCore.Functions.TriggerCallback("QBCore:HasItem", function(HasItem)
            if HasItem then
                if dist < 1.5 then
                    if minigame then
                        print("111111111")
                        StopAnimTask(PlayerPedId(), hackAnimDict, "hack_loop", 1.0)
                        TriggerEvent('qb-robbery:darkmail')
                        print("2222222222222")
                        Citizen.SetTimeout(dooropentime, function()
                            TriggerEvent("qb-robbery:startheist")
                        end)
                        
                        
                    else
                        print("333333333333333")
                    end
                end
            end
    end, "blue_laptop")
end)

RegisterNetEvent('qb-robbery:bossdoor', function()
    QBCore.Functions.TriggerCallback("QBCore:HasItem", function(HasItem)
        local dist = GetDistanceBetweenCoords(pos, -104.17, 6473.95, 31.63, 41.22)
        exports["memorygame"]:thermiteminigame(2, 2, 2, 10,
        function()
            
                if HasItem then
                    thermiteanime()
                end
            
        end,
        function()
            
            
        end)
    end, "thermite")
end)

RegisterNetEvent('qb-robbery:laseroff', function()
    exports['vaultcodes']:StartMinigame({
        success = 'test:success',
        fail = 'test:fail',
        numbers=2,
        timer=15
    })
end)


RegisterNetEvent('test:success')
AddEventHandler('test:success', function()
    activateLasers(false)
end)

RegisterNetEvent('test:fail')
AddEventHandler('test:fail', function()
    print('ridi')
end)

exports['qb-target']:AddBoxZone("boos_door", vector3(-105.11, 6478.84, 31.63), 2, 1, {
    name="boos_door",
    heading=135,
    --debugPoly=true,
    minZ=28.43,
    maxZ=32.43
}, {
    options = {
        {
        event = "qb-robbery:laseroff",
        icon = "far fa-clipboard",
        label = "Hack Lasers(Turn Them off)",
        },
    },
    distance = 3.5
})

RegisterNetEvent("qb-robbery:startheist", function(data, name)
    currentname = name
    Citizen.Wait(1000)
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    currentname = name
    SpawnTrolleys(data, name)
end)

local laserDrawDistancePoint = vector3(-101.622, 6464.872, 34.024)
local laserStartPoints = {
    vector3(-100.072, 6466.052, 33.704),
    vector3(-101.946, 6465.052, 34.024),
    vector3(-100.776, 6466.756, 32.122),
    vector3(-103.306, 6463.628, 33.584),
}
local laserGridPoints = {
    vector3(-103.73, 6464.054, 30.78),
    vector3(-102.096, 6465.402, 30.634),
    vector3(-102.784, 6464.004, 30.634),
    vector3(-100.494, 6466.474, 30.698),
}



RegisterNetEvent("sv-heists:cityPowerState")
AddEventHandler("sv-heists:cityPowerState", function(state)
    cityPowerState = state
end)

Citizen.CreateThread(function()
    for k, coords in pairs(laserStartPoints) do
        local cLaser = Laser.new(coords, laserGridPoints, {
            travelTimeBetweenTargets = {1.0, 4.0},
            waitTimeAtTargets = {0.0, 1.0},
            randomTargetSelection = true,
            name = "laser_" .. tostring(k),
            color = {255, 0, 0, 150}
        })
        lasers[#lasers + 1] = cLaser
    end

    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        if not lasersActive and not IS_LOWER_VAULT_ON_COOLDOWN and cityPowerState  then
            lasersActive = true
            activateLasers(true)
            Movement(false)
            Visible(true)
        elseif lasersActive and not cityPowerState then
            lasersActive = false
            activateLasers(false)
        end
        Citizen.Wait(5000)
    end
end)

RegisterCommand('testbank', function()
    TriggerEvent("qb-robbery:bossdoor")
end)
