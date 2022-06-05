-- Zones for Menues
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    ['police'] = {
        vector3(461.45, -986.2, 30.73),
    },
    ['ambulance'] = {
        vector3(335.46, -594.52, 43.28),
    },
    ['realestate'] = {
        vector3(-716.11, 261.21, 84.14),
    },
    ['taxi'] = {
        vector3(907.24, -150.19, 74.17),
    },
    ['cardealer'] = {
        vector3(-27.47, -1107.13, 27.27),
    },
    ['mechanic'] = {
        vector3(-25.19, -1051.68, 32.4),
    },
    ['sandersmotor'] = {
        vector3(274.91, -1153.14, 33.24),
    },
    ['burgershot'] = {
        vector3(-1177.69, -896.09, 14.88),
    },
    ['records'] = {
        vector3(-817.12, -699.44, 32.14),
    },
    ['uwu'] = {
        vector3(-596.14, -1052.56, 22.34),
    },
    ['pizza'] = {
        vector3(797.12, -751.6, 31.27),
    },
    ['pawnshop'] = {
        vector3(167.5, -1314.45, 29.36),
    },
    ['judge'] = {
        vector3(-588.03, -205.63, 38.23),
    },
    ['digitalden'] = {
        vector3(1135.2, -468.97, 66.49),
    }
}

Config.BossMenuZones = {
    ['police'] = {
        { coords = vector3(461.45, -986.2, 30.73), length = 0.35, width = 0.45, heading = 351.0, minZ = 30.58, maxZ = 30.68 } ,
    },
    ['ambulance'] = {
        { coords = vector3(335.46, -594.52, 43.28), length = 1.2, width = 0.6, heading = 341.0, minZ = 43.13, maxZ = 43.73 },
    },
    ['realestate'] = {
        { coords = vector3(-716.11, 261.21, 84.14), length = 0.6, width = 1.0, heading = 25.0, minZ = 83.943, maxZ = 84.74 },
    },
    ['taxi'] = {
        { coords = vector3(907.24, -150.19, 74.17), length = 1.0, width = 3.4, heading = 327.0, minZ = 73.17, maxZ = 74.57 },
    },
    ['cardealer'] = {
        { coords = vector3(-27.47, -1107.13, 27.27), length = 2.4, width = 1.05, heading = 340.0, minZ = 27.07, maxZ = 27.67 },
    },
    ['mechanic'] = {
        { coords = vector3(-25.19, -1051.68, 32.4), length = 1.15, width = 2.6, heading = 353.0, minZ = 31.4, maxZ = 33.4 },
    },
    ['sandersmotor'] = {
        { coords = vector3(274.91, -1153.14, 33.24), length = 1.15, width = 2.6, heading = 353.0, minZ = 32.24, maxZ = 34.24 },
    },
    ['burgershot'] = {
        { coords = vector3(-1177.69, -896.09, 14.88), length = 1.15, width = 2.6, heading = 353.0, minZ = 13.88, maxZ = 15.50 },
    },
    ['records'] = {
        { coords = vector3(-817.12, -699.44, 32.14), length = 1, width = 1, heading = 0, minZ = 28.74, maxZ = 32.74 },
    },
    ['uwu'] = {
        { coords = vector3(-596.14, -1052.56, 22.34), length = 1, width = 1, heading = 0, minZ = 19.14, maxZ = 23.14 },
    },
    ['pizza'] = {
        { coords = vector3(797.12, -751.6, 31.27), length = 1, width = 1, heading = 0, minZ = 27.87, maxZ = 31.87 },
    },
    ['pawnshop'] = {
        { coords = vector3(167.5, -1314.45, 29.36), length = 1, width = 1, heading = 65, minZ = 26.36, maxZ = 30.36 },
    },
    ['judge'] = {
        { coords = vector3(-588.03, -205.63, 38.23), length = 1, width = 1, heading = 65, minZ = 26.36, maxZ = 30.36 },
    },
    ['digitalden'] = {
        { coords = vector3(1135.2, -468.97, 66.49), length = 0.5, width = 0.5, heading = 0, minZ = 62.89, maxZ = 66.89 },
    },
}

Config.GangMenus = {
    ['lostmc'] = {
        vector3(0, 0, 0),
    },
    ['ballas'] = {
        vector3(0,0, 0),
    },
    ['vagos'] = {
        vector3(0, 0, 0),
    },
    ['cartel'] = {
        vector3(0, 0, 0),
    },
    ['families'] = {
        vector3(0, 0, 0),
    },
}

Config.GangMenuZones = {
    --[[
    ['gangname'] = {
        { coords = vector3(0.0, 0.0, 0.0), length = 0.0, width = 0.0, heading = 0.0, minZ = 0.0, maxZ = 0.0 },
    },
    ]]
}
