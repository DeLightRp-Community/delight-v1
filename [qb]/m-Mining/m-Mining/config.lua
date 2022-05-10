Config = {}


----------------------
-- Utility
----------------------
Config.Framework = "NEW"
Config.CoreName = "qb-core"
Config.SkillBar = "np-skillbar"                                                     -- np-skillbar / qb-skillbar / reload-skillbar
Config.QBMenu = "qb-menu"                                                           -- Name of qb-menu
Config.Target = "qb-target"                                                         -- Target
Config.LocalizacaoBlip = vector3(-567.14, 5345.54, 70.23)                           -- Location of map blip
Config.EnableSound = true
Config.NeedJob = false -- Need job to work?
Config.JobName = "" -- Name of job

----------------------
-- Location of Stones Legal
----------------------
Config.BlipStones = {
    Enable = true,
    Name = "Stone",
    Sprite = 253,
    Scale = 0.6,
    Colour = 4,
    OneBlip = true, -- If true, only one blip will appear instead of a blip at each mining site
    OneBlipLocation = vector3(2955.54, 2773.44, 39.56), -- if EnableOneBlip this is the coords of blip
}


Config["Minar"] = {
    [1] = { x = 2955.54, y = 2773.44, z = 39.56 },  -- Loc of mining stones
    [2] = { x = 2952.56, y = 2770.17, z = 39.04 },  -- Loc of mining stones
    [3] = { x = 2947.85, y = 2768.32, z = 38.94 },  -- Loc of mining stones
}

----------------------
-- Location of Stones Ilegal
----------------------
Config.NomeJobPolicia = "police"    -- Name of job police
Config.PoliciaNecessaria = 1        -- Amount of police needed
Config.NecessarioPolicia = true    -- Police needed?

Config.BlipIllegal = {
    Enable = true,
    Name = "Illegal Mining",
    Sprite = 253,
    Scale = 0.6,
    Colour = 4,
    OneBlip = true, -- If true, only one blip will appear instead of a blip at each mining site
    OneBlipLocation = vector3(-590.68, 2074.51, 131.28), -- if EnableOneBlip this is the coords of blip
}

Config["MinarIlegal"] = {
    [1] = { x = -590.68, y = 2074.51, z = 131.28, distance = 3.0 },  -- Loc of mining stones ilegal
    [2] = { x = -590.84, y = 2064.01, z = 130.98, distance = 3.0 },  -- Loc of mining stones ilegal
    [3] = { x = -586.73, y = 2052.52, z = 130.13, distance = 3.0 },  -- Loc of mining stones ilegal
}

----------------------
-- Location of wash stones
----------------------
Config.BlipWash = {
    Enable = true,
    Name = "Wash Stones",
    Sprite = 468,
    Scale = 0.8,
    Colour = 38,
    OneBlip = true, -- If true, only one blip will appear instead of a blip at each mining site
    OneBlipLocation = vector3(1180.43, -119.41, 56.49), -- if EnableOneBlip this is the coords of blip
}

Config["Lavagem"] = {
    [1] = { x = 1180.43, y = -119.41, z = 56.49, distance = 5.0 },  -- Loc of washing stones
    [2] = { x = 1173.98, y = -122.48, z = 56.25, distance = 5.0 },  -- Loc of washing stones
}
Config.Maquina = {
    ["maquina"] = {model = `prop_cementmixer_01a`, freeze = false}, -- Prop spawn with item "machine" to brake rocks
}

----------------------
-- Rewards of Level System Pickaxe
----------------------
Config.RewardPicaretaLevel_1 = 1 -- Amount received with pickaxe level 1
Config.RewardPicaretaLevel_2 = 2 -- Amount received with pickaxe level 2
Config.RewardPicaretaLevel_3 = 3 -- Amount received with pickaxe level 3
Config.RewardPicaretaLevel_4 = 4 -- Amount received with pickaxe level 4
Config.RewardPicaretaLevel_5 = 5 -- Amount received with pickaxe level 5

----------------------
-- Itens necessários para dar upgrade ao maxado
----------------------
Config.ItemNecessario = "pedras" -- Item 1 to upgrade
Config.ItemNecessario2 = "phone" -- Item 2 to upgrade
Config.QuantidadeNecessariaLevel2 = 15  -- Required amount of both items to upgrade to level 2
Config.QuantidadeNecessariaLevel3 = 25 -- Required amount of both items to upgrade to level 3
Config.QuantidadeNecessariaLevel4 = 35 -- Required amount of both items to upgrade to level 4
Config.QuantidadeNecessariaLevel5 = 45 -- Required amount of both items to upgrade to level 5

----------------------
-- Ores after wash
----------------------
Config.Ores = {
    "ouro", 
    "ferro",
    "carvao",
    "ruby",
    "esmeralda",
    "diamante",
    "safira",
    "magnesio",
    "titanite",
    "wolframite",
    "perovskite",
    "baryte",
    "rainbowpyrite"
}

----------------------
-- Ores mining on mine illegal
----------------------
Config.OresIlegal = {
    "ouro", 
    "ferro",
    "carvao",
    "ruby",
    "esmeralda",
    "diamante",
    "safira",
    "magnesio",
    "titanite",
    "wolframite",
    "perovskite",
    "baryte",
    "rainbowpyrite"
}

----------------------
-- Ores prices when sell
----------------------
Config.Prices = {
    ['ouro']            = { name = 'ouro',          amount = 1 },
    ['ferro']           = { name = 'ferro',         amount = 1 },
    ['carvao']          = { name = 'carvao',        amount = 1 },
    ['ruby']            = { name = 'ruby',          amount = 1 },
    ['esmeralda']       = { name = 'esmeralda',     amount = 1 },
    ['diamante']        = { name = 'diamante',      amount = 1 },
    ['safira']          = { name = 'safira',        amount = 1 },
    ['magnesio']        = { name = 'magnesio',      amount = 1 },
    ['titanite']        = { name = 'titanite',      amount = 1 },
    ['wolframite']      = { name = 'wolframite',    amount = 1 },
    ['perovskite']      = { name = 'perovskite',    amount = 1 },
    ['baryte']          = { name = 'baryte',        amount = 1 },
    ['rainbowpyrite']   = { name = 'rainbowpyrite', amount = 1 },
}

----------------------
-- Targets
----------------------
-- Mining Rocks
Config.TargetCutMinerLabel = "Mine"
Config.TargetCutMinerIcon = "fa-solid fa-minimize"
-- Break Stones
Config.BreakStonesLabel = "Break Stones"
Config.BreakStonesIcon = "fa-solid fa-hand"
-- Machine
Config.MachineLabel = "Save Machine"
Config.MachineIcon = "fa-solid fa-clock-rotate-left"
-- Wash Stones
Config.TargetSeparateMinerLabel = "Wash Stone"
Config.TargetSeparateMinerIcon = "fa-solid fa-water"
-- Shop / Boss of wood
Config.TargetShopMinerLabel = "Talk to the boss"
Config.TargetShopMinerIcon = "fa-solid fa-person"
-- Vehicles
Config.LocalizacaoVehicles = vector3(2957.67, 2745.84, 43.54)       -- Location of shop, you need to change on Config.LocalizacaoPedShop too
Config.TargetVehiclesLabel = "Vehicles"
Config.TargetVehiclesIcon = "fa-solid fa-person"
-- Sell Ores
Config.EnableBlipSell = true
Config.NameOfSellOres = "Sell Ores"     -- Name of blip
Config.TargetSellMinerLocation = vector3(-623.23, -230.23, 38.06)  -- Location of sell, you need to change on Config.LocalizacaoPedShop too
Config.TargetSellMinerLabel = "Sell Ores"
Config.TargetSellMinerIcon = "fas fa-sack-dollar"

Config["Mineiros"] = {    -- Shops 
    [1] = { x = 2959.14, y = 2753.43, z = 43.71},  
    [2] = { x = -595.07, y = 2091.42, z = 130.46},  
    -- You can add more locations
}
----------------------
-- Notification
----------------------
Config["Notificacoes"] = {
    ["Falhaste"]            = "You failed!",
    ["CorreuMal"]           = "Something went wrong!",
    ["JaTensMachado"]       = "You already have an pickaxe with you!",
    ["NaoTensNecessario"]   = "You don't have what you need.",
    ["NadaParaVender"]      = "You have nothing to sell.",
    ["VeiculoDisponivel"]   = "Vehicle loaned successfully.",
    ["NaoTensPicaretas"]    = "You don't have any pickaxe!",
    ["NaoTensPedras"]       = "You don't have any stones!",
    ["Cancelado"]           = "Canceled.",
    ["SpawnBloqueado"]      = "There is a vehicle blocking the spawn.",
    ["AguardaPeloSpawn"]    = "You recently removed a vehicle. wait.",
    ["NoPolice"]            = "There are not enough police",
    ["NoJob"]               = "You don't work on miners!"
}

----------------------
-- Progressbars
----------------------
Config["ProgressBars"] = {
    ["MinerarPedras"]   = "Mining....",
    ["LavarPedras"]     = "Washing stones..",
    ["PartirPedras"]    = "Break stones..",
    ["PutMachine"]      = "Put Machine..",
    ["SaveMachine"]     = "Save Machine",

}

----------------------
-- Menus ( qb-menu )
----------------------
-- Shop
Config.QBMenuShopHeader         = "Boss of Miners"
Config.QBMenuShopGiveAxe        = "I want a pickaxe!"
Config.QBMenuShopGiveVehicle    = "I need a vehicle!"
Config.QBMenuShopDeleteVehicle  = "Deliver vehicle"
Config.QBMenuShopOpenShop       = "Open Shop"
Config.QBMenuShopEvolveAxe      = "I want to evolve my pickaxe!"
Config.QBMenuShopClose          = "< Close"
-- Envolve
Config.QBMenuEnvolveHeader      = "Evolution of Pickaxes"
Config.QBMenuEnvolveLevel2      = "Upgrade to level 2"
Config.QBmenuEnvolveTxtLevel2   = "You need: <br> 50x Stone <br> 1x Pickaxe Level 1 <br> 50x "..Config.ItemNecessario2
Config.QBMenuEnvolveLevel3      = "Upgrade to level 3"
Config.QBmenuEnvolveTxtLevel3   = "You need: <br> 100x Stone <br> 1x Pickaxe Level 2 <br> 100x "..Config.ItemNecessario2
Config.QBMenuEnvolveLevel4      = "Upgrade to level 4"
Config.QBmenuEnvolveTxtLevel4   = "You need: <br> 150x Stone <br> 1x Pickaxe Level 3 <br> 150x"..Config.ItemNecessario2
Config.QBMenuEnvolveLevel5      = "Upgrade to level 5"
Config.QBmenuEnvolveTxtLevel5   = "You need: <br> 200x Stone <br> 1x Pickaxe Level 4 <br> 200x"..Config.ItemNecessario2
Config.QBMenuEnvolveClose       = "< Close"
-- Selling
Config.QBMenuSellingHeader      = "Sell Miners"
Config.QBMenuSellingOption1     = "Sell all"
Config.QBMenuSellingOption2     = ""
Config.QBMenuSellingClose       = "< Close"


----------------------
-- Car 
----------------------
Config.PayForVehicle = true
Config.AmountPayForVehicle = 250
Config.TempoParaSpawnarNovamente = 60000            -- Time to spawn another vehicle. 60000 = 1 Min
Config.Fuel = "LegacyFuel"                                          -- Name of your fuel script
Config.VehicleKeysTrigger = "vehiclekeys:client:SetOwner"           -- Trigger to give vehiclekeys

Config.Carros = {
    [1] = {carro = "biff"},                                         -- Name of car
}

Config.SpawnCarrinho = {
    [1] = {x = 2958.51, y = 2749.64, z = 43.47, h = 282.22},        -- Location to spawn car
}

----------------------
-- Bag 
----------------------
Config.Slots = 4
Config.Weight = 5000

-----------------
-- Shop
-----------------
Config.OpenInvTrigger   = "inventory:server:OpenInventory"          
Config.ShopName         = "Miners Shop"                          
Config.Products = {
    ["Miners"] = {
        [1] = {
            name = "water_bottle",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "weapon_bread",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "oculosmineiro",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "fonesmineiro",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "sacomineiros",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "maquina",                                  
            price = 5,
            amount = 25,
            info = {},
            type = "item",
            slot = 6,
        },
    },
}

Config.Lojinha = {
    ["Miners"] = {
        ["label"] = "Miners",
        ["type"] = "BM",
        ["coords"] = {
            [1] = {
                ["x"] = 1333.06,    -- Dont touch, is using qb-target.
                ["y"] = 4326.86,    -- Dont touch, is using qb-target.
                ["z"] = 38.017,     -- Dont touch, is using qb-target.
            },
        },
        ["CoisasBoas"] = Config.Products["Miners"],
    },
}

----------------------
-- Peds
----------------------
Config.PedListMineiros = {                                              -- Peds that will be spawned in
    {
        model = "s_m_y_armymech_01",                                                         
        coords = vector3(2959.14, 2753.43, 42.71),           
        heading = 203.72,
        gender = "male",
        scenario = "WORLD_HUMAN_STAND_MOBILE_UPRIGHT" 
    },
    {
        model = "s_m_y_armymech_01",                                           
        coords = vector3(2957.67, 2745.84, 42.54),           
        heading = 325.34,
        gender = "male",
        scenario = "WORLD_HUMAN_STAND_MOBILE_UPRIGHT" 
    },
    {
        model = "cs_jimmyboston",                                           
        coords = vector3(-623.23, -230.23, 37.06),         
        heading = 68.34,
        gender = "male",
        scenario = "WORLD_HUMAN_STAND_MOBILE_UPRIGHT" 
    },
    {
        model = "S_M_Y_Construct_01",                                           
        coords = vector3(-595.07, 2091.42, 130.46),         
        heading = 49.89,
        gender = "male",
        scenario = "WORLD_HUMAN_CLIPBOARD" 
    },
}

------------- 
--- Police Alert Ilegal Mining
------------
Config.ChanceChamarPolicia = 50     --The higher the value, the lower the probability
function ChamarPolicia()
    TriggerServerEvent('qb-dispatch:illegalmining')
    -- You can trigger your dispatch
end
