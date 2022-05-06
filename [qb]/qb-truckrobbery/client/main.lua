local QBCore = exports['qb-core']:GetCoreObject()
local VehicleSpawn1 = vector3(-1327.479736328, -86.045326232910, 49.31)  		--<< below the coordinates for random vehicle responses
local VehicleSpawn2 = vector3(-2075.888183593, -233.73908996580, 21.10)
local VehicleSpawn3 = vector3(-972.1781616210, -1530.9045410150, 4.890)
local VehicleSpawn4 = vector3(798.18426513672, -1799.8173828125, 29.33)
local VehicleSpawn5 = vector3(1247.0718994141, -344.65634155273, 69.08)
local DriverWep = "WEAPON_MICROSMG" 		--<< the weapon the driver is to be equipped with
local NavWep = "WEAPON_MICROSMG"  			--<< the weapon the guard should be equipped with
local NavWepsoc = "WEAPON_CARBINERIFLE"
local TimeToBlow = 30 * 1000 				--<< bomb detonation time after planting, default 20 seconds
local PickupMoney = 0
local BlowBackdoor = 0
local SilenceAlarm = 0
local PoliceAlert = 0
local PoliceBlip = 0
local moneyCalc = 1
local LootTime = 1
local GuardsDead = 0
local prop
local lootable = 0
local BlownUp = 0
local TruckBlip
local transport
local MissionStart = 0
local warning = 0
local VehicleCoords = nil
local dealer
local PlayerJob = {}
local CurrentCops = 0

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

--[[function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, 20000)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end]]

--Ped spawn and mission accept
--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = #(plyCoords - vector3(MissionMarker.x, MissionMarker.y, MissionMarker.z))

			if dist <= 25.0  then
				if not DoesEntityExist(dealer) then
				RequestModel("s_m_y_dealer_01")
				while not HasModelLoaded("s_m_y_dealer_01") do
				Wait(10)
				end
				dealer = CreatePed(26, "s_m_y_dealer_01", dealerCoords.x, dealerCoords.y, dealerCoords.z, 268.9422, false, false)
				SetEntityHeading(dealer, 1.8)
				SetBlockingOfNonTemporaryEvents(dealer, true)
				TaskStartScenarioInPlace(dealer, "WORLD_HUMAN_AA_SMOKE", 0, false)
				end
				DrawMarker(25, MissionMarker.x, MissionMarker.y, MissionMarker.z-0.90, 0, 0, 0, 0, 0, 0, 1.301, 1.3001, 1.3001, 0, 205, 250, 200, 0, 0, 0, 0)
			else
			Citizen.Wait(1500)
			end

            if dist <= 1.0 then
				DrawText3D(MissionMarker.x, MissionMarker.y, MissionMarker.z, "~g~[E]~b~ To accept missions")
				if IsControlJustPressed(0, 38) then
				TriggerServerEvent("AttackTransport:akceptujto")
				Citizen.Wait(500)
				end
            end

	end
end)]]
---

function anim()
    Citizen.Wait(1000)
	local display = true
    if display then
        print('hi')
        local playerPed = PlayerPedId()
        print('here')
        local dict = "amb@world_human_seat_wall_tablet@female@base"
        RequestAnimDict(dict)
        if tabletObject == nil then
            tabletObject = CreateObject(GetHashKey('prop_cs_tablet'), GetEntityCoords(playerPed), 1, 1, 1)
            AttachEntityToEntity(tabletObject, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.03, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        end
        while not HasAnimDictLoaded(dict) do Citizen.Wait(100) end
        if not IsEntityPlayingAnim(playerPed, dict, 'base', 3) then
            TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
        end
    end
end

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)


RegisterNetEvent('useVPN', function(data)
	local tabletObject = GetHashKey('prop_cs_tablet')
	anim()
	local success =  exports['boostinghack']:StartHack()
	if CurrentCops >= Config.MinimumStoreRobberyPolice then
		if success then
			local ped = PlayerPedId()
			TriggerServerEvent("AttackTransport:akceptujto")
			QBCore.Functions.Notify('you can see the loction in your map', "success")
			StopAnimTask(ped, "amb@world_human_seat_wall_tablet@female@base", "base", 1.0)
			--DeleteEntity(tabletObject)
			deletebase()
			TriggerServerEvent("QBCore:Server:RemoveItem", "vpn", 1)
				TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["vpn"], "remove")
		else
			local ped = PlayerPedId()
			--DeleteEntity(tabletObject)
			deletebase()
			StopAnimTask(ped, "amb@world_human_seat_wall_tablet@female@base", "base", 1.0)
			local chance = math.random(1,10)

			QBCore.Functions.Notify('Failed', "error")
			if chance == 5 then
				TriggerEvent("qb-truckrobbery:notif2")
				QBCore.Functions.Notify('police find out', "error")
				TriggerServerEvent("QBCore:Server:RemoveItem", "vpn", 1)
				TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["vpn"], "remove")
			end

		end
	else
		QBCore.Functions.Notify('not enough police', "error")
	end
	
end)


function deletebase()
    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey("prop_cs_tablet"), false, false, false)
    if object ~= 0 then
        DeleteObject(object)
    end
end

RegisterNetEvent("qb-truckrobbery:notif")
AddEventHandler("qb-truckrobbery:notif", function()
	
    TriggerEvent("qb-armoredtruckheist:client:robberyCall")
end)

RegisterNetEvent("qb-truckrobbery:notif2")
AddEventHandler("qb-truckrobbery:notif2", function()

    TriggerEvent("qb-armoredtruckheist:client:911alert")
end)

function CheckGuards()
	if IsPedDeadOrDying(pilot) == 1 or IsPedDeadOrDying(navigator) == 1 then
		GuardsDead = 1
	end
	Citizen.Wait(500)
end

function AlertPolice()
	local a,b,c = table.unpack(GetEntityCoords(transport))
	local AlertCoordA = tonumber(string.format("%.2f", a))
	local AlertCoordB = tonumber(string.format("%.2f", b))
	local AlertCoordC = tonumber(string.format("%.2f", c))
	TriggerServerEvent('AttackTransport:zawiadompsy', AlertCoordA, AlertCoordB, AlertCoordC)
	Citizen.Wait(500)
end


--[[RegisterNetEvent('AttackTransport:InfoForLspd')
AddEventHandler('AttackTransport:InfoForLspd', function(x, y, z)
	if PlayerJob ~= nil and PlayerJob.name == 'police' then

		if PoliceBlip == 0 then
			PoliceBlip = 1
			local blip = AddBlipForCoord(x, y, z)
			SetBlipSprite(blip, 67)
			SetBlipScale(blip, 1.0)
			SetBlipColour(blip, 2)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Assault on the transport of cash')
			EndTextCommandSetBlipName(blip)
			SetNewWaypoint(x, y)
			Citizen.Wait(10000)
			RemoveBlip(blip)
			PoliceBlip = 0
		end

		local PoliceCoords = GetEntityCoords(PlayerPedId(), false)
		local PoliceDist = #(PoliceCoords - vector3(x, y, z))
		if PoliceDist <= 4.5 then
			local dict = "anim@mp_player_intmenu@key_fob@"

			RequestAnimDict(dict)
			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(100)
			end
			if SilenceAlarm == 0 then
				hintToDisplay('Press ~INPUT_DETONATE~ to silence the alarm')
				SilenceAlarm = 1
			end
			if IsControlPressed(0, 47) and GuardsDead == 1 then

				TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
				TriggerEvent('AttackTransport:CleanUp')
				RemoveBlip(TruckBlip)
				Citizen.Wait(500)
			end
		end

	end
end)]]

RegisterNetEvent('qb-armoredtruckheist:client:911alert')
AddEventHandler('qb-armoredtruckheist:client:911alert', function()
	if PoliceAlert == 0 then
		local transCoords = GetEntityCoords(transport)

		local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, transCoords.x, transCoords.y, transCoords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
		local street1 = GetStreetNameFromHashKey(s1)
		local street2 = GetStreetNameFromHashKey(s2)
		local streetLabel = street1
		if street2 ~= nil then
			streetLabel = streetLabel .. " " .. street2
		end
		exports['qb-dispatch']:VanRobbery()

			TriggerServerEvent("qb-armoredtruckheist:server:callCops", streetLabel, transCoords)

		PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
		PoliceAlert = 1
	end
end)

RegisterNetEvent('qb-armoredtruckheist:client:robberyCall')
AddEventHandler('qb-armoredtruckheist:client:robberyCall', function(streetLabel, coords)
    if PlayerJob.name == "police" then
        local store = "Armored Truck"

            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
			exports['qb-dispatch']:TruckRobbery()

        local transG = 250
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 487)
        SetBlipColour(blip, 4)
        SetBlipDisplay(blip, 4)
        SetBlipAlpha(blip, transG)
        SetBlipScale(blip, 1.2)
        SetBlipFlashes(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("10-90: Armored Truck Robbery")
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

function MissionNotification()
	Citizen.Wait(2000)
	TriggerServerEvent('qb-phone:server:sendNewMail', {
	sender = "The Cartel",
	subject = "New Target",
	message = "just sent you location ... dont fuck up",
	})
	Citizen.Wait(3000)
end
---
--
RegisterNetEvent('AttackTransport:Pozwolwykonac')
AddEventHandler('AttackTransport:Pozwolwykonac', function()
MissionNotification()
ClearPedTasks(dealer)
TaskWanderStandard(dealer, 100,100)
local DrawCoord = math.random(1,5)
if DrawCoord == 1 then
VehicleCoords = VehicleSpawn1
elseif DrawCoord == 2 then
VehicleCoords = VehicleSpawn2
elseif DrawCoord == 3 then
VehicleCoords = VehicleSpawn3
elseif DrawCoord == 4 then
VehicleCoords = VehicleSpawn4
elseif DrawCoord == 5 then
VehicleCoords = VehicleSpawn5
end

RequestModel(GetHashKey('stockade'))
while not HasModelLoaded(GetHashKey('stockade')) do
Citizen.Wait(0)
end

SetNewWaypoint(VehicleCoords.x, VehicleCoords.y)
ClearAreaOfVehicles(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 15.0, false, false, false, false, false)
transport = CreateVehicle(GetHashKey('stockade'), VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 52.0, true, true)
SetEntityAsMissionEntity(transport)
TruckBlip = AddBlipForEntity(transport)
SetBlipSprite(TruckBlip, 57)
SetBlipColour(TruckBlip, 1)
SetBlipFlashes(TruckBlip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString('Truck Van')
EndTextCommandSetBlipName(TruckBlip)
--
RequestModel("s_m_m_security_01")
while not HasModelLoaded("s_m_m_security_01") do
	Wait(10)
end
pilot = CreatePed(26, "s_m_m_security_01", VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 268.9422, true, false)
navigator = CreatePed(26, "s_m_m_security_01", VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 268.9422, true, false)
naviigator = CreatePed(26, "s_m_m_security_01", VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 268.9422, true, false)
naviggator = CreatePed(26, "s_m_m_security_01", VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 268.9422, true, false)
SetPedIntoVehicle(pilot, transport, -1)
SetPedIntoVehicle(navigator, transport, 0)
SetPedIntoVehicle(naviigator, transport, 1)
SetPedIntoVehicle(naviggator, transport, 2)
SetPedFleeAttributes(pilot, 0, 0)
SetPedCombatAttributes(pilot, 46, 1)
SetPedCombatAbility(pilot, 100)
SetPedCombatMovement(pilot, 2)
SetPedCombatRange(pilot, 2)
SetPedKeepTask(pilot, true)
GiveWeaponToPed(pilot, GetHashKey(DriverWep),250,false,true)
SetPedAsCop(pilot, true)
SetPedDropsWeaponsWhenDead(pilot, false)
--
SetPedFleeAttributes(navigator, 0, 0)
SetPedArmour(navigator, 500)
SetPedCombatAttributes(navigator, 46, 1)
SetPedCombatAbility(navigator, 100)
SetPedCombatMovement(navigator, 2)
SetPedCombatRange(navigator, 2)
SetPedKeepTask(navigator, true)
TaskEnterVehicle(navigator,transport,-1,0,1.0,1)
GiveWeaponToPed(navigator, GetHashKey(NavWep),250,false,true)
SetPedAsCop(navigator, true)
SetPedAccuracy(navigator, 100)
TaskCombatPed(navigator, GetPlayerPed(-1))
SetPedDropsWeaponsWhenDead(navigator, false)

--
SetPedFleeAttributes(naviigator, 0, 0)
SetPedArmour(naviigator, 500)
SetPedCombatAttributes(naviigator, 46, 1)
SetPedCombatAbility(naviigator, 100)
SetPedCombatMovement(naviigator, 2)
SetPedCombatRange(naviigator, 2)
SetPedKeepTask(naviigator, true)
TaskEnterVehicle(naviigator,transport,-1,1,1.0,1)
GiveWeaponToPed(naviigator, GetHashKey(NavWepsoc),250,false,true)
SetPedAsCop(naviigator, true)
SetPedAccuracy(naviigator, 100)
TaskCombatPed(naviigator, GetPlayerPed(-1))
SetPedDropsWeaponsWhenDead(naviigator, false)
--
SetPedFleeAttributes(naviggator, 0, 0)
SetPedArmour(naviggator, 500)
SetPedCombatAttributes(naviggator, 46, 1)
SetPedCombatAbility(naviggator, 100)
SetPedCombatMovement(naviggator, 2)
SetPedCombatRange(naviggator, 2)
SetPedKeepTask(naviggator, true)
TaskEnterVehicle(naviggator,transport,-1,2,1.0,1)
GiveWeaponToPed(naviggator, GetHashKey(NavWepsoc),250,false,true)
SetPedAsCop(naviggator, true)
SetPedAccuracy(naviggator, 100)
TaskCombatPed(naviggator, GetPlayerPed(-1))
SetPedDropsWeaponsWhenDead(naviggator, false)
--
TaskVehicleDriveWander(pilot, transport, 80.0, 443)
MissionStart = 1
end)

--Crims side of the mission
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)

		if MissionStart == 1 then
			local plyCoords = GetEntityCoords(PlayerPedId(), false)
			local transCoords = GetEntityCoords(transport)
			local dist = #(plyCoords - transCoords)

			if dist <= 55.0  then
				DrawMarker(0, transCoords.x, transCoords.y, transCoords.z+4.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 135, 31, 35, 100, 1, 0, 0, 0)
				if warning == 0 then
				warning = 1
				QBCore.Functions.Notify("Get rid of the guards before you place the bomb.", "error")
				end

				if GuardsDead == 0 then
					CheckGuards()
				elseif GuardsDead == 1 and BlownUp == 0 then
					AlertPolice()
				end

			else
			Citizen.Wait(500)
			end

			if dist <= 7 and BlownUp == 0 and PlayerJob.name ~= 'police' then
				if BlowBackdoor == 0 then
					--exports['qb-core']:DrawText('Press [G] to blow up the back door and take the money', 'left')
					BlowBackdoor = 1
				end
				if IsControlPressed(0, 47) and GuardsDead == 1 then
					--exports['qb-core']:HideText()
					CheckVehicleInformation()
					TriggerEvent("qb-truckrobbery:notif")					
					Citizen.Wait(500)
				end
			end



		else
		Citizen.Wait(1500)
		end
end
end)

RegisterNetEvent('qb-truckrobbery:plantc4', function(data)
	CheckVehicleInformation()
end)

function CheckVehicleInformation()
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
            
        
	if IsVehicleStopped(transport) then
		if IsVehicleSeatFree(transport, -1) and IsVehicleSeatFree(transport, 0) and IsVehicleSeatFree(transport, 1) and GuardsDead == 1 then
			if not IsEntityInWater(PlayerPedId()) then
				RequestAnimDict('anim@heists@ornate_bank@thermal_charge_heels')
				while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge_heels') do
					Citizen.Wait(50)
				end
				local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
				prop = CreateObject(GetHashKey('prop_c4_final_green'), x, y, z+0.2,  true,  true, true)
				AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.06, 0.0, 0.06, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
				SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"),true)
				FreezeEntityPosition(PlayerPedId(), true)
				TaskPlayAnim(PlayerPedId(), 'anim@heists@ornate_bank@thermal_charge_heels', "thermal_charge", 3.0, -8, -1, 63, 0, 0, 0, 0 )
				Citizen.Wait(5500)
				ClearPedTasks(PlayerPedId())
				DetachEntity(prop)
				deletebasse()
				AttachEntityToEntity(prop, transport, GetEntityBoneIndexByName(transport, 'door_pside_r'), -0.7, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
				QBCore.Functions.Notify('The load will be detonated in '..TimeToBlow / 1000 ..' seconds.', "error")
				FreezeEntityPosition(PlayerPedId(), false)
				Citizen.Wait(TimeToBlow)
				local transCoords = GetEntityCoords(transport)
				SetVehicleDoorBroken(transport, 2, false)
				SetVehicleDoorBroken(transport, 3, false)
				AddExplosion(transCoords.x,transCoords.y,transCoords.z, 'EXP_TAG_BOMB_STANDARD', 3.0, true, false, 2.0, 5.0)
				ApplyForceToEntity(transport, 0, transCoords.x,transCoords.y,transCoords.z, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
				BlownUp = 1
				lootable = 1
				QBCore.Functions.Notify('You can start collecting cash.', "success")
				RemoveBlip(TruckBlip)
				TriggerServerEvent("QBCore:Server:RemoveItem", "tcard", 1)
				TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["tcard"], "remove")
				TriggerServerEvent("QBCore:Server:RemoveItem", "electronickit", 1)
					TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["electronickit"], "remove")
			else
				QBCore.Functions.Notify('Get out of the water', "error")
			end
		else
			QBCore.Functions.Notify('dead body pull them out', "error")
		end
		else
			QBCore.Functions.Notify('You cant rob a vehicle that is moving.', "error")
		end
	else
		QBCore.Functions.Notify('You dont have the right item', 'error', 3500)
	end
end, "tcard")

end

function deletebasse()
    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey("prop_c4_final_green"), false, false, false)
    if object ~= 0 then
        DeleteObject(object)
    end
end

--Crim Client
Citizen.CreateThread(function()
Wait(1000)
local models = {
	"seat_dside_r",
	"seat_pside_r",
}
exports['qb-target']:AddTargetBone(models, {
	options = {
		{
			type = "client",
			event = "qb-truckrobbery:plantc4",
			icon = "fas fa-bomb",
			label = "Plant the C4",
			canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
				if IsPedAPlayer(entity) then return false end -- This will return false if the entity interacted with is a player and otherwise returns true
				if BlownUp == 0 then
					return true
				else
					return false
				end
				
			end,
		},
		{
			type = "client",
			event = "qb-takingmoney",
			icon = "fas fa-bomb",
			label = "Take the money",
			canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
				if IsPedAPlayer(entity) then return false end -- This will return false if the entity interacted with is a player and otherwise returns true
				if BlownUp == 1 then
					return true
				else
					return false
				end
				
			end,
		},
	},
	distance = 4.0
})

end)

RegisterNetEvent('AttackTransport:CleanUp')
AddEventHandler('AttackTransport:CleanUp', function()
	PickupMoney = 0
	BlowBackdoor = 0
	SilenceAlarm = 0
	PoliceAlert = 0
	PoliceBlip = 0
	moneyCalc = 1
	LootTime = 1
	GuardsDead = 0
	lootable = 0
	BlownUp = 0
	MissionStart = 0
	warning = 0
end)

--Crim Client
--[[function TakingMoney()
	RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
	while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
		Citizen.Wait(50)
	end

	local PedCoords = GetEntityCoords(PlayerPedId())
	bag = CreateObject(GetHashKey('prop_cs_heist_bag_02'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(bag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
	TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
	FreezeEntityPosition(PlayerPedId(), true)
	QBCore.Functions.Notify('You are packing cash into a bag', "success")
	local _time = GetGameTimer()
	while GetGameTimer() - _time < 1200000 do
		exports['qb-core']:DrawText('Hold [G] to bail out', 'left')
		if IsControlPressed(0, 47) then
			exports['qb-core']:HideText()
			break
		end
		
		Citizen.Wait(1)
	end
	LootTime = GetGameTimer() - _time
	DeleteEntity(bag)
	deletebassse()
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
	SetPedComponentVariation(PlayerPedId(), 1, 38, 0, 2)
	TriggerServerEvent("AttackTransport:graczZrobilnapad", LootTime)
	TriggerEvent('AttackTransport:CleanUp')
	Citizen.Wait(2500)
end]]

RegisterNetEvent("qb-takingmoney")
AddEventHandler("qb-takingmoney", function()
    
    	
	local PedCoords = GetEntityCoords(PlayerPedId())
	bag = CreateObject(GetHashKey('prop_cs_heist_bag_02'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(bag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
	--TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
	FreezeEntityPosition(PlayerPedId(), true)
	--QBCore.Functions.Notify('You are packing cash into a bag', "success")
				QBCore.Functions.Progressbar("take_money", "Picking up the cash...", 120000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "anim@heists@ornate_bank@grab_cash_heels",
					anim = "grab",
					flags = 36,
				}, {}, {}, function() -- Done
					StopAnimTask(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 1.0)
                    QBCore.Functions.Notify("good work", "success")
					DeleteEntity(bag)
					deletebassse()
	               	FreezeEntityPosition(PlayerPedId(), false)
	               	--SetPedComponentVariation(PlayerPedId(), 5, 98, 0, 2)
				   	TriggerServerEvent("AttackTransport:graczZrobilnapad", LootTime)
	               	TriggerEvent('AttackTransport:CleanUp')
				   	ClearPedTasks(PlayerPedId())
				end, function()
					StopAnimTask(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 1.0)
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
end)

function deletebassse()
    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey("prop_cs_heist_bag_02"), false, false, false)
    if object ~= 0 then
        DeleteObject(object)
    end
end