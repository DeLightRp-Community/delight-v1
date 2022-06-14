--[[
    ['Innocence'] = {
    settings = {
        label = 'Bennys Motorworks', -- Text label for anything that wants it
        welcomeLabel = "Welcome to Benny's Motorworks!", -- Welcome label in the UI
        enabled = true, -- If the location can be used at all
    },
    blip = {
        label = 'Bennys Motorworks',
        coords = vector3(-205.6992, -1312.7377, 31.1588),
        sprite = 72,
        scale = 0.65,
        color = 0,
        display = 4,
        enabled = true,
    },
    categories = { -- Only include the categories you want. A category not listed defaults to FALSE.
        mods = true, -- Performance Mods
        repair = true,
        armor = true,
        respray = true,
        liveries = true,
        wheels = true,
        tint = true,
        plate = true,
        extras = true,
        neons = true,
        xenons = true,
        horn = true,
        turbo = true,
        cosmetics = true, -- Cosmetic Mods
    },
    drawtextui = {
        text = "Bennys Motorworks",
    },
    restrictions = { -- A person must pass ALL the restriction checks. Remove an item below to automatically pass that check.
        job = "any", -- Allowed job. Can be an array of strings for multiple jobs. Any for all jobs
        gang = "any", -- Allowed gang. Can be an array of strings for multiple gangs. Any for all gangs
        allowedClasses = {}, -- Array of allowed classes. Empty will allow any but denied classes.
        deniedClasses = {}, -- Array of denied classes.
    },
    zones = {
        { coords = vector3(-212.55, -1320.56, 31.0), length = 6.0, width = 4.0, heading = 270.0, minZ = 29.88, maxZ = 33.48 },
        { coords = vector3(-222.47, -1329.73, 31.0), length = 6.0, width = 4.4, heading = 270.0, minZ = 29.88, maxZ = 33.48 },
    }
},

Vehicle Classes:
0: Compacts     1: Sedans       2: SUVs         3: Coupes       4: Muscle       5: Sports Classics
6: Sports       7: Super        8: Motorcycles  9: Off-road     10: Industrial  11: Utility
12: Vans        13: Cycles      14: Boats       15: Helicopters 16: Planes      17: Service
18: Emergency   19: Military    20: Commercial  21: Trains
 ]]

 Config = Config or {}

 Config.Locations = {
    ['Power'] = {
        settings = {
            label = 'Bennys Motorworks',
            welcomeLabel = "Welcome to Benny's Motorworks!",
            enabled = true,
        },
        blip = {
            label = 'Bennys Motorworks',
            coords = vector3(-41.8942, -1044.1943, 28.6297),
            sprite = 72,
            scale = 0.65,
            color = 0,
            display = 4,
            enabled = true,
        },
        categories = {
            -- mods = true,
            -- turbo = true,
            repair = true,
            respray = true,
            liveries = true,
            wheels = true,
            tint = true,
            plate = true,
            extras = true,
            neons = true,
            xenons = true,
            horn = true,
            cosmetics = true,
        },
        drawtextui = {
            text = "Bennys Motorworks"
        },
        restrictions = { 
            job = "mechanic",
            deniedClasses = { 18 } 
        },
        zones = {
            { coords = vector3(-32.48, -1065.38, 28.4), length = 6.0, width = 4.0, heading = 340.0, minZ = 27.0, maxZ = 31.0 },
            { coords = vector3(-38.12, -1052.85, 28.4), length = 6.0, width = 4.0, heading = 340.0, minZ = 27.0, maxZ = 31.0 },
        }
    },

    ['atous'] = {
        settings = {
            label = 'Bennys Motorworks',
            welcomeLabel = "Welcome to Benny's Motorworks!",
            enabled = true,
        },
        blip = {
            label = 'Atous Repairs',
            coords = vector3(829.16, -811.34, 26.33),
            sprite = 72,
            scale = 0.65,
            color = 0,
            display = 4,
            enabled = true,
        },
        categories = {
            -- mods = true,
            -- turbo = true,
            repair = true,
            respray = true,
            liveries = true,
            wheels = true,
            tint = true,
            plate = true,
            extras = true,
            neons = true,
            xenons = true,
            horn = true,
            cosmetics = true,
        },
        drawtextui = {
            text = "Bennys Motorworks"
        },
        restrictions = { 
            job = "atous",
            deniedClasses = { 18 } 
        },
        zones = {
            { coords = vector3(831.32, -805.6, 26.33), length = 7.0, width = 4.0, heading = 340.0, minZ = 24.93, maxZ = 28.93 },
        }
    },
 
     ['MRPD'] = {
         settings = {
             label = 'MRPD Motorworks',
             welcomeLabel = "Welcome to MRPD Motorworks!",
             enabled = true,
         },
         categories = {
             mods = true,
             turbo = true,
             repair = true,
             respray = true,
             liveries = true,
             tint = true,
              extras = true,
              plate = true,
              cosmetics = true,
         },
         drawtextui = {
             text = "MRPD Motorworks",
         },
         restrictions = {
             job = { 'police', 'bcso', 'sasp' },
             allowedClasses = { 18 },
         },
         zones = {
             { coords = vector3(450.09, -975.92, 25.7), length = 9.0, width = 4.0, heading = 90.0, minZ = 24.5, maxZ = 28.5 },
             { coords = vector3(435.53, -975.97, 25.7), length = 9.0, width = 4.0, heading = 90.0, minZ = 24.5, maxZ = 28.5 },
         }
     },
 
     ['Pillbox'] = {
         settings = {
             label = 'Pillbox Motorworks',
             welcomeLabel = "Welcome to Pillbox Motorworks!",
             enabled = true,
         },
         categories = {
             repair = true,
             respray = true,
             liveries = true,
             tint = true,
             -- extras = true,
             -- plate = true,
             -- cosmetics = true,
         },
         drawtextui = {
             text = "Pillbox Motorworks"
         },
         restrictions = {
             job = { 'ambulance' },
             allowedClasses = { 18 },
         },
         zones = {
             { coords = vector3(337.2, -579.6, 28.8), length = 9.4, width = 4.2, heading = 340.0, minZ = 27.5, maxZ = 31.5 },
             { coords = vector3(340.38, -570.8, 28.8), length = 8.8, width = 4.2, heading = 340.0, minZ = 27.5, maxZ = 31.5 },
         }
     },
 }