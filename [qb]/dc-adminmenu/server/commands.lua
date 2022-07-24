QBCore.Commands.Add('blips', Lang:t("commands.blips_for_player"), {}, false, function(source)
    local src = source

    if not (QBCore.Functions.HasPermission(src, commands['blips']) or HasPermission(src, commands['blips'])) then NoPerms(src) return end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Blips', 'red', '**'..GetPlayerName(src)..'** Turn Blips **', false)

    TriggerClientEvent('qb-admin:client:toggleBlips', src)
end)

QBCore.Commands.Add('names', Lang:t("commands.player_name_overhead"), {}, false, function(source)
    local src = source

    if not (QBCore.Functions.HasPermission(src, commands['names']) or HasPermission(src, commands['names'])) then NoPerms(src) return end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'NAMES', 'red', '**'..GetPlayerName(src)..'** Turn Names **', false)

    TriggerClientEvent('qb-admin:client:toggleNames', src)
end)

QBCore.Commands.Add('coords', Lang:t("commands.coords_dev_command"), {}, false, function(source)
    local src = source

    if not (QBCore.Functions.HasPermission(src, commands['coords']) or HasPermission(src, commands['coords'])) then NoPerms(src) return end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'COORDS', 'red', '**'..GetPlayerName(src)..'** Turn Coords **', false)

    TriggerClientEvent('qb-admin:client:ToggleCoords', src)
end)

QBCore.Commands.Add('noclip', Lang:t("commands.toogle_noclip"), {}, false, function(source)
    local src = source

    if not (QBCore.Functions.HasPermission(src, commands['noclip']) or HasPermission(src, commands['noclip'])) then NoPerms(src) return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'NOCLIP', 'red', '**'..GetPlayerName(src)..'** Use Noclip **', false)

    TriggerClientEvent('qb-admin:client:ToggleNoClip', src)
end)

QBCore.Commands.Add('admincar', Lang:t("commands.save_vehicle_garage"), {}, false, function(source)
    local src = source

    if not (QBCore.Functions.HasPermission(src, events['savecar']) or HasPermission(src, events['savecar'])) then NoPerms(src) return end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'ADMINCAR', 'red', '**'..GetPlayerName(src)..'** Use Admin Car **', false)

    TriggerClientEvent('qb-admin:client:SaveCar', src)
end)

QBCore.Commands.Add('announce', Lang:t("commands.make_announcement"), {}, false, function(source, args)
    if not (QBCore.Functions.HasPermission(source, commands['announce']) or HasPermission(source, commands['announce'])) then NoPerms(source) return end

    local msg = table.concat(args, ' ')
    if msg == '' then return end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'ANNOUNCE', 'red', '**'..GetPlayerName(src)..'** Use Announce : '..msg..' **', false)

    TriggerClientEvent('chat:addMessage', -1, {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Announcement", msg}
    })
end)

QBCore.Commands.Add('admin', Lang:t("commands.open_admin"), {}, false, function(source)
    if not (QBCore.Functions.HasPermission(source, events['usemenu']) or HasPermission(source, events['usemenu'])) then NoPerms(source) return end

    TriggerClientEvent('qb-admin:client:openMenu', source)
end)

QBCore.Commands.Add('report', Lang:t("info.admin_report"), {{name='message', help='Message'}}, true, function(source, args)
    local src = source
    local msg = table.concat(args, ' ')
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerEvent('qb-admin:server:SendReport', GetPlayerName(src), src, msg)
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report', 'green', '**'..GetPlayerName(source)..'** (CitizenID: '..Player.PlayerData.citizenid..' | ID: '..source..') **Report:** ' ..msg, false)
end)

QBCore.Commands.Add('staffchat', Lang:t("commands.staffchat_message"), {{name='message', help='Message'}}, true, function(source, args)
    if not (QBCore.Functions.HasPermission(source, commands['staffchat']) or HasPermission(source, commands['staffchat'])) then NoPerms(source) return end

    local msg = table.concat(args, ' ')
    TriggerEvent('qb-admin:server:Staffchat:addMessage', GetPlayerName(source), msg)
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'STAFCHAT', 'red', '**'..GetPlayerName(src)..'** Use staff chat'..msg..' **', false)

end)

QBCore.Commands.Add('s', Lang:t("commands.staffchat_message"), {{name='message', help='Message'}}, true, function(source, args)
    if not (QBCore.Functions.HasPermission(source, commands['staffchat']) or HasPermission(source, commands['staffchat'])) then NoPerms(source) return end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'STAFFCHAT', 'red', '**'..GetPlayerName(src)..'** Use staff chat'..msg..' **', false)

    local msg = table.concat(args, ' ')
    TriggerEvent('qb-admin:server:Staffchat:addMessage', GetPlayerName(source), msg)
end)

--- No one uses this properly. For the ones that do I'll leave it here
-- QBCore.Commands.Add('givenuifocus', Lang:t("commands.nui_focus"), {{name='id', help='Player id'}, {name='focus', help='Set focus on/off'}, {name='mouse', help='Set mouse on/off'}}, true, function(_, args)
--     local playerid = tonumber(args[1])
--     local focus = args[2]
--     local mouse = args[3]
--     TriggerClientEvent('qb-admin:client:GiveNuiFocus', playerid, focus, mouse)
-- end)

--- Highly recommend using txAdmin for warnings and bans.
-- QBCore.Commands.Add('warn', Lang:t("commands.warn_a_player"), {{name='ID', help='Player'}, {name='Reason', help='Mention a reason'}}, true, function(source, args)
--     if not (QBCore.Functions.HasPermission(source, commands['warn']) or HasPermission(source, commands['warn'])) then return end

--     local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--     local senderPlayer = QBCore.Functions.GetPlayer(source)
--     table.remove(args, 1)
--     local msg = table.concat(args, ' ')
--     local warnId = 'WARN-'..math.random(1111, 9999)
--     if targetPlayer ~= nil then
--         TriggerClientEvent('chat:addMessage', targetPlayer.PlayerData.source, {
--             color = { 255, 0, 0},
--             multiline = true,
--             args = {Lang:t("info.warning_chat_message")..' '..GetPlayerName(source), msg}
--         })
--         TriggerClientEvent('chat:addMessage', source, {
--             color = { 255, 0, 0},
--             multiline = true,
--             args = {Lang:t("info.warning_staff_message")..GetPlayerName(targetPlayer.PlayerData.source), msg}
--         })
--         MySQL.Async.insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)', {
--             senderPlayer.PlayerData.license,
--             targetPlayer.PlayerData.license,
--             msg,
--             warnId
--         })
--     else
--         TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
--     end
-- end)

-- QBCore.Commands.Add('checkwarns', Lang:t("commands.check_player_warning"), {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, false, function(source, args)
--     if not (QBCore.Functions.HasPermission(source, commands['warn']) or HasPermission(source, commands['warn'])) then return end

--     if args[2] == nil then
--         local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--         local result = MySQL.Sync.fetchAll('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
--         TriggerClientEvent('chat:addMessage', source, {
--             color = { 255, 0, 0},
--             multiline = true,
--             args = {'SYSTEM', targetPlayer.PlayerData.name..' has '..#result..' warnings!'}
--         })
--     else
--         local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--         local warnings = MySQL.Sync.fetchAll('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
--         local selectedWarning = tonumber(args[2])
--         if warnings[selectedWarning] ~= nil then
--             local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
--             TriggerClientEvent('chat:addMessage', source, {
--                 color = { 255, 0, 0},
--                 multiline = true,
--                 args = {'SYSTEM', targetPlayer.PlayerData.name..' has been warned by '..sender.PlayerData.name..', Reason: '..warnings[selectedWarning].reason}
--             })
--         end
--     end
-- end)

-- QBCore.Commands.Add('delwarn', Lang:t("commands.delete_player_warning"), {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, true, function(source, args)
--     if not (QBCore.Functions.HasPermission(source, commands['delwarn']) or HasPermission(source, commands['delwarn'])) then return end

--     local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--     local warnings = MySQL.Sync.fetchAll('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
--     local selectedWarning = tonumber(args[2])
--     if warnings[selectedWarning] ~= nil then
--         TriggerClientEvent('chat:addMessage', source, {
--             color = { 255, 0, 0},
--             multiline = true,
--             args = {'SYSTEM', 'You have deleted warning ('..selectedWarning..') , Reason: '..warnings[selectedWarning].reason}
--         })
--         MySQL.Async.execute('DELETE FROM player_warns WHERE warnId = ?', { warnings[selectedWarning].warnId })
--     end
-- end)

QBCore.Commands.Add('reportr', Lang:t("commands.reply_to_report"), {{name='id', help='Player'}, {name = 'message', help = 'Message to respond with'}}, false, function(source, args)
    local src = source

    if not (QBCore.Functions.HasPermission(src, events['reports']) or HasPermission(src, events['reports'])) then NoPerms(src) return end

    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if msg == '' then return end
    if not OtherPlayer then return TriggerClientEvent('QBCore:Notify', src, 'Player is not online', 'error') end
    if not QBCore.Functions.HasPermission(src) or IsPlayerAceAllowed(src, 'command') ~= 1 then return end
    TriggerClientEvent('chat:addMessage', playerId, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Admin Response', msg}
    })
    TriggerClientEvent('chat:addMessage', src, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Report Response ('..playerId..')', msg}
    })
    TriggerClientEvent('QBCore:Notify', src, 'Reply Sent')
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Report Reply', 'red', '**'..GetPlayerName(src)..'** replied on: **'..OtherPlayer.PlayerData.name.. ' **(ID: '..OtherPlayer.PlayerData.source..') **Message:** ' ..msg, false)
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report Reply', 'red', '**'..GetPlayerName(src)..'** replied on: **'..OtherPlayer.PlayerData.name.. ' **(ID: '..OtherPlayer.PlayerData.source..') **Message:** ' ..msg, false)

end)

QBCore.Commands.Add('setmodel', Lang:t("commands.change_ped_model"), {{name='model', help='Name of the model'}, {name='id', help='Id of the Player (empty for yourself)'}}, false, function(source, args)
    
    if not (QBCore.Functions.HasPermission(source, commands['setmodel']) or HasPermission(source, commands['setmodel'])) and not(QBCore.Functions.GetPlayer(source).PlayerData.citizenid =="IQK22539") then NoPerms(source) return end

    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= '' then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
                TriggerEvent('qb-log:server:CreateLog', 'admin', 'Report', 'green', '**'..GetPlayerName(source)..'SetModel : ' ..model..' for : '..GetPlayerName(target), false)

            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.failed_set_model"), 'error')
    end

end)

--- Only really works with QBCore permissions for now.
QBCore.Commands.Add('reporttoggle', Lang:t("commands.report_toggle"), {}, false, function(source)
    local src = source

    if not (QBCore.Functions.HasPermission(src, commands['reporttoggle']) or HasPermission(src, commands['reporttoggle'])) then NoPerms(src) return end

    QBCore.Functions.ToggleOptin(src)
    if QBCore.Functions.IsOptin(src) then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.receive_reports"), 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_receive_report"), 'error')
    end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Report Toggle', 'red', '**'..GetPlayerName(src)..'** Use report toggle **', false)

end)

QBCore.Commands.Add('kickall', Lang:t("commands.kick_all"), {}, false, function(source, args)
    local src = source

    if not (QBCore.Functions.HasPermission(src, commands['kickall']) or HasPermission(src, commands['kickall'])) then NoPerms(src) return end

    local reason = table.concat(args, ' ')
    if reason and reason ~= '' then
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player then
                DropPlayer(Player.PlayerData.source, reason)
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("info.no_reason_specified"), 'error')
    end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'KICKAll', 'red', '**'..GetPlayerName(src)..'** Use Kill All**', false)

end)

QBCore.Commands.Add('setammo', Lang:t("commands.ammo_amount_set"), {{name='amount', help='Amount of bullets, for example: 20'}, {name='weapon', help='Name of the weapen, for example: WEAPON_VINTAGEPISTOL'}}, false, function(source, args)
    local src = source
    local weapon = args[2]
    local amount = tonumber(args[1])

    if not (QBCore.Functions.HasPermission(src, commands['setammo']) or HasPermission(src, commands['setammo'])) then NoPerms(src) return end

    if weapon ~= nil then
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
    else
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, 'current', amount)
        TriggerEvent('qb-log:server:CreateLog', 'admin', 'SetAmmo', 'red', '**'..GetPlayerName(src)..'** Use setammo**', false)

    end
end)





-- Teleport

QBCore.Commands.Add('tp', 'TP To Player or Coords (Admin Only)', { { name = 'id/x', help = 'ID of player or X position' }, { name = 'y', help = 'Y position' }, { name = 'z', help = 'Z position' } }, false, function(source, args)
    
    local src = source

    if not (QBCore.Functions.HasPermission(src, commands['tp']) or HasPermission(src, commands['tp'])) then NoPerms(src) return end

    if args[1] and not args[2] and not args[3] then
        local target = GetPlayerPed(tonumber(args[1]))
        if target ~= 0 then
            local coords = GetEntityCoords(target)
            print('**'..GetPlayerName(src)..'** TP to '..GetPlayerName(tonumber(args[1]))..' at Coord '..coords.x..' ,'..coords.y..' ,'..coords.z..'**')
            TriggerClientEvent('QBCore:Command:TeleportToPlayer', source, coords)
            
            TriggerEvent('qb-log:server:CreateLog', 'admin', 'TP', 'red', '**'..GetPlayerName(src)..'** TP to '..GetPlayerName(tonumber(args[1]))..' at Coord '..coords.x..' ,'..coords.y..' ,'..coords.z..'**', false)

        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
        end
    else
        if args[1] and args[2] and args[3] then
            local x = tonumber((args[1]:gsub(",",""))) + .0
            local y = tonumber((args[2]:gsub(",",""))) + .0
            local z = tonumber((args[3]:gsub(",",""))) + .0
            if x ~= 0 and y ~= 0 and z ~= 0 then
                TriggerClientEvent('QBCore:Command:TeleportToCoords', source, x, y, z)
                TriggerEvent('qb-log:server:CreateLog', 'admin', 'TP', 'red', '**'..GetPlayerName(src)..'** TP Coord '..x..' ,'..y..' ,'..z..'**', false)

            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t('error.wrong_format'), 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, Lang:t('error.missing_args'), 'error')
        end
        
    end
end)

QBCore.Commands.Add('tpm', 'TP To Marker (Admin Only)', {}, false, function(source)
    local src = source
    if not (QBCore.Functions.HasPermission(src, commands['tp']) or HasPermission(src, commands['tp'])) then NoPerms(src) return end
    TriggerClientEvent('QBCore:Command:GoToMarker', source)
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'TPM', 'red', '**'..GetPlayerName(src)..'** Use TPM**', false)

end)

-- QBCore.Commands.Add('togglepvp', 'Toggle PVP on the server (Admin Only)', {}, false, function()
--     local src = source
--     if not (QBCore.Functions.HasPermission(src, commands['tp']) or HasPermission(src, commands['tp'])) then NoPerms(src) return end
--     QBConfig.Server.PVP = not QBConfig.Server.PVP
--     TriggerClientEvent('QBCore:Client:PvpHasToggled', -1, QBConfig.Server.PVP)
-- end, 'admin')


-- Vehicle

QBCore.Commands.Add('car', 'Spawn Vehicle (Admin Only)', { { name = 'model', help = 'Model name of the vehicle' } }, true, function(source, args)
    local src = source
    if not (QBCore.Functions.HasPermission(src, commands['spawnVehicle']) or HasPermission(src, commands['spawnVehicle'])) then NoPerms(src) return end
    TriggerClientEvent('QBCore:Command:SpawnVehicle', source, args[1])
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'CAR', 'red', '**'..GetPlayerName(src)..'** Use Car to Spawn '..args[1]..'**', false)

end)

QBCore.Commands.Add('dv', 'Delete Vehicle (Admin Only)', {}, false, function(source)
    local src = source
    if not (QBCore.Functions.HasPermission(src, commands['spawnVehicle']) or HasPermission(src, commands['spawnVehicle'])) then NoPerms(src) return end
    TriggerClientEvent('QBCore:Command:DeleteVehicle', source)
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'DV', 'red', '**'..GetPlayerName(src)..'** Use DV**', false)

end)

-- Money

QBCore.Commands.Add('givemoney', 'Give A Player Money (Admin Only)', { { name = 'id', help = 'Player ID' }, { name = 'moneytype', help = 'Type of money (cash, bank, crypto)' }, { name = 'amount', help = 'Amount of money' } }, true, function(source, args)
    local src = source
    if not (QBCore.Functions.HasPermission(src, commands['money']) or HasPermission(src, commands['money'])) then NoPerms(src) return end
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
        TriggerEvent('qb-log:server:CreateLog', 'admin', 'GIVEMONEY', 'red', '**'..GetPlayerName(src)..'** Use givemoney '..args[3]..' to '..GetPlayerName(args[1])..' in '..args[2]..'**', false)

    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end)

QBCore.Commands.Add('setmoney', 'Set Players Money Amount (Admin Only)', { { name = 'id', help = 'Player ID' }, { name = 'moneytype', help = 'Type of money (cash, bank, crypto)' }, { name = 'amount', help = 'Amount of money' } }, true, function(source, args)
    local src = source
    if not (QBCore.Functions.HasPermission(src, commands['money']) or HasPermission(src, commands['money'])) then NoPerms(src) return end
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
        TriggerEvent('qb-log:server:CreateLog', 'admin', 'SETMONEY', 'red', '**'..GetPlayerName(src)..'** Use setmoney '..args[3]..' to '..GetPlayerName(args[1])..' in '..args[2]..'**', false)

    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end)

-- Inventory (should be in qb-inventory?)

QBCore.Commands.Add('clearinv', 'Clear Players Inventory (Admin Only)', { { name = 'id', help = 'Player ID' } }, false, function(source, args)
    local src = source
    if not (QBCore.Functions.HasPermission(src, commands['inv']) or HasPermission(src, commands['inv'])) then NoPerms(src) return end
    local playerId = args[1] and args[1] ~= '' or source
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Player then
        Player.Functions.ClearInventory()
        TriggerEvent('qb-log:server:CreateLog', 'admin', 'CLEARINV', 'red', '**'..GetPlayerName(src)..'** Clear '..GetPlayerName(playerId)..' **', false)

    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end)


QBCore.Commands.Add('setjob', 'Set A Players Job (Admin Only)', { { name = 'id', help = 'Player ID' }, { name = 'job', help = 'Job name' }, { name = 'grade', help = 'Grade' } }, true, function(source, args)
    local src = source
    if not (QBCore.Functions.HasPermission(src, commands['job']) or HasPermission(src, commands['job'])) then NoPerms(src) return end
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        print('**'..GetPlayerName(src)..'** set '..GetPlayerName(tonumber(args[1]))..' job to '..args[2]..' and grade '..args[3]..'**')
        Player.Functions.SetJob(tostring(args[2]), tonumber(args[3]))
        TriggerEvent('qb-log:server:CreateLog', 'admin', 'SETJOB', 'red', '**'..GetPlayerName(src)..'** set '..GetPlayerName(tonumber(args[1]))..' job to '..args[2]..' and grade '..args[3]..'**', false)

    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end)



QBCore.Commands.Add("revive", Lang:t('info.revive_player_a'), {{name = "id", help = Lang:t('info.player_id')}}, false, function(source, args)
	local src = source
    if not (QBCore.Functions.HasPermission(src, commands['medical']) or HasPermission(src, commands['medical'])) then NoPerms(src) return end
	if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
			TriggerClientEvent('hospital:client:Revive', Player.PlayerData.source)
            TriggerEvent('qb-log:server:CreateLog', 'admin', 'REVIVE', 'red', '**'..GetPlayerName(src)..'** Revive '..GetPlayerName(tonumber(args[1])), false)

		else
			TriggerClientEvent('QBCore:Notify', src, Lang:t('error.not_online'), "error")
		end
	else
		TriggerClientEvent('hospital:client:Revive', src)
        TriggerEvent('qb-log:server:CreateLog', 'admin', 'REVIVE', 'red', '**'..GetPlayerName(src)..'** Set Pain For'..GetPlayerName(src), false)

	end
end)

QBCore.Commands.Add("setpain", Lang:t('info.pain_level'), {{name = "id", help = Lang:t('info.player_id')}}, false, function(source, args)
	local src = source
    if not (QBCore.Functions.HasPermission(src, commands['medical']) or HasPermission(src, commands['medical'])) then NoPerms(src) return end
	if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
			TriggerClientEvent('hospital:client:SetPain', Player.PlayerData.source)
            TriggerEvent('qb-log:server:CreateLog', 'admin', 'SETPAIN', 'red', '**'..GetPlayerName(src)..'** Set Pain For'..GetPlayerName(tonumber(args[1])), false)

		else
			TriggerClientEvent('QBCore:Notify', src, Lang:t('error.not_online'), "error")
		end
	else
		TriggerClientEvent('hospital:client:SetPain', src)
        TriggerEvent('qb-log:server:CreateLog', 'admin', 'SETPAIN', 'red', '**'..GetPlayerName(src)..'** Set Pain For'..GetPlayerName(src), false)

	end
end)

QBCore.Commands.Add("kill", Lang:t('info.kill'), {{name = "id", help = Lang:t('info.player_id')}}, false, function(source, args)
	local src = source
    if not (QBCore.Functions.HasPermission(src, commands['medical']) or HasPermission(src, commands['medical'])) then NoPerms(src) return end
	if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
			TriggerClientEvent('hospital:client:KillPlayer', Player.PlayerData.source)
            TriggerEvent('qb-log:server:CreateLog', 'admin', 'KILL', 'red', '**'..GetPlayerName(src)..'** Kill '..GetPlayerName(tonumber(args[1])), false)

		else
			TriggerClientEvent('QBCore:Notify', src, Lang:t('error.not_online'), "error")
		end
	else
		TriggerClientEvent('hospital:client:KillPlayer', src)
        TriggerEvent('qb-log:server:CreateLog', 'admin', 'KILL', 'red', '**'..GetPlayerName(src)..'** Set Pain For'..GetPlayerName(src), false)

	end
end)

QBCore.Commands.Add('aheal', Lang:t('info.heal_player_a'), {{name = 'id', help = Lang:t('info.player_id')}}, false, function(source, args)
	local src = source
    if not (QBCore.Functions.HasPermission(src, commands['medical']) or HasPermission(src, commands['medical'])) then NoPerms(src) return end
	if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
			TriggerClientEvent('hospital:client:adminHeal', Player.PlayerData.source)
            TriggerEvent('qb-log:server:CreateLog', 'admin', 'AHEAL', 'red', '**'..GetPlayerName(src)..'** Aheal For'..GetPlayerName(tonumber(args[1])), false)

		else
			TriggerClientEvent('QBCore:Notify', src, Lang:t('error.not_online'), "error")
		end
	else
		TriggerClientEvent('hospital:client:adminHeal', src)
        TriggerEvent('qb-log:server:CreateLog', 'admin', 'AHEAL', 'red', '**'..GetPlayerName(src)..'** Aheal For'..GetPlayerName(src), false)

	end
end)

-- Inventory


