Config = {}

Config.minEarn = 100
Config.maxEarn = 450
Config.RegisterEarnings = math.random(Config.minEarn, Config.maxEarn)
Config.MinimumStoreRobberyPolice = 0
Config.resetTime = (60 * 1000) * 30
Config.tickInterval = 1000

Config.Registers = {
    [1] = {vector3(-47.24,-1757.65, 29.53), robbed = false, time = 0, safeKey = 1, camId = 4, propExistAndDamage= false},
    [2] = {vector3(-48.58,-1759.21, 29.59), robbed = false, time = 0, safeKey = 1, camId = 4, propExistAndDamage= false},
    [3] = {vector3(-1486.26,-378.0,  40.16), robbed = false, time = 0, safeKey = 2, camId = 5, propExistAndDamage= false},
    [4] = {vector3(-1222.03,-908.32, 12.32), robbed = false, time = 0, safeKey = 3, camId = 6, propExistAndDamage= false},
    [5] = {vector3(-706.08, -915.42, 19.21), robbed = false, time = 0, safeKey = 4, camId = 7, propExistAndDamage= false},
    [6] = {vector3(-706.16, -913.5, 19.21), robbed = false, time = 0, safeKey = 4, camId = 7, propExistAndDamage= false},
    [7] = {vector3(24.87, -1345.66, 29.5), robbed = false, time = 0, safeKey = 5, camId = 8, propExistAndDamage= false},
    [8] = {vector3(24.89, -1347.95, 29.5), robbed = false, time = 0, safeKey = 5, camId = 8, propExistAndDamage= false},
    [9] = {vector3(1134.15, -982.53, 46.41), robbed = false, time = 0, safeKey = 6, camId = 9, propExistAndDamage= false},
    [10] = {vector3(1165.05, -324.49, 69.2), robbed = false, time = 0, safeKey = 7, camId = 10, propExistAndDamage= false},
    [11] = {vector3(1164.7, -322.58, 69.2), robbed = false, time = 0, safeKey = 7, camId = 10, propExistAndDamage= false},
    [12] = {vector3(373.14, 328.62, 103.56), robbed = false, time = 0, safeKey = 8, camId = 11, propExistAndDamage= false},
    [13] = {vector3(372.57, 326.42, 103.56), robbed = false, time = 0, safeKey = 8, camId = 11, propExistAndDamage= false},
    [14] = {vector3(-1818.9, 792.9, 138.08), robbed = false, time = 0, safeKey = 9, camId = 12, propExistAndDamage= false},
    [15] = {vector3(-1820.17, 794.28, 138.08), robbed = false, time = 0, safeKey = 9, camId = 12, propExistAndDamage= false},
    [16] = {vector3(-2966.46, 390.89, 15.04), robbed = false, time = 0, safeKey = 10, camId = 13, propExistAndDamage= false},
    [17] = {vector3(-3041.14, 583.87, 7.9), robbed = false, time = 0, safeKey = 11, camId = 14, propExistAndDamage= false},
    [18] = {vector3(-3038.92, 584.5, 7.9), robbed = false, time = 0, safeKey = 11, camId = 14, propExistAndDamage= false},
    [19] = {vector3(-3244.56, 1000.14, 12.83), robbed = false, time = 0, safeKey = 12, camId = 15, propExistAndDamage= false},
    [20] = {vector3(-3242.24, 999.98, 12.83), robbed = false, time = 0, safeKey = 12, camId = 15, propExistAndDamage= false},
    [21] = {vector3(549.42, 2669.06, 42.15), robbed = false, time = 0, safeKey = 13, camId = 16, propExistAndDamage= false},
    [22] = {vector3(549.05, 2671.39, 42.15), robbed = false, time = 0, safeKey = 13, camId = 16, propExistAndDamage= false},
    [23] = {vector3(1165.9, 2710.81, 38.15), robbed = false, time = 0, safeKey = 14, camId = 17, propExistAndDamage= false},
    [24] = {vector3(2676.02, 3280.52, 55.24), robbed = false, time = 0, safeKey = 15, camId = 18, propExistAndDamage= false},
    [25] = {vector3(2678.07, 3279.39, 55.24), robbed = false, time = 0, safeKey = 15, camId = 18, propExistAndDamage= false},
    [26] = {vector3(1958.96, 3741.98, 32.34), robbed = false, time = 0, safeKey = 16, camId = 19, propExistAndDamage= false},
    [27] = {vector3(1960.13, 3740.0, 32.34), robbed = false, time = 0, safeKey = 16, camId = 19, propExistAndDamage= false},
    [28] = {vector3(1728.86, 6417.26, 35.03), robbed = false, time = 0, safeKey = 17, camId = 20, propExistAndDamage= false},
    [29] = {vector3(1727.85, 6415.14, 35.03), robbed = false, time = 0, safeKey = 17, camId = 20, propExistAndDamage= false},
    [30] = {vector3(-161.07, 6321.23, 31.5), robbed = false, time = 0, safeKey = 18, camId = 27, propExistAndDamage= false},
    [31] = {vector3(160.52, 6641.74, 31.6), robbed = false, time = 0, safeKey = 19, camId = 28, propExistAndDamage= false},
    [32] = {vector3(162.16, 6643.22, 31.6), robbed = false, time = 0, safeKey = 19, camId = 29, propExistAndDamage= false},
}

Config.Safes = {
    [1] = {x = -43.43, y = -1748.3, z = 29.42, h = 52.5, type = "keypad", robbed = false, camId = 4, timer= 10}, 
    [2] = {x = -1478.94, y = -375.5, z = 39.16, h = 229.5, type = "padlock", robbed = false, camId = 5, timer= 10},
    [3] = {x = -1220.85, y = -916.05, z = 11.32, h = 229.5, type = "padlock", robbed = false, camId = 6, timer= 10},
    [4] = {x = -709.74, y = -904.15, z = 19.21, h = 229.5, type = "keypad", robbed = false, camId = 7, timer= 10},
    [5] = {x = 28.21, y = -1339.14, z = 29.49, type = "keypad", robbed = false, camId = 8, timer= 10},
    [6] = {x = 1126.77, y = -980.1, z = 45.41, type = "padlock", robbed = false, camId = 9, timer= 10},
    [7] = {x = 1159.46, y = -314.05, z = 69.2, type = "keypad", robbed = false, camId = 10, timer= 10},
    [8] = {x = 378.17, y = 333.44, z = 103.56, type = "keypad", robbed = false, camId = 11, timer= 10},
    [9] = {x = -1829.27, y = 798.76, z = 138.19, type = "keypad", robbed = false, camId = 12, timer= 10},
    [10] = {x = -2959.64, y = 387.08, z = 14.04, type = "padlock", robbed = false, camId = 13, timer= 10},
    [11] = {x = -3047.88, y = 585.61, z = 7.9, type = "keypad", robbed = false, camId = 14, timer= 10},
    [12] = {x = -3250.02, y = 1004.43, z = 12.83, type = "keypad", robbed = false, camId = 15, timer= 10},
    [13] = {x = 546.41, y = 2662.8, z = 42.15, type = "keypad", robbed = false, camId = 16, timer= 10},
    [14] = {x = 1169.31, y = 2717.79, z = 37.15, type = "padlock", robbed = false, camId = 17, timer= 10},
    [15] = {x = 2672.69, y = 3286.63, z = 55.24, type = "keypad", robbed = false, camId = 18, timer= 10},
    [16] = {x = 1959.26, y = 3748.92, z = 32.34, type = "keypad", robbed = false, camId = 19, timer= 10},
    [17] = {x = 1734.78, y = 6420.84, z = 35.03, type = "keypad", robbed = false, camId = 20, timer= 10},
    [18] = {x = -168.40, y = 6318.80, z = 30.58, type = "padlock", robbed = false, camId = 27, timer= 10},
    [19] = {x = 168.95, y = 6644.74, z = 31.70, type = "keypad", robbed = false, camId = 30, timer= 10},
}


Config.MaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true,
}
Config.FemaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true,
}
