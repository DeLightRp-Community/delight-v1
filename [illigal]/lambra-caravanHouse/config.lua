Config = {}
Config.CorePrefix = "qb-"

Config.QBTarget = "qb-target" --"none" if you don't want to use target else set your target resource name for example "qb-target"

Config.Shop = {
    blipID = 642,
    blipScale = 1.0,
    blipColor = 2,
    pedModel = "a_m_o_genstreet_01",
    pos = vector4(1224.57, 2728.74, 38.01, 176.07),
    showRoom = vector4(1222.83, 2708.2, 37.58, 304.97),
    boughtPos = vector4(1248.38, 2710.32, 37.58, 184.16)
}

Config.Caravans = {
    ["camper"] = {
        price = 400000,
        stashSlots = 50,
        stashWeight = 100000, -- Set Value in Grams, it will be converted to KG on script
        stashPos = vector3(1216.93, 2701.05, 1.37),
        interior = vector3(1219.95, 2702.15, 1.37), -- Thats the coords for inside the caravan
        bone = "window_rr" -- Thats the bone to get the position to the entering door
    }
}


Locales = {
    ["BlipText"] = "Caravan Dealership",
    ["shopLabel"] = "Press ~g~E~w~ to open the shop",
    ["shopHeader"] = "Available Caravans",
    ["shopDetails"] = "Click to see details",
    ["shopClose"] = "⬅ Close Menu",
    ["detailsStashSlots"] = "[~y~Stash slots~w~] ",
    ["detailsStashWeight"] = "[~y~Stash weight~w~] ",
    ["detailsShopPrice"] = "[~g~Price~w~] ",
    ["detailsWeightUni"] = "Kg",
    ["currency"] = "$",
    ["shopClickToBuy"] = "Press [~g~E~w~] to buy",
    ["shopConfirmation"] = "Press [~g~G~w~] to ~y~Confirm",
    ["successBuy"] = "You successfully bought the vehicle.",
    ["failBuy"] = "Not enough money",
    ["caravanEnterLabel"] = "Press [~g~E~w~] to ~y~Enter",
    ["caravanExitLabel"] = "Press [~g~E~w~] to ~y~Leave",
    ["caravanOpenStash"] = "Press [~g~E~w~] to open ~y~Stash",


    --Only Change below if your using target
    ["targetIcon"] = "fas fa-car",
    ["targetLabel"] = "Open the shop"
}