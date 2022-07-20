local QBCore = exports['qb-core']:GetCoreObject()
--Blip Creation 

Citizen.CreateThread(function()
    DigitalDen = AddBlipForCoord(1132.19, -472.15, 66.48)
    SetBlipSprite (DigitalDen, 107)
    SetBlipDisplay(DigitalDen, 4)
    SetBlipScale(DigitalDen, 1.5)
    SetBlipAsShortRange(DigitalDen, true)
    SetBlipColour(DigitalDen, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("DigitalDen")
    EndTextCommandSetBlipName(DigitalDen)
end) 

RegisterNetEvent("qb-digitalden:Tray")
AddEventHandler("qb-digitalden:Tray", function()
    TriggerEvent("inventory:client:SetCurrentStash", "ddigitaltray1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "ddigitaltray1", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-digitalden:Storage")
AddEventHandler("qb-digitalden:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "digitaldenstorage")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "digitaldenstorage", {
        maxweight = 1000000,
        slots = 50,
    })
end)
-- eye targets

exports['qb-target']:AddBoxZone("digitaltray", vector3(1134.02, -468.75, 66.49), 1, 1, {
    name = "digitaltray",
    heading=75,
    --debugPoly=true,
}, {
    options = {
        {  
        event = "qb-digitalden:Tray",
        icon = "far fa-clipboard",
        label = "Counter",
        job = "digitalden",
        },
    },
    distance = 2.5
})

exports['qb-target']:AddBoxZone("digitalcraft", vector3(1134.92, -466.59, 66.49), 1.4, 1, {
    name = "digitalcraft",
    heading=350,
    --debugPoly=true,
}, {
    options = {
        {  
        event = "qb-digitalden:client:openCraftMenu",
        icon = "far fa-clipboard",
        label = "Craft",
        job = "digitalden",
        },
    },
    distance = 2.5
})

exports['qb-target']:AddBoxZone("digitalstorage", vector3(1132.53, -465.77, 66.49), 1.4, 1, {
    name = "digitalstorage",
    heading=75,
    --debugPoly=true,
}, {
    options = {
        {  
        event = "qb-digitalden:Storage",
        icon = "far fa-clipboard",
        label = "Storage",
        job = "digitalden",
        },
    },
    distance = 2.5
})