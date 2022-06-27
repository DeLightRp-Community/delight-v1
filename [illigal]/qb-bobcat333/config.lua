Config = {}

Config.MinimumPolice = 0 -- minimum police to start heist

Config.Cooldown = 60 -- minutes / reset vault time // check the server side line 77

Config.FirstDoor = vector3(880.895142, -2258.308350, 32.534858)
Config.SecondDoor = vector3(881.617066, -2264.669434, 32.591564)
Config.ThirdDoor = vector3(882.619874, -2268.408204, 32.591602)

Config.DoorLock = 'qb' -- qb/nui

Config.RemoveKeycardOnUse = true
Config.RemoveKeycardOnUseChance = 50 -- %

Config.RemoveKeycardOnFail = true
Config.RemoveKeycardOnFailChance = 25 -- %

Config.RemoveThermiteOnFail = false

Config.Smgs = {
    "weapon_smg",
    "weapon_microsmg",
    "weapon_machinepistol",
    "weapon_minismg",
    "weapon_pistol50"
}

Config.Explosives = {
    "weapon_grenade",
    "weapon_molotov",
    "weapon_stickybomb",

}

Config.Rifles = {
    "weapon_assaultrifle", 
    "weapon_compactrifle",
    "weapon_mg",
    "weapon_pumpshotgun",
}

Config.UseBlip = true

Config.BlipLocation = {
    {title="Bobcat Security", colour=5, id=106, x = 883.78784179688, y = -2275.9799804688, z = 30.467803955078},
}
 

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
