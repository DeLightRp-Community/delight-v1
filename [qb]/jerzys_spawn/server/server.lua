local coreName = Config.coreName;
coreName = exports['qb-core']:GetCoreObject()
local data = {}

--[[ Check Admin ]]--
RegisterNetEvent('jerzys_spawn:server:checkAdmin', function()
    local source = source
    local isGod = coreName.Functions.HasPermission(source, 'god')
    local isAdmin = coreName.Functions.HasPermission(source, 'admin')
    if isGod or isAdmin then
        TriggerClientEvent('jerzys_spawn:client:enableDev', source)
    end
end)

--[[ Update all Spawn Points ]]---
RegisterNetEvent('jerzys_spawn:server:updateAll', function (source)
    local source = source
    local player = coreName.Functions.GetPlayer(source)
    local job =player.PlayerData.job.name
    local gang = player.PlayerData.gang.name
    table.remove(data)
    MySQL.query('SELECT * FROM jerzys_spawns WHERE deleted = 0 AND showall = 1 OR JOB = ? OR GANG = ?', {job,gang}, function(result)
        for k,v in pairs(result) do
            data[k] = {
                ["cord_id"] = v.id,
                ["cord_name"]= v.cord_name,
                ["cord_desc"] = v.cord_description,
                ["x_cord"] = v.x_cord,
                ["y_cord"] = v.y_cord,
                ["z_cord"] = v.z_cord,
                ["top_value"] = v.top_value,
                ["left_value"] = v.left_value,
                ["gang"] = v.gang,
                ["job"] = v.job,
                ["all"] = v.all,
               }
            end
        TriggerClientEvent('jerzys_spawn:client:updateAll',source, data)
    end)
end)


--[[ Get all Spawn Points ]] --
RegisterNetEvent('jerzys_spawn:server:getAll', function ()
    local source = source
    local player = coreName.Functions.GetPlayer(source)
    local job = player.PlayerData.job.name
    local gang = player.PlayerData.gang.name
    table.remove(data)

    MySQL.query('SELECT * FROM jerzys_spawns WHERE deleted = 0 AND showall = 1 OR job = ? OR gang = ?', {job,gang},function(result)
        if result[1] then
            for k,v in pairs(result) do
                data[k] = {
                    ["cord_id"] = v.id,
                    ["cord_name"]= v.cord_name,
                    ["cord_desc"] = v.cord_description,
                    ["x_cord"] = v.x_cord,
                    ["y_cord"] = v.y_cord,
                    ["z_cord"] = v.z_cord,
                    ["top_value"] = v.top_value,
                    ["left_value"] = v.left_value,
                    ["gang"] = v.gang,
                    ["job"] = v.job,
                    ["all"] = v.all,
                    }
                end
        end
        TriggerClientEvent('jerzys_spawn:client:pushData', source, data, apartments)
    end)
end)

--[[ Create Spawn ]] --
RegisterNetEvent('jerzys_spawn:server:createNode', function (data)
    local source = source
    local isGod = coreName.Functions.HasPermission(source, 'god')
    local isAdmin = coreName.Functions.HasPermission(source, 'admin')
    if isGod or isAdmin then
        local d = data;
        if d ~= nil then
            MySQL.query('INSERT INTO jerzys_spawns (cord_name,cord_description,x_cord,y_cord,z_cord,top_value,left_value,deleted) VALUES (?,?,?,?,?,?,?,?)',{d.cordName,d.cordDesc,d.x_cord,d.y_cord,d.z_cord,d.top_value,d.left_value,false}, function (id)
                TriggerEvent('jerzys_spawn:server:updateAll', source)
                TriggerClientEvent('jerzys_spawn:client:handle',source, {message = Lang:t('success.saveCords'), type = "noti_success", title = Lang:t('success.title')})
            end)
        end
    else
        TriggerClientEvent('jerzys_spawn:client:handle',source, {message = Lang:t('error.permission'), type = "noti_error", title = 'Error'})
    end
end)

-- [[ Delete Spawn ]] --
RegisterNetEvent('jerzys_spawn:server:deleteNode', function(data)
    local source = source
    local isGod = coreName.Functions.HasPermission(source, 'god')
    local isAdmin = coreName.Functions.HasPermission(source, 'admin')
    if isGod or isAdmin then
    local d = data
        if d ~= nil then
            MySQL.query('UPDATE jerzys_spawns SET deleted = ? WHERE id = ?', {true, d.id}, function ()
                TriggerEvent('jerzys_spawn:server:updateAll', source)
                TriggerClientEvent('jerzys_spawn:client:handle',source, {message = Lang:t('success.delete'), type = "noti_success", title = Lang:t('success.title')})
            end)
        end
    else
        TriggerClientEvent('jerzys_spawn:client:handle',source, {message = Lang:t('error.permission'), type = "noti_error", title = Lang:t('error.title')})
    end
end)

-- [[ Update Coords]] --
RegisterNetEvent('jerzys_spawn:server:updateCords', function(data)
    local source = source
    local isGod = coreName.Functions.HasPermission(source, 'god')
    local isAdmin = coreName.Functions.HasPermission(source, 'admin')
    if isGod or isAdmin then
        local d = data
        if d ~= nil then
            MySQL.query('UPDATE jerzys_spawns SET top_value = ?, left_value = ? WHERE id = ?', {d.top_value,d.left_value,d.id}, function ()
                TriggerEvent('jerzys_spawn:server:updateAll', source)
                TriggerClientEvent('jerzys_spawn:client:handle',source, {message = Lang:t('success.update'), type = "noti_success", title = Lang:t('success.title')})
            end)
        end
    else
        TriggerClientEvent('jerzys_spawn:client:handle',source, {message = Lang:t('error.permission'), type = "noti_error", title = Lang:t('error.title')})
    end
end)

--[[ Update Coords Name/Desc/Vec ]]--
RegisterNetEvent('jerzys_spawn:server:updateNode', function (data)
    local source = source
    local isGod = coreName.Functions.HasPermission(source, 'god')
    local isAdmin = coreName.Functions.HasPermission(source, 'admin')
    if isGod or isAdmin then
        local d = data
        if d ~= nil then
            table.remove(data)
            MySQL.query('UPDATE jerzys_spawns SET cord_name = ?, cord_description = ?, x_cord = ?, y_cord = ?, z_cord = ? WHERE id = ?', {d.cordName,d.cordDesc,d.x_cord,d.y_cord,d.z_cord,d.id}, function ()        
                TriggerEvent('jerzys_spawn:server:updateAll', source)
                TriggerClientEvent('jerzys_spawn:client:handle',source, {message = Lang:t('success.update'), type = "noti_success", title = Lang:t('success.title')})
            end)
        end
    else
        TriggerClientEvent('jerzys_spawn:client:handle',source, {message = Lang:t('error.permission'), type = "noti_error", title = Lang:t('error.title')})
    end
end)

-- [[ Get Owned Apartments or Houses ]] --
coreName.Functions.CreateCallback('qb-spawn:server:getOwnedApartments', function(source, cb)
    local source = source
    local player = coreName.Functions.GetPlayer(source)
    local cid = player.PlayerData.citizenid
    local houses = MySQL.Sync.fetchAll('SELECT * FROM player_houses WHERE citizenid = ?', {cid})
    local apartements = MySQL.Sync.fetchAll('SELECT * FROM apartments WHERE citizenid = ?', {cid})
    if houses[1] and apartements[1] then
        cb(houses,apartements)
    elseif houses[1] and not apartements[1] then
        cb(houses,nil)
    elseif apartements[1] and not houses[1] then
        cb(nil, apartements)
    else
        cb(nil,nil)
    end
end)
