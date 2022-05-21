QBCore = exports['qb-core']:GetCoreObject()
QBCore.Functions.CreateCallback("qb-banking:server:GetBankData", function(source, cb,bankType)
    local src = source
    if not src then return end
    print(bankType)
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    local PlayerMoney = Player.PlayerData.money["bank"] or 0 
    local PlayerPaycheck = Player.PlayerData.money["paycheck"] or 0 
    local CitizenId = Player.PlayerData.citizenid 

    local TransactionHistory = {}
    local TransactionRan = false
    local tbl = {}
    tbl[1] = {
        type = "personal",
        amount = PlayerMoney
    }
    if bankType == "bigbank" then
        tbl[2] = {
            type = "paycheck",
            name = "paycheck",
            amount = PlayerPaycheck
        }
    end 

    local job = Player.PlayerData.job
    if (job.name and job.grade.name) then
        if(SimpleBanking.Config["business_ranks"][job.grade.name] or SimpleBanking.Config["business_ranks_overrides"][job.name] and SimpleBanking.Config["business_ranks_overrides"][job.name][job.grade.name]) then
            local result =  MySQL.Sync.fetchAll('SELECT * FROM management_funds WHERE job_name= ?', {job.name})
            local data = result[1]

            if data ~= nil then
                tbl[#tbl + 1] = {
                    type = "business",
                    name = job.name,
                    amount = format_int(data.amount) or 0
                }
            end
        end
    end

    local gang = Player.PlayerData.gang

    if (gang.name and gang.grade.name) then
        if(SimpleBanking.Config["gang_ranks"][string.lower(gang.grade.name)] or SimpleBanking.Config["gang_ranks_overrides"][string.lower(gang.name)] and SimpleBanking.Config["gang_ranks_overrides"][string.lower(gang.name)][string.lower(gang.grade.name)]) then

            local result = MySQL.Sync.fetchAll('SELECT * FROM management_funds WHERE job_name= ?', {gang.name})
            local data = result[1]

            if data ~= nil then
                tbl[#tbl + 1] = {
                    type = "organization",
                    name = gang.label,
                    amount = format_int(data.amount) or 0
                }
            end
        end
    end
    
    local result = MySQL.Sync.fetchAll("SELECT * FROM transaction_history WHERE citizenid =  ? AND DATE(date) > (NOW() - INTERVAL "..SimpleBanking.Config["Days_Transaction_History"].." DAY)", {Player.PlayerData.citizenid})

    if result ~= nil then
        TransactionRan = true
        TransactionHistory = result
    end
    

    repeat
        Wait(0)
    until 
        TransactionRan
    cb(tbl, TransactionHistory, bankType)
end)

QBCore.Commands.Add('givecash', 'Usage /givecash [ID] [AMOUNT]', {{name = 'id', help = 'Player ID'}, {name = 'amount', help = 'Amount'}}, true, function(source, args)
    local src = source
	local id = tonumber(args[1])
	local amount = math.ceil(tonumber(args[2]))

	if id and amount then
		local xPlayer = QBCore.Functions.GetPlayer(src)
		local xReciv = QBCore.Functions.GetPlayer(id)

		if xReciv and xPlayer then
			if not xPlayer.PlayerData.metadata["isdead"] then
				local distance = xPlayer.PlayerData.metadata["inlaststand"] and 3.0 or 10.0
				if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(id))) < distance then
                    if amount > 0 then
                        if xPlayer.Functions.RemoveMoney('cash', amount) then
                            if xReciv.Functions.AddMoney('cash', amount) then
                                TriggerClientEvent('QBCore:Notify', src, Lang:t('success.give_cash',{id = tostring(id), cash = tostring(amount)}), "success")
                                TriggerClientEvent('QBCore:Notify', id, Lang:t('success.received_cash',{id = tostring(src), cash = tostring(amount)}), "success")
                                TriggerClientEvent("payanimation", src)
                            else
                                -- Return player cash
                                xPlayer.Functions.AddMoney('cash', amount)
                                TriggerClientEvent('QBCore:Notify', src, "Could not give item to the given id.", "error")
                            end
                        else
                            TriggerClientEvent('QBCore:Notify', src, "You don\'t have this amount.", "error")
                        end
                    else
                        TriggerClientEvent('QBCore:Notify', src, "Invalid Amount Given", "error")
                    end
				else
					TriggerClientEvent('QBCore:Notify', src, "You are too far away lmfao.", "error")
				end
			else
				TriggerClientEvent('QBCore:Notify', src, "You are dead LOL.", "error")
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "Wrong ID.", "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, "Usage /givecash [ID] [AMOUNT]", "error")
	end
end)
