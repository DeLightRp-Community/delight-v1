--[[
---------------------------------------------------
LUXART VEHICLE CONTROL (FOR FIVEM)
---------------------------------------------------
Last revision: DECEMBER 26 2020 (VERS. 3.0.6)
Coded by Lt.Caine
ELS Clicks by Faction
Additonal Modification by TrevorBarns
---------------------------------------------------
FILE: client.lua
PURPOSE: Everything Client Side minus UI
---------------------------------------------------
]]

--RUNTIME VARIABLES (Do not touch unless you know what you're doing.) 
--GLOBAL VARIABLES used in both menu.lua and client.lua
show_HUD = hud_first_default							
key_lock = false				
HUD_x_offset = 0
HUD_y_offset = 0
HUD_move_mode = false

tone_PMANU_id = 2
tone_SMANU_id = 3
tone_AUX_id = 1
tone_main_mem_id = nil
tone_main_reset_standby = true
tone_airhorn_intrp = true
park_kill = true

airhorn_button_SFX = false
manu_button_SFX = false
activity_reminder_index = 1
last_activity_timer = 0

button_sfx_scheme = default_sfx_scheme_name
button_sfx_scheme_id = 1
on_volume = default_on_volume	
off_volume = default_off_volume	
upgrade_volume = default_upgrade_volume	
downgrade_volume = default_downgrade_volume
hazards_volume = default_hazards_volume
lock_volume = default_lock_volume
lock_reminder_volume = default_lock_reminder_volume
activity_reminder_volume = default_reminder_volume

veh = nil
playerped = nil
player_is_emerg_driver = false
curr_version =  GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
repo_version = nil

--LOCAL VARIABLES
local siren_string_lookup = { "VEHICLES_HORNS_SIREN_1", 
							  "VEHICLES_HORNS_SIREN_2", 
							  "VEHICLES_HORNS_POLICE_WARNING",
							  "VEHICLES_HORNS_AMBULANCE_WARNING", 
							}
local activity_reminder_lookup = { [2] = 30000, [3] = 60000, [4] = 120000, [5] = 300000, [6] = 600000 } 

local count_bcast_timer = 0
local delay_bcast_timer = 200

local count_sndclean_timer = 0
local delay_sndclean_timer = 400

local actv_ind_timer = false
local count_ind_timer = 0
local delay_ind_timer = 180

local actv_lxsrnmute_temp = false
local srntone_temp = 0
local dsrn_mute = true

local state_indic = {}
local state_lxsiren = {}
local state_pwrcall = {}
local state_airmanu = {}

local ind_state_o = 0
local ind_state_l = 1
local ind_state_r = 2
local ind_state_h = 3

local snd_lxsiren = {}
local snd_pwrcall = {}
local snd_airmanu = {}

TriggerEvent('chat:addSuggestion', '/lvclock', 'Toggle Luxart Vehicle Control Keybinding Lockout.')																								 																						   
----------------THREADED FUNCTIONS----------------
-- Set check variable `player_is_emerg_driver` if player is driver of emergency vehicle.
-- Disables controls faster than previous thread. 
Citizen.CreateThread(function()
	while true do
		playerped = GetPlayerPed(-1)	
		--IS IN VEHICLE
		player_is_emerg_driver = false
		if IsPedInAnyVehicle(playerped, false) then
			veh = GetVehiclePedIsUsing(playerped)	
			--IS DRIVER
			if GetPedInVehicleSeat(veh, -1) == playerped then
				--IS EMERGENCY VEHICLE
				if GetVehicleClass(veh) == 18 then
					player_is_emerg_driver = true
					DisableControlAction(0, 86, true) -- INPUT_VEH_HORN	
					DisableControlAction(0, 172, true) -- INPUT_CELLPHONE_UP  
					DisableControlAction(0, 81, true) -- INPUT_VEH_NEXT_RADIO
					DisableControlAction(0, 82, true) -- INPUT_VEH_PREV_RADIO
					DisableControlAction(0, 84, true) -- INPUT_VEH_PREV_RADIO_TRACK  
					DisableControlAction(0, 83, true) -- INPUT_VEH_NEXT_RADIO_TRACK 
					DisableControlAction(0, 19, true) -- INPUT_CHARACTER_WHEEL 
					DisableControlAction(0, 85, true) -- INPUT_VEH_RADIO_WHEEL 
					DisableControlAction(0, 80, true) -- INPUT_VEH_CIN_CAM														 									   								
				end
			end
		end
		Citizen.Wait(1)
	end
end)

-- ParkKill Functionality
Citizen.CreateThread(function()
	while true do
		while park_kill and playerped ~= nil and veh ~= nil do
			if GetIsTaskActive(playerped, 2) then
				if not tone_main_reset_standby and state_lxsiren[veh] ~= 0 then
					tone_main_mem_id = state_lxsiren[veh]
				end
				SetLxSirenStateForVeh(veh, 0)
				SetPowercallStateForVeh(veh, 0)
				SetAirManuStateForVeh(veh, 0)
				count_bcast_timer = delay_bcast_timer
				Citizen.Wait(1000)		
			end
			Citizen.Wait(0)		
		end
		Citizen.Wait(1000)
	end
end)

-- Activity Reminder Functionality
Citizen.CreateThread(function()
	while true do
		while activity_reminder_index > 1 and player_is_emerg_driver do
			if IsVehicleSirenOn(veh) and state_lxsiren[veh] == 0 and state_pwrcall[veh] == 0 then
				if last_activity_timer < 1 then
					TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Reminder", activity_reminder_volume) -- Upgrade
					SetActivityTimer()
				end
			end
			Citizen.Wait(100)
		end
		Citizen.Wait(1000)
	end
end) 

-- Activity Reminder Timer
Citizen.CreateThread(function()
	while true do
		if veh ~= nil then
			while activity_reminder_index > 1 and IsVehicleSirenOn(veh) do
				if last_activity_timer > 1 then
					Citizen.Wait(1000)
					last_activity_timer = last_activity_timer - 1000
				else
					Citizen.Wait(100)
					SetActivityTimer()
				end
			end
		else
			Citizen.Wait(1000)			
		end
		Citizen.Wait(1000)
	end
end)

--------------------------------------------------
-- Move Move UI + Control handling
Citizen.CreateThread(function()
	local HUD_move_lg_increment = 0.0050
	local HUD_move_sm_increment = 0.0001
	while true do 
		--HUD MOVE MODE
		while HUD_move_mode and player_is_emerg_driver do
			ShowText(0.5, 0.75, 0, "~w~HUD Move Mode ~g~enabled~w~. To stop press ~b~Backspace ~w~/~b~ Right-Click ~w~/~b~ Esc~w~.")
			ShowText(0.5, 0.775, 0, "~w~← → left-right ↑ ↓ up-down\nCTRL + Arrow for fine control.")

			--FINE MOVEMENT
			if IsControlPressed(0, 224) then
				if IsDisabledControlPressed(0, 172) then	--Arrow Up
					HUD_y_offset = HUD_y_offset - HUD_move_sm_increment
				end
				if IsDisabledControlPressed(0, 173) then	--Arrow Down
					HUD_y_offset = HUD_y_offset + HUD_move_sm_increment
				end
				if IsDisabledControlPressed(0, 174) then	--Arrow Left
					HUD_x_offset = HUD_x_offset - HUD_move_sm_increment
				end
				if IsDisabledControlPressed(0, 175) then	--Arrow Right
					HUD_x_offset = HUD_x_offset + HUD_move_sm_increment
				end
			--LARGE MOVEMENT
			else
				if IsDisabledControlPressed(0, 172) then	--Arrow Up
					HUD_y_offset = HUD_y_offset - HUD_move_lg_increment
				end
				if IsDisabledControlPressed(0, 173) then	--Arrow Down
					HUD_y_offset = HUD_y_offset + HUD_move_lg_increment
				end
				if IsDisabledControlPressed(0, 174) then	--Arrow Left
					HUD_x_offset = HUD_x_offset - HUD_move_lg_increment
				end
				if IsDisabledControlPressed(0, 175) then	--Arrow Right
					HUD_x_offset = HUD_x_offset + HUD_move_lg_increment
				end
				
				--HANDLE EXIT CONDITION: BACKSPACE / ESC / RIGHT CLICK
				if IsControlPressed(0, 177) then
					TogMoveMode()
				end
			end
			
			--PREVENT HUD FROM LEAVING SCREEN
			if HUD_x_offset > 1 then
				HUD_x_offset = HUD_x_offset - 0.01
			elseif HUD_x_offset < -0.15 then
				HUD_x_offset = HUD_x_offset + 0.01			
			end
			
			if HUD_y_offset > 0.3 then
				HUD_y_offset = HUD_y_offset - 0.01
			elseif HUD_y_offset < -0.75 then
				HUD_y_offset = HUD_y_offset + 0.01			
			end
			Citizen.Wait(0)
		end
		Citizen.Wait(1000)
	end
end)

-- Main HUD UI drawing 
Citizen.CreateThread(function()
	local retrieval, veh_lights, veh_headlights 
	while true do
	
		--Ensure textures have streamed
		while not HasStreamedTextureDictLoaded("commonmenu") do
			RequestStreamedTextureDict("commonmenu", false);
			Citizen.Wait(0)
		end
		
		while show_HUD and player_is_emerg_driver and not IsHudHidden() do
			DrawRect(HUD_x_offset + 0.0828, HUD_y_offset + 0.724, 0.16, 0.06, 26, 26, 26, hud_bgd_opacity)
			if IsVehicleSirenOn(veh) then
				DrawSprite("commonmenu", "lvc_switch_3_hud", HUD_x_offset + 0.025, HUD_y_offset + 0.725, 0.042, 0.06, 0.0, 200, 200, 200, hud_button_on_opacity)									
			else
				DrawSprite("commonmenu", "lvc_switch_1_hud", HUD_x_offset + 0.025, HUD_y_offset + 0.725, 0.042, 0.06, 0.0, 200, 200, 200, hud_button_off_opacity)														
			end
			
			if state_lxsiren[veh] ~= nil then
				if state_lxsiren[veh] > 0 or state_pwrcall[veh] == true then
					DrawSprite("commonmenu", "lvc_siren_on_hud", HUD_x_offset + 0.061, HUD_y_offset + 0.725, 0.0275, 0.05, 0.0, 200, 200, 200, hud_button_on_opacity)				
				else
					DrawSprite("commonmenu", "lvc_siren_off_hud", HUD_x_offset + 0.061, HUD_y_offset + 0.725, 0.0275, 0.05, 0.0, 200, 200, 200, hud_button_off_opacity)										
				end
			else
				DrawSprite("commonmenu", "lvc_siren_off_hud", HUD_x_offset + 0.061, HUD_y_offset + 0.725, 0.0275, 0.05, 0.0, 200, 200, 200, hud_button_off_opacity)										
			end
			
			if IsDisabledControlPressed(0, 86) and not key_lock then
				DrawSprite("commonmenu", "lvc_horn_on_hud", HUD_x_offset + 0.0895, HUD_y_offset + 0.725, 0.0275, 0.05, 0.0, 200, 200, 200, hud_button_on_opacity)												
			else
				DrawSprite("commonmenu", "lvc_horn_off_hud", HUD_x_offset + 0.0895, HUD_y_offset + 0.725, 0.0275, 0.05, 0.0, 200, 200, 200, hud_button_off_opacity)																			
			end
			
			if (IsDisabledControlPressed(0, 80) or IsDisabledControlPressed(0, 81)) and not key_lock then
				if state_lxsiren[veh] > 0 then
					DrawSprite("commonmenu", "lvc_horn_on_hud", HUD_x_offset + 0.0895, HUD_y_offset + 0.725, 0.0275, 0.05, 0.0, 200, 200, 200, hud_button_on_opacity)
				else
					DrawSprite("commonmenu", "lvc_siren_on_hud", HUD_x_offset + 0.061, HUD_y_offset + 0.725, 0.0275, 0.05, 0.0, 200, 200, 200, hud_button_on_opacity)	
				end
			end
			
			retrieval, veh_lights, veh_headlights  = GetVehicleLightsState(veh)
			if veh_lights == 1 and veh_headlights == 0 then
				DrawSprite("commonmenu", "lvc_tkd_off_hud" ,HUD_x_offset + 0.118, HUD_y_offset + 0.725, 0.0275, 0.05, 0.0, 200, 200, 200, hud_button_off_opacity)																			
			elseif (veh_lights == 1 and veh_headlights == 1) or (veh_lights == 0 and veh_headlights == 1) then
				DrawSprite("commonmenu", "lvc_tkd_on_hud", HUD_x_offset + 0.118, HUD_y_offset + 0.725, 0.0275, 0.05, 0.0, 200, 200, 200, hud_button_on_opacity)
			else
				DrawSprite("commonmenu", "lvc_tkd_off_hud", HUD_x_offset + 0.118, HUD_y_offset + 0.725, 0.0275, 0.05, 0.0, 200, 200, 200, hud_button_off_opacity)																			
			end
			
			if key_lock then
				DrawSprite("commonmenu", "lvc_lock_on_hud", HUD_x_offset + 0.1465, HUD_y_offset + 0.725, 0.0275, 0.05, 0.0, 200, 200, 200, hud_button_on_opacity)
			else
				DrawSprite("commonmenu", "lvc_lock_off_hud", HUD_x_offset + 0.1465, HUD_y_offset + 0.725, 0.0275, 0.05, 0.0, 200, 200, 200, hud_button_off_opacity)					
			end
			Citizen.Wait(0)
		end
		Citizen.Wait(1000)
	end
end)

----------------STORAGE MANAGEMENT----------------
--On Spawn Register Keys and Load Settings
AddEventHandler( "playerSpawned", function()
	TriggerServerEvent('lvc_GetVersion_s')
	LoadSettings()
end )

---------------REGISTERED COMMANDS----------------
--Deletes all saved KVPs for that vehicle profile
RegisterCommand('lvcfactoryreset', function(source, args)
	local save_prefix = "lvc_lite_"
	local handle = StartFindKvp(save_prefix);
	local key = FindKvp(handle)
	while key ~= nil do
		DeleteResourceKvp(key)
		print("LVC Info: Deleting Key \"" .. key .. "\"")
		key = FindKvp(handle)
		Citizen.Wait(0)
	end
	ResetSettings()
	print("LVC Info: Successfully cleared all save data.")
	ShowNotification("~g~Success~s~: You have deleted all save data and reset LVC.")
end)


--Toggle LVC lock command
RegisterCommand('lvclock', function(source, args)
	if player_is_emerg_driver then	
		key_lock = not key_lock
		TriggerEvent("lvc:audio", "Key_Lock", lock_volume) 
		--if HUD is visible do not show notification
		if not show_HUD then
			if key_lock then
				ShowNotification("Siren Control Box: ~r~Locked")
			else
				ShowNotification("Siren Control Box: ~g~Unlocked")				
			end
		end
	end
end)

RegisterKeyMapping("lvclock", "LVC: Lock out controls", "keyboard", lockout_default_hotkey)

-- Register Siren Keymaps
function RegisterKeyMaps()
	for i=1, 3 do
		RegisterCommand('_lvc_siren_'..i, function(source, args)
			if veh ~= nil and player_is_emerg_driver ~= nil then
				if IsVehicleSirenOn(veh) and player_is_emerg_driver and not key_lock then
					if state_lxsiren[veh] ~= i or state_lxsiren[veh] == 0 then
						TriggerEvent("lvc:audio", button_sfx_scheme .. "/" ..  "Upgrade", upgrade_volume)
						SetLxSirenStateForVeh(veh, i)
						count_bcast_timer = delay_bcast_timer
					else
						TriggerEvent("lvc:audio", button_sfx_scheme .. "/" ..  "Downgrade", downgrade_volume)
						SetLxSirenStateForVeh(veh, 0)
						count_bcast_timer = delay_bcast_timer				
					end
				end
			end
		end)
	end
	if main_siren_register_keys_set_defaults then
		RegisterKeyMapping('_lvc_siren_1', 'LVC Primary Siren' , "keyboard", '1')		
		RegisterKeyMapping('_lvc_siren_2', 'LVC Secondary Siren' , "keyboard", '2')		
		RegisterKeyMapping('_lvc_siren_3', 'LVC Tertiary Siren' , "keyboard", '3')
	else
		RegisterKeyMapping('_lvc_siren_1', 'LVC Primary Siren' , "keyboard", '')		
		RegisterKeyMapping('_lvc_siren_2', 'LVC Secondary Siren' , "keyboard", '')		
		RegisterKeyMapping('_lvc_siren_3', 'LVC Tertiary Siren' , "keyboard", '')
	end
end

--On resource restart
Citizen.CreateThread(function()
	TriggerServerEvent('lvc_GetVersion_s')
	RegisterKeyMaps()
end)

------------------------------------------------
-------------------FUNCTIONS--------------------
------------------------------------------------
--Toggles HUD
function ShowHUD()
	if not show_HUD then
		show_HUD = true
	end
end

------------------------------------------------
--Resets activity timer
function SetActivityTimer()
	last_activity_timer = activity_reminder_lookup[activity_reminder_index] or 0
end

------------------------------------------------
--On screen GTA V notification
function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, true)
end

------------------------------------------------
--Drawn On Screen Text at X, Y
function ShowText(x, y, align, text, scale)
	scale = scale or 0.4
	SetTextJustification(align)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, scale)
	SetTextColour(128, 128, 128, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
	ResetScriptGfxAlign()
end

------------------------------------------------
--Toggles HUD move mode
function TogMoveMode()
	ShowHUD()
	if HUD_move_mode then		
		HUD_move_mode = false
		Citizen.Wait(100)
		RageUI.Visible(RMenu:Get('lvc', 'hudsettings'), true)
	else					
		HUD_move_mode = true
		RageUI.Visible(RMenu:Get('lvc', 'hudsettings'), false)
	end
end

------------------------------------------------
--Save all settings
function SaveSettings()
	local save_prefix = "lvc_lite_"
	--Set KVP value to indicate there is a save present, if so what version
	SetResourceKvp(save_prefix .. "save_version", curr_version)
	
	--UI Settings
	SetResourceKvpInt(save_prefix .. "HUD",  BoolToInt(show_HUD))
	SetResourceKvpFloat(save_prefix .. "HUD_x_offset",  HUD_x_offset + .0)
	SetResourceKvpFloat(save_prefix .. "HUD_y_offset",  HUD_y_offset + .0)
	SetResourceKvpInt(save_prefix .. "hud_bgd_opacity",  hud_bgd_opacity)
	SetResourceKvpInt(save_prefix .. "hud_button_off_opacity",  hud_button_off_opacity)

	--Siren Specific Settings
	SetResourceKvpInt(save_prefix .. "tone_PMANU_id",  	tone_PMANU_id)
	SetResourceKvpInt(save_prefix .. "tone_SMANU_id",  	tone_SMANU_id)
	SetResourceKvpInt(save_prefix .. "tone_AUX_id",  	tone_AUX_id)
	SetResourceKvpInt(save_prefix .. "park_kill",  BoolToInt(park_kill))
	SetResourceKvpInt(save_prefix .. "tone_airhorn_intrp",  BoolToInt(tone_airhorn_intrp))
	SetResourceKvpInt(save_prefix .. "tone_main_reset_standby", BoolToInt(tone_main_reset_standby))
	
	--Audio Settings
	SetResourceKvpInt(save_prefix .. "button_sfx_scheme_id",  button_sfx_scheme_id)
	SetResourceKvpFloat(save_prefix .. "audio_on_volume",  on_volume + .0)
	SetResourceKvpFloat(save_prefix .. "audio_off_volume",  off_volume + .0)
	SetResourceKvpFloat(save_prefix .. "audio_upgrade_volume",  upgrade_volume + .0)
	SetResourceKvpFloat(save_prefix .. "audio_downgrade_volume",  downgrade_volume + .0)
	SetResourceKvpFloat(save_prefix .. "audio_activity_reminder_volume",  activity_reminder_volume + .0)
	SetResourceKvpFloat(save_prefix .. "audio_hazards_volume",  hazards_volume + .0)
	SetResourceKvpFloat(save_prefix .. "audio_lock_volume",  lock_volume + .0)
	SetResourceKvpFloat(save_prefix .. "audio_lock_reminder_volume",  lock_reminder_volume + .0)
	SetResourceKvpInt(save_prefix  ..  "audio_airhorn_button_SFX",  BoolToInt(airhorn_button_SFX))
	SetResourceKvpInt(save_prefix  ..  "audio_manu_button_SFX",  BoolToInt(manu_button_SFX))
	SetResourceKvpInt(save_prefix  ..  "audio_activity_reminder_index", activity_reminder_index)
	
	ShowNotification("~g~Success~s~: Your settings have been saved.")
end

------------------------------------------------
--Load all settings
function LoadSettings()
	local save_prefix = "lvc_lite_"
	comp_version = GetResourceMetadata(GetCurrentResourceName(), 'compatible', 0)
	save_version = GetResourceKvpString(save_prefix .. "save_version")
	incompatible = IsNewerVersion(comp_version, save_version)
	
	--Is save present if so what version
	if incompatible then
		AddTextEntry("lvc_mismatch_version","~r~~h~Warning:~h~ ~s~Luxart Vehicle Control Save Version Mismatch.\n~b~Compatible Version: " .. comp_version .. "\n~o~Save Version: " .. save_version .. "~s~\nYou may experience issues, to prevent this message from appearing verify settings and resave.")
		SetNotificationTextEntry("lvc_mismatch_version")
		DrawNotification(false, true)
	end
	
	--General Settings
	if save_version ~= nil then
		show_HUD = IntToBool(GetResourceKvpInt(save_prefix .. "HUD"))
		HUD_x_offset = GetResourceKvpFloat(save_prefix .. "HUD_x_offset")
		HUD_y_offset = GetResourceKvpFloat(save_prefix .. "HUD_y_offset")
		hud_bgd_opacity = GetResourceKvpInt(save_prefix .. "hud_bgd_opacity")
		hud_button_off_opacity = GetResourceKvpInt(save_prefix .. "hud_button_off_opacity")
		
		--Profile Specific Settings
		tone_PMANU_id = GetResourceKvpInt(save_prefix .. "tone_PMANU_id")
		tone_SMANU_id = GetResourceKvpInt(save_prefix .. "tone_SMANU_id")
		tone_AUX_id = GetResourceKvpInt(save_prefix ..  "tone_AUX_id")
		tone_airhorn_intrp = IntToBool(GetResourceKvpInt(save_prefix .. "tone_airhorn_intrp"))
		tone_main_reset_standby = IntToBool(GetResourceKvpInt(save_prefix .. "tone_main_reset_standby"))
		park_kill = IntToBool(GetResourceKvpInt(save_prefix .. "park_kill"))

		--Audio Settings
		if ( GetResourceKvpInt(save_prefix .. "button_sfx_scheme_id") ~= nil ) then
			button_sfx_scheme_id = GetResourceKvpInt(save_prefix .. "button_sfx_scheme_id")
		else
			button_sfx_scheme_id = 1
		end
		on_volume 			= GetResourceKvpFloat(save_prefix .. "audio_on_volume")	
		off_volume 			= GetResourceKvpFloat(save_prefix .. "audio_off_volume")		
		upgrade_volume 		= GetResourceKvpFloat(save_prefix .. "audio_upgrade_volume")		
		downgrade_volume	= GetResourceKvpFloat(save_prefix .. "audio_downgrade_volume")	
		activity_reminder_volume = GetResourceKvpFloat(save_prefix .. "audio_activity_reminder_volume")	
		hazards_volume 		= GetResourceKvpFloat(save_prefix .. "audio_hazards_volume")	
		lock_volume 		= GetResourceKvpFloat(save_prefix .. "audio_lock_volume")	
		lock_reminder_volume = GetResourceKvpFloat(save_prefix .. "audio_lock_reminder_volume")
		airhorn_button_SFX 	 = IntToBool(GetResourceKvpInt(save_prefix .. "audio_airhorn_button_SFX"))
		manu_button_SFX 	 = IntToBool(GetResourceKvpInt(save_prefix .. "audio_manu_button_SFX"))
		activity_reminder_index = GetResourceKvpInt(save_prefix  ..  "audio_activity_reminder_index")	
		
		ShowNotification("~g~Success~s~: Your settings have been loaded.")
	end
end

------------------------------------------------
--RESETS ANY SETTINGS IN MENU TO DEFAULT USED WHEN FACTORY RESETTING
function ResetSettings()
	show_HUD = hud_first_default							
	key_lock = false				
	HUD_x_offset = 0
	HUD_y_offset = 0
	HUD_move_mode = false
	hud_bgd_opacity = 155
	hud_button_on_opacity = 255
	hud_button_off_opacity = 175

	tone_PMANU_id = 2
	tone_SMANU_id = 3
	tone_AUX_id = 1
	tone_main_mem_id = nil
	tone_main_reset_standby = true
	tone_airhorn_intrp = true
	park_kill = false

	airhorn_button_SFX = false
	manu_button_SFX = false
	activity_reminder_index = 1
	last_activity_timer = 0

	button_sfx_scheme = default_sfx_scheme_name
	button_sfx_scheme_id = 1
	on_volume = default_on_volume	
	off_volume = default_off_volume	
	upgrade_volume = default_upgrade_volume	
	downgrade_volume = default_downgrade_volume
	hazards_volume = default_hazards_volume
	lock_volume = default_lock_volume
	lock_reminder_volume = default_lock_reminder_volume
	activity_reminder_volume = default_reminder_volume
end

------------------------------------------------
--HELPER FUNCTIONS for main siren settings saving:end
--Compare Version Strings: Is version newer than test_version
function IsNewerVersion(version, test_version)
	if version == nil or test_version == nil then
		return false
	end
	
	_, _, s1, s2, s3 = string.find( version, "(%d+)%.(%d+)%.(%d+)" )
	_, _, c1, c2, c3 = string.find( test_version, "(%d+)%.(%d+)%.(%d+)" )
	
	if s1 > c1 then				-- s1.0.0 Vs c1.0.0
		return true
	elseif s1 < c1 then
		return false
	else
		if s2 > c2 then			-- s1.0.0 Vs c1.0.0
			return true
		elseif s2 < c2 then
			return false
		else
			if s3 > c3 then		-- 0.0.s3 Vs 0.0.c3
				return true
			else
				return false
			end
		end
	end
end

function IntToBool(int_value)
	if int_value == 1 then
		return true
	else
		return false
	end
end

function BoolToInt(bool_value)
	if bool_value then
		return 1
	else
		return 0
	end
end

------------------------------------------------
function useFiretruckSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #eModelsWithFireSrn, 1 do
		if model == GetHashKey(eModelsWithFireSrn[i]) then
			tone_airhorn_intrp = false
			return true
		end
	end
	return false
end

------------------------------------------------
function usePowercallAuxSrn(veh)
	local model = GetEntityModel(veh)
	for i = 1, #eModelsWithPcall, 1 do
		if model == GetHashKey(eModelsWithPcall[i]) then
			return true
		end
	end
	if tone_AUX_id > 4 then
		tone_AUX_id = 1
	end
	return false
end

------------------------------------------------
function CleanupSounds()
	if count_sndclean_timer > delay_sndclean_timer then
		count_sndclean_timer = 0
		for k, v in pairs(state_lxsiren) do
			if v > 0 then
				if not DoesEntityExist(k) or IsEntityDead(k) then
					if snd_lxsiren[k] ~= nil then
						StopSound(snd_lxsiren[k])
						ReleaseSoundId(snd_lxsiren[k])
						snd_lxsiren[k] = nil
						state_lxsiren[k] = nil
					end
				end
			end
		end
		for k, v in pairs(state_pwrcall) do
			if v == true then
				if not DoesEntityExist(k) or IsEntityDead(k) then
					if snd_pwrcall[k] ~= nil then
						StopSound(snd_pwrcall[k])
						ReleaseSoundId(snd_pwrcall[k])
						snd_pwrcall[k] = nil
						state_pwrcall[k] = nil
					end
				end
			end
		end
		for k, v in pairs(state_airmanu) do
			if v == true then
				if not DoesEntityExist(k) or IsEntityDead(k) or IsVehicleSeatFree(k, -1) then
					if snd_airmanu[k] ~= nil then
						StopSound(snd_airmanu[k])
						ReleaseSoundId(snd_airmanu[k])
						snd_airmanu[k] = nil
						state_airmanu[k] = nil
					end
				end
			end
		end
	else
		count_sndclean_timer = count_sndclean_timer + 1
	end
end

------------------------------------------------
function TogIndicStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate == ind_state_o then
			SetVehicleIndicatorLights(veh, 0, false) -- R
			SetVehicleIndicatorLights(veh, 1, false) -- L
		elseif newstate == ind_state_l then
			SetVehicleIndicatorLights(veh, 0, false) -- R
			SetVehicleIndicatorLights(veh, 1, true) -- L
		elseif newstate == ind_state_r then
			SetVehicleIndicatorLights(veh, 0, true) -- R
			SetVehicleIndicatorLights(veh, 1, false) -- L
		elseif newstate == ind_state_h then
			SetVehicleIndicatorLights(veh, 0, true) -- R
			SetVehicleIndicatorLights(veh, 1, true) -- L
		end
		state_indic[veh] = newstate
	end
end

------------------------------------------------
function TogMuteDfltSrnForVeh(veh, toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		DisableVehicleImpactExplosionActivation(veh, toggle)
	end
end

------------------------------------------------
function SetLxSirenStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_lxsiren[veh] then
			if snd_lxsiren[veh] ~= nil then
				StopSound(snd_lxsiren[veh])
				ReleaseSoundId(snd_lxsiren[veh])
				snd_lxsiren[veh] = nil
			end		
			if newstate ~= 0 then
				if useFiretruckSiren(veh) and newstate == 1 then
					TogMuteDfltSrnForVeh(veh, false)	
				else
					snd_lxsiren[veh] = GetSoundId()
					PlaySoundFromEntity(snd_lxsiren[veh], siren_string_lookup[newstate], veh, 0, 0, 0)
					TogMuteDfltSrnForVeh(veh, true)		
				end
			end
			state_lxsiren[veh] = newstate
		end
	end
end
------------------------------------------------
function SetPowercallStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_pwrcall[veh] then
			if snd_pwrcall[veh] ~= nil then
				StopSound(snd_pwrcall[veh])
				ReleaseSoundId(snd_pwrcall[veh])
				snd_pwrcall[veh] = nil
			end
			if newstate ~= 0 then
				snd_pwrcall[veh] = GetSoundId()
				PlaySoundFromEntity(snd_pwrcall[veh], siren_string_lookup[newstate], veh, 0, 0, 0)	
			end
			state_pwrcall[veh] = newstate
		end
	end
end

------------------------------------------------
function SetAirManuStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_airmanu[veh] then
			if snd_airmanu[veh] ~= nil then
				StopSound(snd_airmanu[veh])
				ReleaseSoundId(snd_airmanu[veh])
				snd_airmanu[veh] = nil
			end
			snd_airmanu[veh] = GetSoundId()
			if newstate == 1 then
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_FIRETRUCK_WARNING", veh, 0, 0, 0)				
				else
					PlaySoundFromEntity(snd_airmanu[veh], "SIRENS_AIRHORN", veh, 0, 0, 0)
				end
			elseif newstate ~= 0 then
				PlaySoundFromEntity(snd_airmanu[veh], siren_string_lookup[newstate-1], veh, 0, 0, 0)
			end
			state_airmanu[veh] = newstate
		end
	end
end

------------------------------------------------
----------------EVENT HANDLERS------------------
------------------------------------------------
AddEventHandler('lvc:audio', function(soundFile, soundVolume)
SendNUIMessage({
  transactionType     = 'playSound',
  transactionFile     = soundFile,
  transactionVolume   = soundVolume
})
end)

------------------------------------------------
RegisterNetEvent("lvc_GetVersion_c")
AddEventHandler("lvc_GetVersion_c", function(sender, version)
	repo_version = version
end)

------------------------------------------------
RegisterNetEvent("lvc_TogIndicState_c")
AddEventHandler("lvc_TogIndicState_c", function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= GetPlayerPed(-1) then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogIndicStateForVeh(veh, newstate)
			end
		end
	end
end)



------------------------------------------------
RegisterNetEvent("lvc_TogDfltSrnMuted_c")
AddEventHandler("lvc_TogDfltSrnMuted_c", function(sender, toggle)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= GetPlayerPed(-1) then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogMuteDfltSrnForVeh(veh, toggle)
			end
		end
	end
end)

------------------------------------------------
RegisterNetEvent("lvc_SetLxSirenState_c")
AddEventHandler("lvc_SetLxSirenState_c", function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= GetPlayerPed(-1) then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetLxSirenStateForVeh(veh, newstate)
			end
		end
	end
end)

------------------------------------------------
RegisterNetEvent("lvc_SetPwrcallState_c")
AddEventHandler("lvc_SetPwrcallState_c", function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= GetPlayerPed(-1) then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetPowercallStateForVeh(veh, newstate)
			end
		end
	end
end)

------------------------------------------------
RegisterNetEvent("lvc_SetAirManuState_c")
AddEventHandler("lvc_SetAirManuState_c", function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= GetPlayerPed(-1) then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetAirManuStateForVeh(veh, newstate)
			end
		end
	end
end)
------------------------------------------------

------------------------------------------------
Citizen.CreateThread(function()
	while true do
			CleanupSounds()
			DistantCopCarSirens(false)
			----- IS IN VEHICLE -----
			local playerped = GetPlayerPed(-1)		
			if IsPedInAnyVehicle(playerped, false) then	
				----- IS DRIVER -----
				local veh = GetVehiclePedIsUsing(playerped)	
				if GetPedInVehicleSeat(veh, -1) == playerped then
					if state_indic[veh] ~= ind_state_o and state_indic[veh] ~= ind_state_l and state_indic[veh] ~= ind_state_r and state_indic[veh] ~= ind_state_h then
						state_indic[veh] = ind_state_o
					end
					
					-- INDIC AUTO CONTROL
					if actv_ind_timer == true then	
						if state_indic[veh] == ind_state_l or state_indic[veh] == ind_state_r then
							if GetEntitySpeed(veh) < 6 then
								count_ind_timer = 0
							else
								if count_ind_timer > delay_ind_timer then
									count_ind_timer = 0
									actv_ind_timer = false
									state_indic[veh] = ind_state_o
									TogIndicStateForVeh(veh, state_indic[veh])
									count_bcast_timer = delay_bcast_timer
								else
									count_ind_timer = count_ind_timer + 1
								end
							end
						end
					end
					
					
					--- IS EMERG VEHICLE ---
					if GetVehicleClass(veh) == 18 then
						local actv_manu = false
						local actv_horn = false
						
						DisableControlAction(0, 86, true) -- INPUT_VEH_HORN	
						DisableControlAction(0, 172, true) -- INPUT_CELLPHONE_UP  
						DisableControlAction(0, 81, true) -- INPUT_VEH_NEXT_RADIO
						DisableControlAction(0, 82, true) -- INPUT_VEH_PREV_RADIO
						DisableControlAction(0, 19, true) -- INPUT_CHARACTER_WHEEL 
						DisableControlAction(0, 85, true) -- INPUT_VEH_RADIO_WHEEL 
						DisableControlAction(0, 80, true) -- INPUT_VEH_CIN_CAM 
					
						SetVehRadioStation(veh, "OFF")
						SetVehicleRadioEnabled(veh, false)
						
						if state_lxsiren[veh] ~= 1 and state_lxsiren[veh] ~= 2 and state_lxsiren[veh] ~= 3 and state_lxsiren[veh] ~= 4 then
							state_lxsiren[veh] = 0
						end
						if state_pwrcall[veh] ~= 1 and state_pwrcall[veh] ~= 2 and state_pwrcall[veh] ~= 3 and state_pwrcall[veh] ~= 4 and state_pwrcall[veh] ~= 5 then
							state_pwrcall[veh] = 0
						end
						if state_airmanu[veh] ~= 1 and state_airmanu[veh] ~= 2 and state_airmanu[veh] ~= 3 and state_airmanu[veh] ~= 4 then
							state_airmanu[veh] = 0
						end
						if useFiretruckSiren(veh) and state_lxsiren[veh] == 1 then
							TogMuteDfltSrnForVeh(veh, false)
							dsrn_mute = false
						else
							TogMuteDfltSrnForVeh(veh, true)
							dsrn_mute = true
						end
						
						if not IsVehicleSirenOn(veh) and state_lxsiren[veh] > 0 then
							SetLxSirenStateForVeh(veh, 0)
							count_bcast_timer = delay_bcast_timer
						end
						if not IsVehicleSirenOn(veh) and state_pwrcall[veh] > 0 then
							SetPowercallStateForVeh(veh, 0)
							count_bcast_timer = delay_bcast_timer
						end
					
						----- CONTROLS -----
						if not IsPauseMenuActive() then
							if not key_lock then
								-- TOG DFLT SRN LIGHTS
								if IsDisabledControlJustReleased(0, 85) or IsDisabledControlJustReleased(0, 246) then
									SetActivityTimer() 
									if IsVehicleSirenOn(veh) then
										TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Off", off_volume) -- Off
										SetVehicleSiren(veh, false)
										--If the siren was on, save it in memory
										if state_lxsiren[veh] > 0 and not tone_main_reset_standby then
											tone_main_mem_id = state_lxsiren[veh]
										end
									else
										TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "On", on_volume) -- On
										Citizen.Wait(150)
										SetVehicleSiren(veh, true)
										count_bcast_timer = delay_bcast_timer
									end		
								
								-- TOG LX SIREN
								elseif IsDisabledControlJustReleased(0, 19) or IsDisabledControlJustReleased(0, 82) then
									SetActivityTimer()
									local cstate = state_lxsiren[veh]
									if cstate == 0 then
										if IsVehicleSirenOn(veh) then
											TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Upgrade", upgrade_volume) -- Upgrade
											if not tone_main_reset_standby then
												SetLxSirenStateForVeh(veh, tone_main_mem_id or 1)
											else
												SetLxSirenStateForVeh(veh, 1)
											end											
											count_bcast_timer = delay_bcast_timer
										end
									else
										TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Downgrade", downgrade_volume) -- Downgrade
										if not tone_main_reset_standby then
											tone_main_mem_id = state_lxsiren[veh]
										end
										SetLxSirenStateForVeh(veh, 0)
										count_bcast_timer = delay_bcast_timer
									end
									
								-- POWERCALL
								elseif IsDisabledControlJustReleased(0, 172) and not IsMenuOpen() and not HUD_move_mode then
									SetActivityTimer()
									if state_pwrcall[veh] > 0 then
										TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Downgrade", downgrade_volume) -- Downgrade
										SetPowercallStateForVeh(veh, 0)
										count_bcast_timer = delay_bcast_timer
									else
										if IsVehicleSirenOn(veh) then
											TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Upgrade", upgrade_volume) -- Upgrade
											if usePowercallAuxSrn(veh) then
												SetPowercallStateForVeh(veh, 4)
											else
												SetPowercallStateForVeh(veh, tone_AUX_id)
											end
											count_bcast_timer = delay_bcast_timer
										end
									end
									
								end
								
								-- BROWSE LX SRN TONES
								if state_lxsiren[veh] > 0 then
									if IsDisabledControlJustReleased(0, 80) or IsDisabledControlJustReleased(0, 81) then
										if IsVehicleSirenOn(veh) then
											local cstate = state_lxsiren[veh]
											local nstate = 1
										TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Upgrade", upgrade_volume)
											if cstate == 1 then
												nstate = 2
											elseif cstate == 2 then
												nstate = 3
											else	
												nstate = 1
											end
											SetLxSirenStateForVeh(veh, nstate)
											count_bcast_timer = delay_bcast_timer
										end
									end
								else
								end
											
								-- MANU
								if state_lxsiren[veh] == 0 then
									if IsDisabledControlPressed(0, 80) or (IsDisabledControlPressed(0, 81) and not IsMenuOpen()) then
										SetActivityTimer()
										actv_manu = true
									else
										actv_manu = false
									end
								else
									actv_manu = false
								end
								
								-- HORN
								if IsDisabledControlPressed(0, 86) then
									SetActivityTimer()
									actv_horn = true
								else
									actv_horn = false
								end
								
								--AIRHORN AND MANU BUTTON SFX
								if airhorn_button_SFX then
									if IsDisabledControlJustPressed(0, 86) then
										TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Press", upgrade_volume)									
									end								
									if IsDisabledControlJustReleased(0, 86) then
										TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Release", upgrade_volume)									
									end
								end							
								if manu_button_SFX and state_lxsiren[veh] == 0 then
									if IsDisabledControlJustPressed(0, 80) or IsDisabledControlJustPressed(0, 81) then
										TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Press", upgrade_volume)									
									end								
									if IsDisabledControlJustReleased(0, 80) or IsDisabledControlJustReleased(0, 81) then
										TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Release", upgrade_volume)									
									end
								end
							elseif not HUD_move_mode then
								if (IsDisabledControlJustReleased(0, 86) or 
									IsDisabledControlJustReleased(0, 81) or 
									IsDisabledControlJustReleased(0, 80) or 
									IsDisabledControlJustReleased(0, 81) or
									IsDisabledControlJustReleased(0, 172) or 
									IsDisabledControlJustReleased(0, 19) or 
									IsDisabledControlJustReleased(0, 82) or
									IsDisabledControlJustReleased(0, 85) or 
									IsDisabledControlJustReleased(0, 246)) then
										if locked_press_count % lock_reminder_rate == 0 then
											TriggerEvent("lvc:audio", "Locked_Press", lock_reminder_volume) -- lock reminder
											ShowNotification("~y~~h~Reminder~h~~s~: Your siren control box is ~r~locked~s~.")
										end
										locked_press_count = locked_press_count + 1
								end								
							end
						end
						
						---- ADJUST HORN / MANU STATE ----
						local hmanu_state_new = 0
						if actv_horn == true and actv_manu == false then
							hmanu_state_new = 1
						elseif actv_horn == false and actv_manu == true then
							hmanu_state_new = tone_PMANU_id
						elseif actv_horn == true and actv_manu == true then
							hmanu_state_new = tone_SMANU_id
						end
						
						if tone_airhorn_intrp then
							if hmanu_state_new == 1 then
								if state_lxsiren[veh] > 0 and actv_lxsrnmute_temp == false then
									srntone_temp = state_lxsiren[veh]
									SetLxSirenStateForVeh(veh, 0)
									actv_lxsrnmute_temp = true
								end
							else
								if actv_lxsrnmute_temp == true then
									SetLxSirenStateForVeh(veh, srntone_temp)
									actv_lxsrnmute_temp = false
								end
							end 
						end
						if state_airmanu[veh] ~= hmanu_state_new then
							SetAirManuStateForVeh(veh, hmanu_state_new)
							count_bcast_timer = delay_bcast_timer
						end	
					end

					--- IS ANY LAND VEHICLE ---	
					if GetVehicleClass(veh) ~= 14 and GetVehicleClass(veh) ~= 15 and GetVehicleClass(veh) ~= 16 and GetVehicleClass(veh) ~= 21 then				
						----- CONTROLS -----
						if not IsPauseMenuActive() then						
							-- IND L
							if IsDisabledControlJustReleased(0, left_signal_key) then -- INPUT_VEH_PREV_RADIO_TRACK
								local cstate = state_indic[veh]
								if cstate == ind_state_l then
									state_indic[veh] = ind_state_o
									actv_ind_timer = false
								else
									state_indic[veh] = ind_state_l
									actv_ind_timer = true
								end
								TogIndicStateForVeh(veh, state_indic[veh])
								count_ind_timer = 0
								count_bcast_timer = delay_bcast_timer			
							-- IND R
							elseif IsDisabledControlJustReleased(0, right_signal_key) then -- INPUT_VEH_NEXT_RADIO_TRACK
								local cstate = state_indic[veh]
								if cstate == ind_state_r then
									state_indic[veh] = ind_state_o
									actv_ind_timer = false
								else
									state_indic[veh] = ind_state_r
									actv_ind_timer = true
								end
								TogIndicStateForVeh(veh, state_indic[veh])
								count_ind_timer = 0
								count_bcast_timer = delay_bcast_timer
							-- IND H
							elseif IsControlPressed(0, 194) then -- INPUT_FRONTEND_CANCEL / Backspace
								if GetLastInputMethod(0) then -- last input was with kb
									Citizen.Wait(hazard_hold_duration)
									if IsControlPressed(0, 194) then -- INPUT_FRONTEND_CANCEL / Backspace
										local cstate = state_indic[veh]
										if cstate == ind_state_h then
											state_indic[veh] = ind_state_o
											TriggerEvent("lvc:audio", "Hazards_Off", hazards_volume) -- Hazards On
										else
											state_indic[veh] = ind_state_h
											TriggerEvent("lvc:audio", "Hazards_On", hazards_volume) -- Hazards On
										end
										TogIndicStateForVeh(veh, state_indic[veh])
										actv_ind_timer = false
										count_ind_timer = 0
										count_bcast_timer = delay_bcast_timer
										Citizen.Wait(300)
									end
								end
							end
						end
						
						
						----- AUTO BROADCAST VEH STATES -----
						if count_bcast_timer > delay_bcast_timer then
							count_bcast_timer = 0
							--- IS EMERG VEHICLE ---
							if GetVehicleClass(veh) == 18 then
								TriggerServerEvent("lvc_TogDfltSrnMuted_s", dsrn_mute)
								TriggerServerEvent("lvc_SetLxSirenState_s", state_lxsiren[veh])
								TriggerServerEvent("lvc_SetPwrcallState_s", state_pwrcall[veh])
								TriggerServerEvent("lvc_SetAirManuState_s", state_airmanu[veh])
							end
							--- IS ANY OTHER VEHICLE ---
							TriggerServerEvent("lvc_TogIndicState_s", state_indic[veh])
						else
							count_bcast_timer = count_bcast_timer + 1
						end
					
					end
					
				end
			end
			
		Citizen.Wait(0)
	end
end)
