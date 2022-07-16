local QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = true

local onDuty = false
local payed = false
function DrawText3Ds(x, y, z, text)
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


--[[RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	if PlayerData.job.onduty then
	    if PlayerData.job.name == "nightclub" then
		TriggerServerEvent("QBCore:ToggleDuty")
	    end
	end
end)]]

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job.name == "nightclub" then
    	onDuty = duty
    end
end)
--blip 
Citizen.CreateThread(function()
    nightclub = AddBlipForCoord(337.74, 297.15, 115.01)
    SetBlipSprite (nightclub, 279)
    SetBlipDisplay(nightclub, 4)
    SetBlipScale  (nightclub, 1.0)
    SetBlipAsShortRange(nightclub, true)
    SetBlipColour(nightclub, 83)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Galaxy")
    EndTextCommandSetBlipName(nightclub)
end) 

--storage and pickup

RegisterNetEvent("qb-nightclub:Tray")
AddEventHandler("qb-nightclub:Tray", function()
    TriggerEvent("inventory:client:SetCurrentStash", "nighttray")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "nighttray", {
        maxweight = 25000,
        slots = 5,
    })
end)

RegisterNetEvent("qb-nightclub:Tray2")
AddEventHandler("qb-nightclub:Tray2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "nighttray")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "nighttray", {
        maxweight = 25000,
        slots = 5,
    })
end)

RegisterNetEvent("qb-nightclub:Storage")
AddEventHandler("qb-nightclub:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "nighttorage")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "nighttorage", {
        maxweight = 4000000,
        slots = 50,
    })
end)

RegisterNetEvent("qb-nightclub:bitch")
AddEventHandler("qb-nightclub:bitch", function()

TaskPlayAnim(ped2, "mini@strip_club@private_dance@part2", "priv_dance_p2", 8.0, -8.0, -1, 0, 0, false, false, false)

    
    
end)

Citizen.CreateThread(function()
	exports['qb-target']:AddBoxZone("nc", vector3(352.94, 285.31, 91.19), 3, 1, {
        name="nc",
        heading=245,
        --debugPoly=true,
        --minZ=26.16,
        --maxZ=30.16
	}, {
		options = {
		    {  
			event = "qb-nightclub:Tray",
			icon = "far fa-circle",
			label = "pickup order",
			--job = "all",
		    },
		},
		distance = 1.5
	})

    exports['qb-target']:AddBoxZone("nc", vector3(408.6, 250.09, 92.05), 3, 1, {
        name="nc",
        heading=245,
        --debugPoly=true,
        --minZ=26.16,
        --maxZ=30.16
	}, {
		options = {
		    {  
			event = "qb-nightclub:Tray2",
			icon = "far fa-circle",
			label = "pickup order",
			--job = "all",
		    },
		},
		distance = 1.5
	})


    exports["qb-target"]:AddCircleZone("storagenc", vector3(352.01, 274.76, 94.19), 1.0, {
        name ="storagenc",
        useZ = true,
        --debugPoly=true
        }, {
            options = {
                {
                    event = "qb-nightclub:Storage",
                    icon = "fas fa-box",
                    label = "Storage!",
                    job = "nightclub",
                },
             },
            distance = 2.0
        })

        exports["qb-target"]:AddCircleZone("bitch", vector3(384.44, 252.35, 92.05), 1.0, {
            name ="bitch",
            useZ = true,
            --debugPoly=true
            }, {
                options = {
                    {
                        type = "server",
                        event = "qb-lapdance:buy",
                        icon = "fas fa-box",
                        label = "Dance For me Bitch!",
                        --job = "nightclub",
                    },
                 },
                distance = 2.0
            })

end)



CreateThread(function()
    Wait(10)
	nightPeds()
end)

function nightPeds()

-- recption
    model = GetHashKey("s_f_y_bartender_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 345.71, 284.85, 94.79, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 70.44 )
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    -- gaurd main 1

    model = GetHashKey("s_m_m_highsec_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    ped = CreatePed(0, model , 356.85, 303.22, 102.72, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, 345.6 )
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

     -- gaurd main 2

     model = GetHashKey("s_m_m_highsec_02")
     RequestModel(model)
     while not HasModelLoaded(model) do
         Wait(1)
     end
     ped = CreatePed(0, model , 354.13, 304.32, 102.8, true)
     FreezeEntityPosition(ped, true)
     SetEntityHeading(ped, 348.12 )
     SetEntityInvincible(ped, true)
     SetBlockingOfNonTemporaryEvents(ped, true)
     TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
-- gaurd in map 1
     model = GetHashKey("s_m_y_devinsec_01")
     RequestModel(model)
     while not HasModelLoaded(model) do
         Wait(1)
     end
     ped = CreatePed(0, model , 375.72, 267.78, 93.19, true)
     FreezeEntityPosition(ped, true)
     SetEntityHeading(ped, 39.94 )
     SetEntityInvincible(ped, true)
     SetBlockingOfNonTemporaryEvents(ped, true)
     TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

     model = GetHashKey("s_m_m_bouncer_01")
     RequestModel(model)
     while not HasModelLoaded(model) do
         Wait(1)
     end
     ped = CreatePed(0, model , 391.81, 257.76, 91.05, true)
     FreezeEntityPosition(ped, true)
     SetEntityHeading(ped, 244.85 )
     SetEntityInvincible(ped, true)
     SetBlockingOfNonTemporaryEvents(ped, true)
     TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

     model = GetHashKey("s_m_m_bouncer_01")
     RequestModel(model)
     while not HasModelLoaded(model) do
         Wait(1)
     end
     ped = CreatePed(0, model , 390.72, 254.0, 91.05, true)
     FreezeEntityPosition(ped, true)
     SetEntityHeading(ped, 252.87 )
     SetEntityInvincible(ped, true)
     SetBlockingOfNonTemporaryEvents(ped, true)
     TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

     model = GetHashKey("s_f_y_stripperlite")
     RequestModel(model)
     while not HasModelLoaded(model) do
         Wait(1)
     end
     ped2 = CreatePed(0, model , 384.9, 252.34, 91.63, true)
     FreezeEntityPosition(ped2, true)
     SetEntityHeading(ped2, 44.38 )
     SetEntityInvincible(ped2, true)
     SetBlockingOfNonTemporaryEvents(ped2, true)
     RequestAnimDict("mini@strip_club@private_dance@part2")
	while not HasAnimDictLoaded("mini@strip_club@private_dance@part2") do
		Citizen.Wait(20)
	end

    model = GetHashKey("a_c_panther")
     RequestModel(model)
     while not HasModelLoaded(model) do
         Wait(1)
     end
     ped2 = CreatePed(0, model , 409.15, 244.94, 91.05, true)
     FreezeEntityPosition(ped2, true)
     SetEntityHeading(ped2, 67.45 )
     SetEntityInvincible(ped2, true)
     SetBlockingOfNonTemporaryEvents(ped2, true)
     --TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

     model = GetHashKey("a_c_panther")
     RequestModel(model)
     while not HasModelLoaded(model) do
         Wait(1)
     end
     ped2 = CreatePed(0, model , 407.86, 240.86, 91.05, true)
     FreezeEntityPosition(ped2, true)
     SetEntityHeading(ped2, 67.57 )
     SetEntityInvincible(ped2, true)
     SetBlockingOfNonTemporaryEvents(ped2, true)
     --TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
end