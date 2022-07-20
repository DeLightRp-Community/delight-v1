Config = {}
Config.UsingTarget = GetConvar('UseTarget', 'false') == 'true'
Config.Commission = 0.15 -- Percent that goes to sales person from a full car sale 10%
Config.FinanceCommission = 0.05 -- Percent that goes to sales person from a finance sale 5%
Config.FinanceZone = vector3(-29.53, -1103.67, 26.42)-- Where the finance menu is located
Config.PaymentWarning = 10 -- time in minutes that player has to make payment before repo
Config.PaymentInterval = 24 -- time in hours between payment being due
Config.MinimumDown = 10 -- minimum percentage allowed down
Config.MaximumPayments = 24 -- maximum payments allowed
Config.Shops = {
    ['pdm'] = {
        ['Type'] = 'managed',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-56.727394104004, -1086.2325439453),
                vector2(-60.612808227539, -1096.7795410156),
                vector2(-58.26834487915, -1100.572265625),
                vector2(-35.927803039551, -1109.0034179688),
                vector2(-34.427627563477, -1108.5111083984),
                vector2(-32.02657699585, -1101.5877685547),
                vector2(-33.342102050781, -1101.0377197266),
                vector2(-31.292987823486, -1095.3717041016)
            },
            ['minZ'] = 25.0,  -- min height of the shop zone
            ['maxZ'] = 28.0,  -- max height of the shop zone
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'cardealer', -- Name of job or none
        ['Rank'] = 2,
        ['ShopLabel'] = 'Premium Deluxe Motorsport', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 326,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['sportsclassics'] = 'Sports Classics',
            ['sedans'] = 'Sedans',
            ['coupes'] = 'Coupes',
            ['suvs'] = 'SUVs',
            ['offroad'] = 'Offroad',
            ['muscle'] = 'Muscle',
            ['compacts'] = 'Compacts',
            ['vans'] = 'Vans',
            ['super'] = 'Super',
            ['sports'] = 'Sports'
        },
        ['TestDriveTimeLimit'] = 3.0, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-45.67, -1098.34, 26.42), -- Blip Location
        ['ReturnLocation'] = vector3(-44.74, -1082.58, 26.68), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-56.79, -1109.85, 26.43, 71.5), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-1265.31, -354.44, 26.3 , 205.08),
                defaultVehicle = 'blade',
                chosenVehicle = 'blade',
            },
            [2] = {
                coords = vector4(-54.33, -1096.98, 26.3, 77.35),
                defaultVehicle = 'moonbeam',
                chosenVehicle = 'moonbeam',
            },
            [3] = {
                coords = vector4(-47.83, -1091.91, 26.3, 240.15),
                defaultVehicle = 'nero',
                chosenVehicle = 'nero',
            },
            [4] = {
                coords = vector4(-36.93, -1093.23, 26.3, 52.32),
                defaultVehicle = 'neon',
                chosenVehicle = 'neon',
            },
            [5] = {
                coords = vector4(-42.39, -1101.63, 26.3, 159.23),
                defaultVehicle = 'asbo',
                chosenVehicle = 'asbo',
            },
        },
    },
    ['luxury'] = {
        ['Type'] = 'managed',  -- meaning a real player has to sell the car
        ['Zone'] = {
            ['Shape'] = {
                vector2(-1260.6973876953, -349.21334838867),
                vector2(-1268.6248779297, -352.87365722656),
                vector2(-1274.1533203125, -358.29794311523),
                vector2(-1273.8425292969, -362.73715209961),
                vector2(-1270.5701904297, -368.6716003418),
                vector2(-1266.0561523438, -375.14080810547),
                vector2(-1244.3684082031, -362.70278930664),
                vector2(-1249.8704833984, -352.03326416016),
                vector2(-1252.9503173828, -345.85726928711)
            },
            ['minZ'] = 36.646457672119,
            ['maxZ'] = 37.516143798828,
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'cardealer', -- Name of job or none
        ['Rank'] = 2,
        ['ShopLabel'] = 'Luxury Vehicle Shop',
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 326,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = {
            ['super'] = 'Super',
            ['sports'] = 'Sports'
        },
        ['TestDriveTimeLimit'] = 0.5,
        ['Location'] = vector3(-1255.6, -361.16, 36.91),
        ['ReturnLocation'] = vector3(-1231.46, -349.86, 37.33),
        ['VehicleSpawn'] = vector4(-1231.46, -349.86, 37.33, 26.61),
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-1265.31, -354.44, 35.91, 205.08),
                defaultVehicle = 'italirsx',
                chosenVehicle = 'italirsx',
            },
            [2] = {
                coords = vector4(-1270.06, -358.55, 35.91, 247.08),
                defaultVehicle = 'italigtb',
                chosenVehicle = 'italigtb',
            },
            [3] = {
                coords = vector4(-1269.21, -365.03, 35.91, 297.12),
                defaultVehicle = 'nero',
                chosenVehicle = 'nero',
            },
        }
    }, -- Add your next table under this comma
    ['boats'] = {
        ['Type'] = 'managed',  -- no player interaction is required to purchase a vehicle
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-729.39, -1315.84),
                vector2(-766.81, -1360.11),
                vector2(-754.21, -1371.49),
                vector2(-716.94, -1326.88),
            },
            ['minZ'] = 0.0,  -- min height of the shop zone
            ['maxZ'] = 5.0,  -- max height of the shop zone
            ['size'] = 6.2, -- size of the vehicles zones
        },
        ['Job'] = 'boatdealer', -- Name of job or none
        ['Rank'] = 1,
        ['ShopLabel'] = 'Marina Shop', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 410,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['boats'] = 'Boats',
        },
        ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-738.25, -1334.38, 1.6), -- Blip Location
        ['ReturnLocation'] = vector3(-714.34, -1343.31, 0.0), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-727.87, -1353.1, -0.17, 137.09), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-727.05, -1326.59, 0.00, 229.5), -- where the vehicle will spawn on display
                defaultVehicle = 'seashark', -- Default display vehicle
                chosenVehicle = 'seashark', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-732.84, -1333.5, -0.50, 229.5),
                defaultVehicle = 'dinghy',
                chosenVehicle = 'dinghy',
            },
            [3] = {
                coords = vector4(-737.84, -1340.83, -0.50, 229.5),
                defaultVehicle = 'speeder',
                chosenVehicle = 'speeder',
            },
            [4] = {
                coords = vector4(-741.53, -1349.7, -2.00, 229.5),
                defaultVehicle = 'marquis',
                chosenVehicle = 'marquis',
            },
        },
    },
    ['air'] = { 
        ['Type'] = 'managed',  -- no player interaction is required to purchase a vehicle
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-1607.58, -3141.7),
                vector2(-1672.54, -3103.87),
                vector2(-1703.49, -3158.02),
                vector2(-1646.03, -3190.84),
            },
            ['minZ'] = 0.0,  -- min height of the shop zone
            ['maxZ'] = 5.0,  -- max height of the shop zone
            ['size'] = 7.0, -- size of the vehicles zones
        },
        ['Job'] = 'aridealer', -- Name of job or none
        ['Rank'] = 1,
        ['ShopLabel'] = 'Air Shop', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 251,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['helicopters'] = 'Helicopters',
            ['planes'] = 'Planes',
        },
        ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-1652.76, -3143.4, 13.99), -- Blip Location
        ['ReturnLocation'] = vector3(-1628.44, -3104.7, 13.94), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-1617.49, -3086.17, 13.94, 329.2), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-1651.36, -3162.66, 12.99, 346.89), -- where the vehicle will spawn on display
                defaultVehicle = 'volatus', -- Default display vehicle
                chosenVehicle = 'volatus', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-1668.53, -3152.56, 12.99, 303.22),
                defaultVehicle = 'luxor2',
                chosenVehicle = 'luxor2',
            },
            [3] = {
                coords = vector4(-1632.02, -3144.48, 12.99, 31.08),
                defaultVehicle = 'nimbus',
                chosenVehicle = 'nimbus',
            },
            [4] = {
                coords = vector4(-1663.74, -3126.32, 12.99, 275.03),
                defaultVehicle = 'frogger',
                chosenVehicle = 'frogger',
            },
        },
    },
    ['motorsell'] = {
        ['Type'] = 'managed',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(319.21337890625, -1167.9049072266),
                vector2(319.21337890625, -1167.9049072266),
                vector2(319.39953613282, -1141.4072265625),
                vector2(261.4464416504, -1141.5701904296),
                vector2(262.53045654296, -1178.1197509766)
            },
            ['minZ'] = 29.0,  -- min height of the shop zone
            ['maxZ'] = 27.0,  -- max height of the shop zone
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'sandersmotor', -- Name of job or none
        ['Rank'] = 1,
        ['ShopLabel'] = 'Sanders Motor', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 226,  -- Blip sprite
        ['blipColor'] = 4,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['motorcycles'] = 'Motorcycles',
            ['cycles'] = 'Bicycles',
        },
        ['TestDriveTimeLimit'] = 3.0, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(289.77, -1159.8, 29.47), -- Blip Location
        ['ReturnLocation'] = vector3(286.75, -1146.94, 29.29), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(273.9, -1160.95, 29.27, 53.16), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(289.77, -1159.8, 29.47-1.0, 324.94), -- where the vehicle will spawn on display
                defaultVehicle = 'bati', -- Default display vehicle
                chosenVehicle = 'bati', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(289.67, -1162.34, 29.47-1.0, 314.35),
                defaultVehicle = 'bf400',
                chosenVehicle = 'bf400',
            },
            [3] = {
                coords = vector4(286.84, -1155.03, 29.47-1.0, 266.5),
                defaultVehicle = 'chimera',
                chosenVehicle = 'chimera',
            },
            [4] = {
                coords = vector4(282.59, -1150.59, 29.46-1.0, 284.23),
                defaultVehicle = 'cliffhanger',
                chosenVehicle = 'cliffhanger',
            },
            [5] = {
                coords = vector4(290.18, -1150.53, 29.47-1.0, 290.99),
                defaultVehicle = 'daemon',
                chosenVehicle = 'daemon',
            },
            [6] = {
                coords = vector4(294.71, -1150.37, 29.47-1.0, 284.31),
                defaultVehicle = 'diablous',
                chosenVehicle = 'diablous',
            },
            [7] = {
                coords = vector4(303.52, -1157.08, 29.47-1.0, 201.78),
                defaultVehicle = 'esskey',
                chosenVehicle = 'esskey',
            },
        },
    },
    ['policecars'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(459.87796020508, -1021.2864379882),
                vector2(466.1242980957, -1021.3388061524),
                vector2(466.13272094726, -1012.9619140625),
                vector2(459.75994873046, -1012.9376220704)
            },
            ['minZ'] = 28.0,  -- min height of the shop zone
            ['maxZ'] = 28.0,  -- max height of the shop zone
            ['size'] = 2.7, -- size of the vehicles zones
        },
        ['Job'] = 'police', -- Name of job or none
        ['OpenFinanceF'] = false,
        ['TestDriveF'] = false,
        ['ShopLabel'] = 'police car', -- Blip name
        ['showBlip'] = false,  -- true or false
        ['blipSprite'] = 226,  -- Blip sprite
        ['blipColor'] = 4,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['policecar'] = 'Police Car'
        },
        ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(425.8, -994.32, 25.7), -- Blip Location
        ['ReturnLocation'] = vector3(425.8, -994.32, 25.7), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(425.8, -994.32, 25.7, 269.57), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(463.87, -1019.7, 27.1, 89.35), -- where the vehicle will spawn on display
                defaultVehicle = 'npolvic', -- Default display vehicle
                chosenVehicle = 'npolvic', -- Same as default but is dynamically changed when swapping vehicles
            },
        },
    },
    ['mediccars'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(316.29791259766, -566.08618164062),
                vector2(323.64569091796, -568.84851074218),
                vector2(322.10223388672, -572.91516113282),
                vector2(314.87008666992, -570.22259521484)
            },
            ['minZ'] = 28.0,  -- min height of the shop zone
            ['maxZ'] = 28.0,  -- max height of the shop zone
            ['size'] = 2.7, -- size of the vehicles zones
        },
        ['Job'] = 'ambulance', -- Name of job or none
        ['OpenFinanceF'] = false,
        ['TestDriveF'] = false,
        ['ShopLabel'] = 'Medic car', -- Blip name
        ['showBlip'] = false,  -- true or false
        ['blipSprite'] = 226,  -- Blip sprite
        ['blipColor'] = 4,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['mediccar'] = 'Medic Car'
        },
        ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(321.43, -565.36, 28.8), -- Blip Location
        ['ReturnLocation'] = vector3(321.43, -565.36, 28.8), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(321.43, -565.36, 28.8, 249.07), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(320.2, -569.84, 27.8, 250.0), -- where the vehicle will spawn on display
                defaultVehicle = 'emsnspeedo', -- Default display vehicle
                chosenVehicle = 'emsnspeedo', -- Same as default but is dynamically changed when swapping vehicles
            },
        },
    },
}