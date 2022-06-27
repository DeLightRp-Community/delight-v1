Config = {}

Config.Cops = 0

-- laptop mingame settings anything more than 6 blocks will look ugly
Config.LaptopTime = 55
Config.LaptopBlocks = 6
Config.LaptopRepeat = 5

Config.MarkedBagMin = 1
Config.MarkedBagMax = 5
Config.MarkedMin = 25000
Config.MarkedMax = 50000

Config.Time = 30 -- time in seconds for the bomb to explode 

Config.Explosion = {
    [1] = {
        x = 891.89,
        y = -2284.89,
        z = 32.44,
        h = 75.46,
        hit = false
    }   
}


Config.Trolleys = {
    [1] = {
        coords = vector3(888.44, -2287.37, 31.44), 
        h =  5.92,
        hit = false
    },
    [2] = {
        coords = vector3(885.67, -2286.2, 31.44), 
        h =  349.89,
        hit = false
    },
    [3] = {
        coords = vector3(883.89, -2282.42, 31.44), 
        h = 164.06,
        hit = false
    },
    [4] = {
        coords = vector3(881.89, -2284.64, 31.44), 
        h = 324.95,
        hit = false
    }
}

-- Guards 
Config.SpawnGuards = true

Config.Guards = {
    [1] = {
        pos = {889.25, -2277.2, 30.47, 45.51}, -- guards position
        ped = 's_m_m_prisguard_01', -- guards hash
        weapon = 'WEAPON_CARBINERIFLE', -- guards weapon
        health = 1000, -- guards health
        range = 2, -- guards range
        accuracy = 50, -- guards accuracy
        aggresiveness = 3, -- guards aggresiveness - 0 stand / 1 defensive / 2 offensive / 3 ultra offensive 
        alertness = 2, -- guards alertness 3 is the highest one - values from 0 to 3.
        armor = 50 -- guards armor 
    },  
    [2] = {
        pos = {894.96, -2275.74, 30.47, 76.28}, -- guards position
        ped = 's_m_m_prisguard_01', -- guards hash
        weapon = 'WEAPON_CARBINERIFLE', -- guards weapon
        health = 1000, -- guards health
        range = 2, -- guards range
        accuracy = 50, -- guards accuracy
        aggresiveness = 3, -- guards aggresiveness - 0 stand / 1 defensive / 2 offensive / 3 ultra offensive 
        alertness = 2, -- guards alertness 3 is the highest one - values from 0 to 3.
        armor = 50 -- guards armor 
    },  
    [3] = {
        pos = {895.44, -2279.01, 30.47, 68.48}, -- guards position
        ped = 's_m_m_prisguard_01', -- guards hash
        weapon = 'WEAPON_CARBINERIFLE', -- guards weapon
        health = 1000, -- guards health
        range = 2, -- guards range
        accuracy = 50, -- guards accuracy
        aggresiveness = 3, -- guards aggresiveness - 0 stand / 1 defensive / 2 offensive / 3 ultra offensive 
        alertness = 2, -- guards alertness 3 is the highest one - values from 0 to 3.
        armor = 50 -- guards armor 
    }, 
    [4] = {
        pos = {893.06, -2289.42, 30.47, 18.59}, -- guards position
        ped = 's_m_m_prisguard_01', -- guards hash
        weapon = 'WEAPON_CARBINERIFLE', -- guards weapon
        health = 1000, -- guards health
        range = 2, -- guards range
        accuracy = 50, -- guards accuracy
        aggresiveness = 3, -- guards aggresiveness - 0 stand / 1 defensive / 2 offensive / 3 ultra offensive 
        alertness = 2, -- guards alertness 3 is the highest one - values from 0 to 3.
        armor = 50 -- guards armor 
    }, 
    [5] = {
        pos = {895.49, -2288.31, 30.47, 8.73}, -- guards position
        ped = 's_m_m_prisguard_01', -- guards hash
        weapon = 'WEAPON_CARBINERIFLE', -- guards weapon
        health = 1000, -- guards health
        range = 2, -- guards range
        accuracy = 50, -- guards accuracy
        aggresiveness = 3, -- guards aggresiveness - 0 stand / 1 defensive / 2 offensive / 3 ultra offensive 
        alertness = 2, -- guards alertness 3 is the highest one - values from 0 to 3.
        armor = 50 -- guards armor 
    }, 
    [6] = {
        pos = {891.64, -2291.96, 30.47, 351.48}, -- guards position
        ped = 's_m_m_prisguard_01', -- guards hash
        weapon = 'WEAPON_CARBINERIFLE', -- guards weapon
        health = 1000, -- guards health
        range = 2, -- guards range
        accuracy = 50, -- guards accuracy
        aggresiveness = 3, -- guards aggresiveness - 0 stand / 1 defensive / 2 offensive / 3 ultra offensive 
        alertness = 2, -- guards alertness 3 is the highest one - values from 0 to 3.
        armor = 50 -- guards armor  
    }, 
}
