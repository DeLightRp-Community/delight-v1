-- Variables
QBCore = exports['qb-core']:GetCoreObject()
isHandcuffed = false
cuffType = 1
isEscorted = false
draggerId = 0
PlayerJob = {}
onDuty = false
local DutyBlips = {}

-- Functions
local function CreateDutyBlips(playerId, playerLabel, playerJob, playerGrade, playerLocation)
    local ped = GetPlayerPed(playerId)
    local blip = GetBlipFromEntity(ped)
    if not DoesBlipExist(blip) then
        if NetworkIsPlayerActive(playerId) then
            blip = AddBlipForEntity(ped)
        else
            blip = AddBlipForCoord(playerLocation.x, playerLocation.y, playerLocation.z)
        end
        SetBlipSprite(blip, 1)
        ShowHeadingIndicatorOnBlip(blip, true)
        SetBlipRotation(blip, math.ceil(playerLocation.w))
        SetBlipScale(blip, 1.0)
        local playerGrade = playerGrade.level
        if playerJob == "police" then
            if playerGrade == 0 then
                SetBlipColour(blip, 39)
            elseif playerGrade>= 1 and playerGrade<=11 then
                SetBlipColour(blip, 38)
            elseif playerGrade>=12 and playerGrade<=22 then
                SetBlipColour(blip, 47)
            elseif playerGrade>=23 and playerGrade<=31 then
                SetBlipColour(blip, 25)
            elseif playerGrade>=31 and playerGrade<=38 then
                SetBlipColour(blip, 18)
            elseif playerGrade==39 then
                SetBlipColour(blip, 72)
            end
            -- SetBlipColour(blip, 72)
        else
            SetBlipColour(blip, 1)
        end
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(playerLabel)
        EndTextCommandSetBlipName(blip)
        DutyBlips[#DutyBlips+1] = blip
    end

    if GetBlipFromEntity(PlayerPedId()) == blip then
        -- Ensure we remove our own blip.
        RemoveBlip(blip)
    end
end

-- Events
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job
    onDuty = player.job.onduty
    isHandcuffed = false
    TriggerServerEvent("QBCore:Server:SetMetaData", "ishandcuffed", false)
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    TriggerServerEvent("police:server:UpdateBlips")
    TriggerServerEvent("police:server:UpdateCurrentCops")

    if player.metadata.tracker then
        local trackerClothingData = {
            outfitData = {
                ["accessory"] = {
                    item = 13,
                    texture = 0
                }
            }
        }
        TriggerEvent('qb-clothing:client:loadOutfit', trackerClothingData)
    else
        local trackerClothingData = {
            outfitData = {
                ["accessory"] = {
                    item = -1,
                    texture = 0
                }
            }
        }
        TriggerEvent('qb-clothing:client:loadOutfit', trackerClothingData)
    end

    if PlayerJob and PlayerJob.name ~= "police" then
        if DutyBlips then
            for k, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    TriggerServerEvent('police:server:UpdateBlips')
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    TriggerServerEvent("police:server:UpdateCurrentCops")
    isHandcuffed = false
    isEscorted = false
    onDuty = false
    ClearPedTasks(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
    if DutyBlips then
        for k, v in pairs(DutyBlips) do
            RemoveBlip(v)
        end
        DutyBlips = {}
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    if JobInfo.name == "police" and PlayerJob.name ~= "police" then
        if JobInfo.onduty then
            TriggerServerEvent("QBCore:ToggleDuty")
            onDuty = false
        end
    end

    if JobInfo.name ~= "police" then
        if DutyBlips then
            for k, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
    end
    PlayerJob = JobInfo
    TriggerServerEvent("police:server:UpdateBlips")
end)

RegisterNetEvent('police:client:sendBillingMail', function(amount)
    SetTimeout(math.random(2500, 4000), function()
        local gender = Lang:t('info.mr')
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = Lang:t('info.mrs')
        end
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Lang:t('email.sender'),
            subject = Lang:t('email.subject'),
            message = Lang:t('email.message', {value = gender, value2 = charinfo.lastname, value3 = amount}),
            button = {}
        })
    end)
end)

RegisterNetEvent('police:client:UpdateBlips', function(players)
    -- print(json.encode(players))
    if PlayerJob and (PlayerJob.name == 'police' or PlayerJob.name == 'ambulance') and
        onDuty then
        if DutyBlips then
            for k, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
        if players then
            for k, data in pairs(players) do
                local id = GetPlayerFromServerId(data.source)
                CreateDutyBlips(id, data.label, data.job, data.grade, data.location)

            end
        end
    end
end)

RegisterNetEvent('police:client:policeAlert', function(coords, text)
    local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street1name = GetStreetNameFromHashKey(street1)
    local street2name = GetStreetNameFromHashKey(street2)
    QBCore.Functions.Notify({text = text, caption = street1name.. ' ' ..street2name}, 'police')
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blip2 = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blipText = Lang:t('info.blip_text', {value = text})
    SetBlipSprite(blip, 60)
    SetBlipSprite(blip2, 161)
    SetBlipColour(blip, 1)
    SetBlipColour(blip2, 1)
    SetBlipDisplay(blip, 4)
    SetBlipDisplay(blip2, 8)
    SetBlipAlpha(blip, transG)
    SetBlipAlpha(blip2, transG)
    SetBlipScale(blip, 0.8)
    SetBlipScale(blip2, 2.0)
    SetBlipAsShortRange(blip, false)
    SetBlipAsShortRange(blip2, false)
    PulseBlip(blip2)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(blipText)
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
        Wait(180 * 4)
        transG = transG - 1
        SetBlipAlpha(blip, transG)
        SetBlipAlpha(blip2, transG)
        if transG == 0 then
            RemoveBlip(blip)
            return
        end
    end
end)

RegisterNetEvent('police:client:SendToJail', function(time)
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    isHandcuffed = false
    isEscorted = false
    ClearPedTasks(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
    TriggerEvent("prison:client:Enter", time)
end)

RegisterNetEvent('police:client:SendPoliceEmergencyAlert', function()
    local Player = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('police:server:policeAlert', Lang:t('info.officer_down', {lastname = Player.charinfo.lastname, callsign = Player.metadata.callsign}))
    TriggerServerEvent('hospital:server:ambulanceAlert', Lang:t('info.officer_down', {lastname = Player.charinfo.lastname, callsign = Player.metadata.callsign}))
end)



-- Threads
CreateThread(function()
    for k, station in pairs(Config.Locations["stations"]) do
        local blip = AddBlipForCoord(station.coords.x, station.coords.y, station.coords.z)
        SetBlipSprite(blip, 60)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 29)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(station.label)
        EndTextCommandSetBlipName(blip)
    end
end)


local showWatch = false
RegisterNetEvent('qb-smallrecources:useSmartWatch', function()
    QBCore.Functions.Notify("You are Using Your Smart Watch")
	if showWatch then
        TriggerServerEvent("qb-policejob:server:useSmartWatch", showWatch)
    else
        TriggerServerEvent("qb-policejob:server:useSmartWatch", showWatch)  
    end
    showWatch= not showWatch
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent('qb-police:remmask')
AddEventHandler('qb-police:remmask', function(t)
    t, distance = QBCore.Functions.GetClosestPlayer()
    if (distance ~= -1 and distance < 5) then
        if not IsPedInVehicle(t,GetVehiclePedIsIn(t, false),false) then
            TriggerServerEvent("police:remmaskGranted", Player(t))
            
            AnimSet = "mp_missheist_ornatebank"
            AnimationOn = "stand_cash_in_bag_intro"
            AnimationOff = "stand_cash_in_bag_intro"
            loadAnimDict(AnimSet)
            TaskPlayAnim( PlayerPedId(), AnimSet, AnimationOn, 8.0, -8, -1, 49, 0, 0, 0, 0 )
        
            ClearPedTasks(PlayerPedId())
        end
    else
        QBCore.Functions.Notify("No player near you (maybe get closer)!")
    end
end)

RegisterNetEvent('police:remmaskAccepted')
AddEventHandler('police:remmaskAccepted', function()

	TriggerEvent("facewear:adjust", 1, true)
	TriggerEvent("facewear:adjust", 3, true)
	TriggerEvent("facewear:adjust", 4, true)
	TriggerEvent("facewear:adjust", 2, true)
end)


local facialWear = {
	[1] = { ["Prop"] = -1, ["Texture"] = -1 },
	[2] = { ["Prop"] = -1, ["Texture"] = -1 },
	[3] = { ["Prop"] = -1, ["Texture"] = -1 },
	[4] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- this is actually a pedtexture variations, not a prop
	[5] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- this is actually a pedtexture variations, not a prop
	[6] = { ["Prop"] = -1, ["Palette"] = -1, ["Texture"] = -1 }, -- this is actually a pedtexture variations, not a prop
}

RegisterNetEvent("facewear:adjust")
AddEventHandler("facewear:adjust",function(faceType,remove)
	local AnimSet = "none"
	local AnimationOn = "none"
	local AnimationOff = "none"
	local PropIndex = 0

	local AnimSet = "mp_masks@on_foot"
	local AnimationOn = "put_on_mask"
	local AnimationOff = "put_on_mask"

	facialWear[6]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 0)
	facialWear[6]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 0)
	facialWear[6]["Texture"] = GetPedTextureVariation(PlayerPedId(), 0)

	for i = 0, 3 do
		if GetPedPropIndex(PlayerPedId(), i) ~= -1 then
			facialWear[i+1]["Prop"] = GetPedPropIndex(PlayerPedId(), i)
		end
		if GetPedPropTextureIndex(PlayerPedId(), i) ~= -1 then
			facialWear[i+1]["Texture"] = GetPedPropTextureIndex(PlayerPedId(), i)
		end
	end

	if GetPedDrawableVariation(PlayerPedId(), 1) ~= -1 then
		facialWear[4]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 1)
		facialWear[4]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 1)
		facialWear[4]["Texture"] = GetPedTextureVariation(PlayerPedId(), 1)
	end

	if GetPedDrawableVariation(PlayerPedId(), 11) ~= -1 then
		facialWear[5]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 11)
		facialWear[5]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 11)
		facialWear[5]["Texture"] = GetPedTextureVariation(PlayerPedId(), 11)
	end

	if faceType == 1 then
		PropIndex = 0
	elseif faceType == 2 then
		PropIndex = 1

		AnimSet = "clothingspecs"
		AnimationOn = "take_off"
		AnimationOff = "take_off"

	elseif faceType == 3 then
		PropIndex = 2
	elseif faceType == 4 then
		PropIndex = 1
		if remove then
			AnimSet = "missfbi4"
			AnimationOn = "takeoff_mask"
			AnimationOff = "takeoff_mask"
		end
	elseif faceType == 5 then
		PropIndex = 11
		AnimSet = "oddjobs@basejump@ig_15"
		AnimationOn = "puton_parachute"
		AnimationOff = "puton_parachute"	
		--mp_safehouseshower@male@ male_shower_idle_d_towel
		--mp_character_creation@customise@male_a drop_clothes_a
		--oddjobs@basejump@ig_15 puton_parachute_bag
	end

	loadAnimDict( AnimSet )
	if faceType == 5 then
		if remove then
			SetPedComponentVariation(PlayerPedId(), 3, 2, facialWear[6]["Texture"], facialWear[6]["Palette"])
		end
	end
	if remove then
		TaskPlayAnim( PlayerPedId(), AnimSet, AnimationOff, 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
		Citizen.Wait(500)
		if faceType ~= 5 then
			if faceType == 4 then
				SetPedComponentVariation(PlayerPedId(), PropIndex, -1, -1, -1)
			else
				if faceType ~= 2 then
					ClearPedProp(PlayerPedId(), tonumber(PropIndex))
				end
			end
		end
	else
		TaskPlayAnim( PlayerPedId(), AnimSet, AnimationOn, 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
		Citizen.Wait(500)
		if faceType ~= 5 and faceType ~= 2 then
			if faceType == 4 then
				SetPedComponentVariation(PlayerPedId(), PropIndex, facialWear[faceType]["Prop"], facialWear[faceType]["Texture"], facialWear[faceType]["Palette"])
			else
				SetPedPropIndex( PlayerPedId(), tonumber(PropIndex), tonumber(facialWear[PropIndex+1]["Prop"]), tonumber(facialWear[PropIndex+1]["Texture"]), false)
			end
		end
	end
	if faceType == 5 then
		if not remove then
			SetPedComponentVariation(PlayerPedId(), 3, 1, facialWear[6]["Texture"], facialWear[6]["Palette"])
			SetPedComponentVariation(PlayerPedId(), PropIndex, facialWear[faceType]["Prop"], facialWear[faceType]["Texture"], facialWear[faceType]["Palette"])
		else
			SetPedComponentVariation(PlayerPedId(), PropIndex, -1, -1, -1)
		end
		Citizen.Wait(1800)
	end
	if faceType == 2 then
		Citizen.Wait(600)
		if remove then
			ClearPedProp(PlayerPedId(), tonumber(PropIndex))
		end

		if not remove then
			Citizen.Wait(140)
			SetPedPropIndex( PlayerPedId(), tonumber(PropIndex), tonumber(facialWear[PropIndex+1]["Prop"]), tonumber(facialWear[PropIndex+1]["Texture"]), false)
		end
	end
	if faceType == 4 and remove then
		Citizen.Wait(1200)
	end
	ClearPedTasks(PlayerPedId())
end)