Config = {}

-- **** IMPORTANT ****
-- UseTarget should only be set to true when using qb-target
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
Config.Targets = {}

Config.AttachedVehicle = nil

Config.AuthorizedIds = {
    -- "insertcitizenidhere",
}

Config.MaxStatusValues = {
    ["engine"] = 1000.0,
    ["body"] = 1000.0,
    ["radiator"] = 100,
    ["axle"] = 100,
    ["brakes"] = 100,
    ["clutch"] = 100,
    ["fuel"] = 100,
}

Config.ValuesLabels = {
    ["engine"] = "Motor",
    ["body"] = "Body",
    ["radiator"] = "Radiator",
    ["axle"] = "Drive Shaft",
    ["brakes"] = "Brakes",
    ["clutch"] = "Clutch",
    ["fuel"] = "Fuel Ttank",
}

Config.RepairCost = {
    ["body"] = "plastic",
    ["radiator"] = "plastic",
    ["axle"] = "steel",
    ["brakes"] = "iron",
    ["clutch"] = "aluminum",
    ["fuel"] = "plastic",
}

Config.RepairCostAmount = {
    ["engine"] = {
        item = "metalscrap",
        costs = 2,
    },
    ["body"] = {
        item = "plastic",
        costs = 3,
    },
    ["radiator"] = {
        item = "steel",
        costs = 5,
    },
    ["axle"] = {
        item = "aluminum",
        costs = 7,
    },
    ["brakes"] = {
        item = "copper",
        costs = 5,
    },
    ["clutch"] = {
        item = "copper",
        costs = 6,
    },
    ["fuel"] = {
        item = "plastic",
        costs = 5,
    },
}

Config.Businesses = {
    "Auto Repair",
}

Config.Plates = {
     [1] = {
         coords = vector4(-29.38, -1042.73, 28.63, 161.81),
         boxData = {
             heading = 340,
             length = 5,
             width = 2.5,
             debugPoly = false
         },
         AttachedVehicle = nil,
    },
}

Config.Locations={
    ["exit"] = vector3(-339.04, -135.53, 39),
    ["duty"] = vector3(-33.39, -1040.74, 28.6),
    ["stash"] =vector3(-39.95, -1056.57, 28.4),
    ["vehicle"] = vector4(-20.86, -1020.63, 28.9, 69.21),
}

Config.Vehicles = {
     ["flatbed"] = "Flatbed",
     ["towtruck"] = "Towtruck",t
}

Config.MinimalMetersForDamage = {
    [1] = {
        min = 8000,
        max = 12000,
        multiplier = {
            min = 1,
            max = 8,
        }
    },
    [2] = {
        min = 12000,
        max = 16000,
        multiplier = {
            min = 8,
            max = 16,
        }
    },
    [3] = {
        min = 12000,
        max = 16000,
        multiplier = {
            min = 16,
            max = 24,
        }
    },
}

Config.Damages = {
    ["radiator"] = "Radiator",
    ["axle"] = "Drive Shaft",
    ["brakes"] = "Brakes",
    ["clutch"] = "Clutch",
    ["fuel"] = "Fuel Tank",
}

Config.cfg = {
    modifyTime = 10000,

    modLocation = {
        [1] = {coords = vector4(-36.59, -1069.96, 28.4, 158.56), blip = true},
    },

    crafts = {
        ["Mechanic Items"] = {
            ["repairkit"] = {
                items = {["iron"] = 2,["plastic"] = 1,}
            },
            ["advancedrepairkit"] = {
                items = {["aluminum"] = 3,["iron"] = 2,}
            },
            ["cleaningkit"] = {
                items = {["steel"] = 3,["rubber"] = 2,}
            },
            ["harness"] = {
                items = {["rubber"] = 3,["plastic"] = 2,}
            },
        },
    }
}
