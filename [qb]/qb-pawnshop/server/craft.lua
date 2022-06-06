local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('inventory:server:SaveInventory', function(type, id)
    local src = source
    -- print(id)
    if type=="stash" and id~=nil and id =="pawnshopcraft" then
        local result ={}
        Wait(100)
        result = MySQL.Sync.fetchAll('SELECT * FROM stashitems WHERE stash = @pawn', { ["@pawn"] = id })
        
        local itemOne =json.decode(result[1].items)[1]
        if result[1]~=nil and itemOne~=nil and itemOne.name == "recyclepart" then
            -- print(json.encode(itemOne))
            TriggerClientEvent('qb-pawnshop:carf:choose',src,itemOne.amount)
        else
            
        end
    end
end)



QBCore.Functions.CreateCallback('qb-pawnshop:server:craftItem', function (source, cb, data)
    local src = source
    -- print(QBCore.Shared.Items[data.name].weight)
    -- ''
    TriggerClientEvent('qb-pawnshop:craft:disable',-1,data.count)
    local item = '[{"weight":'..QBCore.Shared.Items[data.name].weight*data.count..',"useable":false,"unique":false,"info":[],"slot":1,"name":"'..data.name..'","type":"item","label":"'..QBCore.Shared.Items[data.name].label..'","image":"'..QBCore.Shared.Items[data.name].image..'","amount":'..data.count..'}]'
    MySQL.Sync.fetchAll('UPDATE stashitems SET items=@item WHERE stash=@stash', { ["@item"] = item, ["@stash"] = 'pawnshopcraft' })
    return cb(true)

end)

function tointeger(x)
    num = tonumber(x)
    return num < 0 and math.ceil( num ) or math.floor( num )
end