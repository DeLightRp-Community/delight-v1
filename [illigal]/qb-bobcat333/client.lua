local QBCore = exports['qb-core']:GetCoreObject()

local pedSpawned = false

local looted1 = false
local looted2 = false
local looted3 = false

local killedpeds = false

Citizen.CreateThread(function()
    RequestIpl("prologue06_int")
    local interiorid = GetInteriorAtCoords(883.4142, -2282.372, 31.44168)
    ActivateInteriorEntitySet(interiorid, "np_prolog_clean")
    DeactivateInteriorEntitySet(interiorid, "np_prolog_broken")
    RefreshInterior(interiorid)
end)

-- Minigame and Heist Starting 

RegisterNetEvent('sd-bobcat:startHeist', function() 
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    QBCore.Functions.TriggerCallback("sd-bobcat:server:getCops", function(enoughCops)  
        if enoughCops >= Config.MinimumPolice then   
            QBCore.Functions.TriggerCallback("sd-bobcat:server:cooldown", function(cooldown)  
                if not cooldown then
                    if #(coords - Config.FirstDoor) < 2.0 then  
                        exports["memorygame"]:thermiteminigame(12, 4, 4, 120, function() 
                            firstDoor()
                            policeAlert()
                        end, function() 
                            if Config.RemoveThermiteOnFail then
                            TriggerServerEvent("QBCore:Server:RemoveItem", "thermite", 1) 
                            end
                            QBCore.Functions.Notify('You failed!', "error")
                        end) 
                    elseif #(coords - Config.SecondDoor) < 2.0 then      
                        exports["memorygame"]:thermiteminigame(12, 4, 4, 120, function() 
                            secondDoor() 
                            policeAlert()
                            if Config.RemoveThermiteOnFail then
                                TriggerServerEvent("QBCore:Server:RemoveItem", "thermite", 1) 
                            end
                            TriggerServerEvent('sd-bobcat:server:startCooldown')
                            print('cooldown started')
                        end, function() 
                            QBCore.Functions.Notify('You failed!', "error")
                        end) 
                    end
                else
                    QBCore.Functions.Notify('This place has been robbed recently!', 'error')
                end
            end)
            
        else
            QBCore.Functions.Notify('Not enough cops!', 'error')
        end
    end)
end)

-- Police Alert

function policeAlert()
	-- exports['qb-dispatch']:BankRobbery() -- Project-SLoth qb-dispatch
	-- TriggerServerEvent('police:server:policeAlert', 'Bobcat Robbery') -- Regular qbcore
    -- These are just examples, you'll have to implement your own police alert system!
end 


-- Blip Creation

Citizen.CreateThread(function()
	for _, info in pairs(Config.BlipLocation) do
		if Config.UseBlip then
	   		info.blip = AddBlipForCoord(info.x, info.y, info.z)
	   		SetBlipSprite(info.blip, info.id)
	   		SetBlipDisplay(info.blip, 4)
	   		SetBlipScale(info.blip, 0.6)	
	   		SetBlipColour(info.blip, info.colour)
	   		SetBlipAsShortRange(info.blip, true)
	   		BeginTextCommandSetBlipName("STRING")
	   		AddTextComponentString(info.title)
	   		EndTextCommandSetBlipName(info.blip)
	 	end
   	end	
end)

-- Opening Doors 

function firstDoor()
    TriggerServerEvent("QBCore:Server:RemoveItem", "thermite", 1) 
    loadAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 170.52)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(882.1660, -2258.35, 30.54, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 882.1660, -2258.35, 320.54,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomb = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.3,  true,  true, true)

    SetEntityCollision(bomb, false, true)
    AttachEntityToEntity(bomb, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Wait(2000)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomb, 1, 1)
    FreezeEntityPosition(bomb, true)
    TriggerServerEvent("sd-bobcat:particles", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomb)
    StopParticleFxLooped(effect, 0)
    TriggerEvent("sd-bobcat:openFirstDoor") 
end 

function secondDoor() 
    TriggerServerEvent("QBCore:Server:RemoveItem", "thermite", 1) 
    loadAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 170.52)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(880.4080, -2264.50, 30.471, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 880.4080, -2264.50, 30.471,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomb = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.4,  true,  true, true)

    SetEntityCollision(bomb, false, true)
    AttachEntityToEntity(bomb, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Wait(2000)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomb, 1, 1)
    FreezeEntityPosition(bomb, true)
    TriggerServerEvent("sd-bobcat:particles2", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomb)
    StopParticleFxLooped(effect, 0)
	TriggerEvent("sd-bobcat:openSecondDoor")
end

function bombplant()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 79.95)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(890.35430908203,-2285.4541015625,30.441303253174, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 890.35430908203,-2285.4541015625,30.441303253174,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.3,  true,  true, true)

    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(2000)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    TriggerServerEvent("SD-particleserver", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    Citizen.Wait(2000)
    ClearPedTasks(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
end

-- Doorlocks

RegisterNetEvent('sd-bobcat:openFirstDoor', function()  
    Wait(500)
if Config.DoorLock == 'qb' then
    TriggerServerEvent('qb-doorlock:server:updateState', 'bobcatfirst', false, false, false, true, false, false) 
elseif Config.DoorLock == 'nui' then
    TriggerServerEvent('nui_doorlock:server:updateState', 'bobcatfirst', false, false, false, true)

end
end)

RegisterNetEvent('sd-bobcat:openSecondDoor', function()  
    Wait(500)
if Config.DoorLock == 'qb' then
    TriggerServerEvent('qb-doorlock:server:updateState', 'bobcatsecond', false, false, false, true, false, false)
elseif Config.DoorLock == 'nui' then
    TriggerServerEvent('nui_doorlock:server:updateState', 'bobcatsecond', false, false, false, true)

end
end)

local function thirdunlock(success)
    if success then

        if Config.RemoveKeycardOnUse then
            TriggerServerEvent("sd-bobcat:server:removecard")
        end

        TriggerEvent('mhacking:hide')
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped) 
        local id_card = `p_ld_id_card_01`
        RequestModel(id_card)
        while not HasModelLoaded("p_ld_id_card_01") do
            Wait(1)
        end
        SetEntityCoords(ped, Config.ThirdDoor.x, Config.ThirdDoor.y, Config.ThirdDoor.z)
        SetEntityHeading(ped, 174.12)
        idProp = CreateObject(id_card, coords, 1, 1, 0)
        local boneIndex = GetPedBoneIndex(ped, 28422)
        AttachEntityToEntity(idProp, ped, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
        
        loadAnimDict("amb@prop_human_atm@male@enter")
        loadAnimDict("amb@prop_human_atm@male@idle_a")
        TaskPlayAnim(ped, "amb@prop_human_atm@male@enter", "enter", 1.0, 1.0, -1, 49, 0, 0, 0, 0)

        DetachEntity(idProp, false, false)

        Wait(3500) 
        if Config.DoorLock == 'qb' then
        TriggerServerEvent('qb-doorlock:server:updateState', 'bobcatthird', false, false, false, true, false, false)
        elseif Config.DoorLock == 'nui' then
        TriggerServerEvent('nui_doorlock:server:updateState', 'bobcatthird', false, false, false, true)
    end   
        if Config.SpawnGuards then 
            TriggerEvent('sd-bobcat:client:npcSync') 
            print("Peds have been spawned!")
        end
        ClearPedTasks(ped)
        TriggerServerEvent('sd-bobcat:server:vaultsync')  
    else
    TriggerEvent('mhacking:hide')
    end
end

RegisterNetEvent('sd-bobcat:openThirdDoor', function()    
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped) 
    if #(coords - Config.ThirdDoor) < 2.0 then  
        if Config.RemoveKeycardOnFail then
            print('konii')
            TriggerServerEvent("sd-bobcat:server:removecard")
        end
        print('babat')
        Wait(1000)
        TriggerEvent("mhacking:show")
        TriggerEvent("mhacking:start", math.random(2, 11), 25, thirdunlock)
    end
end)

RegisterNetEvent('sd-bobcat:client:vaultsync', function()
    killedpeds = true
end)

local guards = {} 

RegisterNetEvent('sd-bobcat:client:npcSync', function()
    SpawnGuards()
end) 


function SpawnGuards()
    ClearAreaOfEverything(894.35, -2278.84, 30.44, 65.34, true, true, true, true)
    local ped = PlayerPedId() 

    SetPedRelationshipGroupHash(ped, GetHashKey("PLAYER"))
    AddRelationshipGroup("Guards")

    for i = 1, #Config.Guards do 
        local guard = Config.Guards[i]
        RequestModel(GetHashKey(guard.ped))
        while not HasModelLoaded(GetHashKey(guard.ped)) do 
            Wait(1)
        end
        guards[i] = CreatePed(4, GetHashKey(guard.ped), guard.pos[1], guard.pos[2], guard.pos[3], guard.pos[4], true, false)  
        SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(guards[i]), true) 
        GiveWeaponToPed(guards[i], GetHashKey(guard.weapon), 255, false, false) 
        SetPedRelationshipGroupHash(guards[i], GetHashKey("Guards"))
        SetPedAccuracy(guards[i], guard.accuracy)
        SetPedArmour(guards[i], guard.armor)
        SetPedFleeAttributes(guards[i], 0, false)
        SetPedCanSwitchWeapon(guards[i], true)
        SetPedDropsWeaponsWhenDead(guards[i], false)
        SetPedAsEnemy(guards[i], true)
        SetPedCombatMovement(guards[i], guard.aggresiveness)
        SetPedAlertness(guards[i], guard.alertness)
        SetPedCombatRange(guards[i], guard.range)
        SetPedSeeingRange(guards[i], 150.0)
        SetPedHearingRange(guards[i], 150.0)
        SetPedCombatAttributes(guards[i], 5000, 1)
        SetPedCanRagdollFromPlayerImpact(guards[i], false)
        SetEntityAsMissionEntity(guards[i])
        SetEntityVisible(guards[i], true)
        SetEntityMaxHealth(guards[i], guard.health)
        SetEntityHealth(guards[i], guard.health) 
        TaskGuardCurrentPosition(guards[i], 5.0, 5.0, 1) 
    end

    SetRelationshipBetweenGroups(0, GetHashKey("Guards"), GetHashKey("Guards"))
    SetRelationshipBetweenGroups(5, GetHashKey("Guards"), GetHashKey("PLAYER"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("Guards"))	
end

-- Particles 

RegisterNetEvent("sd-bobcat:ptfxparticle", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Wait(1)
    end
        ptfx = vector3(882.1320, -2257.34, 30.461)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(4000) 
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent("sd-bobcat:ptfxparticle2", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Wait(1)
    end
        ptfx = vector3(880.49, -2263.60, 30.441)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(4000) 
    StopParticleFxLooped(effect, 0)
end)    

-- Weapon Stash Spawning

RegisterNetEvent('SD-propcreate')
AddEventHandler('SD-propcreate', function()
    local weaponbox = CreateObject(GetHashKey("ex_prop_crate_ammo_sc"), 888.0774, -2287.33, 29.471, true,  true, true)
    CreateObject(weaponbox)
    SetEntityHeading(weaponbox, 176.02)
    FreezeEntityPosition(weaponbox, true)

    local weaponbox2 = CreateObject(GetHashKey("ex_prop_crate_expl_sc"), -1085.58, -1319.79, 5.28, true,  true, true)
    CreateObject(weaponbox2)
    SetEntityHeading(weaponbox2, 352.02)
    FreezeEntityPosition(weaponbox2, true) 

    local weaponbox3 = CreateObject(GetHashKey("ex_prop_crate_expl_bc"), 882.1840, -2286.8, 29.471, true,  true, true)
    CreateObject(weaponbox3)
    SetEntityHeading(weaponbox3, 158.02)
    FreezeEntityPosition(weaponbox3, true) 

    local weaponbox4 = CreateObject(GetHashKey("ex_prop_crate_ammo_bc"), 881.4557, -2282.61, 29.471, true,  true, true)
    CreateObject(weaponbox4)
    SetEntityHeading(weaponbox4, 52.02)
    FreezeEntityPosition(weaponbox4, true)
end)


-- Vault Opening 

RegisterNetEvent('sd-bobcat:client:explosion')
AddEventHandler('sd-bobcat:client:explosion', function()
	Citizen.Wait(7500)
	AddExplosion(890.7849, -2284.88, 32.441, 32, 150000.0, true, false, 4.0)
	AddExplosion(894.0084, -2284.90, 32.580, 32, 150000.0, true, false, 4.0)
    TriggerServerEvent("sd-bobcat:server:explodeVaultDoorSync")
    TriggerServerEvent("sd-bobcat:server:lootsync")
end)

RegisterNetEvent('SD-updateIpls')
AddEventHandler('SD-updateIpls', function()
	local interiorid = GetInteriorAtCoords(883.4142, -2282.372, 31.44168)
	ActivateInteriorEntitySet(interiorid, "np_prolog_broken")
	RemoveIpl(interiorid, "np_prolog_broken")
	DeactivateInteriorEntitySet(interiorid, "np_prolog_clean")
	RefreshInterior(interiorid)

    killedpeds = false
end) 

RegisterNetEvent('sd-bobcat:client:bomb')
AddEventHandler('sd-bobcat:client:bomb', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            bombplant()
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["c4_bomb"], "remove")
            TriggerServerEvent("QBCore:Server:RemoveItem", "c4_bomb", 1) 
            QBCore.Functions.Notify("Explosives has been planted! Get to safe a distance!", 'success')
            Citizen.Wait(1000)
            TriggerEvent("sd-bobcat:client:explosion")
        else
            QBCore.Functions.Notify("You dont have C4!", 'error')
        end
    end, "c4_bomb")
end)

RegisterNetEvent('sd-bobcat:client:resetVault', function()
    print('vault reset')
    RequestIpl("prologue06_int_np")
	local interiorid = GetInteriorAtCoords(883.4142, -2282.372, 31.44168)
	ActivateInteriorEntitySet(interiorid, "np_prolog_clean") 
    DeactivateInteriorEntitySet(interiorid, "np_prolog_broken")
	RefreshInterior(interiorid)
if Config.DoorLock == 'qb' then
    TriggerServerEvent('qb-doorlock:server:updateState', 'bobcatfirst', true, false, false, true, false, false) 
    Wait(500)
    TriggerServerEvent('qb-doorlock:server:updateState', 'bobcatsecond', true, false, false, true, false, false)
    Wait(500)
    TriggerServerEvent('qb-doorlock:server:updateState', 'bobcatthird', true, false, false, true, false, false)
elseif Config.DoorLock == 'nui' then
    TriggerServerEvent('nui_doorlock:server:updateState', 'bobcatfirst', true, false, false, true)
    Wait(500)
    TriggerServerEvent('nui_doorlock:server:updateState', 'bobcatsecond', true, false, false, true)
    Wait(500)
    TriggerServerEvent('nui_doorlock:server:updateState', 'bobcatthird', true, false, false, true)

    looted1 = false
    looted2 = false
    looted3 = false

    killedpeds = false

   end
end)

RegisterNetEvent('sd-bobcat:client:lootsync', function()
    looted1 = true
    looted2 = true
    looted3 = true
end)

RegisterNetEvent('sd-bobcat:client:Smgs', function()
    QBCore.Functions.Progressbar("LootCrate", "Looting Crate", 4500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "creatures@rottweiler@tricks@",
            anim = "petting_franklin",
            flags = 16,
        }, {}, {}, function() -- Done
        TriggerServerEvent('sd-bobcat:giveRandomSmgs')
        TriggerServerEvent('sd-bobcat:server:smgsync')
    end, function()
        QBCore.Functions.Notify('Canceled', 'error', 2500)
    end)
end)

RegisterNetEvent('sd-bobcat:client:smgsync', function()
    looted1 = false
end)

RegisterNetEvent('sd-bobcat:client:Explosives', function()
    QBCore.Functions.Progressbar("LootCrate", "Looting Crate", 4500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "creatures@rottweiler@tricks@",
        anim = "petting_franklin",
        flags = 16,
    }, {}, {}, function() -- Done
        TriggerServerEvent('sd-bobcat:giveRandomExplosives')
        TriggerServerEvent('sd-bobcat:server:explosivesync')
    end, function()
        QBCore.Functions.Notify('Canceled', 'error', 2500)
    end)
end)

RegisterNetEvent('sd-bobcat:client:explosivesync', function()
    looted2 = false
end)

RegisterNetEvent('sd-bobcat:client:Rifles', function()
    QBCore.Functions.Progressbar("LootCrate", "Looting Crate", 4500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "creatures@rottweiler@tricks@",
        anim = "petting_franklin",
        flags = 16,
    }, {}, {}, function() -- Done
        TriggerServerEvent('sd-bobcat:giveRandomRifles') 
        TriggerServerEvent('sd-bobcat:server:riflesync')
    end, function()
        QBCore.Functions.Notify('Canceled', 'error', 2500)
    end)
end)

RegisterNetEvent('sd-bobcat:client:riflesync', function()
    looted3 = false
end)

-- Target Export 
            exports["qb-target"]:AddCircleZone("boom", vector3(890.36480712891,-2284.8154296875,32.441284179688), 2.0, {
                name ="boom",
                useZ = true,
                --debugPoly=true
                }, {
                    options = {
                        {
                            event = "sd-bobcat:client:bomb",
                            icon = "fas fa-bomb",
                            label = "Plant Explosives",

                            canInteract = function()
                                if killedpeds then return true else return false end 
                            end
                        }
                     },
                    distance = 2.1
                })

                exports["qb-target"]:AddCircleZone("smg", vector3(881.33, -2282.6, 31.47), 2.0, {
                    name = "smgs",
                    useZ = true,
                    --debugPoly=true
                    }, {
                        options = {
                            {
                                type = "client",
                                event = "sd-bobcat:client:Smgs",
                                icon = "fas fa-box",
                                label = "Take Weapons",

                                canInteract = function()
                                    if looted1 then return true else return false end 
                                end
                            },
                         },
                        distance = 2.1
                    })

                    exports["qb-target"]:AddCircleZone("explosives", vector3(882.29, -2286.37, 30.87), 2.0, {
                        name = "explosives",
                        useZ = true,
                        --debugPoly=true
                        }, {
                            options = {
                                {
                                    type = "client",
                                    event = "sd-bobcat:client:Explosives",
                                    icon = "fas fa-box",
                                    label = "Take Weapons",

                                    canInteract = function()
                                        if looted2 then return true else return false end 
                                    end
                                },
                             },
                            distance = 2.1
                        })

                        exports["qb-target"]:AddCircleZone("Rifles", vector3(888.04, -2287.1, 30.87), 2.0, {
                            name = "Rifles",
                            useZ = true,
                            --debugPoly=true
                            }, {
                                options = {
                                    {
                                        type = "client",
                                        event = "sd-bobcat:client:Rifles",
                                        icon = "fas fa-box",
                                        label = "Take Weapons",

                                        canInteract = function()
                                            if looted3 then return true else return false end 
                                        end
                                    },
                                 },
                                distance = 2.1
                            })

-- Load Anim Dict  

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end 


