local soundname = 'Unknown'
local soundrange = 0
local soundvolume = 0
local itemname = 'Unknown'
local itemamount = 0
local banreason = 'Unknown'
local banlength = nil
local kickreason = 'Unknown'

local BanMenuButton1 = BanMenu:AddButton({
    icon = '',
    label = Lang:t("info.reason"),
    value = "reason",
    description = Lang:t("desc.ban_reason"),
    select = function(btn)
        local dialog = exports['qb-input']:ShowInput({
            header = Lang:t("desc.ban_reason"),
            submitText = "Confirm",
            inputs = {
                {
                    text = "VDM",
                    name = "reason",
                    type = "text",
                    isRequired = true
                }
            }
        })
        if dialog then
            banreason = dialog.reason
        end
    end
})
local BanMenuButton2 = BanMenu:AddSlider({
    icon = '⏲️',
    label = Lang:t("info.length"),
    value = '3600',
    values = {{
        label = Lang:t("time.1hour"),
        value = '3600',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.6hour"),
        value ='21600',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.12hour"),
        value = '43200',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.1day"),
        value = '86400',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.3day"),
        value = '259200',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.1week"),
        value = '604800',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.1month"),
        value = '2678400',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.3month"),
        value = '8035200',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.6month"),
        value = '16070400',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.1year"),
        value = '32140800',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.permenent"),
        value = '99999999999',
        description = Lang:t("time.ban_length")
    }, {
        label = Lang:t("time.self"),
        value = "self",
        description = Lang:t("time.ban_length")
    }},
    select = function(btn, newValue, oldValue)
        if newValue == "self" then
            local dialog = exports['qb-input']:ShowInput({
                header = 'Ban Length',
                submitText = "Confirm",
                inputs = {
                    {
                        text = "20",
                        name = "lenght",
                        type = "number",
                        isRequired = true
                    }
                }
            })
            if dialog then
                banlength = dialog.lenght
            end
        else
            banlength = newValue
        end
    end
})
local BanMenuButton3 = BanMenu:AddButton({
    icon = '',
    label = Lang:t("info.confirm"),
    value = "ban",
    description = Lang:t("desc.confirm_ban"),
    select = function(btn)
        if banreason ~= 'Unknown' and banlength ~= nil then
            TriggerServerEvent('qb-admin:server:ban', PlayerDetails, banlength, banreason)
            banreason = 'Unknown'
            banlength = nil
        else
            QBCore.Functions.Notify(Lang:t("error.invalid_reason_length_ban"), 'error')
        end
    end
})

local KickMenuButton1 = KickMenu:AddButton({
    icon = '',
    label = Lang:t("info.reason"),
    value = "reason",
    description = Lang:t("desc.kick_reason"),
    select = function(btn)
        local dialog = exports['qb-input']:ShowInput({
            header = Lang:t("desc.kick_reason"),
            submitText = "Confirm",
            inputs = {
                {
                    text = "VDM",
                    name = "reason",
                    type = "text",
                    isRequired = true
                }
            }
        })
        if dialog then
            kickreason = dialog.reason
        end
    end
})
local KickMenuButton2 = KickMenu:AddButton({
    icon = '',
    label = Lang:t("info.confirm"),
    value = "kick",
    description = Lang:t("desc.confirm_kick"),
    select = function(btn)
        if kickreason ~= 'Unknown' then
            TriggerServerEvent('qb-admin:server:kick', PlayerDetails, kickreason)
            kickreason = 'Unknown'
        else
            QBCore.Functions.Notify(Lang:t("error.missing_reason"), 'error')
        end
    end
})

local PermsMenuButton1 = PermsMenu:AddSlider({
    icon = '',
    label = 'Group',
    value = 'user',
    values = {{
        label = 'Remove',
        value = 'user',
        description = 'Group'
    }, {
        label = 'Admin',
        value = 'admin',
        description = 'Group'
    }, {
        label = 'God',
        value = 'god',
        description = 'Group'
    }},
    change = function(item, newValue, oldValue)
        local vcal = newValue
        if vcal == 1 then
            selectedgroup = {}
            selectedgroup[#selectedgroup+1] = {rank = "user", label = "User"}
        elseif vcal == 2 then
            selectedgroup = {}
            selectedgroup[#selectedgroup+1] = {rank = "AdminmenuAdmin", label = "Admin"}
        elseif vcal == 3 then
            selectedgroup = {}
            selectedgroup[#selectedgroup+1] = {rank = "AdminmenuGod", label = "God"}
        end
    end
})
local PermsMenuButton2 = PermsMenu:AddButton({
    icon = '',
    label = Lang:t("info.confirm"),
    value = "giveperms",
    description = 'Give the permission group',
    select = function(btn)
        if selectedgroup ~= 'Unknown' then
            TriggerServerEvent('qb-admin:server:setPermissions', PlayerDetails.id, selectedgroup)
            selectedgroup = 'Unknown'
        else
            QBCore.Functions.Notify(Lang:t("error.changed_perm_failed"), 'error')
        end
    end
})

local GiveItemMenuButton1 = GiveItemMenu:AddSlider({
    icon = '',
    label = Lang:t("info.item"),
    value = "reason",
    values = {{
        label = Lang:t("menu.item_list"),
        value = '',
        description = Lang:t("desc.item_list")
    }, {
        label = Lang:t("menu.item_self"),
        value = 'Self',
        description = Lang:t("desc.item_self")
    }},
    select = function(btn, newValue, oldValue)
        if newValue == 'Self' then
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("desc.item_self"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "Lockpick",
                        name = "item",
                        type = "text",
                        isRequired = true
                    }
                }
            })
            if dialog then
                itemname = dialog.item
            end
        else
            local ItemMenu = {
                {
                    header = Lang:t('info.item'),
                    isMenuHeader = true
                }
            }

            for k, v in pairs(QBCore.Shared.Items) do
                ItemMenu[#ItemMenu + 1] = {
                    header = v['label'],
                    txt = "",
                    params = {
                        event = "qb-admin:client:openItemMenu",
                        args = {
                            name = v['name']
                        }
                    }
                }
            end

            exports['qb-menu']:openMenu(ItemMenu)
        end
    end
})
local GiveItemMenuButton2 = GiveItemMenu:AddButton({
    icon = '',
    label = Lang:t("info.amount"),
    value = "reason",
    description = Lang:t("desc.amount"),
    select = function(btn)
        local dialog = exports['qb-input']:ShowInput({
            header = Lang:t("desc.amount"),
            submitText = "Confirm",
            inputs = {
                {
                    text = "Lockpick",
                    name = "amount",
                    type = "number",
                    isRequired = true
                }
            }
        })
        if dialog then
            itemamount = dialog.amount
        end
    end
})
local GiveItemMenuButton3 = GiveItemMenu:AddButton({
    icon = '',
    label = Lang:t("info.confirm"),
    value = "kick",
    description = Lang:t("desc.confirm_kick"),
    select = function(btn)
        if itemname ~= 'Unknown' and itemamount ~= 0 then
            TriggerServerEvent('QBCore:CallCommand', "giveitem", {PlayerDetails.id, itemname, itemamount})
            itemname = 'Unknown'
            itemamount = 0
        else
            QBCore.Functions.Notify(Lang:t("error.give_item"), 'error')
        end
    end
})

local SoundMenuButton1 = SoundMenu:AddButton({
    icon = '',
    label = Lang:t("info.sound"),
    value = "reason",
    description = Lang:t("desc.sound"),
    select = function(btn)
        TriggerServerEvent('qb-admin:server:getsounds')
    end
})
local SoundMenuButton2 = SoundMenu:AddSlider({
    icon = '',
    label = Lang:t("volume.volume"),
    value = '0.5',
    values = {{
        label = Lang:t("volume.01"),
        value = 0.1,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.02"),
        value = 0.2,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.03"),
        value = 0.3,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.04"),
        value = 0.4,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.05"),
        value = 0.5,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.06"),
        value = 0.6,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.07"),
        value = 0.7,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.08"),
        value = 0.8,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.09"),
        value = 0.9,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.1.0"),
        value = 1.0,
        description = Lang:t("volume.volume")
    }, {
        label = Lang:t("volume.self"),
        value = "self",
        description = Lang:t("volume.volume")
    }},
    description = Lang:t("volume.volume_desc"),
    select = function(btn, newValue, oldValue)
        if newValue == "self" then
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("volume.volume_desc"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "0.6",
                        name = "volume",
                        type = "text",
                        isRequired = true
                    }
                }
            })
            if dialog then
                soundvolume = tonumber(dialog.volume)
            end
        else
            soundvolume = newValue
        end
    end
})
local SoundMenuButton3 = SoundMenu:AddSlider({
    icon = '',
    label = Lang:t("volume.radius"),
    value = '0.5',
    values = {{
        label = Lang:t("volume.10"),
        value = 10,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.20"),
        value = 20,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.30"),
        value = 30,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.40"),
        value = 40,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.50"),
        value = 50,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.60"),
        value = 60,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.70"),
        value = 70,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.80"),
        value = 80,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.90"),
        value = 90,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.100"),
        value = 100,
        description = Lang:t("volume.radius")
    }, {
        label = Lang:t("volume.self"),
        value = "self",
        description = Lang:t("volume.radius")
    }},
    description = Lang:t("volume.radius_desc"),
    select = function(btn, newValue, oldValue)
        if newValue == "self" then
            local dialog = exports['qb-input']:ShowInput({
                header = Lang:t("volume.radius_desc"),
                submitText = "Confirm",
                inputs = {
                    {
                        text = "30",
                        name = "volume",
                        type = "number",
                        isRequired = true
                    }
                }
            })
            if dialog then
                soundrange = tonumber(dialog.volume)
            end
        else
            soundrange = newValue
        end
    end
})
local SoundMenuButton4 = SoundMenu:AddButton({
    icon = '',
    label = Lang:t("info.confirm_play"),
    value = '',
    description = Lang:t("desc.confirm_play"),
    select = function(btn)
        if soundname ~= 'Unknown' and soundvolume ~= 0 then
            TriggerServerEvent('InteractSound_SV:PlayOnOne', PlayerDetails.id, soundname, soundvolume)
        else
            QBCore.Functions.Notify(Lang:t("error.give_item"), 'error')
        end
    end
})
local SoundMenuButton5 = SoundMenu:AddButton({
    icon = '',
    label = Lang:t("info.confirm_play_radius"),
    value = '',
    description = Lang:t("desc.confirm_play_radius"),
    select = function(btn)
        if soundname ~= 'Unknown' and soundvolume ~= 0 and soundrange ~= 0 then
            TriggerServerEvent('qb-admin:server:playsound', PlayerDetails.id, soundname, soundvolume, soundrange)
        else
            QBCore.Functions.Notify(Lang:t("error.give_item"), 'error')
        end
    end
})

function OpenPlayerMenus()
    PlayerDetailMenu:ClearItems()
    MenuV:OpenMenu(PlayerDetailMenu)
    local PlayersButton1 = PlayerDetailMenu:AddButton({
        icon = '🛠️',
        label = Lang:t("menu.player_general"),
        value = PlayerGeneralMenu,
        description = Lang:t("desc.admin_options_desc")
    })
    PlayersButton1:On('select', function(item)
        PlayerGeneralMenu:ClearItems()
        local elements = {
            [1] = {
                icon = '💀',
                label = Lang:t("menu.kill"),
                value = "kill",
                description = Lang:t("menu.kill").. " " .. PlayerDetails.name
            },
            [2] = {
                icon = '🏥',
                label = Lang:t("menu.revive"),
                value = "revive",
                description = Lang:t("menu.revive") .. " " .. PlayerDetails.name
            },
            [3] = {
                icon = '🥶',
                label = Lang:t("menu.freeze"),
                value = "freeze",
                description = Lang:t("menu.freeze") .. " " .. PlayerDetails.name
            },
            [4] = {
                icon = '👀',
                label = Lang:t("menu.spectate"),
                value = "spectate",
                description = Lang:t("menu.spectate") .. " " .. PlayerDetails.name
            },
            [5] = {
                icon = '➡️',
                label = Lang:t("info.goto"),
                value = "goto",
                description = Lang:t("info.goto") .. " " .. PlayerDetails.name .. Lang:t("info.position")
            },
            [6] = {
                icon = '⬅️',
                label = Lang:t("menu.bring"),
                value = "bring",
                description = Lang:t("menu.bring") .. " " .. PlayerDetails.name .. " " .. Lang:t("info.your_position")
            },
            [7] = {
                icon = '🚗',
                label = Lang:t("menu.sit_in_vehicle"),
                value = "intovehicle",
                description = Lang:t("desc.sit_in_veh_desc") .. " " .. PlayerDetails.name .. " " .. Lang:t("desc.sit_in_veh_desc2")
            }
        }
        for k, v in ipairs(elements) do
            local PlayerGeneralButton = PlayerGeneralMenu:AddButton({
                icon = v.icon,
                label = ' ' .. v.label,
                value = v.value,
                description = v.description,
                select = function(btn)
                    local values = btn.Value
                    TriggerServerEvent('qb-admin:server:'..values, PlayerDetails)
                end
            })
        end
        local PlayerGeneralRoutingbucket = PlayerGeneralMenu:AddButton({
            icon = '🧿',
            label = Lang:t("menu.routingbucket"),
            value = "routingbucket",
            description = Lang:t("desc.routingbucket"),
            select = function(btn)
                local dialog = exports['qb-input']:ShowInput({
                    header = Lang:t("desc.routingbucket"),
                    submitText = "Confirm",
                    inputs = {
                        {
                            text = "5",
                            name = "bucket",
                            type = "number",
                            isRequired = true
                        }
                    }
                })
                if dialog then
                    TriggerServerEvent('qb-admin:server:routingbucket', PlayerDetails, dialog.bucket)
                end
            end
        })
    end)

    local PlayersButton2 = PlayerDetailMenu:AddButton({
        icon = '🧾',
        label = Lang:t("menu.player_administration"),
        value = PlayerAdminMenu,
        description = Lang:t("desc.player_administration")
    })
    PlayersButton2:On('select', function(item)
        PlayerAdminMenu:ClearItems()
        local elements = {
            [1] = {
                icon = '🥾',
                label = Lang:t("menu.kick"),
                value = "kick",
                description = Lang:t("menu.kick") .. " " .. PlayerDetails.name .. " " .. Lang:t("info.reason")
            },
            [2] = {
                icon = '🚫',
                label = Lang:t("menu.ban"),
                value = "ban",
                description = Lang:t("menu.ban") .. " " .. PlayerDetails.name .. " " .. Lang:t("info.reason")
            },
            [3] = {
                icon = '🎟️',
                label = Lang:t("menu.permissions"),
                value = "perms",
                description = Lang:t("info.give") .. " " .. PlayerDetails.name .. " " .. Lang:t("menu.permissions")
            }
        }
        for k, v in ipairs(elements) do
            local PlayerAdminButton = PlayerAdminMenu:AddButton({
                icon = v.icon,
                label = ' ' .. v.label,
                value = v.value,
                description = v.description,
                select = function(btn)
                    local values = btn.Value
                    if values == 'ban' then
                        MenuV:OpenMenu(BanMenu)
                    elseif values == 'kick' then
                        MenuV:OpenMenu(KickMenu)
                    elseif values == 'perms' then
                        MenuV:OpenMenu(PermsMenu)
                    end
                end
            })
        end    
    end)

    local PlayersButton3 = PlayerDetailMenu:AddButton({
        icon = '🕹️',
        label = Lang:t("menu.player_extra"),
        value = PlayerExtraMenu,
        description = Lang:t("desc.player_extra_desc")
    })
    PlayersButton3:On('select', function(item)
        PlayerExtraMenu:ClearItems()
        local elements = {
            [1] = {
                icon = '🎒',
                label = Lang:t("menu.open_inv"),
                value = "inventory",
                description = Lang:t("info.open") .. " " .. PlayerDetails.name .. Lang:t("info.inventories")
            },
            [2] = {
                icon = '👕',
                label = Lang:t("menu.give_clothing_menu"),
                value = "cloth",
                description = Lang:t("desc.clothing_menu_desc") .. " " .. PlayerDetails.name
            },
            [3] = {
                icon = '🏒',
                label = Lang:t("menu.give_item_menu"),
                value = "giveitem",
                description = Lang:t("desc.give_item_menu_desc") .. " " .. PlayerDetails.name
            },
            [4] = {
                icon = '🎵',
                label = Lang:t("menu.play_sound"),
                value = "sound",
                description = Lang:t("desc.play_sound") .. " " .. PlayerDetails.name
            },
            [5] = {
                icon = '🔇',
                label = Lang:t("menu.mute_player"),
                value = "mute",
                description = Lang:t("desc.mute_player")
            },
        }
        for k, v in ipairs(elements) do
            local PlayerExtraButton = PlayerExtraMenu:AddButton({
                icon = v.icon,
                label = ' ' .. v.label,
                value = v.value,
                description = v.description,
                select = function(btn)
                    local values = btn.Value
                    if values == 'inventory' then
                        TriggerEvent('qb-admin:client:inventory', PlayerDetails.id)
                    elseif values == 'giveitem' then
                        MenuV:OpenMenu(GiveItemMenu)
                    elseif values == 'sound' then
                        MenuV:OpenMenu(SoundMenu)
                    elseif values == 'mute' then
                        exports['pma-voice']:toggleMutePlayer(PlayerDetails.id)
                    else
                        TriggerServerEvent('qb-admin:server:'..values, PlayerDetails)
                    end
                end
            })
        end    
    end)
    local PlayersButton4 = PlayerDetailMenu:AddButton({
        label = Lang:t("label.name").. ': ' ..PlayerDetails.name,
        description = Lang:t("desc.player_info")
    })
    local PlayersButton5 = PlayerDetailMenu:AddButton({
        label = Lang:t("label.food").. ': ' ..PlayerDetails.food.. '%',
        description = Lang:t("desc.player_info")
    })
    local PlayersButton6 = PlayerDetailMenu:AddButton({
        label = Lang:t("label.water").. ': ' ..PlayerDetails.water.. '%',
        description = Lang:t("desc.player_info")
    })
    local PlayersButton7 = PlayerDetailMenu:AddButton({
        label = Lang:t("label.stress").. ': ' ..PlayerDetails.stress.. '%',
        description = Lang:t("desc.player_info")
    })
    local PlayersButton8 = PlayerDetailMenu:AddButton({
        label = Lang:t("label.armor").. ': ' ..PlayerDetails.armor.. '%',
        description = Lang:t("desc.player_info")
    })
    local PlayersButton9 = PlayerDetailMenu:AddButton({
        label = Lang:t("label.phone").. ': ' ..PlayerDetails.phone,
        description = Lang:t("desc.player_info")
    })
    local PlayersButton10 = PlayerDetailMenu:AddButton({
        label = Lang:t("label.craftingrep").. ': ' ..PlayerDetails.craftingrep,
        description = Lang:t("desc.player_info")
    })
    local PlayersButton11 = PlayerDetailMenu:AddButton({
        label = Lang:t("label.dealerrep").. ': ' ..PlayerDetails.dealerrep,
        description = Lang:t("desc.player_info")
    })
    local PlayersButton12 = PlayerDetailMenu:AddButton({
        label = Lang:t("label.cash").. ': ' ..PlayerDetails.cash.. '$',
        description = Lang:t("desc.player_info")
    })
    local PlayersButton11 = PlayerDetailMenu:AddButton({
        label = Lang:t("label.bank").. ': ' ..PlayerDetails.bank.. '$',
        description = Lang:t("desc.player_info")
    })
    local PlayersButton11 = PlayerDetailMenu:AddButton({
        label = Lang:t("label.gang").. ': ' ..PlayerDetails.gang,
        description = Lang:t("desc.player_info")
    })
    local PlayersButton12 = PlayerDetailMenu:AddButton({
        label = Lang:t("label.radio").. ': ' ..Player(PlayerDetails.id).state['radioChannel'],
        description = Lang:t("desc.player_info")
    })
end

RegisterNetEvent('qb-admin:client:openSoundMenu', function(data)
    soundname = data.name
end)

RegisterNetEvent('qb-admin:client:openItemMenu', function(data)
    itemname = data.name
end)
