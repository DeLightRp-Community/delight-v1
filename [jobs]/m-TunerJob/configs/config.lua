
Config = {}

Config.Framework = "NEW" -- "NEW" - new qbcore | "OLD" - old qbcore
Config.CoreName = "qb-core"

Config.Businesses = {
    "Auto Repair",                                              -- Name of company                        
}

-----------------
-- Repair Stations
-----------------  
Config.SocietyAccount    = 'tuner'                                                              -- Society account job name
Config.UseSocietyAccount = true                                                                 -- if you want to use Society Account
Config.EnableSoundEffect = true                                                                 -- Enable and disable the sounds
Config.RepairButton      = 38                                                                   -- E - To change go to: https://docs.fivem.net/docs/game-references/controls/
Config.Text3DToRepair    = "[E] Repair Vehicle"
Config.TextToPayRepair   = "Price: $125"
Config.TextNoMoney       = "You don't have enough money."

Config.Stations          = {                                                                    -- if you want repair for free, set cost to false
    { x = 124.95,   y = -3047.38, z = 7.04, cost = 125, repairTime = 5000 },
}

-----------------
-- Chop Chop
-----------------
Config.EnableChopChop = true    -- Enable Chop Chop?
Config.EnableSpecificVehicles = false   -- Enable Specific Vehicles? If true change on : Config.SpecificVehicles
Config.TimeToChopChopAgain = 900000   -- Time to chopchop again. (15 Minutes)
Config["ChopChopLocation"] = {
    [1] = { x = 144.06, y = -2998.79, z = 7.03},  
    -- You can add more locations
}

Config.QuantityChopChop = math.random(2,4) -- Number of random items
Config.AmountGieAfterChopChop = math.random(2,4) -- Number of items that will go out
Config.ItemsOnChopChop = {  -- Items reward on chopchop
    'plastic',
    'metalscrap',
    'copper',
    'aluminum',
    'iron',
    'steel',
    'rubber',
    'glass',
    'electronics',
}

Config.SpecificVehicles = {     -- List of Specific Vehicles for chop chop
    "t20"
}

-----------------
-- Vehicles
----------------- 
Config.Vehicles = {
    ["flatbed3"]    = "Flatbed",                  -- List of vehicles available to mechanics.
    ["towtruck"]    = "Towtruck",                 -- List of vehicles available to mechanics.
    ["minivan"]     = "Minivan (Rental Car)",     -- List of vehicles available to mechanics.
    ["blista"]      = "Blista",                   -- List of vehicles available to mechanics.
}

Config.PlateText = "TUNNERS"

Config.Locations = {
    ["exit"] = vector3(125.38, -3034.99, 7.04),             -- Loc of the shop
    ["vehicle"] = vector4(137.92, -3023.74, 7.04, 270.38),  -- Loc of spawn vehicle
}

Config.CarItems = {  -- Items that will automatically be in the glovebox compartment of mechanics vehicles
    [1] = {
        name = "repairkit",
        amount = 2,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "advancedrepairkit",
        amount = 2,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "maquinadiagonostico",
        amount = 2,
        info = {},
        type = "item",
        slot = 3,
    },
    [4] = {
        name = "cleaningkit",
        amount = 2,
        info = {},
        type = "item",
        slot = 4,
    },
}

-----------------
-- Câmeras
-----------------
Config.CamerasSeguranca = {
    hideradar = false,
    cameras = {
        [1] = {label = "CAM#1", coords = vector3(156.28, -3006.42, 13.15),  r = {x = -25.0, y = 0.0, z = 235.85},    canRotate = true, isOnline = true},
        [2] = {label = "CAM#2", coords = vector3(156.07, -3059.22, 13.57),  r = {x = -25.0, y = 0.0, z = 159.23},    canRotate = true, isOnline = true},
        [3] = {label = "CAM#3", coords = vector3(153.90, -3051.26, 12.49),  r = {x = -35.0, y = 0.0, z = 68.09},     canRotate = true, isOnline = true},
        [4] = {label = "CAM#4", coords = vector3(123.2, -3017.04, 10.02),   r = {x = -35.0, y = 0.0, z = -168.91},   canRotate = true, isOnline = true},
    },
}

-----------------
-- Utilitys
-----------------   
Config.QBGaragesTrigger     = "qb-garage:server:checkVehicleOwner"
Config.HudNitroTrigger      = "hud:client:UpdateNitrous"
Config.StashInvTrigger      = "inventory:client:SetCurrentStash"
Config.MechanicAvailable    = "m-TunerJob:server:IsMechanicAvailable"
Config.NameOfStash          = "tunerstash"
Config.MaxWeighStash        = 50000
Config.MaxSlotsStash        = 50
Config.OpenInvTrigger       = "inventory:server:OpenInventory"
Config.CraftMechanicTrigger = "inventory:client:CraftingMecanicos"
Config.Phone                = "qb-phone"                                   -- qb-phone or gksphone
Config.PhoneSendEmailQBPhone = "qb-phone:server:sendNewMail"
Config.PhoneSendEmailGKSPhone = "gksphone:NewMail"
Config.NameOfBlip           = "Tuner"
Config.FuelSystem           = "LegacyFuel" -- Your Fuel
Config.VehicleKeysTrigger   = "vehiclekeys:client:SetOwner" -- Trigger to give keys
Config.BlipSprite           = 446
Config.BlipScale            = 0.7
Config.BlipColour           = 0
Config.BlipAlpha            = 0.7
Config.ToggleDuty           = "QBCore:ToggleDuty"               -- Trigger of Duty
Config.checkTunesMessage    = "phone"                           -- Dont toutch     
Config.Job                  = "tuner"                           -- Name of job         
Config.Unemployed           = "unemployed"                      -- Name of unemployed job
Config.QBMenu               = "qb-menu"                         -- Menu
Config.Target               = "qb-target"                       -- Target                           
Config.skillbarTurbo        = "qb-skillbar"                     -- You can use: qb-skillbar
Config.skillbarXenons       = "qb-skillbar"                     -- You can use: qb-skillbar
Config.skillbarRemoveTint   = "qb-skillbar"                     -- You can use: qb-skillbar
Config.SkillbarColour       = "qb-skillbar"                     -- You can use: qb-skillbar
Config.isVehicleOwned = true                                    -- Don't touch
Config.TempoInstalarTurbo = math.random(7000,10000)             -- Time of progressBars to install turbo
Config.TempoInstalarXenonHeadlight = math.random(7000,10000)    -- Time of progressBars to install headlights
Config.TempoUsarAirSuspension = 4500                            -- Time of progressBars to use airsuspensio. Don't touche because the sound only have 4.5s
Config.MultipleTunerchip = 0.08                                 -- Multiplier of tunerchip

-----------------
-- Commands
-----------------
Config.StateVehicle                 = "statevehicle"                                -- Alter state vehicle
Config.StateVehicleHelp             = "Enter the part you want to edit"             -- Part to alter on vehicle.
Config.StateVehicleHelp2            = "A percentagem fixa"                          -- The fixed percentage
Config.StateVehiclePermission       = "god"                                         -- Admin permission to use command.
Config.GiveMechanicJob              = "setmechanic"                                 -- Put someone to mechanic
Config.GiveMechanicJobHelp          = "Give someone the job of a mechanic"          -- Give someone the job of a mechanic
Config.GiveMechanicJobHelp2         = "Player ID"
Config.FireMechanicJob              = "firemechanic"
Config.FireMechanicJobHelp          = "Fire A Mechanic"
Config.FireMechanicJobHelp2         = "Player ID"
Config.BillPlayer                   = "billmechanic"
Config.CleanVehicle                 = "cleanvehicle"    --  Clean closest vehicle   
Config.StatusVehicle                = "statusvehicle"   -- Check vehicle closest vehicle

-----------------
-- Targets
-----------------
-- Coilover Targets
Config.CoiloverTarget       = "Adjust Coilovers"
Config.CoiloverIconTarget   = "fas fa-wrench"
Config.CoiloverItem         = "coilovers"

-- Warehouse Targets
Config["Warehouse"]   = {
    vector3(128.51, -3008.27, 7.88),
    -- You can add more locations
}
Config.WarehouseTarget      = "Warehouse"
Config.WarehouseIconTarget  = "fas fa-box-circle-check"
Config.WarehouseDistTarget  = 2.0

-- Craft Targets
Config["CraftLocation"]     = { 
    vector3(134.8, -3050.64, 7.04),
    -- You can add more locations
}

Config.CraftTarget          = "Craft"
Config.CraftIconTarget      = "fas fa-box-circle-check"
Config.CraftDistTarget      = 2.0

-- Vehicles Targets
Config["VeiculosZinhos"]    = {
    vector3(125.31, -3026.32, 6.04),
    -- You can add more locations
}
Config.VehicleTarget        = "Vehicles"
Config.VehicleIconTarget    = "fas fa-car"
Config.VehicleDistTarget    = 5.0

-- Duty Targets
Config["DutyLocation"]      = {
    vector3(125.75, -3007.48, 7.86),
    -- You can add more locations
} 
Config.DutyTarget           = "Service"
Config.DutyIconTarget       = "fas fa-bell"
Config.DutyDistTarget       = 2.0

-- Nitro Targets
Config["NitroLocation"]     = {
    vector3(137.54, -3050.82, 7.04),
    -- You can add more locations
}

Config.NitroTarget          = "Refill Nitro"
Config.NitroIconTarget      = "far fa-hand-paper"
Config.NitroDistTarget      = 1.5

-- Tunning Targets
Config["TuningLocation"]    = {
    vector3(132.65, -3028.61, 7.09),
    -- You can add more locations
}

Config.TuningTarget         = "Check Modifications"
Config.TuningIconTarget     = "fas fa-car"
Config.TuningDistTarget     = 10.0

-- Shop Targets
Config["ShopLocation"]      = {
    vector3(128.4, -3014.33, 7.85),
    -- You can add more locations
}

Config.ShopTarget           = "Shop"
Config.ShopIconTarget       = "fas fa-box"
Config.ShopDistTarget       = 2.0
Config.ShopName             = "Mechanic Shop"

-- Windows Targets
Config.WindowsTarget        = "Apply Windows Tint"
Config.WindowsIconTarget    = "fas fa-circle"
-- Billing
Config["BillLocation"]      = {
    vector3(133.91, -3015.16, 7.04),
    -- You can add more locations
}

Config.BillTarget           = "Bill a Player"
Config.BillIconTarget       = "fas fa-money-bill-alt"
Config.BillDistTarget       = 2.0
-- Insurance
Config.InsuranceIconTarget  = "fas fa-car"
Config.InsuranceTarget      = "Insurance"
-- Chop Chop
Config.ChopChopLabel        = "Chop Vehicle"
Config.ChopChopIcon         = "fas fa-car"

-----------------
-- Animations
-----------------
-- Windows Tint
Config.AnimationWindowsTint         = "timetable@maid@cleaning_window@idle_b"
Config.SubAnimationWindowsTint      = "idle_d"
Config.PropAnimationWindowsTinto    = "prop_rag_01"
-- Tunerchip
Config.AnimationTurnON              = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
Config.SubAnimationTurnON           = "machinic_loop_mechandplayer"

----------------------
-- Peds
----------------------
Config.PedListMechanic = {                                              -- Peds that will be spawned in
    {
        model = "s_m_y_xmech_02",                                                         
        coords = vector3(125.31, -3026.32, 6.04),           
        heading = 358.52,
        gender = "male",
        scenario = "WORLD_HUMAN_STAND_MOBILE_UPRIGHT" 
    },
    {
        model = "s_m_y_xmech_02",                                                         
        coords = vector3(130.89, -3029.58, 6.04),           
        heading = 277.00,
        gender = "male",
        scenario = "WORLD_HUMAN_CLIPBOARD" 
    },
}