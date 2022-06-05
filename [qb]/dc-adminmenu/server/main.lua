-- Variables
QBCore = exports['qb-core']:GetCoreObject()
local Sounds = {}
local IsFrozen = {}

--- Checks what permission the source has and what their ranking is in the permission hierachy.
--- @param source number - The player's ID
--- @return number - Ranking of the player in the permission hierachy
local function PermOrder(source)
    for i = 1, #PermissionOrder do
        if not OldPermissionSystem then
            if IsPlayerAceAllowed(source, PermissionOrder[i]) then
                return i
            end
        else
            if QBCore.Functions.GetPermission(source, PermissionOrder[i]) then
                return i
            end
        end
    end
    return #PermissionOrder + 1
end

--- Checks if the source is inside of the target's routingbucket
--- if not set the source's routingbucket to the target's
--- @param source number - The player's ID
--- @param target number - The player's ID
local function CheckRoutingbucket(source, target)
    local sourceBucket = GetPlayerRoutingBucket(source)
    local targetBucket = GetPlayerRoutingBucket(target)
    if sourceBucket ~= targetBucket then SetPlayerRoutingBucket(source, tonumber(targetBucket)) end
end

--- Credits https://github.com/prefech/JD_Perms
function UpdatePermission(source, permission)
    local OldFile, OldText, NewFile, NewText, File
    local license = QBCore.Functions.GetIdentifier(source, 'license')
    if permission == 'user' then
        OldFile = io.open('resources/[qb]/dc-adminmenu/permissions.cfg', 'r')
        OldText = OldFile:read('*a')
        OldFile:close()
        NewText = OldText:gsub('\nadd_principal identifier.'..license..' [^\n]*', '')
        NewFile = io.open('resources/[qb]/dc-adminmenu/permissions.cfg', 'w+')
        NewFile:write(NewText)
        NewFile:close()
        ExecuteCommand("remove_principal identifier."..license.." AdminmenuAdmin")
        ExecuteCommand("remove_principal identifier."..license.." AdminmenuGod")
    else
        File = io.open('resources/[qb]/dc-adminmenu/permissions.cfg', 'a')
        io.output(File)
        local data = "\nadd_principal identifier."..license.." "..permission.. "  # ".. GetPlayerName(source)
        io.write(data)
        io.close(File)
        ExecuteCommand("add_principal identifier."..license.." "..permission)
    end
end

local function types(args)
    local argType = type(args[1])
    for i = 2, #args do
        local arg = args[i]
        if argType == arg then
            return true, argType
        end
    end
    return false, argType
end

function type_check(...)
    local vars = {...}
    -- luacheck: ignore
    for i = 1, #vars do
        local var = vars[i]
        local matchesType, varType = types(var)
        if not matchesType then
            table.remove(var, 1)
            print(("Invalid type sent to argument #%s, expected %s, got %s"):format(i, table.concat(var, "|"), varType))
            return false
        end
        return true
    end
end

--- QBCore.Trim function. Inserted locally to prevent complaining from people not upgrading cores.
function Trim(value)
	if not value then return nil end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

local function CreateLog(id, source, target)
    local Player = QBCore.Functions.GetPlayer(source)
    local Target = QBCore.Functions.GetPlayer(target)
    local Log = {
        'Used **kill** on',
        'Used **revive** on',
        'Used **freeze** on',
        'Used **spectate** on',
        'Used **goto** on',
        'Used **bring** on',
        'Used **into vehicle** on',
        'Used **clothing** on',
    }
    if not Log[id] then TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', 'Tried to create a log which doesn\'t exist. #'..id) print('Tried to create a log which doesn\'t exist. #'..id) return end
    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - %s **%s** (CitizenID: %s | ID: %s) [Log #%s]",
    GetPlayerName(source), Player.PlayerData.citizenid, source, Log[id], GetPlayerName(target), Target.PlayerData.citizenid, target, id))
end

RegisterNetEvent('qb-admin:server:GetPlayersForBlips', function()
    local src = source
    local players = {}
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = QBCore.Functions.GetPlayer(v)
        players[#players+1] = {
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | ' .. GetPlayerName(v),
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer = ped.PlayerData.source
        }
    end
    TriggerClientEvent('qb-admin:client:Show', src, players)
end)

RegisterNetEvent('qb-admin:server:kill', function(player)
    local src = source

    if not (QBCore.Functions.HasPermission(src, events['kill'])) then return end
    if PermOrder(src) > PermOrder(player.id) then return end

    CreateLog(1, src, player.id)
    TriggerClientEvent('hospital:client:KillPlayer', player.id)
end)

RegisterNetEvent('qb-admin:server:revive', function(player)
    local src = source

    if not (QBCore.Functions.HasPermission(src, events['revive'])) then return end

    CreateLog(2, src, player.id)
    TriggerClientEvent('hospital:client:Revive', player.id)
end)

RegisterNetEvent('qb-admin:server:freeze', function(player)
    local src = source
    local TargetSource = player.id
    local TargetPed = GetPlayerPed(TargetSource)

    if not (QBCore.Functions.HasPermission(src, events['freeze'])) then return end
    if PermOrder(src) > PermOrder(TargetSource) then return end
    if IsFrozen[TargetSource] == nil then IsFrozen[TargetSource] = false end

    CreateLog(3, src, player.id)
    if IsFrozen[TargetSource] then
        FreezeEntityPosition(TargetPed, false)
        IsFrozen[TargetSource] = false
    else
        FreezeEntityPosition(TargetPed, true)
        IsFrozen[TargetSource] = true
    end
end)

RegisterNetEvent('qb-admin:server:spectate', function(player)
    local src = source
    local targetped = GetPlayerPed(player.id)
    local coords = GetEntityCoords(targetped)

    if not (QBCore.Functions.HasPermission(src, events['spectate'])) then return end

    CreateLog(4, src, player.id)
    TriggerClientEvent('qb-admin:client:spectate', src, player.id, coords)
end)

RegisterNetEvent('qb-admin:server:goto', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(GetPlayerPed(player.id))
    
    if not (QBCore.Functions.HasPermission(src, events['goto'])) then return end

    CreateLog(5, src, player.id)
    CheckRoutingbucket(src, player.id)
    SetEntityCoords(admin, coords)
end)

RegisterNetEvent('qb-admin:server:bring', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(player.id)
    
    if not (QBCore.Functions.HasPermission(src, events['bring'])) then return end

    CreateLog(6, src, player.id)
    CheckRoutingbucket(player.id, src)
    SetEntityCoords(target, coords)
end)

RegisterNetEvent('qb-admin:server:intovehicle', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local targetPed = GetPlayerPed(player.id)
    local vehicle = GetVehiclePedIsIn(targetPed, false)
    local seat = -1

    if not (QBCore.Functions.HasPermission(src, events['intovehicle'])) then return end
    if vehicle == 0 then TriggerClientEvent('QBCore:Notify', src, Lang:t("error.player_no_vehicle"), 'error', 4000) return end
    for i = 0, 8, 1 do if GetPedInVehicleSeat(vehicle, i) == 0 then seat = i break end end
    if seat == -1 then TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_free_seats"), 'error', 4000) return end

    CreateLog(7, src, player.id)
    SetPedIntoVehicle(admin, vehicle, seat)
    TriggerClientEvent('QBCore:Notify', src, Lang:t("success.entered_vehicle"), 'success', 5000)
end)

RegisterNetEvent('qb-admin:server:routingbucket', function(player, bucket)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(player.id)

    if not (QBCore.Functions.HasPermission(src, events['routingbucket'])) then return end
    if GetPlayerRoutingBucket(player.id) == tonumber(bucket) then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Used **routingbucket** on **%s** (CitizenID: %s | ID: %s) and went to bucket **%s**",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(player.id), Target.PlayerData.citizenid, player.id, tonumber(bucket)))
    SetPlayerRoutingBucket(player.id, tonumber(bucket))
end)

RegisterNetEvent('qb-admin:server:kick', function(player, reason)
    local src = source
    local target = player.id
    
    if not (QBCore.Functions.HasPermission(src, events['kick'])) then return end
    if PermOrder(src) > PermOrder(target) then return end
    
    TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Kicked', 'red', string.format('%s was kicked by %s for %s', GetPlayerName(target), GetPlayerName(src), reason), true)
    DropPlayer(target, Lang:t("info.kicked_server") .. ':\n' .. reason .. '\n\n' .. Lang:t("info.check_discord") .. QBCore.Config.Server.discord)
end)

RegisterNetEvent('qb-admin:server:ban', function(player, time, reason)
    local src = source
    local target = player.id
    local banTime = tonumber(os.time() + tonumber(time))
    if banTime > 2147483647 then banTime = 2147483647 end
    local timeTable = os.date('*t', banTime)
    
    if not (QBCore.Functions.HasPermission(src, events['ban'])) then return end
    if PermOrder(src) > PermOrder(target) then return end

    MySQL.Async.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(target),
        QBCore.Functions.GetIdentifier(target, 'license'),
        QBCore.Functions.GetIdentifier(target, 'discord'),
        QBCore.Functions.GetIdentifier(target, 'ip'),
        reason,
        banTime,
        GetPlayerName(src)
    })
    TriggerClientEvent('chat:addMessage', -1, {
        template = "<div class=chat-message server'><strong>ANNOUNCEMENT | {0} has been banned:</strong> {1}</div>",
        args = {GetPlayerName(target), reason}
    })
    TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(target), GetPlayerName(src), reason), true)
    if banTime >= 2147483647 then
        DropPlayer(target, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_perm") .. QBCore.Config.Server.discord)
    else
        DropPlayer(target, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Check our Discord for more information: ' .. QBCore.Config.Server.discord)
    end
end)

RegisterNetEvent('qb-admin:server:setPermissions', function(targetId, group)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(targetId)

    if not (QBCore.Functions.HasPermission(src, events['setPermissions'])) then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Changed **%s** (CitizenID: %s | ID: %s) **permissions** to **%s**",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(targetId), Target.PlayerData.citizenid, targetId, group.label))
    TriggerClientEvent('QBCore:Notify', targetId, Lang:t("info.rank_level")..group.label)
    TriggerClientEvent('QBCore:Notify', src, Lang:t("success.changed_perm")..' : '..group.label)
    UpdatePermission(targetId, group.rank)
end)

RegisterNetEvent('qb-admin:server:cloth', function(player)
    local src = source

    if not (QBCore.Functions.HasPermission(src, events['cloth'])) then return end

    CreateLog(8, src, player.id)
    TriggerClientEvent('qb-clothing:client:openMenu', player.id)
end)

RegisterNetEvent('qb-admin:server:spawnVehicle', function(model)
    local src = source
    local hash = GetHashKey(model)
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerPed = GetPlayerPed(src)
    local coords = GetEntityCoords(PlayerPed)
    local heading = GetEntityHeading(PlayerPed)
    local oldvehicle = GetVehiclePedIsIn(PlayerPed, false)

    if not (QBCore.Functions.HasPermission(src, events['spawnVehicle'])) then return end
    if oldvehicle ~= 0 then DeleteEntity(oldvehicle) end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Spawned in a **%s**",
    GetPlayerName(src), Player.PlayerData.citizenid, src, model))
    local vehicle = CreateVehicle(hash, coords, true, true)
    while not DoesEntityExist(vehicle) do Wait(0) end
    SetEntityHeading(vehicle, heading)
    TaskWarpPedIntoVehicle(PlayerPed, vehicle, -1)
    TriggerClientEvent('vehiclekeys:client:SetOwner', src, GetVehicleNumberPlateText(vehicle))
end)

RegisterNetEvent('qb-admin:server:SaveCar', function(mods, vehicle, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.Sync.fetchAll('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })

    if result[1] ~= nil then TriggerClientEvent('QBCore:Notify', src, Lang:t("error.failed_vehicle_owner"), 'error', 3000) return end
    if not (QBCore.Functions.HasPermission(src, events['savecar'])) then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Saved a car to his garage **%s**",
    GetPlayerName(src), Player.PlayerData.citizenid, src, vehicle.model))
    MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        Player.PlayerData.license,
        Player.PlayerData.citizenid,
        vehicle.model,
        vehicle.hash,
        json.encode(mods),
        plate,
        0
    })
    TriggerClientEvent('QBCore:Notify', src, Lang:t("success.success_vehicle_owner"), 'success', 5000)
end)

RegisterNetEvent('qb-admin:server:vehicleplate', function(Plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Vehicle = GetVehiclePedIsIn(GetPlayerPed(src), false)
    local NewPlate = Trim(Plate):upper()
    local OldPlate = Trim(GetVehicleNumberPlateText(Vehicle))
    local VehicleHash = GetEntityModel(Vehicle)

    if not (QBCore.Functions.HasPermission(src, events['platecar'])) then return end
    if Vehicle == 0 then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Changed a plate from **%s** to **%s**",
    GetPlayerName(src), Player.PlayerData.citizenid, src, OldPlate, NewPlate))
    SetVehicleNumberPlateText(Vehicle, NewPlate)
    TriggerClientEvent('vehiclekeys:client:SetOwner', src, NewPlate)
    local result = MySQL.single.await('SELECT * FROM player_vehicles WHERE plate = ? AND hash = ?', {OldPlate, VehicleHash})
    if not result then return end
    MySQL.update('UPDATE player_vehicles SET plate = ? WHERE plate = ? AND hash = ? AND citizenid = ?', {NewPlate, OldPlate, VehicleHash, result.citizenid})
end)

RegisterNetEvent('qb-admin:server:getsounds', function()
    local src = source

    if not (QBCore.Functions.HasPermission(src, events['playsound'])) then return end

    TriggerClientEvent('qb-admin:client:getsounds', src, Sounds)
end)

AddEventHandler('qb-admin:server:SendReport', function(name, targetSrc, msg)
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        if QBCore.Functions.HasPermission(v, 'admin') then
            TriggerClientEvent('chat:addMessage', v, {
                color = {255, 0, 0},
                multiline = true,
                args = {Lang:t("info.admin_report")..name..' ('..targetSrc..')', msg}
            })
        end
	end
end)

AddEventHandler('qb-admin:server:Staffchat:addMessage', function(name, msg)
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        if QBCore.Functions.HasPermission(v, 'admin') then
            TriggerClientEvent('chat:addMessage', v, {
                color = {255, 0, 0},
                multiline = true,
                args = {Lang:t("info.staffchat")..name, msg}
            })
        end
	end
end)

RegisterNetEvent('qb-admin:server:playsound', function(target, soundname, soundvolume, soundradius)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local Target = QBCore.Functions.GetPlayer(target)

    if not (QBCore.Functions.HasPermission(src, events['playsound'])) then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Played a sound on **%s** (CitizenID: %s | ID: %s) - Sound: **%s** - Volume: **%s** - Radius: **%s**",
    GetPlayerName(src), Player.PlayerData.citizenid, src, GetPlayerName(target), Target.PlayerData.citizenid, target, soundname, soundvolume, soundradius))
    TriggerClientEvent('qb-admin:client:playsound', target, soundname, soundvolume, soundradius)
end)

RegisterNetEvent('qb-admin:server:getradiolist', function(channel)
    local src = source
    local list = exports['pma-voice']:getPlayersInRadioChannel(tonumber(channel))
    local Player = QBCore.Functions.GetPlayer(src)
    local Players = {}

    if not (QBCore.Functions.HasPermission(src, events['getradiolist'])) then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Pulled radiofrequency number **%s**",
    GetPlayerName(src), Player.PlayerData.citizenid, src, tonumber(channel)))
    for targetSource, _ in pairs(list) do -- cheers Knight who shall not be named
        local _Player = QBCore.Functions.GetPlayer(targetSource)
        Players[#Players + 1] = {
            id = targetSource,
            name = _Player.PlayerData.charinfo.firstname .. ' ' .. _Player.PlayerData.charinfo.lastname .. ' | (' .. GetPlayerName(targetSource) .. ')'
        }
    end
    TriggerClientEvent('qb-admin:client:getradiolist', src, Players, channel)
end)

RegisterNetEvent('qb-admin:server:check', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if QBCore.Functions.HasPermission(src, events['usemenu']) then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Tried to use the admin menu when he isn\'t supposed to?",
    GetPlayerName(src), Player.PlayerData.citizenid, src))
    DropPlayer(src, Lang:t("info.dropped"))
end)

RegisterNetEvent('qb-admin:server:giveallweapons', function(Weapontype, PlayerID)
    local src = PlayerID or source
    local Target = QBCore.Functions.GetPlayer(src)
    local Player = QBCore.Functions.GetPlayer(source)

    if not QBCore.Functions.HasPermission(source, events['giveallweapons']) then return end

    TriggerEvent('qb-log:server:CreateLog', 'admin', 'Admin menu', 'pink', string.format("**%s** (CitizenID: %s | ID: %s) - Pulled all the %s weapons for **%s** (CitizenID: %s | ID: %s)",
    GetPlayerName(source), Player.PlayerData.citizenid, source, Weapontype, GetPlayerName(src), Target.PlayerData.citizenid, src))
    for i = 1, #Weaponlist[Weapontype], 1 do
        if not QBCore.Shared.Items[Weaponlist[Weapontype][i]] then return end
        Target.Functions.AddItem(Weaponlist[Weapontype][i], 1)
    end
end)

QBCore.Functions.CreateCallback('qb-adminmenu:callback:getdealers', function(source, cb)
    if not QBCore.Functions.HasPermission(source, events['usemenu']) then return end

    cb(exports['qb-drugs']:GetDealers())
end)

QBCore.Functions.CreateCallback('qb-adminmenu:callback:getplayers', function(source, cb)
    if not QBCore.Functions.HasPermission(source, events['usemenu']) then return end

    local players = {}
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local ped = QBCore.Functions.GetPlayer(v)
        players[#players+1] = {
            id = v,
            cid = ped.PlayerData.citizenid,
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | (' .. GetPlayerName(v) .. ')',
            food = ped.PlayerData.metadata['hunger'],
            water = ped.PlayerData.metadata['thirst'],
            stress = ped.PlayerData.metadata['stress'],
            armor = ped.PlayerData.metadata['armor'],
            phone = ped.PlayerData.charinfo.phone,
            craftingrep = ped.PlayerData.metadata['craftingrep'],
            dealerrep = ped.PlayerData.metadata['dealerrep'],
            cash = ped.PlayerData.money['cash'],
            bank = ped.PlayerData.money['bank'],
            job = ped.PlayerData.job.label .. ' | ' .. ped.PlayerData.job.grade.level,
            gang = ped.PlayerData.gang.label,
        }
    end
        -- Sort players list by source ID (1,2,3,4,5, etc) --
        table.sort(players, function(a, b)
            return a.id < b.id
        end)
        ------
    cb(players)
end)

QBCore.Functions.CreateCallback('qb-adminmenu:callback:getplayer', function(source, cb, TargetID)
    if not QBCore.Functions.HasPermission(source, events['usemenu']) then return end

    local ped = QBCore.Functions.GetPlayer(TargetID)
    local player = {
        id = TargetID,
        cid = ped.PlayerData.citizenid,
        name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | (' .. GetPlayerName(TargetID) .. ')',
        food = ped.PlayerData.metadata['hunger'],
        water = ped.PlayerData.metadata['thirst'],
        stress = ped.PlayerData.metadata['stress'],
        armor = ped.PlayerData.metadata['armor'],
        phone = ped.PlayerData.charinfo.phone,
        craftingrep = ped.PlayerData.metadata['craftingrep'],
        dealerrep = ped.PlayerData.metadata['dealerrep'],
        cash = ped.PlayerData.money['cash'],
        bank = ped.PlayerData.money['bank'],
        job = ped.PlayerData.job.label .. ' | ' .. ped.PlayerData.job.grade.level,
        gang = ped.PlayerData.gang.label,
    }
    cb(player)
end)

CreateThread(function()
    local path = GetResourcePath(SoundScriptName)
    local directory = path:gsub('//', '/')..SoundPath
    if not Linux then
        for filename in io.popen('dir "'..directory..'" /b'):lines() do
            Sounds[#Sounds + 1] = filename:match("(.+)%..+$")
        end
    else
        for filename in io.popen('ls "'..directory..'" /b'):lines() do
            Sounds[#Sounds + 1] = filename:match("(.+)%..+$")
        end
    end
    PerformHttpRequest('https://api.github.com/repos/Disabled-Coding/dc-adminmenu/releases/latest', function(_, resultData, _)
        if not resultData then print('Failed to check for updates') return end
        local result = json.decode(resultData)
        if GetResourceMetadata(GetCurrentResourceName(), 'version') ~= result.tag_name then
            print('New version of '..GetCurrentResourceName()..' is available!')
        end
    end)
end)
