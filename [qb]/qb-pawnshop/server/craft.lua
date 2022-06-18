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

local function hasCraftItems(source, CostItems, amount)
	local Player = QBCore.Functions.GetPlayer(source)
    print(json.encode(CostItems))
	for k, v in pairs(CostItems) do
		if Player.Functions.GetItemByName(k) ~= nil then
			if Player.Functions.GetItemByName(k).amount < (v * amount) then
				return false
			end
		else
			return false
		end
	end
	return true
end

QBCore.Functions.CreateCallback('qb-pawnshop:server:craftiLiggalItem', function (source, cb, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    print(hasCraftItems(src,data.material, 1))
    if hasCraftItems(src,data.material, 1) then
        for k, v in pairs(data.material) do
            Player.Functions.RemoveItem(k, v)
        end
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[data["name"]], "add")
	    TriggerClientEvent('QBCore:Notify', src, QBCore.Shared.Items[data["name"]].label..'craft was succesful !', "success")
        Player.Functions.AddItem(data["name"], 1)
        return cb(true)
    else
        return cb(false)
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