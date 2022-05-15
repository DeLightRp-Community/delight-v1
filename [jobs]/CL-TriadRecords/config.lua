Config = Config or {}

-------------------
--General
-------------------

Config.PolyZone = false -- Want to view all the qb-target poly zones?

Config.UseClothing = true -- Want to use clothing in the job? DONT FORGET TO ADD THE EXPORT IF TRUE

Config.UseBlips = true --Want to use blips?

Config.Thirst = 10 --After drinking alcohol how much thirst it will give to the player?

Config.HandsStress = 2 --After player washes his hands how much stress will decreased ?

Config.DogStress = 3 --After petting the dogs how much stress will decreased ?

Config.BlipLocation = {
    {title = "Triad Records", colour = 59, id = 136, x = -827.5536, y = -728.4981, z = 28.060123},  -- Records Blip
}

Config.Job = 'records' --Name for the job that can access the target etc

--Dogs Locations
Config.Pugs = {
    [1] = {
        ['coords'] = vector4(-838.7279, -730.1538, 28.80244, 12.363456)
    },
}

-------------------
--Target / Menu
-------------------

Config.Target = 'qb-target' --Name of your target

-- Locals for the targets, menus, progressbars feel free to change whatever you want
Config.Locals = {
    SlicesTarget = {
        Label = "Buy Fruit Slices",
        Icon = "fa fa-lemon"
    },

    DutyTarget = {
        Label = "Duty",
        Icon = "fa fa-clock"
    },

    ClothingTarget = {
        Label = "Clothing",
        Icon = "fa fa-t-shirt"
    },

    TablesTarget = {
        Label = "Drink Champagne",
        Icon = "fa fa-beer"
    },

    MenusTarget = {
        Label = "Open Menu",
        Icon = "fa fa-bars"
    },

    ShopTarget = {
        Label = "Open Shop",
        Icon = "fa fa-shop"
    },

    GlassesTarget = {
        Label = "Take Glasses",
        Icon = "fa fa-hand"
    },

    StashTarget = {
        Label = "Open Stash",
        Icon = "fa fa-box"
    },

    BossStashTarget = {
        Label = "Open Boss Stash",
        Icon = "fa fa-box"
    },

    WineTarget = {
        Label = "Make Drinks",
        Icon = "fa fa-beer"
    },

    WorkersCoffeeTarget = {
        Label = "Make Coffee",
        Icon = "fa fa-coffee"
    },

    WorkersFridgeTarget = {
        Label = "Fridge",
        Icon = "fa fa-archive"
    },

    WorkersWashHandsTarget = {
        Label = "Wash Hands",
        Icon = "fa fa-hands-bubbles"
    },

    PugsTarget = {
        Label = "Pet",
        Icon = "fa fa-paw"
    },

    -- Menus

    DutyMenu = {
        Header = "Clock In / Out",
        Txt = "Duty Options"
    },

    WineMenu = {
        Header = "Pour Red Wine",
        Txt = "Start Pouring"
    },

    WhiskeyMenu = {
        Header = "Pour Whiskey",
        Txt = "Start Pouring"
    },

    BeerMenu = {
        Header = "Pour Beer",
        Txt = "Start Pouring"
    },

    WhiteWineMenu = {
        Header = "Pour White Wine",
        Txt = "Start Pouring"
    },

    SakeMenu = {
        Header = "Pour Sake",
        Txt = "Start Pouring"
    },

    SamuraiSakeMenu = {
        Header = "Pour Samurai Sake",
        Txt = "Start Pouring"
    },

    GoldSakeMenu = {
        Header = "Pour Gold Sake",
        Txt = "Start Pouring"
    },

    PinkSakeMenu = {
        Header = "Pour Pink Sake",
        Txt = "Start Pouring"
    },

    WhiteSakeMenu = {
        Header = "Pour White Sake",
        Txt = "Start Pouring"
    },

    AbsintheMenu = {
        Header = "Pour Absinthe",
        Txt = "Start Pouring"
    },

    GarageMenu = {
        MainHeader = "Records Garage",
        FourthHeader = "Store Vehicle",
        ThirdTxt = "Store Vehicle Inside Garage"
    },

    --Progressbars

    DrinkChampagneProgressBar = {
        Txt = "Drinking Champagne",
        Time = 15000
    },

    MakingCoffeeProgressBar = {
        Txt = "Making Coffee...",
        Time = 5000
    },

    DrinkProgressBar = {
        Txt = "Drinking...",
        Time = 5000
    },

    MakingWineProgressBar = {
        Txt = "Pouring Red Wine Into The Glass...",
        Time = 5000
    },

    MakingWhiteWineProgressBar = {
        Txt = "Pouring White Wine Into The Glass...",
        Time = 5000
    },

    MakingWhiskeyProgressBar = {
        Txt = "Pouring Whiskey Into The Glass...",
        Time = 5000
    },

    MakingBeerProgressBar = {
        Txt = "Pouring Beer Into The Glass...",
        Time = 5000
    },

    MakingAbsintheProgressBar = {
        Txt = "Pouring Absinthe Into The Glass...",
        Time = 5000
    },

    MakingSakeProgressBar = {
        Txt = "Pouring Sake Into The Glass...",
        Time = 5000
    },

    MakingSamuraiSakeProgressBar = {
        Txt = "Pouring Samurai Sake Into The Glass...",
        Time = 5000
    },

    MakingGoldSakeProgressBar = {
        Txt = "Pouring Gold Sake Into The Glass...",
        Time = 5000
    },

    MakingPinkSakeProgressBar = {
        Txt = "Pouring Pink Sake Into The Glass...",
        Time = 5000
    },

    MakingWhiteSakeProgressBar = {
        Txt = "Pouring White Sake Into The Glass...",
        Time = 5000
    },

    WashingHandsProgressBar = {
        Txt = "Washing Hands...",
        Time = 5000
    },

    PetPugProgressBar = {
        Txt = "Petting...",
        Time = 3000
    },
}

-- The Extras To the drinks locations you can add as many as you like
Config.ExtrasLocations = {
    [1] = {
        ['coords'] = vector3(-830.8991, -727.6964, 28.060123),
        ['heading'] = 161.01315,
        ['minZ'] = 27.060123,
        ['maxZ'] = 29.060123,
        ['poly1'] = 0.2,
        ['poly2'] = 0.5,
    }, 
    [2] = {
        ['coords'] = vector3(-832.2764, -727.8022, 28.125059),
        ['heading'] = 189.4906,
        ['minZ'] = 27.125059,
        ['maxZ'] = 29.125059,
        ['poly1'] = 0.2,
        ['poly2'] = 0.5,
    }, 
}

--Tables with Champagne you can add as many as you like
Config.TablesLocations = {
    [1] = {
        ['coords'] = vector3(-832.9331, -719.4033, 28.300342),
        ['heading'] = 144.48844,
        ['minZ'] = 27.300342,
        ['maxZ'] = 29.300342,
        ['poly1'] = 0.5,
        ['poly2'] = 0.5,
    }, 
    [2] = {
        ['coords'] = vector3(-829.9296, -722.2174, 28.300342),
        ['heading'] = 94.488433,
        ['minZ'] = 27.300342,
        ['maxZ'] = 29.300342,
        ['poly1'] = 0.5,
        ['poly2'] = 0.5,
    }, 
}

--Washing hands locations you can add as many as you like
Config.WashHandsLocations = {
    [1] = {
        ['coords'] = vector3(-811.3872, -694.9793, 28.060125),
        ['heading'] = 267.27001,
        ['minZ'] = 27.060125,
        ['maxZ'] = 29.060125,
        ['poly1'] = 0.5,
        ['poly2'] = 0.6,
    }, 
    [2] = {
        ['coords'] = vector3(-827.728, -730.4797, 27.80813),
        ['heading'] = 178.90289,
        ['minZ'] = 27.100342,
        ['maxZ'] = 29.100342,
        ['poly1'] = 0.5,
        ['poly2'] = 0.5,
    }, 
}

--Menu locations you can add as many as you like
Config.MenusLocations = {
    [1] = {
        ['coords'] = vector3(-826.9999, -727.90, 28.096),
        ['heading'] = 153.4886,
        ['minZ'] = 27.096,
        ['maxZ'] = 29.096,
        ['poly1'] = 0.2,
        ['poly2'] = 0.3,
    }, 
    [2] = {
        ['coords'] = vector3(-826.0014, -729.00106, 28.298828),
        ['heading'] = 93.268295,
        ['minZ'] = 27.298828,
        ['maxZ'] = 29.298828,
        ['poly1'] = 0.2,
        ['poly2'] = 0.3,
    }, 
    [3] = {
        ['coords'] = vector3(-832.4928, -727.4523, 28.138313),
        ['heading'] = 196.77792,
        ['minZ'] = 27.138313,
        ['maxZ'] = 29.138313,
        ['poly1'] = 0.2,
        ['poly2'] = 0.3,
    }, 
    [4] = {
        ['coords'] = vector3(-833.3806, -719.6311, 27.807891),
        ['heading'] = 274.35769,
        ['minZ'] = 26.807891,
        ['maxZ'] = 28.807891,
        ['poly1'] = 0.2,
        ['poly2'] = 0.3,
    }, 
    [5] = {
        ['coords'] = vector3(-829.5753, -721.8955, 27.80813),
        ['heading'] = 115.249,
        ['minZ'] = 26.80813,
        ['maxZ'] = 28.80813,
        ['poly1'] = 0.2,
        ['poly2'] = 0.3,
    }, 
    [6] = {
        ['coords'] = vector3(-827.7398, -718.3391, 27.80812),
        ['heading'] = 280.24871,
        ['minZ'] = 26.80812,
        ['maxZ'] = 28.80812,
        ['poly1'] = 0.2,
        ['poly2'] = 0.3,
    }, 
    [7] = {
        ['coords'] = vector3(-835.3693, -723.2101, 27.808017),
        ['heading'] = 0.0117305,
        ['minZ'] = 26.808017,
        ['maxZ'] = 28.808017,
        ['poly1'] = 0.2,
        ['poly2'] = 0.3,
    }, 
}

-------------------
--Items
-------------------

Config.CoffeeItem = 'coffee'

Config.WineGlassItem = 'rwineglass'

Config.WineBottleItem = 'rbottlewine'

Config.WineItem = 'rwine'

Config.WhiteWineGlassItem = 'rwineglass'

Config.WhiteWineBottleItem = 'rwhitewinebottle'

Config.WhiteWineItem = 'rwhitewine'

Config.WhiskeyGlassItem = 'rsmallglass'

Config.WhiskeyBottleItem = 'rwhiskeybottle'

Config.WhiskeyItem = 'rwhiskey'

Config.BeerGlassItem = 'rglass'

Config.BeerBottleItem = 'rbeerbottle'

Config.BeerItem = 'rbeer'

Config.SakeGlassItem = 'rcocktailglass'

Config.SakeBottleItem = 'rsakebottle'

Config.SakeItem = 'rsake'

Config.SamuraiSakeGlassItem = 'rcocktailglass'

Config.SamuraiSakeBottleItem = 'rsamuraisakebottle'

Config.SamuraiSakeItem = 'rsamuraisake'

Config.GoldSakeGlassItem = 'rcocktailglass'

Config.GoldSakeBottleItem = 'rgoldsakebottle'

Config.GoldSakeItem = 'rgoldsake'

Config.PinkSakeGlassItem = 'rcocktailglass'

Config.PinkSakeBottleItem = 'rpinksakebottle'

Config.PinkSakeItem = 'rpinksake'

Config.WhiteSakeGlassItem = 'rcocktailglass'

Config.WhiteSakeBottleItem = 'rwhitesakebottle'

Config.WhiteSakeItem = 'rwhitesake'

Config.AbsintheGlassItem = 'rglasstype2'

Config.AbsintheBottleItem = 'rabsinthebottle'

Config.AbsintheItem = 'rabsinthe'

Config.BeerLimeItem = 'rglasslime'

Config.BeerLemonItem = 'rglasslemon'

Config.BeerKiwiItem = 'rglasskiwi'

Config.BeerOrangeItem = 'rglassorange'

Config.BeerPineappleItem = 'rglasspineapple'

Config.Glasses = {
    [1] = {
        ['glass'] = 'rglass',
        ['glassname'] = 'Regular Glass',
        ['price'] = 20,
    }, 
    [2] = {
        ['glass'] = 'rglasstype2',
        ['glassname'] = 'Absinthe Glass',
        ['price'] = 30,
    }, 
    [3] = {
        ['glass'] = 'rsmallglass',
        ['glassname'] = 'Whiskey Glass',
        ['price'] = 10,
    }, 
    [4] = {
        ['glass'] = 'rwineglass',
        ['glassname'] = 'Wine Glass',
        ['price'] = 50,
    }, 
    [5] = {
        ['glass'] = 'rcocktailglass',
        ['glassname'] = 'Cocktails Glass',
        ['price'] = 35,
    }, 
}

-------------------
--Garage
-------------------

Config.BossVehicle = "baller"

--Vehicles, you can add as many as you like.
Config.Vehicles = {
    [1] = {
        ['vehiclename'] = "Baller", -- Name
        ['vehicle'] = "baller3", -- Model To Spawn
        ['price'] = 5500, -- Price
    }, 
    [2] = {
        ['vehiclename'] = "Pony", -- Name
        ['vehicle'] = "pony", -- Model To Spawn
        ['price'] = 2500, -- Price
    }, 
}

-------------------
--Shops
-------------------

--Slices Shop
Config.SliceItems = {
    label = "Slices",
    slots = 5,
    items = {
        [1] = {
            name = "rlime",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "rlemon",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "rkiwi",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "rorange",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "rpineapple",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 5,
        },
    }
}

--Drinks Shop
Config.ShopItems = {
    label = "Drinks",
    slots = 5,
    items = {
        [1] = {
            name = "rwhiskeybottle",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "rbeerbottle",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "rwhitewinebottle",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "rbottlewine",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "rabsinthebottle",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "rsamuraisakebottle",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "rgoldsakebottle",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "rsakebottle",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 8,
        },
        [9] = {
            name = "rwhitesakebottle",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "rpinksakebottle",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 10,
        },
    }
}

--Workers Fridge Shop
Config.FridgeItems = {
    label = "Workers Fridge",
    slots = 5,
    items = {
        [1] = {
            name = "water_bottle",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "kurkakola",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "grapejuice",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "twerks_candy",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "snikkel_candy",
            price = 5,
            amount = 100,
            info = {},
            type = "item",
            slot = 5,
        },
    }   
}