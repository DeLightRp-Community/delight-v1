local SelfMenuButton1 = SelfMenu:AddCheckbox({
    icon = '🎥',
    label = Lang:t("menu.noclip"),
    description = Lang:t("desc.noclip_desc")
})
SelfMenuButton1:On('change', function()
    toggleNoClipMode()
end)

local SelfMenuButton2 = SelfMenu:AddButton({
    icon = '🏥',
    label = Lang:t("menu.revive"),
    description = Lang:t("desc.revive_desc")
})
SelfMenuButton2:On('select', function()
    TriggerEvent('hospital:client:Revive')
    TriggerServerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Revived himself",
    GetPlayerName(PlayerId()), Admin.citizenid, Admin.source))
end)

local SelfMenuButton3 = SelfMenu:AddCheckbox({
    icon = '👻',
    label = Lang:t("menu.invisible"),
    description = Lang:t("desc.invisible_desc")
})
local invisible = false
SelfMenuButton3:On('change', function()
    invisible = not invisible
    TriggerServerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Set Invisible to **%s**",
    GetPlayerName(PlayerId()), Admin.citizenid, Admin.source, invisible))
    if invisible then
        while invisible do
            Wait(0)
            SetEntityVisible(PlayerPedId(), false, 0)
        end
        SetEntityVisible(PlayerPedId(), true, 0)
    end
end)

local SelfMenuButton4 = SelfMenu:AddCheckbox({
    icon = '⚡',
    label = Lang:t("menu.god"),
    description = Lang:t("desc.god_desc")
})
local godmode = false
SelfMenuButton4:On('change', function()
    godmode = not godmode
    TriggerServerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Set Godmode to **%s**",
    GetPlayerName(PlayerId()), Admin.citizenid, Admin.source, godmode))
    if godmode then SetPlayerInvincible(PlayerId(), true)
    else SetPlayerInvincible(PlayerId(), false) end
end)

local SelfMenuButton5 = SelfMenu:AddCheckbox({
    icon = '📋',
    label = Lang:t("menu.names"),
    description = Lang:t("desc.names_desc")
})
SelfMenuButton5:On('change', function()
    TriggerEvent('qb-admin:client:toggleNames')
end)

local SelfMenuButton6 = SelfMenu:AddCheckbox({
    icon = '📍',
    label = Lang:t("menu.blips"),
    description = Lang:t("desc.blips_desc")
})
SelfMenuButton6:On('change', function()
    TriggerEvent('qb-admin:client:toggleBlips')
end)

local SelfMenuButton7 = SelfMenu:AddCheckbox({
    icon = '🚔',
    label = Lang:t("menu.vehicle_godmode"),
    description = Lang:t("desc.vehicle_godmode")
})
local vehiclegodmode = false
SelfMenuButton7:On('change', function()
    vehiclegodmode = not vehiclegodmode
    TriggerServerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Set VehicleGodmode to **%s**",
    GetPlayerName(PlayerId()), Admin.citizenid, Admin.source, vehiclegodmode))
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehiclegodmode then
        SetEntityInvincible(vehicle, true)
        SetEntityCanBeDamaged(vehicle, false)
        while vehiclegodmode do
            vehicle = GetVehiclePedIsIn(ped, false)
            SetVehicleBodyHealth(vehicle, 1000.0)
            SetVehicleFixed(vehicle)
            SetVehicleEngineHealth(vehicle, 1000.0)
            Wait(250)
        end
    else
        SetEntityInvincible(vehicle, false)
        SetEntityCanBeDamaged(vehicle, true)
    end
end)

SelfMenu:AddSlider({
    icon = '👷‍♀️',
    label = Lang:t("menu.ped"),
    value = '',
    values = {{
        label = Lang:t("menu.ped"),
        value = 'ped',
        description = Lang:t("desc.ped")
    }, {
        label = Lang:t("menu.reset_ped"),
        value = 'reset',
        description = Lang:t("desc.reset_ped")
    }},
    select = function(_, newValue)
        if newValue == "ped" then
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("desc.ped"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "a_m_m_salton_03",
                        name = "model",
                        type = "text",
                        isRequired = true
                    }
                }
            })
            if dialog then
                TriggerServerEvent('QBCore:CallCommand', "setmodel", {dialog.model})
            end
        else
            ExecuteCommand('refreshskin')
        end
    end
})

local SelfMenuButton9 = SelfMenu:AddCheckbox({
    icon = '🎯',
    label = Lang:t("menu.ammo"),
    description = Lang:t("desc.ammo")
})
local infiniteammo = false
SelfMenuButton9:On('change', function()
    infiniteammo = not infiniteammo
    TriggerServerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Set InfiniteAmmo to **%s**",
    GetPlayerName(PlayerId()), Admin.citizenid, Admin.source, infiniteammo))
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    if infiniteammo then
        if GetAmmoInPedWeapon(ped, weapon) < 6 then SetAmmoInClip(ped, weapon, 10) Wait(50) end
        while infiniteammo do
            weapon = GetSelectedPedWeapon(ped)
            SetPedInfiniteAmmo(ped, true, weapon)
            RefillAmmoInstantly(ped)
            Wait(250)
        end
    else
        SetPedInfiniteAmmo(ped, false, weapon)
    end
end)

SelfMenu:AddSlider({
    icon = '🔫',
    label = Lang:t("menu.give_weapons"),
    value = '',
    values = {{
        label = Lang:t("menu.weapon_pistol"),
        value = 'pistol',
        description = Lang:t("desc.give_weapons")
    }, {
        label = Lang:t("menu.weapon_smg"),
        value = 'smg',
        description = Lang:t("desc.give_weapons")
    }, {
        label = Lang:t("menu.weapon_shotgun"),
        value = 'shotgun',
        description = Lang:t("desc.give_weapons")
    }, {
        label = Lang:t("menu.weapon_assault"),
        value = 'assault',
        description = Lang:t("desc.give_weapons")
    }, {
        label = Lang:t("menu.weapon_lmg"),
        value = 'lmg',
        description = Lang:t("desc.give_weapons")
    }, {
        label = Lang:t("menu.weapon_sniper"),
        value = 'sniper',
        description = Lang:t("desc.give_weapons")
    }, {
        label = Lang:t("menu.weapon_heavy"),
        value = 'heavy',
        description = Lang:t("desc.give_weapons")
    }},
    select = function(_, newValue)
        TriggerServerEvent('qb-admin:server:giveallweapons', newValue)
    end
})
