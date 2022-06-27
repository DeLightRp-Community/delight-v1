Craft = {
    Targets = {
        CraftEngine = "Craft Engine",
        CraftBrakes = "Craft Brakes",
        CraftTransmission = "Craft Transmission",
        CraftGeneral = "CraftGeneral",
    },
    ["Inv-Link"] = "lj-inventory/html/images/", --Set this to your inventory Directory
    ["Engine"] = {
        ["engine0"] = { 
            hash = "engine0", 
            label = "Motor Level 0",
            materials = {
                [1] = { item = "metalscrap",    amount = 10 },
                [2] = { item = "steel",         amount = 10 },
                [3] = { item = "glass",         amount = 10 },
            }
        },
        ["engine1"] = { 
            hash = "engine1", 
            label = "Motor Level 1",
            materials = {
                [1] = { item = "metalscrap",    amount = 20 },
                [2] = { item = "steel",         amount = 20 },
                [3] = { item = "glass",         amount = 20 },
            }
        },
        ["engine2"] = { 
            hash = "engine2", 
            label = "Motor Level 2",
            materials = {
                [1] = { item = "metalscrap",    amount = 30 },
                [2] = { item = "steel",         amount = 30 },
                [3] = { item = "glass",         amount = 30 },
            }
        },
        ["engine3"] = { 
            hash = "engine3", 
            label = "Motor Level 3",
            materials = {
                [1] = { item = "metalscrap",    amount = 40 },
                [2] = { item = "steel",         amount = 40 },
                [3] = { item = "glass",         amount = 40 },
            }
        },
        ["engine4"] = { 
            hash = "engine4", 
            label = "Motor Level 4",
            materials = {
                [1] = { item = "metalscrap",    amount = 50 },
                [2] = { item = "steel",         amount = 50 },
                [3] = { item = "glass",         amount = 50 },
            }
        },
    },
    ["Brakes"] = {
        ["brake0"] = { 
            hash = "brake0", 
            label = "Brakes Level 0",
            materials = {
                [1] = { item = "metalscrap",    amount = 10 },
                [2] = { item = "steel",         amount = 10 },
                [3] = { item = "glass",         amount = 10 },
            }
        },
        ["brake1"] = { 
            hash = "brake1", 
            label = "Brakes Level 1",
            materials = {
                [1] = { item = "metalscrap",    amount = 20 },
                [2] = { item = "steel",         amount = 20 },
                [3] = { item = "glass",         amount = 20 },
            }
        },
        ["brake2"] = { 
            hash = "brake2", 
            label = "Brakes Level 2",
            materials = {
                [1] = { item = "metalscrap",    amount = 30 },
                [2] = { item = "steel",         amount = 30 },
                [3] = { item = "glass",         amount = 30 },
            }
        },
        ["brake3"] = { 
            hash = "brake3", 
            label = "Brakes Level 3",
            materials = {
                [1] = { item = "metalscrap",    amount = 40 },
                [2] = { item = "steel",         amount = 40 },
                [3] = { item = "glass",         amount = 40 },
            }
        },
    },
    ["Transmission"] = {
        ["transmission0"] = { 
            hash = "transmission0", 
            label = "Transmission Level 0",
            materials = {
                [1] = { item = "metalscrap",    amount = 10 },
                [2] = { item = "steel",         amount = 10 },
                [3] = { item = "glass",         amount = 10 },
            }
        },
        ["transmission1"] = { 
            hash = "transmission1", 
            label = "Transmission Level 1",
            materials = {
                [1] = { item = "metalscrap",    amount = 20 },
                [2] = { item = "steel",         amount = 20 },
                [3] = { item = "glass",         amount = 20 },
            }
        },
        ["transmission2"] = { 
            hash = "transmission2", 
            label = "Transmission Level 2",
            materials = {
                [1] = { item = "metalscrap",    amount = 30 },
                [2] = { item = "steel",         amount = 30 },
                [3] = { item = "glass",         amount = 30 },
            }
        },
        ["transmission3"] = { 
            hash = "transmission3", 
            label = "Transmission Level 3",
            materials = {
                [1] = { item = "metalscrap",    amount = 40 },
                [2] = { item = "steel",         amount = 40 },
                [3] = { item = "glass",         amount = 40 },
            }
        },
    },
    ["General"] = {
        ["turbo"] = { 
            hash = "turbo", 
            label = "Turbo",
            materials = {
                [1] = { item = "metalscrap",    amount = 80 },
                [2] = { item = "steel",         amount = 60 },
                [3] = { item = "glass",         amount = 60 },
            }
        },
        ["headlights"] = { 
            hash = "headlights", 
            label = "Headlights",
            materials = {
                [1] = { item = "metalscrap",    amount = 50 },
                [2] = { item = "steel",         amount = 25 },
                [3] = { item = "glass",         amount = 20 },
            }
        },
        ["coilovers"] = { 
            hash = "coilovers", 
            label = "Coilovers",
            materials = {
                [1] = { item = "metalscrap",    amount = 20 },
                [2] = { item = "steel",         amount = 35 },
                [3] = { item = "glass",         amount = 45 },
            }
        },
        ["coilover_wrenches"] = { 
            hash = "coilover_wrenches", 
            label = "Coilover Wrenches",
            materials = {
                [1] = { item = "metalscrap",    amount = 20 },
                [2] = { item = "steel",         amount = 15 },
                [3] = { item = "glass",         amount = 12 },
            }
        },
        ["tint_supplies"] = { 
            hash = "tint_supplies", 
            label = "Tint Supplies",
            materials = {
                [1] = { item = "metalscrap",    amount = 15 },
                [2] = { item = "steel",         amount = 25 },
                [3] = { item = "glass",         amount = 45 },
            }
        },
    },
    ["PublicLocation"] = {
        ["craft"] = {
            ["free1"] = {  
                ["loc"] = vector3(135.03, -3050.65, 7.04),  --Polyzone for crafting
                ["length"] = 1.0,
                ["width"] = 1.0,
                ["name"] = "free1", 
                ["heading"] = 325,
                ["minZ"] = 4,
                ["maxZ"] = 8,
            },  -- Add More Locations below this
        },
    }
}
