local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('inventory:server:SaveInventory', function(type, id)
    local source = source
	-- wait(400)
    -- print(id)
    if id~=nil and string.find(id, "tunerStash") then
        local result ={}
        local result = MySQL.Sync.fetchAll('SELECT * FROM stashitems WHERE stash = @plate', { ["@plate"] = id })
        Wait(400)
        TriggerClientEvent('re2-tunerjob:modify:upgrade',source,result)
    end
end)

RegisterServerEvent("re2-tunerjob:updateVehicle")
AddEventHandler("re2-tunerjob:updateVehicle", function(myCar)
    local src = source
    if IsVehicleOwned(myCar.plate) then
        MySQL.Sync.execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(myCar), myCar.plate})
    end
end)

function IsVehicleOwned(plate)
    local retval = false
    local result = MySQL.Sync.fetchAll('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        retval = true
    end
    return retval
end
RegisterNetEvent("re2-tunerjob:addToPrice")
AddEventHandler("re2-tunerjob:addToPrice", function(source,price)
    local src = source
    TriggerClientEvent('re2-tunerjob:addToPrice',src,price)
end)


RegisterNetEvent("re2-tunerjob:giveRecipe")
AddEventHandler("re2-tunerjob:giveRecipe", function(car)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if car.totalPrice > 0 then
        local info = {
            label = "Modification Recipe For  "..car.vehicle.plate.." Total Price = "..car.totalPrice,
            data = car,
            verify = false
        }
        Player.Functions.AddItem("carrecipe", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["carrecipe"], "add")
    end
    
end)


QBCore.Functions.CreateUseableItem("carrecipe", function(source, item)
	TriggerClientEvent('re2-tuner:client:show-image', source)
    print(json.encode(item))
end)
function verifyRecipe()

end

RegisterNetEvent("re2-tunerjob:requestTuning")
AddEventHandler("re2-tunerjob:requestTuning", function(plate)
    print("hello")
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local balance = Player.Functions.GetMoney("bank")
    local slot = QBCore.Player.GetFirstSlotByItem(Player.PlayerData.items, "carrecipe")
    local ItemSlot = Player.PlayerData.items[slot]
    local tuneCost = ItemSlot.info.data.totalPrice
    local carTunes= ItemSlot.info.data.vehicle
    if ItemSlot.info.data.vehicle.plate==plate then
        if balance >= tuneCost then
            Player.Functions.RemoveMoney("bank", tuneCost, "TunerShop")
            Player.Functions.RemoveItem("carrecipe", 1)
            MySQL.Sync.execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(carTunes), carTunes.plate})
            Wait(100)
            TriggerClientEvent('re2-tunerjob:purchaseSuccessful', source,carTunes)
            
        else
            TriggerClientEvent('re2-tunerjob:purchaseFailed', source)
        end
    else
        TriggerClientEvent('re2-tunerjob:purchaseFailed', source)
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

QBCore.Functions.CreateCallback('re2-tunerjob:server:craftItem', function (source, cb, data)
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

RegisterNetEvent('', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem('chemicals', 1)
	Player.Functions.AddItem('hydrochloric_acid', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['chemicals'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['hydrochloric_acid'], "add")
	TriggerClientEvent('QBCore:Notify', src, 'Hydrochloric acid process was succesful !', "success")
end)