
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local totalPrice=0

RegisterNetEvent('re2-tunerjob:addToPrice', function(price)
    totalPrice=totalPrice+price
    print(totalPrice)
end)



CreateThread(function()
--     for _, ped in pairs(cfg.pedLocations) do
--         print(ped.lLocation.x)
--         local veh = GetClosestVehicle(ped.lLocation.x, ped.lLocation.y, ped.lLocation.z, 3, 0)
--         print(veh)
      
--   end
end)


RegisterNetEvent("re2-tunerjob:purchaseSuccessful", function(mycar)
    QBCore.Functions.Notify("Tuning is Start")
    print(json.encode(mycar))
    local veh = QBCore.Functions.GetClosestVehicle()
    QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
        QBCore.Functions.SetVehicleProperties(veh, mycar)
    end, mycar.plate)
end)

RegisterNetEvent("re2-tunerjob:purchaseFailed", function()
    isPurchaseSuccessful = false
    attemptingPurchase = false
    QBCore.Functions.Notify("You Dont Have that Much Money", "error")
end)

RegisterNetEvent('re2-tunerjob:tuner_mod:makeTunerRecipe', function(car,url)

        print("HELLO tuner")
    local data= {
        totalPrice = totalPrice,
        vehicle = car,
        url = url
    }
    TriggerServerEvent('re2-tunerjob:giveRecipe',data)
end)

