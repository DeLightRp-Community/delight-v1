local QBCore = exports['qb-core']:GetCoreObject()


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

-----------------------------------------------------------------------------------------
-- Selling Items to Pawn Store
-----------------------------------------------------------------------------------------
RegisterNetEvent("qb-pawnshop:server:sellPawnItems", function(itemName, itemAmount, itemPrice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPrice = (tonumber(itemAmount) * itemPrice)

    if Player.Functions.RemoveItem(itemName, tonumber(itemAmount)) then
        if Config.SocietyMoney then
            exports['qb-management']:AddMoney(Player.PlayerData.job.name, totalPrice)
            --TriggerEvent('qb-bossmenu:server:addAccountMoney','pawnshop', totalPrice)
        else
            Player.Functions.AddMoney("cash", totalPrice)
        end
        TriggerClientEvent("QBCore:Notify", src, Lang:t('success.sold', {value = tonumber(itemAmount), value2 = QBCore.Shared.Items[itemName].label, value3 = totalPrice}), 'success')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
        TriggerClientEvent("QBCore:Notify", src, Lang:t('error.no_items'), "error")
    end
end)

QBCore.Functions.CreateCallback('qb-pawnshop:server:getInv', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items

    return cb(inventory)
end)
-----------------------------------------------------------------------------------------
-- Billing
-----------------------------------------------------------------------------------------
RegisterServerEvent("qb-pawnshop:server:Charge", function(citizen, price)
    local src = source
    local biller = QBCore.Functions.GetPlayer(source)
    local billed = QBCore.Functions.GetPlayer(tonumber(citizen))
    local amount = tonumber(price)
    local commission = amount * 0.10 -- AMOUNT THE EMPLOYEE RECEIVES AS COMMISSION (15% BY DEFAULT)
	if billed ~= nil then
		if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then

			if amount <= biller.PlayerData.money["cash"] then 
                billed.Functions.AddMoney('cash', amount, "pawn-payment")

                biller.Functions.RemoveMoney('cash', amount, "pawn-payment")

                exports['qb-management']:AddMoney(player.PlayerData.job.name, commission)
                TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, '$'..amount..' payment received.', 'success') -- CUSTOMER NOTIFICATION OF PAYMENT
                TriggerClientEvent('QBCore:Notify', biller.PlayerData.source, '$'..amount..' payment sent, commission received successfully.', 'success') -- EMPLOYEE NOTIFICATION OF PAYMENT
			else TriggerClientEvent('QBCore:Notify', src, 'You dont have enough money', 'error')	end
		else TriggerClientEvent('QBCore:Notify', src, 'You cannot pay yourself...', 'error') end
	else TriggerClientEvent('QBCore:Notify', src, 'Person not available', 'error') end
end) 


