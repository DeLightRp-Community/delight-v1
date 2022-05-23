local VehicleNitrous = {}

RegisterNetEvent('tackle:server:TacklePlayer', function(playerId)
    TriggerClientEvent("tackle:client:GetTackled", playerId)
end)

QBCore.Functions.CreateCallback('nos:GetNosLoadedVehs', function(source, cb)
    cb(VehicleNitrous)
end)

QBCore.Commands.Add("id", "Check Your ID #", {}, false, function(source, args)
    local src = source
    TriggerClientEvent('QBCore:Notify', src,  "ID: "..src)
end)

QBCore.Functions.CreateUseableItem("harness", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('seatbelt:client:UseHarness', src, item)
end)

QBCore.Functions.CreateUseableItem("starterpack", function(source)
    local src = source
    TriggerClientEvent('qb-smallrecources:starterpack', src)
end)

QBCore.Functions.CreateUseableItem("medicalbag", function(source,item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        -- TriggerClientEvent('attach:medicalBag', src, item.info.boxid)
        TriggerClientEvent('qb-ambulance:client:openMedicalBag', src, item.info.bagID)
        
    end
end)

RegisterNetEvent('equip:harness', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.items[item.slot].info.uses == 1 then
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['harness'], "remove")
        Player.Functions.RemoveItem('harness', 1)
    else
        Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('seatbelt:DoHarnessDamage', function(hp, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if hp == 0 then
        Player.Functions.RemoveItem('harness', 1, data.slot)
    else
        Player.PlayerData.items[data.slot].info.uses = Player.PlayerData.items[data.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('qb-carwash:server:washCar', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney('cash', Config.DefaultPrice, "car-washed") then
        TriggerClientEvent('qb-carwash:client:washCar', src)
    elseif Player.Functions.RemoveMoney('bank', Config.DefaultPrice, "car-washed") then
        TriggerClientEvent('qb-carwash:client:washCar', src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You dont have enough money..', 'error')
    end
end)

QBCore.Functions.CreateCallback('smallresources:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)


RegisterNetEvent('qb-smallrecources:rewardpack', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('starterpack', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["starterpack"], "remove")
    Player.Functions.AddItem("phone", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["phone"], "add")
    Player.Functions.AddItem("lockpick", math.random(1,2), nil, {["quality"] = 100})
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["lockpick"], "add")
    Player.Functions.AddItem("burger-bleeder", math.random(3,5), nil, {["quality"] = 100})
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["burger-bleeder"], "add")
    Player.Functions.AddItem("water_bottle", math.random(3,5), nil, {["quality"] = 100})
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["water_bottle"], "add")
    Player.Functions.AddItem("repairkit", math.random(1,2), nil, {["quality"] = 100})
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["repairkit"], "add")
    Player.Functions.AddItem("bandage", math.random(1,3), nil, {["quality"] = 100})
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["bandage"], "add")
end)


AddEventHandler("playerSpawned", function()
    if not isCop then
        disablePlayerVehicleRewards(-1);
        end
end)