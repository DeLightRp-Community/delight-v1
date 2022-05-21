--[[
---------------------------------------------------
LUXART VEHICLE CONTROL (FOR FIVEM)
---------------------------------------------------
Last revision: DECEMBER 26 2020 (VERS. 3.0.6)
Coded by Lt.Caine
ELS Clicks by Faction
Additonal Modification by TrevorBarns
---------------------------------------------------
FILE: menu.lua
PURPOSE: Handle RageUI menu stuff
---------------------------------------------------
]]

RMenu.Add('lvc', 'main', RageUI.CreateMenu("Luxart Vehicle Control", "Main Menu"))
RMenu.Add('lvc', 'hudsettings', RageUI.CreateSubMenu(RMenu:Get('lvc', 'main'),"Luxart Vehicle Control", "HUD Settings"))
RMenu.Add('lvc', 'audiosettings', RageUI.CreateSubMenu(RMenu:Get('lvc', 'main'),"Luxart Vehicle Control", "Audio Settings"))
RMenu.Add('lvc', 'saveload', RageUI.CreateSubMenu(RMenu:Get('lvc', 'main'),"Luxart Vehicle Control", "Storage Management"))
RMenu.Add('lvc', 'about', RageUI.CreateSubMenu(RMenu:Get('lvc', 'main'),"Luxart Vehicle Control", "About"))
RMenu:Get('lvc', 'main'):SetTotalItemsPerPage(13)
RMenu:Get('lvc', 'audiosettings'):SetTotalItemsPerPage(12)
RMenu:Get('lvc', 'main'):DisplayGlare(false)
RMenu:Get('lvc', 'saveload'):DisplayGlare(false)
RMenu:Get('lvc', 'hudsettings'):DisplayGlare(false)
RMenu:Get('lvc', 'audiosettings'):DisplayGlare(false)
RMenu:Get('lvc', 'about'):DisplayGlare(false)

local github_index = 1
local hazard_state = false
local confirm_reset_msg
local tone_list = {{ Name = "Wail", Value = 1 },{ Name = "Yelp", Value = 2 },{ Name = "Priority", Value = 3 }}

Keys.Register(open_menu_key, open_menu_key, 'LVC: Open Menu', function()
	if not key_lock and player_is_emerg_driver and UpdateOnscreenKeyboard() ~= 0 then
		RageUI.Visible(RMenu:Get('lvc', 'main'), not RageUI.Visible(RMenu:Get('lvc', 'main')))
	end
end)

--Returns true if any menu is open
function IsMenuOpen()
	return RageUI.Visible(RMenu:Get('lvc', 'main')) or 
	RageUI.Visible(RMenu:Get('lvc', 'hudsettings')) or 
	RageUI.Visible(RMenu:Get('lvc', 'audiosettings')) or 
	RageUI.Visible(RMenu:Get('lvc', 'saveload')) or 
	RageUI.Visible(RMenu:Get('lvc', 'about'))
end

--Handle user input to cancel confirmation message for FACTORY RESET
Citizen.CreateThread(function()
	while true do 
		while not RageUI.Settings.Controls.Back.Enabled do
			for Index = 1, #RageUI.Settings.Controls.Back.Keys do
				if IsDisabledControlJustPressed(RageUI.Settings.Controls.Back.Keys[Index][1], RageUI.Settings.Controls.Back.Keys[Index][2]) then
					confirm_reset_msg = ""
					Citizen.Wait(10)
					RageUI.Settings.Controls.Back.Enabled = true
					break
				end
			end
			Citizen.Wait(0)
		end
		Citizen.Wait(100)
	end
end)

--Handle Disabling Controls while menu open
Citizen.CreateThread(function()
	while true do 
		while IsMenuOpen() do
			DisableControlAction(0, 27, true) 
			DisableControlAction(0, 99, true) 
			DisableControlAction(0, 172, true) 
			DisableControlAction(0, 173, true) 
			DisableControlAction(0, 174, true) 
			DisableControlAction(0, 175, true) 
			Citizen.Wait(0)
		end
		Citizen.Wait(100)
	end
end)

Citizen.CreateThread(function()
    while true do
		--Main Menu Visible
	    RageUI.IsVisible(RMenu:Get('lvc', 'main'), function()
			RageUI.Separator("Siren Settings")		
			if custom_manual_tones_master_switch then
				--PMT List
				RageUI.List('Primary Manual Tone', tone_list, tone_PMANU_id-1, "Change your primary manual tone.", {}, true, {
				  onListChange = function(Index, Item)
					tone_PMANU_id = Item.Value+1;
				  end,
				})
				--SMT List
				RageUI.List('Secondary Manual Tone', tone_list, tone_SMANU_id-1, "Change your secondary manual tone.", {}, true, {
				  onListChange = function(Index, Item)
					tone_SMANU_id = Item.Value+1;
				  end,
				})
			end
			if custom_aux_tones_master_switch then
				--AST List
				RageUI.List('Auxiliary Siren Tone', tone_list, tone_AUX_id, "Change your auxiliary/dual siren tone.", {}, not usePowercallAuxSrn(veh), {
				  onListChange = function(Index, Item)
					tone_AUX_id = Item.Value;
				  end,
				})
			end
			RageUI.Checkbox('Airhorn Interrupt Mode', "Toggles whether the airhorn interupts main siren. Not avaliable on fire apparati.", tone_airhorn_intrp, {Enabled = not useFiretruckSiren(veh)}, {
            onSelected = function(Index)				
                tone_airhorn_intrp = Index
            end	
			})
			RageUI.Checkbox('Reset to Standby', "When enabled, the primary siren will reset to the first siren tone. When disabled, the last played tone will resume.", tone_main_reset_standby, {}, {
            onSelected = function(Index)
				tone_main_reset_standby = Index
            end
            })			
			RageUI.Checkbox('Siren Park Kill', "Toggles whether your sirens turn off automatically when you exit your vehicle. ", park_kill, {}, {
			  onSelected = function(Index)
				  park_kill = Index
			  end
			})
			--Begin HUD Settings
			RageUI.Separator("Other Settings")
			RageUI.Button('HUD Settings', "Open HUD settings menu.", {RightLabel = "→→→"}, true, {
			  onSelected = function()
			  end,
			}, RMenu:Get('lvc', 'hudsettings'))				
			RageUI.Button('Audio Settings', "Open audio settings menu.", {RightLabel = "→→→"}, true, {
			  onSelected = function()
			  end,
			}, RMenu:Get('lvc', 'audiosettings'))	
			RageUI.Separator("Miscellaneous")		
			RageUI.Button('Storage Management', "Save, load or reset settings.", {RightLabel = "→→→"}, true, {
			  onSelected = function()
			  
			  end,
			}, RMenu:Get('lvc', 'saveload'))			
			RageUI.Button('More Information', "Learn more about Luxart Vehicle Control.", {RightLabel = "→→→"}, true, {
			  onSelected = function()

			  end,
			}, RMenu:Get('lvc', 'about'))
        end)
		---------------------------------------------------------------------
		-------------------------OTHER SETTINGS MENU-------------------------
		---------------------------------------------------------------------
	    RageUI.IsVisible(RMenu:Get('lvc', 'hudsettings'), function()
			RageUI.Checkbox('HUD Visible', "Toggles whether the HUD is on screen.\nCan't see it? Ensure HUD is enabled in GTA V settings.", show_HUD, {}, {
			  onSelected = function(Index)
				  show_HUD = Index	  
			  end
			})
			RageUI.Button('HUD Move Mode', "Move HUD position on screen.", {}, true, {
			  onSelected = function()
					TogMoveMode()
				end,
			  });
			RageUI.Slider('HUD Background Opacity', hud_bgd_opacity, 255, 20, "Change opacity of of the HUD background rectangle.", true, {}, true, {
			  onSliderChange = function(Index)
				ShowHUD()
				--Stupid way to check if a KVP was found.
				if Index == 0 then
					Index = 1
				end
				hud_bgd_opacity = Index
			  end,
			})
			RageUI.Slider('HUD Button Opacity', hud_button_off_opacity, 255, 20, "Change opacity of inactive HUD buttons.", true, {}, true, {
			  onSliderChange = function(Index)
				ShowHUD()
				--Stupid way to check if a KVP was found.
				if Index == 0 then
					Index = 1
				end
				hud_button_off_opacity = Index 
			  end,
			})
        end)	    
		--AUDIO SETTINGS MENU
		RageUI.IsVisible(RMenu:Get('lvc', 'audiosettings'), function()
			RageUI.List("Sirenbox SFX Scheme", button_sfx_scheme_choices, button_sfx_scheme_id, "Change what SFX to use for siren box clicks.", {}, true, {
			  onListChange = function(Index, Item)
				button_sfx_scheme_id = Index
				button_sfx_scheme = button_sfx_scheme_choices[button_sfx_scheme_id]
			  end,				
			})
			RageUI.Checkbox('Manual Button Clicks', "When enabled, your manual tone button (default: R) will activate the upgrade SFX.", manu_button_SFX, {}, {
            onSelected = function(Index)
				manu_button_SFX = Index
            end
            })			
			RageUI.Checkbox('Airhorn Button Clicks', "When enabled, your airhorn button (default: E) will activate the upgrade SFX.", airhorn_button_SFX, {}, {
            onSelected = function(Index)
				airhorn_button_SFX = Index
            end
            })		
			RageUI.List('Activity Reminder', {"Off", "1/2", "1", "2", "5", "10"}, activity_reminder_index, ("Recieve reminder tone that your lights are on. Options are in minutes. Timer (sec): %1.0f"):format((last_activity_timer / 1000) or 0), {}, true, {
			  onListChange = function(Index, Item)
				activity_reminder_index = Index
				SetActivityTimer()
			  end,
			})			
			RageUI.Slider('On Volume', (on_volume*100), 100, 2, "Set volume of light slider / button. Plays when lights are turned ~g~on~s~. Press Enter to play the sound.", true, {}, true, {
			  onSliderChange = function(Index)
				on_volume = (Index / 100)
			  end,
			  onSelected = function(Index, Item)
				TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "On", on_volume)
			  end,
			})			
			RageUI.Slider('Off Volume', (off_volume*100), 100, 2, "Set volume of light slider / button. Plays when lights are turned ~r~off~s~. Press Enter to play the sound.", true, {}, true, {
			  onSliderChange = function(Index)
				off_volume = (Index/100)
			  end,
			  onSelected = function(Index, Item)
				TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Off", off_volume)
			  end,
			})			
			RageUI.Slider('Upgrade Volume', (upgrade_volume*100), 100, 2, "Set volume of siren button. Plays when siren is turned ~g~on~s~. Press Enter to play the sound.", true, {}, true, {
			  onSliderChange = function(Index)
				upgrade_volume = (Index/100)
			  end,
			  onSelected = function(Index, Item)
				TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Upgrade", upgrade_volume)
			  end,			  
			})			
			RageUI.Slider('Downgrade Volume', (downgrade_volume*100), 100, 2, "Set volume of siren button. Plays when siren is turned ~r~off~s~. Press Enter to play the sound.", true, {}, true, {
			  onSliderChange = function(Index)
				downgrade_volume = (Index/100)
			  end,
			  onSelected = function(Index, Item)
				TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Downgrade", downgrade_volume)
			  end,			  
			})					
			RageUI.Slider('Activity Reminder Volume', (activity_reminder_volume*500), 100, 2, "Set volume of activity reminder tone. Plays when lights are ~g~on~s~, siren is ~r~off~s~, and timer is has finished. Press Enter to play the sound.", true, {}, true, {
			  onSliderChange = function(Index)
				activity_reminder_volume = (Index/500)
			  end,
			  onSelected = function(Index, Item)
				TriggerEvent("lvc:audio", button_sfx_scheme .. "/" .. "Reminder", activity_reminder_volume)
			  end,			  
			})			
			RageUI.Slider('Hazards Volume', (hazards_volume*100), 100, 2, "Set volume of hazards button. Plays when hazards are toggled. Press Enter to play the sound.", true, {}, true, {
			  onSliderChange = function(Index)
				hazards_volume = (Index/100)
			  end,
			  onSelected = function(Index, Item)
				if hazard_state then
					TriggerEvent("lvc:audio", "Hazards_On", hazards_volume)
				else
					TriggerEvent("lvc:audio", "Hazards_Off", hazards_volume)
				end
				hazard_state = not hazard_state
			  end,			  
			})
			RageUI.Slider('Lock Volume', (lock_volume*100), 100, 2, "Set volume of lock notification sound. Plays when siren box lockout is toggled. Press Enter to play the sound.", true, {}, true, {
			  onSliderChange = function(Index)
				lock_volume = (Index/100)			
			  end,
			  onSelected = function(Index, Item)
				TriggerEvent("lvc:audio", "Key_Lock", lock_volume)
			  end,			  
			})					
			RageUI.Slider('Lock Reminder Volume', (lock_reminder_volume*100), 100, 2, "Set volume of lock reminder sound. Plays when locked out keys are pressed repeatedly. Press Enter to play the sound.", true, {}, true, {
			  onSliderChange = function(Index)
				lock_reminder_volume = (Index/100)
			  end,
			  onSelected = function(Index, Item)
				TriggerEvent("lvc:audio", "Locked_Press", lock_reminder_volume)
			  end,			  
			})	
        end)
		---------------------------------------------------------------------
		----------------------------SAVE LOAD MENU---------------------------
		---------------------------------------------------------------------
	    RageUI.IsVisible(RMenu:Get('lvc', 'saveload'), function()
			RageUI.Button('Save Settings', "Save all LVC options. All saving is client side and shared among servers.", {}, true, {
			  onSelected = function()
			  	SaveSettings()
			  end,
			})			
			RageUI.Button('Load Settings', "Load settings.", {}, true, {
			  onSelected = function()
					LoadSettings()
			  end,
			})			
			RageUI.Separator("Advanced Settings")
			RageUI.Button('Factory Reset', "~r~Permanently delete any saves, resetting LVC to its default state.", {RightLabel = confirm_reset_msg, RightLabelOpacity = 255}, true, {
			  onSelected = function()
				if confirm_reset_msg == "~r~Are you sure?" then
					Citizen.Wait(100)
					RageUI.Visible(RMenu:Get('lvc', 'saveload'), not RageUI.Visible(RMenu:Get('lvc', 'saveload')))
					ExecuteCommand('lvcfactoryreset')
					confirm_reset_msg = nil
				else 
					RageUI.Settings.Controls.Back.Enabled = false
					confirm_reset_msg = "~r~Are you sure?" 
				end
			  end,
			})
        end)	
		---------------------------------------------------------------------
		------------------------------ABOUT MENU-----------------------------
		---------------------------------------------------------------------
	    RageUI.IsVisible(RMenu:Get('lvc', 'about'), function()
			if curr_version ~= nil then
				--print(repo_version, curr_version, IsNewerVersion(repo_version, curr_version))
				if IsNewerVersion(repo_version, curr_version) then
					RageUI.Button('Current Version', "This server is running " .. curr_version, { RightLabel = "~o~~h~" .. curr_version or "unknown" }, true, {
					  onSelected = function()
					  end,
					  });	
					RageUI.Button('Latest Version', "The latest update is " .. repo_version .. ". Contact a server developer.", {RightLabel = repo_version or "unknown"}, true, {
						onSelected = function()
					end,
					});
				else
					RageUI.Button('Current Version', "This server is running " .. curr_version .. ", the latest version.", { RightLabel = curr_version or "unknown" }, true, {
					  onSelected = function()
					  end,
					  });			
				end
			end
			RageUI.List('Launch GitHub Page', {"Main Repository", "File Bug Report"}, github_index, "View the project and more info on GitHub.", {}, true, {
			  onListChange = function(Index, Item)
				github_index = Index
			  end,
			  onSelected = function()
				if github_index == 1 then
					TriggerServerEvent('lvc_OpenLink_s', "https://github.com/TrevorBarns/luxart-vehicle-control-lite")
				else
					TriggerServerEvent('lvc_OpenLink_s', "https://github.com/TrevorBarns/luxart-vehicle-control-lite/issues/new")			
				end
			  end,
			})
			RageUI.Button('Developer\'s Discord', "Join my discord for support, future updates, and other resources.", {}, true, {
				onSelected = function()
				TriggerServerEvent('lvc_OpenLink_s', "https://discord.gg/HGBp3un")
			end,
			});	
			RageUI.Button('About / Credits', "Originally designed and created by ~b~Lt. Caine~s~. ELS SoundFX by ~b~Faction~s~. Version 3 expansion by ~b~Trevor Barns~s~.\n\nSpecial thanks to Lt. Cornelius, bakerxgooty, MrLucky8, xotikorukx, the RageUI team, and everyone else who helped beta test, this would not have been possible without you all!", {}, true, {
				onSelected = function()
			end,
			});
			  
        end)
        Citizen.Wait(1)
	end
end)
