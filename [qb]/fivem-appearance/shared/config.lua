Config = {}

Config.Debug = false

Config.ClothingCost = 100
Config.BarberCost = 100
Config.TattooCost = 100
Config.SurgeonCost = 100

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.EnablePedMenu = false
Config.PedMenuGroup = 'admin'

Config.Blips = {
    ['clothing'] = {
        Show = true,
        Sprite = 366,
        Color = 47,
        Scale = 0.7,
        Name = "Clothing Store",
    },
    ['barber'] = {
        Show = true,
        Sprite = 71,
        Color = 0,
        Scale = 0.7,
        Name = "Barber",
    },
    ['tattoo'] = {
        Show = true,
        Sprite = 75,
        Color = 4,
        Scale = 0.7,
        Name = "Tattoo Shop",
    },
    ['surgeon'] = {
        Show = true,
        Sprite = 102,
        Color = 4,
        Scale = 0.7,
        Name = "Plastic Surgeon",
    }
}

Config.Stores = {
    [1] = {shopType = 'clothing', coords = vector4(1691.6, 4818.47, 42.07, 6.29), width = 4, length = 4, showBlip = true}, -- showBlip overrides the blip visibilty configured above for the group
    [2] = {shopType = 'clothing', coords = vector4(-706.68, -151.26, 37.42, 122.83), width = 4, length = 4},
    [3] = {shopType = 'clothing', coords = vector4(-1196.71, -778.56, 17.33, 33.03), width = 4, length = 4},
    [4] = {shopType = 'clothing', coords = vector4(422.69, -810.37, 29.49, 357.54), width = 4, length = 4},
    [5] = {shopType = 'clothing', coords = vector4(-166.88, -301.79, 39.73, 253.12), width = 4, length = 4},
    [6] = {shopType = 'clothing', coords = vector4(78.26, -1388.77, 29.38, 177.79), width = 4, length = 4},
    [7] = {shopType = 'clothing', coords = vector4(-817.39, -1074.02, 11.33, 114.98), width = 4, length = 4},
    [8] = {shopType = 'clothing', coords = vector4(-1447.8, -240.07, 49.82, 51.79), width = 4, length = 4},
    [9] = {shopType = 'clothing', coords = vector4(-0.11, 6511.72, 31.88, 312.32), width = 4, length = 4},
    [10] = {shopType = 'clothing', coords = vector4(621.29, 2753.99, 42.09, 93.8), width = 4, length = 4},
    [11] = {shopType = 'clothing', coords = vector4(1200.77, 2707.3, 38.22, 88.04), width = 4, length = 4},
    [12] = {shopType = 'clothing', coords = vector4(-3172.74, 1054.75, 20.86, 247.08), width = 4, length = 4},
    [13] = {shopType = 'clothing', coords = vector4(-1096.48, 2711.12, 19.11, 128.73), width = 4, length = 4},
    -- [14] = {shopType = 'clothing', coords = vector4(-1207.65, -1456.89, 4.37, 131.41), width = 4, length = 4},
    [14] = {shopType = 'clothing', coords = vector4(122.89, -213.0, 54.56, 257.04), width = 2, length = 2},
    [15] = {shopType = 'barber', coords = vector4(-817.3, -183.04, 37.57, 210.99), width = 2, length = 2},
    [16] = {shopType = 'barber', coords = vector4(139.4, -1709.12, 29.3, 54.84), width = 2, length = 2},
    [17] = {shopType = 'barber', coords = vector4(-1281.98, -1119.8, 7.0, 358.74), width = 2, length = 2},
    [18] = {shopType = 'barber', coords = vector4(1933.55, 3732.14, 32.85, 116.74), width = 2, length = 2},
    [19] = {shopType = 'barber', coords = vector4(1212.49, -475.48, 66.22, 342.89), width = 2, length = 2},
    [20] = {shopType = 'barber', coords = vector4(-35.69, -152.29, 57.09, 253.43), width = 2, length = 2},
    [21] = {shopType = 'barber', coords = vector4(-279.49, 6225.83, 31.71, 317.98), width = 2, length = 2},
    [22] = {shopType = 'tattoo', coords = vector4(1324.59, -1650.25, 52.28, 131.41), width = 2, length = 2},
    [23] = {shopType = 'tattoo', coords = vector4(-1152.25, -1423.74, 4.95, 129.63), width = 2, length = 2},
    [24] = {shopType = 'tattoo', coords = vector4(319.66, 180.7, 103.59, 252.27), width = 2, length = 2},
    [25] = {shopType = 'tattoo', coords = vector4(-3170.44, 1073.01, 20.83, 342.14), width = 2, length = 2},
    [26] = {shopType = 'tattoo', coords = vector4(1862.4, 3748.3, 33.03, 35.93), width = 2, length = 2},
    [27] = {shopType = 'tattoo', coords = vector4(-292.07, 6199.82, 31.49, 229.82), width = 2, length = 2},
    -- [29] = {shopType = 'surgeon', coords = vector3(299.68, -572.99, 43.26), width = 2, length = 2},
}

Config.ClothingRooms = {
    [1] = {requiredJob = "police", isGang = false, coords = vector3(463.43, -999.07, 30.69), width = 3, length = 3},
    --[2] = {requiredJob = "police", isGang = false, coords = vector3(454.43, -988.85, 30.69), width = 2, length = 2},
    [2] = {requiredJob = "police", isGang = false, coords = vector3(301.3, -599.04, 43.28), width = 3, length = 3}, -- Right double door in Hospital Map that is on QBCore GitHub
    --[3] = {requiredJob = "police", coords = vector3(314.76, 671.78, 14.73)},
    --[3] = {requiredJob = "ambulance", coords = vector3(338.70, 659.61, 14.71)},    
    --[4] = {requiredJob = "ambulance", coords = vector3(-1098.45, 1751.71, 23.35)},    
    --[6] = {requiredJob = "police", coords = vector3(-77.59, -129.17, 5.03)},
}


Config.PlayerOutfitRooms = {
    -- Sample outfit room config
--[[
    [1] = {
        coords = vector3(287.29, -573.41, 43.17),
        width = 3,
        length = 3,
        citizenIDs = {
            "BHH65156",
        }
    },
    ]]--
}

Config.Outfits = {
    ['police'] = {
        ['male'] = {
            [1] = {
                outfitLabel = 'Short Sleeve',
                outfitData = {
                    ['pants'] = {item = 24, texture = 0}, -- Pants
                    ['arms'] = {item = 19, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
                    ['vest'] = {item = 0, texture = 0}, -- Body Vest
                    ['torso2'] = {item = 55, texture = 0}, -- Jacket
                    ['shoes'] = {item = 51, texture = 0}, -- Shoes
                    ['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['hat'] = {item = -1, texture = -1}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['mask'] = {item = 0, texture = 0} -- Mask
                },
                grades = {0, 1, 2, 3, 4},
            },
            [2] = {
                outfitLabel = 'Trooper Tan',
                outfitData = {
                    ['pants'] = {item = 24, texture = 0}, -- Pants
                    ['arms'] = {item = 20, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
                    ['vest'] = {item = 0, texture = 0}, -- Body Vest
                    ['torso2'] = {item = 317, texture = 3}, -- Jacket
                    ['shoes'] = {item = 51, texture = 0}, -- Shoes
                    ['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['hat'] = {item = 58, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['mask'] = {item = 0, texture = 0} -- Mask
                },
                grades = {0, 1, 2, 3, 4},
            },
            [3] = {
                outfitLabel = 'Long Sleeve',
                outfitData = {
                    ['pants'] = {item = 24, texture = 0}, -- Pants
                    ['arms'] = {item = 20, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
                    ['vest'] = {item = 0, texture = 0}, -- Body Vest
                    ['torso2'] = {item = 317, texture = 0}, -- Jacket
                    ['shoes'] = {item = 51, texture = 0}, -- Shoes
                    ['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['hat'] = {item = -1, texture = -1}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['mask'] = {item = 0, texture = 0} -- Mask
                },
                grades = {1, 2, 3, 4},
            },
            [4] = {
                outfitLabel = 'Trooper Black',
                outfitData = {
                    ['pants'] = {item = 24, texture = 0}, -- Pants
                    ['arms'] = {item = 20, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
                    ['vest'] = {item = 0, texture = 0}, -- Body Vest
                    ['torso2'] = {item = 317, texture = 8}, -- Jacket
                    ['shoes'] = {item = 51, texture = 0}, -- Shoes
                    ['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['hat'] = {item = 58, texture = 3}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['mask'] = {item = 0, texture = 0} -- Mask
                },
                grades = {2, 3, 4},
            },
            [5] = {
                outfitLabel = 'SWAT',
                outfitData = {
                    ['pants'] = {item = 130, texture = 1}, -- Pants
                    ['arms'] = {item = 172, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 15, texture = 0}, -- T Shirt
                    ['vest'] = {item = 15, texture = 2}, -- Body Vest
                    ['torso2'] = {item = 336, texture = 3}, -- Jacket
                    ['shoes'] = {item = 24, texture = 0}, -- Shoes
                    ['accessory'] = {item = 133, texture = 0}, -- Neck Accessory
                    ['hat'] = {item = 150, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['mask'] = {item = 52, texture = 0} -- Mask
                },
                grades = {3, 4},
            }
        },
        ['female'] = {
            [1] = {
                outfitLabel = 'Short Sleeve',
                outfitData = {
                    ['pants'] = {item = 133, texture = 0}, -- Pants
                    ['arms'] = {item = 31, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
                    ['vest'] = {item = 34, texture = 0}, -- Body Vest
                    ['torso2'] = {item = 48, texture = 0}, -- Jacket
                    ['shoes'] = {item = 52, texture = 0}, -- Shoes
                    ['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['hat'] = {item = 0, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['mask'] = {item = 0, texture = 0} -- Mask
                },
                grades = {0, 1, 2, 3, 4},
            },
            [2] = {
                outfitLabel = 'Trooper Tan',
                outfitData = {
                    ['pants'] = {item = 133, texture = 0}, -- Pants
                    ['arms'] = {item = 31, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
                    ['vest'] = {item = 34, texture = 0}, -- Body Vest
                    ['torso2'] = {item = 327, texture = 3}, -- Jacket
                    ['shoes'] = {item = 52, texture = 0}, -- Shoes
                    ['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['hat'] = {item = 0, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['mask'] = {item = 0, texture = 0} -- Mask
                },
                grades = {0, 1, 2, 3, 4},
            },
            [3] = {
                outfitLabel = 'Long Sleeve',
                outfitData = {
                    ['pants'] = {item = 133, texture = 0}, -- Pants
                    ['arms'] = {item = 31, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
                    ['vest'] = {item = 34, texture = 0}, -- Body Vest
                    ['torso2'] = {item = 327, texture = 0}, -- Jacket
                    ['shoes'] = {item = 52, texture = 0}, -- Shoes
                    ['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['hat'] = {item = 0, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['mask'] = {item = 0, texture = 0} -- Mask
                },
                grades = {1, 2, 3, 4},
            },
            [4] = {
                outfitLabel = 'Trooper Black',
                outfitData = {
                    ['pants'] = {item = 133, texture = 0}, -- Pants
                    ['arms'] = {item = 31, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
                    ['vest'] = {item = 34, texture = 0}, -- Body Vest
                    ['torso2'] = {item = 327, texture = 8}, -- Jacket
                    ['shoes'] = {item = 52, texture = 0}, -- Shoes
                    ['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['hat'] = {item = 0, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['mask'] = {item = 0, texture = 0} -- Mask
                },
                grades = {2, 3, 4},
            },
            [5] = {
                outfitLabel = 'SWAT',
                outfitData = {
                    ['pants'] = {item = 135, texture = 1}, -- Pants
                    ['arms'] = {item = 213, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 0, texture = 0}, -- T Shirt
                    ['vest'] = {item = 17, texture = 2}, -- Body Vest
                    ['torso2'] = {item = 327, texture = 8}, -- Jacket
                    ['shoes'] = {item = 52, texture = 0}, -- Shoes
                    ['accessory'] = {item = 102, texture = 0}, -- Neck Accessory
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['hat'] = {item = 149, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['mask'] = {item = 35, texture = 0} -- Mask
                },
                grades = {3, 4},
            }
        }
    },
    ['realestate'] = {
        ['male'] = {
            [1] = {
                -- Outfits
                outfitLabel = 'Worker',
                outfitData = {
                    ["pants"]       = { item = 28, texture = 0},  -- Pants
                    ["arms"]        = { item = 1, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 31, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 294, texture = 0},  -- Jacket
                    ["shoes"]       = { item = 10, texture = 0},  -- Shoes
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = 12, texture = -1},  -- Hat
                    ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                },
                grades = {0, 1, 2, 3, 4},
            }
        },
        ['female'] = {
            [1] = {
                outfitLabel = 'Worker',
                outfitData = {
                    ["pants"]       = { item = 57, texture = 2},  -- Pants
                    ["arms"]        = { item = 0, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 34, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 105, texture = 7},  -- Jacket
                    ["shoes"]       = { item = 8, texture = 5},  -- Shoes
                    ["accessory"]   = { item = 11, texture = 3},  -- Neck Accessory
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = -1, texture = -1},  -- Hat
                    ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                },
                grades = {0, 1, 2, 3, 4},
            }
        }
    },
    ['ambulance'] = {
        ['male'] = {
            [1] = {
                outfitLabel = 'T-Shirt',
                outfitData = {
                    ['arms'] = {item = 85, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 129, texture = 0}, -- T-Shirt
                    ['torso2'] = {item = 250, texture = 0}, -- Jackets
                    ['vest'] = {item = 0, texture = 0}, -- Vest
                    ['decals'] = {item = 58, texture = 0}, -- Decals
                    ['accessory'] = {item = 127, texture = 0}, -- Neck
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['pants'] = {item = 96, texture = 0}, -- Pants
                    ['shoes'] = {item = 54, texture = 0}, -- Shoes
                    ['mask'] = {item = 121, texture = 0}, -- Mask
                    ['hat'] = {item = 122, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['ear'] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4},
            },
            [2] = {
                outfitLabel = 'Polo',
                outfitData = {
                    ['arms'] = {item = 90, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 15, texture = 0}, -- T-Shirt
                    ['torso2'] = {item = 249, texture = 0}, -- Jackets
                    ['vest'] = {item = 0, texture = 0}, -- Vest
                    ['decals'] = {item = 57, texture = 0}, -- Decals
                    ['accessory'] = {item = 126, texture = 0}, -- Neck
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['pants'] = {item = 96, texture = 0}, -- Pants
                    ['shoes'] = {item = 54, texture = 0}, -- Shoes
                    ['mask'] = {item = 121, texture = 0}, -- Mask
                    ['hat'] = {item = 122, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['ear'] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {2, 3, 4},
            },
            [3] = {
                outfitLabel = 'Doctor',
                outfitData = {
                    ['arms'] = {item = 93, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 32, texture = 3}, -- T-Shirt
                    ['torso2'] = {item = 31, texture = 7}, -- Jackets
                    ['vest'] = {item = 0, texture = 0}, -- Vest
                    ['decals'] = {item = 0, texture = 0}, -- Decals
                    ['accessory'] = {item = 126, texture = 0}, -- Neck
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['pants'] = {item = 28, texture = 0}, -- Pants
                    ['shoes'] = {item = 10, texture = 0}, -- Shoes
                    ['mask'] = {item = 0, texture = 0}, -- Mask
                    ['hat'] = {item = -1, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['ear'] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {3, 4},
            }
        },
        ['female'] = {
            [1] = {
                outfitLabel = 'T-Shirt',
                outfitData = {
                    ['arms'] = {item = 109, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 159, texture = 0}, -- T-Shirt
                    ['torso2'] = {item = 258, texture = 0}, -- Jackets
                    ['vest'] = {item = 0, texture = 0}, -- Vest
                    ['decals'] = {item = 66, texture = 0}, -- Decals
                    ['accessory'] = {item = 97, texture = 0}, -- Neck
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['pants'] = {item = 99, texture = 0}, -- Pants
                    ['shoes'] = {item = 55, texture = 0}, -- Shoes
                    ['mask'] = {item = 121, texture = 0}, -- Mask
                    ['hat'] = {item = 121, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['ear'] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {0, 1, 2, 3, 4},
            },
            [2] = {
                outfitLabel = 'Polo',
                outfitData = {
                    ['arms'] = {item = 105, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 13, texture = 0}, -- T-Shirt
                    ['torso2'] = {item = 257, texture = 0}, -- Jackets
                    ['vest'] = {item = 0, texture = 0}, -- Vest
                    ['decals'] = {item = 65, texture = 0}, -- Decals
                    ['accessory'] = {item = 96, texture = 0}, -- Neck
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['pants'] = {item = 99, texture = 0}, -- Pants
                    ['shoes'] = {item = 55, texture = 0}, -- Shoes
                    ['mask'] = {item = 121, texture = 0}, -- Mask
                    ['hat'] = {item = 121, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['ear'] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {2, 3, 4},
            },
            [3] = {
                outfitLabel = 'Doctor',
                outfitData = {
                    ['arms'] = {item = 105, texture = 0}, -- Arms
                    ['t-shirt'] = {item = 39, texture = 3}, -- T-Shirt
                    ['torso2'] = {item = 7, texture = 1}, -- Jackets
                    ['vest'] = {item = 0, texture = 0}, -- Vest
                    ['decals'] = {item = 0, texture = 0}, -- Decals
                    ['accessory'] = {item = 96, texture = 0}, -- Neck
                    ['bag'] = {item = 0, texture = 0}, -- Bag
                    ['pants'] = {item = 34, texture = 0}, -- Pants
                    ['shoes'] = {item = 29, texture = 0}, -- Shoes
                    ['mask'] = {item = 0, texture = 0}, -- Mask
                    ['hat'] = {item = -1, texture = 0}, -- Hat
                    ['glass'] = {item = 0, texture = 0}, -- Glasses
                    ['ear'] = {item = 0, texture = 0} -- Ear accessories
                },
                grades = {3, 4},
            }
        }
    }
}
