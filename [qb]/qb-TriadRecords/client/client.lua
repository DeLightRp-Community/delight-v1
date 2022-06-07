local QBCore = exports['qb-core']:GetCoreObject()

----------------
----Locals
----------------

local PugsSpawned = false

PlayerJob = {}

----------------
----Blips
----------------
Citizen.CreateThread(function()
	for _, info in pairs(Config.BlipLocation) do
		if Config.UseBlips then
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.6)	
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
	end	
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	QBCore.Functions.GetPlayerData(function(PlayerData)
		PlayerJob = PlayerData.job
		if not PugsSpawned then
			SpawnPugs()
		end
	end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

AddEventHandler('onClientResourceStart',function()
    Citizen.CreateThread(function()
        while true do
            if QBCore ~= nil and QBCore.Functions.GetPlayerData ~= nil then
                QBCore.Functions.GetPlayerData(function(PlayerData)
                    if PlayerData.job then
                        PlayerJob = PlayerData.job
						QBCore.Functions.TriggerCallback('CL-Records:CheckDuty', function(result)
							if result then
								TriggerServerEvent("CL-Records:ResetDuty")
							end
						end)
					end
                end)
                break
            end
        end
        Citizen.Wait(1)
    end)
end)

----------------
----Garage Marker
----------------
CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        local letSleep = true        

        if PlayerJob.name == Config.Job then
            if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, -816.3193, -728.0169, 23.779037, true) < 10) then
                letSleep = false
                DrawMarker(36, -816.3193, -728.0169, 23.779037 + 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.5, 0.5, 255, 0, 0, 255, true, false, false, true, false, false, false)
                 if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, -816.3193, -728.0169, 23.779037, true) < 1.5) then
                    DrawText3D(-816.3193, -728.0169, 23.779037, "~g~E~w~ - Records Garage") 
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent("CL-Records:Garage:Menu")
                    end
                end  
            end
        end

        if letSleep then
            Wait(2000)
        end

        Wait(1)
    end
end)

----------------
----Events
----------------

RegisterNetEvent('CL-Records:TablesDrinkChampagne')
AddEventHandler('CL-Records:TablesDrinkChampagne', function()
	QBCore.Functions.Progressbar("champagne_drink", Config.Locals["DrinkChampagneProgressBar"]["Txt"], Config.Locals["DrinkChampagneProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {
		model = "prop_champ_jer_01b",
		bone = 28422,
		coords = { x=0.01, y=-0.01, z=-0.36 },
		rotation = { x=0.0, y=0.0, z=0.0 },
	}, {}, function() -- Done
		QBCore.Functions.Notify("You Arent Feeling Good")
		ChampagneEffect()
	end, function() -- Cancel
		QBCore.Functions.Notify("Canceled..", "error")
	end)
end)

RegisterNetEvent('CL-Records:StoreVehicle')
AddEventHandler('CL-Records:StoreVehicle', function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		QBCore.Functions.Notify('Vehicle Stored!')
		local car = GetVehiclePedIsIn(PlayerPedId(),true)
		TaskLeaveVehicle(PlayerPedId(), car, 1)
		Wait(2000)
		DeleteVehicle(car)
		DeleteEntity(car)
	elseif not IsPedInAnyVehicle(PlayerPedId(), false) then
		QBCore.Functions.Notify("You Are Not In Any Vehicle !", "error")
	end
end)

RegisterNetEvent("CL-Records:GrabCoffee")
AddEventHandler("CL-Records:GrabCoffee", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckDuty', function(result)
		if result then
			QBCore.Functions.Progressbar("grabcoffee", Config.Locals["MakingCoffeeProgressBar"]["Txt"], Config.Locals["MakingCoffeeProgressBar"]["Time"], false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@clubhouse@bar@drink@base",
				anim = "idle_a",
				flags = 49,
			}, {}, {}, function()
				TriggerServerEvent("QBCore:Server:AddItem", Config.CoffeeItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.CoffeeItem], "add")
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify("You must be on duty to grab a coffee", "error")
		end
	end)
end)

RegisterNetEvent("CL-Records:Drink")
AddEventHandler("CL-Records:Drink", function(drink, model, bones, coords, rotation)
	QBCore.Functions.Progressbar("drink_"..drink, Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {
		model = model,
		bone = bones,
		coords = { x=coords.x, y=coords.y, z=coords.z },
		rotation = { x=rotation.x, y=rotation.y, z=rotation.z },
	}, {}, function()
		AlcoholEffect()
		TriggerServerEvent("QBCore:Server:RemoveItem", drink, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[drink], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkWhiteWine")
AddEventHandler("CL-Records:DrinkWhiteWine", function()
	TriggerEvent("CL-Records:SpawnWhiteWineGlass")
	QBCore.Functions.Progressbar("drinkwhitewine", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.WhiteWineItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WhiteWineItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkWhiskey")
AddEventHandler("CL-Records:DrinkWhiskey", function()
	TriggerEvent("CL-Records:SpawnWhiskeyGlass")
	QBCore.Functions.Progressbar("drinkwhiskey", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.WhiskeyItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WhiskeyItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkBeer")
AddEventHandler("CL-Records:DrinkBeer", function()
	TriggerEvent("CL-Records:SpawnBeerGlass")
	QBCore.Functions.Progressbar("drinkbeer", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.BeerItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.BeerItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkRegularSake")
AddEventHandler("CL-Records:DrinkRegularSake", function()
	TriggerEvent("CL-Records:SpawnRegularSakeGlass")
	QBCore.Functions.Progressbar("drinkregularsake", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.SakeItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.SakeItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkSamuraiSake")
AddEventHandler("CL-Records:DrinkSamuraiSake", function()
	TriggerEvent("CL-Records:SpawnRegularSakeGlass")
	QBCore.Functions.Progressbar("drinksamuraisake", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.SamuraiSakeItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.SamuraiSakeItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkGoldSake")
AddEventHandler("CL-Records:DrinkGoldSake", function()
	TriggerEvent("CL-Records:SpawnRegularSakeGlass")
	QBCore.Functions.Progressbar("drinkgoldsake", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.GoldSakeItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.GoldSakeItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkPinkSake")
AddEventHandler("CL-Records:DrinkPinkSake", function()
	TriggerEvent("CL-Records:SpawnRegularSakeGlass")
	QBCore.Functions.Progressbar("drinkpinksake", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.PinkSakeItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.PinkSakeItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkWhiteSake")
AddEventHandler("CL-Records:DrinkWhiteSake", function()
	TriggerEvent("CL-Records:SpawnRegularSakeGlass")
	QBCore.Functions.Progressbar("drinkwhitesake", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.WhiteSakeItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WhiteSakeItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkAbsinthe")
AddEventHandler("CL-Records:DrinkAbsinthe", function()
	TriggerEvent("CL-Records:SpawnAbsintheGlass")
	QBCore.Functions.Progressbar("drinkabsinthe", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.AbsintheItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.AbsintheItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkCustomBeerLime")
AddEventHandler("CL-Records:DrinkCustomBeerLime", function()
	TriggerEvent("CL-Records:SpawnCustomBeerGlass")
	QBCore.Functions.Progressbar("customlimedrinkbeer", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.BeerLimeItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.BeerLimeItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkCustomBeerLemon")
AddEventHandler("CL-Records:DrinkCustomBeerLemon", function()
	TriggerEvent("CL-Records:SpawnCustomBeerGlass")
	QBCore.Functions.Progressbar("customlemondrinkbeer", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.BeerLemonItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.BeerLemonItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkCustomBeerKiwi")
AddEventHandler("CL-Records:DrinkCustomBeerKiwi", function()
	TriggerEvent("CL-Records:SpawnCustomBeerGlass")
	QBCore.Functions.Progressbar("customkiwidrinkbeer", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.BeerKiwiItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.BeerKiwiItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkCustomBeerOrange")
AddEventHandler("CL-Records:DrinkCustomBeerOrange", function()
	TriggerEvent("CL-Records:SpawnCustomBeerGlass")
	QBCore.Functions.Progressbar("customorangedrinkbeer", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.BeerOrangeItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.BeerOrangeItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:DrinkCustomBeerPineapple")
AddEventHandler("CL-Records:DrinkCustomBeerPineapple", function()
	TriggerEvent("CL-Records:SpawnCustomBeerGlass")
	QBCore.Functions.Progressbar("custompineappledrinkbeer", Config.Locals["DrinkProgressBar"]["Txt"], Config.Locals["DrinkProgressBar"]["Time"], false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", Config.BeerPineappleItem, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.BeerPineappleItem], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-Records:SpawnWhiteWineGlass")
AddEventHandler("CL-Records:SpawnWhiteWineGlass", function()
	LoadModel('prop_drink_whtwine')
	local WhiteWineGlass = CreateObject(GetHashKey('prop_drink_whtwine'), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local objectWhiteWineGlass = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_drink_whtwine"), false)
	local itemid = objectWhiteWineGlass
	AttachEntityToEntity(objectWhiteWineGlass, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.01, -0.01, -0.07, 0.0, 0.0, 0.0,1,1,0,1,0,1)
	Wait(5500)
	DetachEntity(objectWhiteWineGlass, true, true)
	DeleteObject(objectWhiteWineGlass)
	AlcoholEffect()
end)

RegisterNetEvent("CL-Records:SpawnBeerGlass")
AddEventHandler("CL-Records:SpawnBeerGlass", function()
	LoadModel('prop_drink_whisky')
	local BeerGlass = CreateObject(GetHashKey('prop_drink_whisky'), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local objectBeerGlass = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_drink_whisky"), false)
	local itemid = objectBeerGlass
	AttachEntityToEntity(objectBeerGlass, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.01, -0.01, -0.07, 0.0, 0.0, 0.0,1,1,0,1,0,1)
	Wait(5500)
	DetachEntity(objectBeerGlass, true, true)
	DeleteObject(objectBeerGlass)
	AlcoholEffect()
end)

RegisterNetEvent("CL-Records:SpawWhiskeyGlass")
AddEventHandler("CL-Records:SpawnWhiskeyGlass", function()
	LoadModel('prop_drink_whisky')
	local WhiskeyGlass = CreateObject(GetHashKey('prop_drink_whisky'), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local objectWhiskeyGlass = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_drink_whisky"), false)
	local itemid = objectWhiskeyGlass
	AttachEntityToEntity(objectWhiskeyGlass, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.01, -0.01, -0.07, 0.0, 0.0, 0.0,1,1,0,1,0,1)
	Wait(5500)
	DetachEntity(objectWhiskeyGlass, true, true)
	DeleteObject(objectWhiskeyGlass)
	AlcoholEffect()
end)

RegisterNetEvent("CL-Records:SpawnCustomBeerGlass")
AddEventHandler("CL-Records:SpawnCustomBeerGlass", function()
	LoadModel('prop_drink_champ')
	local CustomBeerGlass = CreateObject(GetHashKey('prop_drink_champ'), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local objectCustomBeerGlass = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_drink_champ"), false)
	local itemid = objectCustomBeerGlass
	AttachEntityToEntity(objectCustomBeerGlass, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.01, -0.01, -0.19, 0.0, 0.0, 0.0,1,1,0,1,0,1)
	Wait(5500)
	DetachEntity(objectCustomBeerGlass, true, true)
	DeleteObject(objectCustomBeerGlass)
	AlcoholEffect()
end)

RegisterNetEvent("CL-Records:SpawnRegularSakeGlass")
AddEventHandler("CL-Records:SpawnRegularSakeGlass", function()
	LoadModel('prop_cocktail_glass')
	local RegularSakeGlass = CreateObject(GetHashKey('prop_cocktail_glass'), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local objectRegularSakeGlass = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_cocktail_glass"), false)
	local itemid = objectRegularSakeGlass
	AttachEntityToEntity(objectRegularSakeGlass, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.01, -0.01, -0.14, 0.0, 0.0, 0.0,1,1,0,1,0,1)
	Wait(5500)
	DetachEntity(objectRegularSakeGlass, true, true)
	DeleteObject(objectRegularSakeGlass)
	AlcoholEffect()
end)

RegisterNetEvent("CL-Records:SpawnAbsintheGlass")
AddEventHandler("CL-Records:SpawnAbsintheGlass", function()
	LoadModel('prop_drink_whisky')
	local AbsintheGlass = CreateObject(GetHashKey('prop_drink_whisky'), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local objectAbsintheGlass = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_drink_whisky"), false)
	local itemid = objectAbsintheGlass
	AttachEntityToEntity(objectAbsintheGlass, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.01, -0.01, -0.07, 0.0, 0.0, 0.0,1,1,0,1,0,1)
	Wait(5500)
	DetachEntity(objectAbsintheGlass, true, true)
	DeleteObject(objectAbsintheGlass)
	AlcoholEffect()
end)

RegisterNetEvent("CL-Records:UseRedWine")
AddEventHandler("CL-Records:UseRedWine", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckForWineItems', function(HasItems)
		if HasItems then
			SetEntityHeading(PlayerPedId(), 0.0345784)
			TriggerEvent("CL-Records:SpawnWine")
			QBCore.Functions.Progressbar("useredwine", Config.Locals["MakingWineProgressBar"]["Txt"], Config.Locals["MakingWineProgressBar"]["Time"], false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
                anim = "pour_one",
				flags = 49,
			}, {}, {}, function()
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.WineGlassItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WineGlassItem], "remove")
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.WineBottleItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WineBottleItem], "remove")
				TriggerServerEvent("QBCore:Server:AddItem", Config.WineItem, 4)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WineItem], "add")
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify('You Are Trying To Make Wine With Nothing ?', 'error')
		end
	end)
end)

RegisterNetEvent("CL-Records:UseWhiteWine")
AddEventHandler("CL-Records:UseWhiteWine", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckForWhiteWineItems', function(HasItems)
		if HasItems then
			SetEntityHeading(PlayerPedId(), 0.0345784)
			TriggerEvent("CL-Records:SpawnWhiteWine")
			QBCore.Functions.Progressbar("useredwhitewine", Config.Locals["MakingWhiteWineProgressBar"]["Txt"], Config.Locals["MakingWhiteWineProgressBar"]["Time"], false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
                anim = "pour_one",
				flags = 49,
			}, {}, {}, function()
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.WhiteWineGlassItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WhiteWineGlassItem], "remove")
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.WhiteWineBottleItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WhiteWineBottleItem], "remove")
				TriggerServerEvent("QBCore:Server:AddItem", Config.WhiteWineItem, 4)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WhiteWineItem], "add")
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify('You Are Trying To Make White Wine With Nothing ?', 'error')
		end
	end)
end)

RegisterNetEvent("CL-Records:UseWhiskey")
AddEventHandler("CL-Records:UseWhiskey", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckForWhiskeyItems', function(HasItems)
		if HasItems then
			SetEntityHeading(PlayerPedId(), 0.0345784)
			TriggerEvent("CL-Records:SpawnWhiskey")
			QBCore.Functions.Progressbar("usewhiskey", Config.Locals["MakingWhiskeyProgressBar"]["Txt"], Config.Locals["MakingWhiskeyProgressBar"]["Time"], false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
                anim = "pour_one",
				flags = 49,
			}, {}, {}, function()
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.WhiskeyGlassItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WhiskeyGlassItem], "remove")
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.WhiskeyBottleItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WhiskeyBottleItem], "remove")
				TriggerServerEvent("QBCore:Server:AddItem", Config.WhiskeyItem, 4)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WhiskeyItem], "add")
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify('You Are Trying To Make Whiskey With Nothing ?', 'error')
		end
	end)
end)

RegisterNetEvent("CL-Records:UseBeer")
AddEventHandler("CL-Records:UseBeer", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckForBeerItems', function(HasItems)
		if HasItems then
			SetEntityHeading(PlayerPedId(), 0.0345784)
			TriggerEvent("CL-Records:SpawnBeer")
			QBCore.Functions.Progressbar("usebeer", Config.Locals["MakingBeerProgressBar"]["Txt"], Config.Locals["MakingBeerProgressBar"]["Time"], false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
                anim = "pour_one",
				flags = 49,
			}, {}, {}, function()
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.BeerGlassItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.BeerGlassItem], "remove")
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.BeerBottleItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.BeerBottleItem], "remove")
				TriggerServerEvent("QBCore:Server:AddItem", Config.BeerItem, 2)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.BeerItem], "add")
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify('You Are Trying To Make Beer With Nothing ?', 'error')
		end
	end)
end)

RegisterNetEvent("CL-Records:UseAbsinthe")
AddEventHandler("CL-Records:UseAbsinthe", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckForAbsintheItems', function(HasItems)
		if HasItems then
			SetEntityHeading(PlayerPedId(), 0.0345784)
			TriggerEvent("CL-Records:SpawnAbsinthe")
			QBCore.Functions.Progressbar("useabsinthe", Config.Locals["MakingAbsintheProgressBar"]["Txt"], Config.Locals["MakingAbsintheProgressBar"]["Time"], false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
                anim = "pour_one",
				flags = 49,
			}, {}, {}, function()
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.AbsintheGlassItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.AbsintheGlassItem], "remove")
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.AbsintheBottleItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.AbsintheBottleItem], "remove")
				TriggerServerEvent("QBCore:Server:AddItem", Config.AbsintheItem, 2)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.AbsintheItem], "add")
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify('You Are Trying To Make Absinthe With Nothing ?', 'error')
		end
	end)
end)

RegisterNetEvent("CL-Records:UseRegularSake")
AddEventHandler("CL-Records:UseRegularSake", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckForRegularSakeItems', function(HasItems)
		if HasItems then
			SetEntityHeading(PlayerPedId(), 0.0345784)
			TriggerEvent("CL-Records:SpawnRegularSake")
			QBCore.Functions.Progressbar("useregularsake", Config.Locals["MakingSakeProgressBar"]["Txt"], Config.Locals["MakingSakeProgressBar"]["Time"], false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
                anim = "pour_one",
				flags = 49,
			}, {}, {}, function()
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.SakeGlassItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.SakeGlassItem], "remove")
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.SakeBottleItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.SakeBottleItem], "remove")
				TriggerServerEvent("QBCore:Server:AddItem", Config.SakeItem, 3)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.SakeItem], "add")
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify('You Are Trying To Make Sake With Nothing ?', 'error')
		end
	end)
end)

RegisterNetEvent("CL-Records:UseSamuraiSake")
AddEventHandler("CL-Records:UseSamuraiSake", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckForSamuraiSakeItems', function(HasItems)
		if HasItems then
			SetEntityHeading(PlayerPedId(), 0.0345784)
			TriggerEvent("CL-Records:SpawnRegularSake")
			QBCore.Functions.Progressbar("usesamuraisake", Config.Locals["MakingSamuraiSakeProgressBar"]["Txt"], Config.Locals["MakingSamuraiSakeProgressBar"]["Time"], false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
                anim = "pour_one",
				flags = 49,
			}, {}, {}, function()
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.SamuraiSakeGlassItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.SamuraiSakeGlassItem], "remove")
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.SakeBottleItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.SamuraiSakeBottleItem], "remove")
				TriggerServerEvent("QBCore:Server:AddItem", Config.SamuraiSakeItem, 3)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.SamuraiSakeItem], "add")
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify('You Are Trying To Make Samurai Sake With Nothing ?', 'error')
		end
	end)
end)

RegisterNetEvent("CL-Records:UseGoldSake")
AddEventHandler("CL-Records:UseGoldSake", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckForGoldSakeItems', function(HasItems)
		if HasItems then
			SetEntityHeading(PlayerPedId(), 0.0345784)
			TriggerEvent("CL-Records:SpawnRegularSake")
			QBCore.Functions.Progressbar("usegoldsake", Config.Locals["MakingGoldSakeProgressBar"]["Txt"], Config.Locals["MakingGoldSakeProgressBar"]["Time"], false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
                anim = "pour_one",
				flags = 49,
			}, {}, {}, function()
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.GoldSakeGlassItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.GoldSakeGlassItem], "remove")
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.SakeBottleItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.GoldSakeBottleItem], "remove")
				TriggerServerEvent("QBCore:Server:AddItem", Config.GoldSakeItem, 2)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.GoldSakeItem], "add")
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify('You Are Trying To Make Gold Sake With Nothing ?', 'error')
		end
	end)
end)

RegisterNetEvent("CL-Records:UsePinkSake")
AddEventHandler("CL-Records:UsePinkSake", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckForPinkSakeItems', function(HasItems)
		if HasItems then
			SetEntityHeading(PlayerPedId(), 0.0345784)
			TriggerEvent("CL-Records:SpawnRegularSake")
			QBCore.Functions.Progressbar("usepinksake", Config.Locals["MakingPinkSakeProgressBar"]["Txt"], Config.Locals["MakingPinkSakeProgressBar"]["Time"], false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
                anim = "pour_one",
				flags = 49,
			}, {}, {}, function()
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.PinkSakeGlassItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.PinkSakeGlassItem], "remove")
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.PinkSakeBottleItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.PinkSakeBottleItem], "remove")
				TriggerServerEvent("QBCore:Server:AddItem", Config.PinkSakeItem, 2)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.PinkSakeItem], "add")
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify('You Are Trying To Make Pink Sake With Nothing ?', 'error')
		end
	end)
end)

RegisterNetEvent("CL-Records:UseWhiteSake")
AddEventHandler("CL-Records:UseWhiteSake", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckForWhiteSakeItems', function(HasItems)
		if HasItems then
			SetEntityHeading(PlayerPedId(), 0.0345784)
			TriggerEvent("CL-Records:SpawnRegularSake")
			QBCore.Functions.Progressbar("usewhitesake", Config.Locals["MakingWhiteSakeProgressBar"]["Txt"], Config.Locals["MakingWhiteSakeProgressBar"]["Time"], false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
                anim = "pour_one",
				flags = 49,
			}, {}, {}, function()
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.WhiteSakeGlassItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WhiteSakeGlassItem], "remove")
				TriggerServerEvent("QBCore:Server:RemoveItem", Config.WhiteSakeBottleItem, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WhiteSakeBottleItem], "remove")
				TriggerServerEvent("QBCore:Server:AddItem", Config.WhiteSakeItem, 2)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.WhiteSakeItem], "add")
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify('You Are Trying To Make White Sake With Nothing ?', 'error')
		end
	end)
end)

RegisterNetEvent("CL-Records:SpawnWhiskey")
AddEventHandler("CL-Records:SpawnWhiskey", function()
	Wait(1400)
	LoadModel('p_whiskey_bottle_s')
	local Whiskey = CreateObject(GetHashKey('p_whiskey_bottle_s'), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local objectWhiskey = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("p_whiskey_bottle_s"), false)
	local itemid = objectWhiskey
	AttachEntityToEntity(objectWhiskey, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 64097),0.00, 0.09, 0.05, 0.0, 0.0, 0.0,1,1,0,1,0,1)
	Wait(3500)
	DetachEntity(objectWhiskey, true, true)
	DeleteObject(objectWhiskey)
end)

RegisterNetEvent("CL-Records:SpawnAbsinthe")
AddEventHandler("CL-Records:SpawnAbsinthe", function()
	Wait(1400)
	LoadModel('prop_bottle_cognac')
	local Absinthe = CreateObject(GetHashKey('prop_bottle_cognac'), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local objectAbsinthe = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_bottle_cognac"), false)
	local itemid = objectAbsinthe
	AttachEntityToEntity(objectAbsinthe, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 64097),0.00, 0.09, -0.08, 0.0, 0.0, 0.0,1,1,0,1,0,1)
	Wait(3500)
	DetachEntity(objectAbsinthe, true, true)
	DeleteObject(objectAbsinthe)
end)

RegisterNetEvent("CL-Records:SpawnBeer")
AddEventHandler("CL-Records:SpawnBeer", function()
	Wait(1400)
	LoadModel('prop_beer_bottle')
	local Beer = CreateObject(GetHashKey('prop_beer_bottle'), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local objectBeer = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_beer_bottle"), false)
	local itemid = objectBeer
	AttachEntityToEntity(objectBeer, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 64097),0.00, 0.09, -0.08, 0.0, 0.0, 0.0,1,1,0,1,0,1)
	Wait(3500)
	DetachEntity(objectBeer, true, true)
	DeleteObject(objectBeer)
end)

RegisterNetEvent("CL-Records:SpawnWine")
AddEventHandler("CL-Records:SpawnWine", function()
	Wait(1400)
	LoadModel('prop_wine_red')
	local Wine = CreateObject(GetHashKey('prop_wine_red'), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local objectWine = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_wine_red"), false)
	local itemid = objectWine
	AttachEntityToEntity(objectWine, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 64097),0.00, 0.09, -0.16, 0.0, 0.0, 0.0,1,1,0,1,0,1)
	Wait(3500)
	DetachEntity(objectWine, true, true)
	DeleteObject(objectWine)
end)

RegisterNetEvent("CL-Records:SpawnWhiteWine")
AddEventHandler("CL-Records:SpawnWhiteWine", function()
	Wait(1400)
	LoadModel('prop_wine_white')
	local WhiteWine = CreateObject(GetHashKey('prop_wine_white'), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local objectWhiteWine = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_wine_white"), false)
	local itemid = objectWhiteWine
	AttachEntityToEntity(objectWhiteWine, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 64097),0.00, 0.09, -0.16, 0.0, 0.0, 0.0,1,1,0,1,0,1)
	Wait(3500)
	DetachEntity(objectWhiteWine, true, true)
	DeleteObject(objectWhiteWine)
end)

RegisterNetEvent("CL-Records:SpawnRegularSake")
AddEventHandler("CL-Records:SpawnRegularSake", function()
	Wait(1400)
	LoadModel('prop_vodka_bottle')
	local RegularSake = CreateObject(GetHashKey('prop_vodka_bottle'), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local objectRegularSake = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_vodka_bottle"), false)
	local itemid = objectRegularSake
	AttachEntityToEntity(objectRegularSake, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 64097),0.00, 0.09, -0.16, 0.0, 0.0, 0.0,1,1,0,1,0,1)
	Wait(3500)
	DetachEntity(objectRegularSake, true, true)
	DeleteObject(objectRegularSake)
end)

RegisterNetEvent('CL-Records:OpenStash', function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckDuty', function(result)
		if result then
			TriggerServerEvent("inventory:server:OpenInventory", "stash", "Triad Records Storage") 
			TriggerEvent("inventory:client:SetCurrentStash", "Triad Records Storage")
		else
			QBCore.Functions.Notify("You must be on duty to open the stash.", "error")
		end
	end)
end)

RegisterNetEvent('CL-Records:OpenBossStash', function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckDuty', function(result)
		if result then
			TriggerServerEvent("inventory:server:OpenInventory", "stash", "Triad Records Boss Storage") 
			TriggerEvent("inventory:client:SetCurrentStash", "Triad Records Boss Storage")
		else
			QBCore.Functions.Notify("You must be on duty to open the boss stash.", "error")
		end
	end)
end)

RegisterNetEvent('CL-Records:BuyFruitSlice', function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckDuty', function(result)
		if result then
			TriggerServerEvent("inventory:server:OpenInventory", "shop", "Records Drink Extra Shop", Config.SliceItems)
		else
			QBCore.Functions.Notify("You must be on duty to purchase fruit slices.", "error")
		end
	end)
end)

RegisterNetEvent('CL-Records:OpenShop', function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckDuty', function(result)
		if result then
			TriggerServerEvent("inventory:server:OpenInventory", "shop", "Main Shop", Config.ShopItems)
		else
			QBCore.Functions.Notify("You must be on duty.", "error")
		end
	end)
end)

RegisterNetEvent('CL-Records:OpenFridge', function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckDuty', function(result)
		if result then
			TriggerServerEvent("inventory:server:OpenInventory", "shop", "Fridge", Config.FridgeItems)
		else
			QBCore.Functions.Notify("You must be on duty to open the fridge.", "error")
		end
	end)
end)

RegisterNetEvent('CL-Records:WashHands', function()
	QBCore.Functions.Progressbar("washhands", Config.Locals["WashingHandsProgressBar"]["Txt"], Config.Locals["WashingHandsProgressBar"]["Time"], false, true, {
		disableMovement = true,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_bum_wash@male@low@base",
		anim = "base",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent('hud:server:RelieveStress', Config.HandsStress)
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent('CL-Records:PetPugs', function()
	QBCore.Functions.Progressbar('petpugs', Config.Locals["PetPugProgressBar"]["Txt"], Config.Locals["PetPugProgressBar"]["Time"], false, false, {
		disableMovement = true, 
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = 'creatures@rottweiler@tricks@', 
		anim = 'petting_franklin', 
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent('hud:server:RelieveStress', Config.DogStress)
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
		ClearPedTasks(PlayerPedId())
	end)
end)

----------------
----Menus
----------------
RegisterNetEvent("CL-Records:DutyMenu", function()
    local DutyMenu = {
        {
            header = "Duty",
            isMenuHeader = true,
        }
    }
	DutyMenu[#DutyMenu+1] = {
        header = Config.Locals["DutyMenu"]["Header"],
		txt = Config.Locals["DutyMenu"]["Txt"],
        params = {
			isServer = true,
            event = "QBCore:ToggleDuty"
        }
    }
    DutyMenu[#DutyMenu+1] = {
        header = "⬅ Close",
        params = {
            event = "qb-menu:client:closemenu"
        }
    }
    exports['qb-menu']:openMenu(DutyMenu)
end)

RegisterNetEvent("CL-Records:OpenGlassesMenu", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckDuty', function(result)
		if result then
			local GlassesMenu = {
				{
					header = "Glasses Menu",
					isMenuHeader = true,
				}
			}
			for k, v in pairs(Config.Glasses) do
				GlassesMenu[#GlassesMenu+1] = {
					header = v.glassname,
					txt = "Buy " .. v.glassname .. " For: " .. v.price .. "$",
					params = {
						isServer = true,
						event = "CL-Records:BuyGlass",
						args = {
							price = v.price,
							glassname = v.glassname,
							glass = v.glass
						}
					}
				}
			end
			GlassesMenu[#GlassesMenu+1] = {
				header = "⬅ Close",
				params = {
					event = "qb-menu:client:closemenu"
				}
			}
			exports['qb-menu']:openMenu(GlassesMenu)
		else
			QBCore.Functions.Notify("You must be on duty to open the glasses menu.", "error")
		end
	end)
end)

RegisterNetEvent("CL-Records:OpenWineMenu", function()
	QBCore.Functions.TriggerCallback('CL-Records:CheckDuty', function(result)
		if result then
			local WineMenu = {
				{
					header = "Drinks",
					isMenuHeader = true,
				}
			}
			WineMenu[#WineMenu+1] = {
				header = "View Drinks",
				txt = "View Drinks Menu",
				params = {
					event = "CL-Records:MainWineMenu",
				}
			}
			WineMenu[#WineMenu+1] = {
				header = "⬅ Close",
				params = {
					event = "qb-menu:client:closemenu"
				}
			}
			exports['qb-menu']:openMenu(WineMenu)
		else
			QBCore.Functions.Notify("You must be on duty to open the wine menu.", "error")
		end
	end)
end)

RegisterNetEvent("CL-Records:MainWineMenu", function()
    local MainWineMenu = {
        {
            header = "Drinks",
            isMenuHeader = true,
        }
    }
	MainWineMenu[#MainWineMenu+1] = {
        header = Config.Locals["WineMenu"]["Header"],
		txt = Config.Locals["WineMenu"]["Txt"],
        params = {
            event = "CL-Records:UseRedWine"
        }
    }
	MainWineMenu[#MainWineMenu+1] = {
        header = Config.Locals["WhiteWineMenu"]["Header"],
		txt = Config.Locals["WhiteWineMenu"]["Txt"],
        params = {
            event = "CL-Records:UseWhiteWine"
        }
    }
	MainWineMenu[#MainWineMenu+1] = {
        header = Config.Locals["WhiskeyMenu"]["Header"],
		txt = Config.Locals["WhiskeyMenu"]["Txt"],
        params = {
            event = "CL-Records:UseWhiskey"
        }
    }
	MainWineMenu[#MainWineMenu+1] = {
        header = Config.Locals["BeerMenu"]["Header"],
		txt = Config.Locals["BeerMenu"]["Txt"],
        params = {
            event = "CL-Records:UseBeer"
        }
    }
	MainWineMenu[#MainWineMenu+1] = {
        header = Config.Locals["SakeMenu"]["Header"],
		txt = Config.Locals["SakeMenu"]["Txt"],
        params = {
            event = "CL-Records:UseRegularSake"
        }
    }
	MainWineMenu[#MainWineMenu+1] = {
        header = Config.Locals["SamuraiSakeMenu"]["Header"],
		txt = Config.Locals["SamuraiSakeMenu"]["Txt"],
        params = {
            event = "CL-Records:UseSamuraiSake"
        }
    }
	MainWineMenu[#MainWineMenu+1] = {
        header = Config.Locals["GoldSakeMenu"]["Header"],
		txt = Config.Locals["GoldSakeMenu"]["Txt"],
        params = {
            event = "CL-Records:UseGoldSake"
        }
    }
	MainWineMenu[#MainWineMenu+1] = {
        header = Config.Locals["PinkSakeMenu"]["Header"],
		txt = Config.Locals["PinkSakeMenu"]["Txt"],
        params = {
            event = "CL-Records:UsePinkSake"
        }
    }
	MainWineMenu[#MainWineMenu+1] = {
        header = Config.Locals["WhiteSakeMenu"]["Header"],
		txt = Config.Locals["WhiteSakeMenu"]["Txt"],
        params = {
            event = "CL-Records:UseWhiteSake"
        }
    }
	MainWineMenu[#MainWineMenu+1] = {
        header = Config.Locals["AbsintheMenu"]["Header"],
		txt = Config.Locals["AbsintheMenu"]["Txt"],
        params = {
            event = "CL-Records:UseAbsinthe"
        }
    }
    MainWineMenu[#MainWineMenu+1] = {
        header = "⬅ Go Back",
        params = {
            event = "CL-Records:OpenWineMenu"
        }
    }
    exports['qb-menu']:openMenu(MainWineMenu)
end)

RegisterNetEvent('CL-Records:Garage:Menu', function()
	local GarageMenu = {
		{
			header = Config.Locals["GarageMenu"]["MainHeader"],
			txt = "View Vehicles",
			params = {
				event = "CL-Records:Catalog",
			}
		}
	}
	GarageMenu[#GarageMenu+1] = {
		header = Config.Locals["GarageMenu"]["FourthHeader"],
		txt = Config.Locals["GarageMenu"]["ThirdTxt"],
		params = {
			event = "CL-Records:StoreVehicle"
		}
	}
	GarageMenu[#GarageMenu+1] = {
		header = "⬅ Close Menu",
		params = {
			event = "qb-menu:client:closeMenu"
		}
	}
	exports['qb-menu']:openMenu(GarageMenu)
end)

RegisterNetEvent("CL-Records:Catalog", function()
    local VehicleMenu = {
        {
            header = "Records Garage",
            isMenuHeader = true,
        }
    }
    for k, v in pairs(Config.Vehicles) do
        VehicleMenu[#VehicleMenu+1] = {
            header = v.vehiclename,
            txt = "Take: " .. v.vehiclename .. " For A Ride By The Price Of: " .. v.price .. "$",
            params = {
                isServer = true,
                event = "CL-Records:TakeMoney",
                args = {
                    price = v.price,
                    vehiclename = v.vehiclename,
                    vehicle = v.vehicle
                }
            }
        }
    end
	if PlayerJob.isboss then
		VehicleMenu[#VehicleMenu+1] = {
			header = "Take Boss Vehicle: " ..Config.BossVehicle,
			params = {
				event = "CL-Records:SpawnBossVehicle",
				args = {
					vehicle = Config.BossVehicle,
				}
			}
		}
	end
    VehicleMenu[#VehicleMenu+1] = {
        header = "⬅ Go Back",
        params = {
            event = "CL-Records:Garage:Menu"
        }
    }
    exports['qb-menu']:openMenu(VehicleMenu)
end)

----------------
----Functions
----------------
function AlcoholEffect()
	TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Config.Thirst)
	local Player = PlayerPedId()
	StartScreenEffect("MinigameEndNeutral", 1.0, 0)
    Citizen.Wait(5000)
    StopScreenEffect("MinigameEndNeutral")
end

function AnimSet(anim)
	RequestAnimDict(anim)
	while not HasAnimDictLoaded(anim) do
		Citizen.Wait(1)
	end
end

RegisterNetEvent("CL-Records:SpawnVehicle", function(vehicle)
	local coords = vector4(-816.2855, -727.9406, 23.779029, 182.20706)
	QBCore.Functions.SpawnVehicle(vehicle, function(veh)
		SetVehicleNumberPlateText(veh, "REC"..tostring(math.random(1000, 9999)))
		exports['LegacyFuel']:SetFuel(veh, 100.0)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
		SetVehicleEngineOn(veh, true, true)
	end, coords, true)     
end)

RegisterNetEvent("CL-Records:SpawnBossVehicle", function(data)
	local coords = vector4(-816.2855, -727.9406, 23.779029, 182.20706)
	QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
		SetVehicleNumberPlateText(veh, "BOSS"..tostring(math.random(1000, 9999)))
		exports['LegacyFuel']:SetFuel(veh, 100.0)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
		SetVehicleEngineOn(veh, true, true)
	end, coords, true)     
end)

function LoadModel(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		Wait(10)
	end
end

function ChampagneEffect()
	local playerPed = GetPlayerPed(-1)
  
	RequestAnimSet("move_m@drunk@moderatedrunk") 
	while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
	Citizen.Wait(0)
	end    	
	
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(playerPed, true)
	SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
	SetPedIsDrunk(playerPed, true)

	--Efects
	local player = PlayerId()
	SetRunSprintMultiplierForPlayer(player, 1.2)
	SetSwimMultiplierForPlayer(player, 1.3)

	Wait(520000)

	SetRunSprintMultiplierForPlayer(player, 1.0)
	SetSwimMultiplierForPlayer(player, 1.0)
end

function SpawnPugs()
    for k, v in pairs(Config.Pugs) do
		PugsSpawned = true
        local hash = GetHashKey('a_c_pug')
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
		ped = CreatePed(28, hash, v.coords.x, v.coords.y, v.coords.z - 1.0001, v.coords.w, false, true)
		SetPedCanBeTargetted(ped, false)
		AnimSet('creatures@pug@amb@world_dog_sitting@idle_a')
		TaskPlayAnim(ped, 'creatures@pug@amb@world_dog_sitting@idle_a', 'idle_c' ,8.0, -8, -1, 1, 0, false, false, false)
		FreezeEntityPosition(ped, true)
		SetEntityAsMissionEntity(ped, true,true)
		SetBlockingOfNonTemporaryEvents(ped, true)
    end
end

----------------
----Target
----------------
CreateThread(function()
	for k, v in pairs(Config.ExtrasLocations) do
		exports[Config.Target]:AddBoxZone("SlicesLocation"..k, vector3(v.coords.x, v.coords.y, v.coords.z), v.poly1, v.poly2, {
			name = "SlicesLocation"..k,
			heading = v.heading,
			debugPoly = Config.PolyZone,
			minZ = v.minZ,
			maxZ = v.maxZ,
			}, {
				options = { 
				{
					type = "client",
					event = "CL-Records:BuyFruitSlice",
					icon = Config.Locals["SlicesTarget"]["Icon"],
					label = Config.Locals["SlicesTarget"]["Label"],
					canInteract = function()
						if PlayerJob.name == Config.Job then
							return true
						else
							return false
						end
					end,
				}
			},
			distance = 1.1,
		})
	end

	for k, v in pairs(Config.TablesLocations) do
		exports[Config.Target]:AddBoxZone("TablesLocation"..k, vector3(v.coords.x, v.coords.y, v.coords.z), v.poly1, v.poly2, {
			name = "TablesLocation"..k,
			heading = v.heading,
			debugPoly = Config.PolyZone,
			minZ = v.minZ,
			maxZ = v.maxZ,
			}, {
				options = { 
				{
					type = "client",
					event = "CL-Records:TablesDrinkChampagne",
					icon = Config.Locals["TablesTarget"]["Icon"],
					label = Config.Locals["TablesTarget"]["Label"],
				}
			},
			distance = 1.5,
		})
	end

	for k, v in pairs(Config.MenusLocations) do
		exports[Config.Target]:AddBoxZone("MenusLocation"..k, vector3(v.coords.x, v.coords.y, v.coords.z), v.poly1, v.poly2, {
			name = "MenusLocation"..k,
			heading = v.heading,
			debugPoly = Config.PolyZone,
			minZ = v.minZ,
			maxZ = v.maxZ,
			}, {
				options = { 
				{
					type = "client",
					event = "CL-Records:OpenMenu",
					icon = Config.Locals["MenusTarget"]["Icon"],
					label = Config.Locals["MenusTarget"]["Label"],
				}
			},
			distance = 1.5,
		})
	end

	exports[Config.Target]:AddBoxZone("Duty", vector3(-815.2927, -717.6597, 28.060127), 0.8, 3.7, {
		name = "Duty",
		heading = 269.86981,
		debugPoly = Config.PolyZone,
		minZ = 27.060127,
		maxZ = 29.060127,
	}, {
		options = { 
			{
				type = "client",
				event = "CL-Records:DutyMenu",
				icon = Config.Locals["DutyTarget"]["Icon"],
				label = Config.Locals["DutyTarget"]["Label"],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			},
			{
				type = "client",
				event = "qb-clothing:client:openMenu",
				icon = Config.Locals["ClothingTarget"]["Icon"],
				label = Config.Locals["ClothingTarget"]["Label"],
				canInteract = function()
					if Config.UseClothing == true and PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			}
		},
		distance = 1.1,
	})

	exports[Config.Target]:AddBoxZone("Shop", vector3(-831.3394, -730.464, 28.132799), 0.8, 0.8, {
		name = "Shop",
		heading = 178.40112,
		debugPoly = Config.PolyZone,
		minZ = 27.132799,
		maxZ = 29.132799,
	}, {
		options = { 
			{
				type = "client",
				event = "CL-Records:OpenShop",
				icon = Config.Locals["ShopTarget"]["Icon"],
				label = Config.Locals["ShopTarget"]["Label"],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			},
		},
		distance = 1.1,
	})

	exports[Config.Target]:AddBoxZone("Glasses", vector3(-832.833, -730.4556, 28.060127), 0.6, 0.6, {
		name = "Glasses",
		heading = 181.99247,
		debugPoly = Config.PolyZone,
		minZ = 27.060127,
		maxZ = 29.060127,
	}, {
		options = { 
			{
				type = "client",
				event = "CL-Records:OpenGlassesMenu",
				icon = Config.Locals["GlassesTarget"]["Icon"],
				label = Config.Locals["GlassesTarget"]["Label"],
				canInteract = function()
				 	if PlayerJob.name == Config.Job then
				 		return true
				 	else
				 		return false
					end
				end,
			},
		},
		distance = 1.1,
	})

	exports[Config.Target]:AddBoxZone("Stash", vector3(-830.1881, -727.7621, 27.65352), 0.8, 2.4, {
		name = "Stash",
		heading = 359.14059,
		debugPoly = Config.PolyZone,
		minZ = 26.05000,
		maxZ = 28.05000,
	}, {
		options = { 
			{
				type = "client",
				event = "CL-Records:OpenStash",
				icon = Config.Locals["StashTarget"]["Icon"],
				label = Config.Locals["StashTarget"]["Label"],
				canInteract = function()
				 	if PlayerJob.name == Config.Job then
				 		return true
				 	else
				 		return false
				 	end
				end,
			},
		},
		distance = 1.1,
	})

	exports[Config.Target]:AddBoxZone("Wine", vector3(-828.3309, -727.8094, 28.060144), 0.6, 2.0, {
		name = "Wine",
		heading = 0.0345784,
		debugPoly = Config.PolyZone,
		minZ = 27.060144,
		maxZ = 29.060144,
	}, {
		options = { 
			{
				type = "client",
				event = "CL-Records:OpenWineMenu",
				icon = Config.Locals["WineTarget"]["Icon"],
				label = Config.Locals["WineTarget"]["Label"],
				canInteract = function()
				 	if PlayerJob.name == Config.Job then
				 		return true
				 	else
				 		return false
					end
				end,
			},
		},
		distance = 1.1,
	})

	exports[Config.Target]:AddBoxZone("BossStash", vector3(-816.5899, -695.6423, 31.696527), 0.8, 0.7, {
		name = "BossStash",
		heading = 0.0345784,
		debugPoly = Config.PolyZone,
		minZ = 30.696527,
		maxZ = 32.696527,
	}, {
		options = { 
			{
				type = "client",
				event = "CL-Records:OpenBossStash",
				icon = Config.Locals["BossStashTarget"]["Icon"],
				label = Config.Locals["BossStashTarget"]["Label"],
				canInteract = function()
				 	if PlayerJob.isboss and PlayerJob.name == Config.Job then
				 		return true
				 	else
				 		return false
				 	end
				end,
			},
		},
		distance = 1.1,
	})

	exports[Config.Target]:AddBoxZone("WorkersCoffee", vector3(-811.3747, -697.813, 28.059928), 0.5, 0.4, {
		name = "WorkersCoffee",
		heading = 268.20697,
		debugPoly = Config.PolyZone,
		minZ = 27.059928,
		maxZ = 29.059928,
	}, {
		options = { 
			{
				type = "client",
				event = "CL-Records:GrabCoffee",
				icon = Config.Locals["WorkersCoffeeTarget"]["Icon"],
				label = Config.Locals["WorkersCoffeeTarget"]["Label"],
				canInteract = function()
				 	if PlayerJob.name == Config.Job then
				 		return true
				 	else
				 		return false
				 	end
				end,
			},
		},
		distance = 1.1,
	})

	exports[Config.Target]:AddBoxZone("WorkersFridge", vector3(-811.6352, -698.5788, 28.060125), 0.5, 1.1, {
		name = "WorkersFridge",
		heading = 269.91729,
		debugPoly = Config.PolyZone,
		minZ = 27.060125,
		maxZ = 29.060125,
	}, {
		options = { 
			{
				type = "client",
				event = "CL-Records:OpenFridge",
				icon = Config.Locals["WorkersFridgeTarget"]["Icon"],
				label = Config.Locals["WorkersFridgeTarget"]["Label"],
				canInteract = function()
				 	if PlayerJob.name == Config.Job then
				 		return true
				 	else
				 		return false
				 	end
				end,
			},
		},
		distance = 1.1,
	})

	for k, v in pairs(Config.WashHandsLocations) do
		exports[Config.Target]:AddBoxZone("WorkersWashHands"..k, vector3(v.coords.x, v.coords.y, v.coords.z), v.poly1, v.poly2, {
			name = "WorkersWashHands"..k,
			heading = v.heading,
			debugPoly = Config.PolyZone,
			minZ = v.minZ,
			maxZ = v.maxZ,
			}, {
				options = { 
				{
					type = "client",
					event = "CL-Records:WashHands",
					icon = Config.Locals["WorkersWashHandsTarget"]["Icon"],
					label = Config.Locals["WorkersWashHandsTarget"]["Label"],
					canInteract = function()
						if PlayerJob.name == Config.Job then
							return true
						else
							return false
						end
					end,
				}
			},
			distance = 1.5,
		})
	end

	exports[Config.Target]:AddTargetModel(`a_c_pug`, {
		options = {
			{
				event = 'CL-Records:PetPugs',
				icon = Config.Locals["PugsTarget"]["Icon"],
				label = Config.Locals["PugsTarget"]["Label"],
			},
		},
		distance = 2.0 
	})
end)

RegisterNUICallback('Click', function()
	PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
end)
  
RegisterNUICallback('CloseNui', function()
	SetNuiFocus(false, false)
end)

RegisterNetEvent('CL-Records:OpenMenu')
AddEventHandler('CL-Records:OpenMenu', function()
  	SetNuiFocus(true, true)
  	SendNUIMessage({action = 'OpenMenu'})
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end