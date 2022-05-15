local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('CL-Records:BuyGlass', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money.cash >= data.price then
        Player.Functions.RemoveMoney("cash", data.price)
        Player.Functions.AddItem(data.glass, 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[data.glass], "add")
        TriggerClientEvent('QBCore:Notify', src, data.glassname .. ' Successfully Bought', "success")   
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Dont Have Enough Money !', "error")              
    end   
end)

QBCore.Functions.CreateUseableItem("rwine", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:Drink", src, 'rwine', 'p_wine_glass_s', 28422, { x=0.01, y=-0.01, z=-0.07 }, { x=0.0, y=0.0, z=0.0 })                                                              				
end)

QBCore.Functions.CreateUseableItem("rwhitewine", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkWhiteWine", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rwhiskey", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkWhiskey", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rbeer", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkBeer", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rsake", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkRegularSake", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rsamuraisake", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkSamuraiSake", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rgoldsake", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkGoldSake", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rpinksake", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkPinkSake", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rwhitesake", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkWhiteSake", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rabsinthe", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkAbsinthe", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rglasslime", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkCustomBeerLime", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rglasslemon", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkCustomBeerLemon", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rglasskiwi", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkCustomBeerKiwi", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rglassorange", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkCustomBeerOrange", src)                                                              				
end)

QBCore.Functions.CreateUseableItem("rglasspineapple", function(source, item)
    local src = source
    TriggerClientEvent("CL-Records:DrinkCustomBeerPineapple", src)                                                              				
end)

QBCore.Functions.CreateCallback('CL-Records:CheckForWineItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local wine = Player.Functions.GetItemByName(Config.WineBottleItem)
    local glass = Player.Functions.GetItemByName(Config.WineGlassItem)
    if glass ~= nil and wine ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-Records:CheckForWhiteWineItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local whitewine = Player.Functions.GetItemByName(Config.WhiteWineBottleItem)
    local glass = Player.Functions.GetItemByName(Config.WhiteWineGlassItem)
    if glass ~= nil and whitewine ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-Records:CheckForWhiskeyItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local whiskey = Player.Functions.GetItemByName(Config.WhiskeyBottleItem)
    local glass = Player.Functions.GetItemByName(Config.WhiskeyGlassItem)
    if glass ~= nil and whiskey ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-Records:CheckForBeerItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local beer = Player.Functions.GetItemByName(Config.BeerBottleItem)
    local glass = Player.Functions.GetItemByName(Config.BeerGlassItem)
    if glass ~= nil and beer ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-Records:CheckForRegularSakeItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local regularsake = Player.Functions.GetItemByName(Config.SakeBottleItem)
    local glass = Player.Functions.GetItemByName(Config.SakeGlassItem)
    if glass ~= nil and regularsake ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-Records:CheckForSamuraiSakeItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local samuraisake = Player.Functions.GetItemByName(Config.SamuraiSakeBottleItem)
    local glass = Player.Functions.GetItemByName(Config.SamuraiSakeGlassItem)
    if glass ~= nil and samuraisake ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-Records:CheckForGoldSakeItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local goldsake = Player.Functions.GetItemByName(Config.GoldSakeBottleItem)
    local glass = Player.Functions.GetItemByName(Config.GoldSakeGlassItem)
    if glass ~= nil and goldsake ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-Records:CheckForPinkSakeItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pinksake = Player.Functions.GetItemByName(Config.PinkSakeBottleItem)
    local glass = Player.Functions.GetItemByName(Config.PinkSakeGlassItem)
    if glass ~= nil and pinksake ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-Records:CheckForWhiteSakeItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local whitesake = Player.Functions.GetItemByName(Config.WhiteSakeBottleItem)
    local glass = Player.Functions.GetItemByName(Config.WhiteSakeGlassItem)
    if glass ~= nil and whitesake ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-Records:CheckForAbsintheItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local absinthe = Player.Functions.GetItemByName(Config.AbsintheBottleItem)
    local glass = Player.Functions.GetItemByName(Config.AbsintheGlassItem)
    if glass ~= nil and absinthe~= nil then
        cb(true)
    else
        cb(false)
	end
end)

RegisterServerEvent('CL-Records:TakeMoney', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.money.cash >= data.price then
        TriggerClientEvent("CL-Records:SpawnVehicle", src, data.vehicle)  
        Player.Functions.RemoveMoney("cash", data.price)
        TriggerClientEvent('QBCore:Notify', src, 'Vehicle Successfully Bought', "success")    
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Dont Have Enough Money !', "error")              
    end    
end)

QBCore.Functions.CreateCallback('CL-Records:CheckDuty', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.onduty then
        cb(true)
    else
        cb(false)
	end
end)

RegisterServerEvent('CL-Records:ResetDuty', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.SetJobDuty(false)  
end)