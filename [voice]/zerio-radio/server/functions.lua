Framework = exports["qb-core"]:GetCoreObject()

if Config.OpenType == "item" then
    Framework.Functions.CreateUseableItem(Config.Item, function(source, item)
        TriggerClientEvent("zerio-radio:client:open", source)
    end)
end

Framework.Functions.CreateCallback('zerio-radio:server:GetbabatItem', function(source, cb, item)
    local src = source
    local Player = Framework.Functions.GetPlayer(src)
    if Player ~= nil then
        local RadioItem = Player.Functions.GetItemByName(item)
        if RadioItem ~= nil and not Player.PlayerData.metadata["isdead"] and
            not Player.PlayerData.metadata["inlaststand"] then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)