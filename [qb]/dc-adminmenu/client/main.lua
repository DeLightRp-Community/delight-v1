QBCore = exports['qb-core']:GetCoreObject()
menuLocation = 'topright' -- e.g. topright (default), topleft, bottomright, bottomleft
menuSize = 'size-125' -- e.g. 'size-100', 'size-110', 'size-125', 'size-150', 'size-175', 'size-200'
r, g, b = 20, 255, 236 -- red, green, blue values for the menu background
SelectedPlayer = nil
Admin = QBCore.Functions.GetPlayerData()
local blockedPeds = {
    "mp_m_freemode_01",
    "mp_f_freemode_01",
    "tony",
    "g_m_m_chigoon_02_m",
    "u_m_m_jesus_01",
    "a_m_y_stbla_m",
    "ig_terry_m",
    "a_m_m_ktown_m",
    "a_m_y_skater_m",
    "u_m_y_coop",
    "ig_car3guy1_m",
}
local lastSpectateCoord = nil
local isSpectating = false

MainMenu = MenuV:CreateMenu(false, Lang:t("menu.admin_menu"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:mainmenu')
SelfMenu = MenuV:CreateMenu(false, Lang:t("menu.admin_options"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:selfmenu')
PlayerMenu = MenuV:CreateMenu(false, Lang:t("menu.online_players"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:playermenu')
PlayerDetailMenu = MenuV:CreateMenu(false, Lang:t("info.options"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:playerdetailmenu')
PlayerGeneralMenu = MenuV:CreateMenu(false, Lang:t("menu.player_general"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:playergeneral')
PlayerAdminMenu = MenuV:CreateMenu(false, Lang:t("menu.player_administration"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:playeradministration')
PlayerExtraMenu = MenuV:CreateMenu(false, Lang:t("menu.player_extra"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:playerextra')
BanMenu = MenuV:CreateMenu(false, Lang:t("menu.ban"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:banmenu')
KickMenu = MenuV:CreateMenu(false, Lang:t("menu.kick"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:kickmenu')
PermsMenu = MenuV:CreateMenu(false, Lang:t("menu.permissions"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:permsmenu')
GiveItemMenu = MenuV:CreateMenu(false, Lang:t("menu.give_item_menu"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:giveitemmenu')
SoundMenu = MenuV:CreateMenu(false, Lang:t("menu.play_sound"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:soundmenu')
ServerMenu = MenuV:CreateMenu(false, Lang:t("menu.manage_server"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:servermenu')
WeatherMenu = MenuV:CreateMenu(false, Lang:t("menu.weather_conditions"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:weathermenu')
VehicleMenu = MenuV:CreateMenu(false, Lang:t("menu.vehicle_options"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:vehiclemenu')
VehCategorieMenu = MenuV:CreateMenu(false, Lang:t("menu.vehicle_categories"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:vehcategoriemenu')
VehNameMenu = MenuV:CreateMenu(false, Lang:t("menu.vehicle_models"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:vehnamemenu')
DealerMenu = MenuV:CreateMenu(false, Lang:t("menu.dealer_list"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:dealermenu')
DevMenu = MenuV:CreateMenu(false, Lang:t("menu.developer_options"), menuLocation, r, g, b, menuSize, 'qbcore', 'menuv', 'qb-admin:devmenu')

MainMenu:AddButton({
    icon = '😃',
    label = Lang:t("menu.admin_options"),
    value = SelfMenu,
    description = Lang:t("desc.admin_options_desc")
})
MainMenu:AddButton({
    icon = '🙍‍♂️',
    label = Lang:t("menu.player_management"),
    value = PlayerMenu,
    description = Lang:t("desc.player_management_desc"),
    select = function()
        PlayerMenu:ClearItems()
        QBCore.Functions.TriggerCallback('qb-adminmenu:callback:getplayers', function(players)
            for _, v in pairs(players) do
                PlayerMenu:AddButton({
                    label = Lang:t("info.id") .. v["id"] .. ' | ' .. v["name"],
                    value = v,
                    description = Lang:t("info.player_name"),
                    select = function(btn)
                        SelectedPlayer = btn.Value
                        OpenPlayerMenus()
                    end
                })
            end
        end)
    end
})
MainMenu:AddButton({
    icon = '🎮',
    label = Lang:t("menu.server_management"),
    value = ServerMenu,
    description = Lang:t("desc.server_management_desc")
})
MainMenu:AddButton({
    icon = '🚗',
    label = Lang:t("menu.vehicles"),
    value = VehicleMenu,
    description = Lang:t("desc.vehicles_desc")
})
MainMenu:AddButton({
    icon = '🔧',
    label = Lang:t("menu.developer_options"),
    value = DevMenu,
    description = Lang:t("desc.developer_desc")
})

--- Functions
local function LoadPlayerModel(skin)
    RequestModel(skin)
    while not HasModelLoaded(skin) do
      Wait(0)
    end
end

local function isPedAllowedRandom(skin)
    local retval = false
    for _, v in pairs(blockedPeds) do
        if v ~= skin then
            retval = true
        end
    end
    return retval
end

function spectatePlayer(targetPed,target,name)
	local playerPed = PlayerPedId() -- yourself
	enable = true
	if (target == PlayerId() or target == -1) then 
		enable = false
	end
	if enable then
		SetEntityVisible(playerPed, false, 0)
		SetEntityCollision(playerPed, false, false)
		SetEntityInvincible(playerPed, true)
		NetworkSetEntityInvisibleToNetwork(playerPed, true)
		Citizen.Wait(200) -- to prevent target player seeing you
		if targetPed == playerPed then
			Wait(500)
			targetPed = GetPlayerPed(target)
		end
		local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
		RequestCollisionAtCoord(targetx,targety,targetz)
		NetworkSetInSpectatorMode(true, targetPed)
		
		DrawPlayerInfo(target)
	elseif not enable then
		RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
		SetEntityVisible(playerPed, true, 0)
		SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z+0.3, 0, 0, 0, false)
		Wait(100)
		oldCoords=nil
		NetworkSetInSpectatorMode(false, targetPed)
		StopDrawPlayerInfo()
		frozen = false
		Citizen.Wait(100) -- to prevent staying invisible
		SetEntityVisible(playerPed, true, 0)
		SetEntityCollision(playerPed, true, true)
		SetEntityInvincible(playerPed, false)
		NetworkSetEntityInvisibleToNetwork(playerPed, false)
	end
end

function DrawPlayerInfo(target)
	drawTarget = target
	drawInfo = true
end

function StopDrawPlayerInfo()
	drawInfo = false
	drawTarget = 0
end

--- NetEvents
RegisterNetEvent('qb-admin:client:openMenu', function()
    TriggerServerEvent('qb-admin:server:check')
    MenuV:OpenMenu(MainMenu)
end)

RegisterNetEvent('qb-admin:client:playsound', function(name, volume, radius)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', radius, name, volume)
end)

AddEventHandler('qb-admin:client:inventory', function(targetPed)
    TriggerServerEvent('qb-admin:server:check')
    TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", targetPed)
end)

RegisterNetEvent('qb-admin:client:spectate', function(playerServerId, tgtCoords)
	local localPlayerPed = PlayerPedId()
	if ((not tgtCoords) or (tgtCoords.z == 0.0)) then tgtCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerServerId))) end
	if playerServerId == GetPlayerServerId(PlayerId()) then 
		-- spectatePlayer(GetPlayerPed(PlayerId()),GetPlayerFromServerId(PlayerId()),GetPlayerName(PlayerId()))
		-- frozen = false
		-- return
	else
		if not oldCoords then
			oldCoords = GetEntityCoords(PlayerPedId())
		end
	end
	SetEntityCoords(localPlayerPed, tgtCoords.x, tgtCoords.y, tgtCoords.z - 10.0, 0, 0, 0, false)
	frozen = true
	stopSpectateUpdate = true
	local adminPed = localPlayerPed
	local playerId = GetPlayerFromServerId(playerServerId)
	repeat
		Wait(200)
		playerId = GetPlayerFromServerId(playerServerId)
	until ((GetPlayerPed(playerId) > 0) and (playerId ~= -1))
	spectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
	stopSpectateUpdate = false
end)

RegisterNetEvent('qb-admin:client:SaveCar', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)

    if veh ~= nil and veh ~= 0 then
        local plate = QBCore.Functions.GetPlate(veh)
        local props = QBCore.Functions.GetVehicleProperties(veh)
        local hash = props.model
        local vehname = GetDisplayNameFromVehicleModel(hash):lower()
        if QBCore.Shared.Vehicles[vehname] ~= nil and next(QBCore.Shared.Vehicles[vehname]) ~= nil then
            TriggerServerEvent('qb-admin:server:SaveCar', props, QBCore.Shared.Vehicles[vehname], plate)
        else
            QBCore.Functions.Notify(Lang:t("error.no_store_vehicle_garage"), 'error')
        end
    else
        QBCore.Functions.Notify(Lang:t("error.no_vehicle"), 'error')
    end
end)

RegisterNetEvent('qb-admin:client:SetModel', function(skin)
    local ped = PlayerPedId()
    local model = GetHashKey(skin)
    SetEntityInvincible(ped, true)

    if IsModelInCdimage(model) and IsModelValid(model) then
        LoadPlayerModel(model)
        SetPlayerModel(PlayerId(), model)

        if isPedAllowedRandom(skin) then
            SetPedRandomComponentVariation(ped, true)
        end

		SetModelAsNoLongerNeeded(model)
	end
	SetEntityInvincible(ped, false)
end)

RegisterNetEvent('qb-weapons:client:SetWeaponAmmoManual', function(Weapon, ammo)
    local ped = PlayerPedId()
    if Weapon ~= "current" then
        local CurrentWeapon = Weapon:upper()
        SetPedAmmo(ped, GetHashKey(CurrentWeapon), ammo)
        QBCore.Functions.Notify(Lang:t("info.ammoforthe", {value = ammo, CurrentWeapon = QBCore.Shared.Weapons[CurrentWeapon]["label"]}), 'success')
    else
        local CurrentWeapon = GetSelectedPedWeapon(ped)
        if CurrentWeapon ~= nil then
            SetPedAmmo(ped, CurrentWeapon, ammo)
            QBCore.Functions.Notify(Lang:t("info.ammoforthe", {value = ammo, CurrentWeapon = QBCore.Shared.Weapons[CurrentWeapon]["label"]}), 'success')
        else
            QBCore.Functions.Notify(Lang:t("error.no_weapon"), 'error')
        end
    end
end)

RegisterNetEvent('qb-admin:client:GiveNuiFocus', function(focus, mouse)
    SetNuiFocus(focus, mouse)
end)

RegisterNetEvent('qb-admin:client:getsounds', function(sounds)
    local soundMenu = {
        {
            header = Lang:t('menu.choose_sound'),
            isMenuHeader = true
        }
    }

    for i = 1, #sounds do
        soundMenu[#soundMenu + 1] = {
            header = sounds[i],
            txt = "",
            params = {
                event = "qb-admin:client:openSoundMenu",
                args = {
                    name = sounds[i]
                }
            }
        }
    end

    exports['qb-menu']:openMenu(soundMenu)
end)

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(500)
		if drawInfo and not stopSpectateUpdate then
			local localPlayerPed = PlayerPedId()
			local targetPed = GetPlayerPed(drawTarget)
			local targetGod = GetPlayerInvincible(drawTarget)
			
			local tgtCoords = GetEntityCoords(targetPed)
			if tgtCoords and tgtCoords.x ~= 0 then
				SetEntityCoords(localPlayerPed, tgtCoords.x, tgtCoords.y, tgtCoords.z - 10.0, 0, 0, 0, false)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Admin = QBCore.Functions.GetPlayerData()
end)
