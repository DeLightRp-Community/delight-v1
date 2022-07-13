Config = {}
Config.MaxWidth = 5.0
Config.MaxHeight = 5.0
Config.MaxLength = 5.0
Config.DamageNeeded = 100.0
Config.IdleCamera = true
Config.EnableProne = false
Config.JointEffectTime = 60
Config.RemoveWeaponDrops = true
Config.RemoveWeaponDropsTimer = 25
Config.DefaultPrice = 20 -- carwash
Config.DirtLevel = 0.1 --carwash dirt level

ConsumeablesEat = {
    ["sandwich"] = 10,
    ["tosti"] = 10,
    ["twerks_candy"] = 5,
    ["snikkel_candy"] = 5,

    ["apple"] = 5,
    ["beef"] = 5,
    ["slicedpie"] = 30,
    ["corncob"] = 5,
    ["canofcorn"] =7,
    ["grapes"] = 5,
    ["greenpepper"] = 5,
    ["chillypepper"] = 5,
    ["tomato"] = 5,
    ["tomatopaste"] = 7,
    ["cooked_bacon"] = 15,
    ["cooked_sausage"] = 15,
    ["cooked_pork"] = 15,
    ["cooked_ham"] = 15,

    ["burger-bleeder"] = 40,
    ["burger-moneyshot"] = 50,
    ["burger-torpedo"] = 35,
    ["burger-heartstopper"] = 100,
    ["burger-meatfree"] = 60,
    ["burger-fries"] = 30,
    --uwu
    ["cupcake-morango"] = 70,
    ["cupcake-chocolate"] = 70,
    ["cupcake-limao"] = 50,
    ["gelado-morango"] = 30,
    ["gelado-chocolate"] = 30,
    ["gelado-baunilha"] = 30,
    ["panqueca-nutela"] = 100,
    ["ppanqueca-oreo"] = 100,
    ["muffin-chocolate"] = 50,
    ["pastel-frango"] = 50,
    ["waffle-nutela"] = 50,
    
    --pizza 
    ["cheese-pizza"] = 70,
}

ConsumeablesDrink = {
    ["water_bottle"] = math.random(10, 15),
    ["kurkakola"] = math.random(15, 20),
    ["coffee"] = math.random(25, 30),

    ["apple_juice"] = math.random(10, 15),
    ["grapejuice"] = math.random(10, 15),
    ["hotsauce"] = math.random(10, 15),

    ["burger-softdrink"] = math.random(40, 50),
    ["burger-mshake"] = math.random(40, 50),

    -- ["sodacup"] = math.random(20, 40),
    --uwu
    ["cafe-uwuu"] = 100,
    ["latte-uwu"] = 30,
    ["bubble-amora"] = 60,
    ["bubble-menta"] = 60,
    ["bubble-morango"] = 60,
    ["milkshake-morango"] = 40,
    ["milkshake-chocolate"] = 40,
   
    
}

ConsumeablesAlcohol = {
    ["whiskey"] = math.random(10, 15),
    ["beer"] = math.random(20, 25),
    ["vodka"] = math.random(10, 15),
}

Config.BlacklistedScenarios = {
    ['TYPES'] = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
        "WORLD_VEHICLE_AMBULANCE",
        "WORLD_VEHICLE_POLICE_NEXT_TO_CAR",
        "WORLD_VEHICLE_POLICE_CAR",
        "WORLD_VEHICLE_POLICE_BIKE",
    },
    ['GROUPS'] = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`,
    }
}

Config.BlacklistedVehs = {
    [`SHAMAL`] = true,
    [`LUXOR`] = true,
    [`LUXOR2`] = true,
    [`JET`] = true,
    [`LAZER`] = true,
    [`BUZZARD`] = true,
    [`BUZZARD2`] = true,
    [`ANNIHILATOR`] = true,
    [`SAVAGE`] = true,
    [`TITAN`] = true,
    [`RHINO`] = true,
    [`FIRETRUK`] = true,
    [`MULE`] = true,
    [`MAVERICK`] = true,
    [`BLIMP`] = true,
    [`AIRTUG`] = true,
    [`CAMPER`] = false,
    [`HYDRA`] = true,
    [`OPPRESSOR`] = true,
    [`technical3`] = true,
    [`insurgent3`] = true,
    [`apc`] = true,
    [`tampa3`] = true,
    [`trailersmall2`] = true,
    [`halftrack`] = true,
    [`hunter`] = true,
    [`vigilante`] = true,
    [`akula`] = true,
    [`barrage`] = true,
    [`khanjali`] = true,
    [`caracara`] = true,
    [`blimp3`] = true,
    [`menacer`] = true,
    [`oppressor2`] = true,
    [`scramjet`] = true,
    [`strikeforce`] = true,
    [`cerberus`] = true,
    [`cerberus2`] = true,
    [`cerberus3`] = true,
    [`scarab`] = true,
    [`scarab2`] = true,
    [`scarab3`] = true,
    [`rrocket`] = true,
    [`ruiner2`] = true,
    [`deluxo`] = true,
    [`besra`] = true,
    [`annihilator2`] = true,
    ['policeb'] = true,
}

Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true,
}

Config.Teleports = {
    --Elevator @ labs
    [1] = {
        [1] = {
            coords = vector4(3540.74, 3675.59, 20.99, 167.5),
            ["AllowVehicle"] = false,
            drawText = '[E] Take Elevator Up'
        },
        [2] = {
            coords = vector4(3540.74, 3675.59, 28.11, 172.5),
            ["AllowVehicle"] = false,
            drawText = '[E] Take Elevator Down'
        },

    },
    --Coke Processing Enter/Exit
    [2] = {
        [1] = {
            coords = vector4(909.49, -1589.22, 30.51, 92.24),
            ["AllowVehicle"] = false,
            drawText = '[E] Enter Coke Processing'
        },
        [2] = {
            coords = vector4(1088.81, -3187.57, -38.99, 181.7),
            ["AllowVehicle"] = false,
            drawText = '[E] Leave'
        },
    },
}

Config.CarWash = { -- carwash
    [1] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(25.29, -1391.96, 29.33),
    },
    [2] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(174.18, -1736.66, 29.35),
    },
    [3] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-74.56, 6427.87, 31.44),
    },
    [5] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(1363.22, 3592.7, 34.92),
    },
    [6] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-699.62, -932.7, 19.01),
    }
}

Config.compatable_weapon_hashes = {
    -- X putter den længere ned
    -- Z Putter det længere til venstre
    -- Y putter det længere ud
    ---- ** Drugs ** ---- 

    -- Weed
    ["wetbud"] = { model = "bkr_prop_weed_drying_02a", hash = GetHashKey("bkr_prop_weed_drying_02a"), bone = 24817, x = 0.2275, y = -0.16, z = 0.0, xr = 0.0, yr = 90.0, zr = 0.0},
    
    -- meth
    ["meth"] = { model = "hei_prop_pill_bag_01", hash = GetHashKey("hei_prop_pill_bag_01"), bone = 24817, x = -0.25, y = -0.14, z = 0.15, xr = 0.0, yr = 90.0, zr = 0.0},


    -- Contraband
    ["markedbills"] = { model = "prop_money_bag_01", hash = GetHashKey("prop_money_bag_01"), bone = 24817, x = -0.5, y = -0.14, z = 0.15, xr = 0.0, yr = 90.0, zr = 0.0},
    
    -- Custom Weapons
    ["weapon_assaultrifle"] = { model = "w_ar_assaultrifle", hash = GetHashKey("weapon_assaultrifle"), bone = 24818, x = 0.0, y = -0.17, z = 0.1, xr = 0.0, yr = 0.0, zr = 0.0},
    ["weapon_specialcarbine_mk2"] = { model = "w_ar_scar", hash = GetHashKey("weapon_specialcarbine_mk2"), bone = 24818, x = 0.0, y = -0.19, z = 0.1, xr = 0.0, yr = 0.0, zr = 0.0},
    ["weapon_m4"] = { model = "w_ar_m4", hash = GetHashKey("weapon_m4"), bone = 24818, x = 0.0, y = -0.19, z = 0.1, xr = 0.0, yr = 0.0, zr = 0.0},
    ["weapon_mm4"] = { model = "w_ar_MM4", hash = GetHashKey("weapon_mm4"), bone = 24818, x = 0.0, y = -0.19, z = 0.1, xr = 0.0, yr = 0.0, zr = 0.0},

    ["weapon_microsmg3"] = { model = "w_sb_microsmg3", hash = GetHashKey("weapon_microsmg3"), bone = 24818, x = 0.0, y = -0.17, z = 0.1, xr = 0.0, yr = 0.0, zr = 0.0},
    ["weapon_microsmg2"] = { model = "w_sb_microsmg2", hash = GetHashKey("weapon_microsmg2"), bone = 24818, x = 0.0, y = -0.17, z = 0.1, xr = 0.0, yr = 0.0, zr = 0.0},
    ["weapon_m14"] = { model = "w_sr_m14", hash = GetHashKey("weapon_m14"), bone = 24818, x = 0.0, y = -0.19, z = 0.1, xr = 0.0, yr = 0.0, zr = 0.0},
    ["weapon_carbinerifle"] = { model = "w_ar_carbinerifle", hash = GetHashKey("weapon_carbinerifle"), bone = 24818, x = 0.0, y = -0.19, z = 0.1, xr = 0.0, yr = 0.0, zr = 0.0},
    ["weapon_compactrifle"] = { model = "w_ar_draco", hash = GetHashKey("weapon_compactrifle"), bone = 24818, x = 0.0, y = -0.19, z = 0.1, xr = 0.0, yr = 0.0, zr = 0.0},
    ["weapon_combatpdw"] = { model = "W_SB_MPX", hash = GetHashKey("weapon_combatpdw"), bone = 24818, x = -0.1, y = -0.19, z = -0.1, xr = 0.0, yr = 0.0, zr = 0.0},
    ["weapon_pumpshotgun_mk2"] = { model = "w_sg_pumpshotgunmk2", hash = GetHashKey("weapon_pumpshotgun_mk2"), bone = 24818, x = 0.0, y = -0.19, z = 0.1, xr = 0.0, yr = 0.0, zr = 0.0},
    ["weapon_machete"] = { model = "w_me_machette_lr", hash = GetHashKey("weapon_machete"), bone = 24818, x = 0.0, y = -0.19, z = 0.1, xr = 0.0, yr = 0.0, zr = 0.0},
    ["weapon_minismg2"] = { model = "w_sb_skorpion", hash = GetHashKey("weapon_minismg2"), bone = 24818, x = 0.0, y = -0.19, z = 0.1, xr = 0.0, yr = 0.0, zr = 0.0},
    ["weapon_katanas"] = { model = "katana_sheath", hash = GetHashKey("weapon_katanas"), bone = 24818, x = -0.1, y = -0.17, z = -0.05, xr = 225.0, yr = 8.0, zr = 90.0},
    ["weapon_mk18b"] = { model = "w_ar_mk18b", hash = GetHashKey("weapon_mk18b"), bone = 24818, x = 0.0, y = -0.19, z = 0.07, xr = 0.0, yr = 0.0, zr = 0.0},


    -- assault rifles:
    ["weapon_carbinerifle_mk2"] = { model = "w_ar_carbineriflemk2", hash = GetHashKey("WEAPON_CARBINERIFLE_MK2"),bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    ["weapon_specialcarbine"] = { model = "w_ar_specialcarbine", hash = -1063057011,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    ["weapon_bullpuprifle"] = { model = "w_ar_bullpuprifle", hash = 2132975508,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    ["weapon_advancedrifle"] = { model = "w_ar_advancedrifle", hash = -1357824103,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    -- sub machine guns:
    ["weapon_appistol"] = { model = "w_pi_appistol", hash = 584646201,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    ["weapon_microsmg"] = { model = "w_sb_microsmg", hash = 324215364,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    ["weapon_assaultsmg"] = { model = "w_sb_assaultsmg", hash = -27001577,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.07},
    ["weapon_smg"] = { model = "w_sb_smg", hash = 736523883,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    ["weapon_smgmk2"] = { model = "w_sb_smgmk2", hash = GetHashKey("WEAPON_SMG_MK2"),bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    ["weapon_gusenberg"] = { model = "w_sb_gusenberg", hash = 1627465347,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    -- sniper rifles:
    ["weapon_sniperrifle"] = { model = "w_sr_sniperrifle", hash = 100416529,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    -- shotguns:
    ["weapon_assaultshotgun"] = { model = "w_sg_assaultshotgun", hash = -494615257,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    ["weapon_bullpupshotgun"] = { model = "w_sg_bullpupshotgun", hash = -1654528753,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    ["weapon_pumpshotgun"] = { model = "w_sg_pumpshotgun", hash = 487013001,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    ["weapon_musket"] = { model = "w_ar_musket", hash = -1466123874,bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
    ["weapon_heavyshotgun"] = { model = "w_sg_heavyshotgun", hash = GetHashKey("WEAPON_HEAVYSHOTGUN"),bone = 24816,x = 0.2275,y = -0.16,z = 0.016,xr = 0.0,yr = 0.0,zr = 1.0},
}

