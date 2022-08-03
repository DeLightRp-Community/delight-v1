Config = {}

Config.Job = "pizza"

Config.FolderName = "qb-restaurantjob"

Config.GaragePedLocations = {
    {coords = vector4(800.74, -738.71, 27.66, 2.79)},
}

Config.Locations = {
    --[1] = {coords = vector3(813.7376, -749.700, 27.529), text = "Drink Station", config = Drink},
    [1] = {coords = vector3(809.89, -761.22, 26.78), text = "Prep Station", config = Prep},
    [2] = {coords = vector3(806.64, -757.7, 26.78), text = "Dough Station", config = Dough},
    -- [3] = {coords = vector3(806.21, -763.18, 26.78), text = "Oven", config = Oven},
    [3] = {coords = vector3(814.72, -760.01, 22.3), text = "Cheese", config = Cheese},
    [4] = {coords = vector3(807.66, -761.22, 26.78), text = "fries", config = fries},
    [5] = {coords = vector3(802.23, -756.91, 26.78), text = "specialp", config = specialp},
}


Config.JobStash = {
    [1] =  {coords = vector3(803.23, -757.42, 26.78), name = 'Generic Restaurant Name', size = 4000000, slots = 100},
}

--[[Drink = {
    [1] = {
        label = "Beer", 
        description = "Beer Bottle", 
        item = "Beer", --item that will be given
        required = {}, -- required items to make (empty if no items required)
        progressbar = "Grabbing Beer", -- text to display on progressbar
        progresstime = 5000, -- time required to make in milliseconds
        dictionary = 'amb@prop_human_bbq@male@idle_a', --dictionary name for animation
        animname = "idle_b", --animation name
    },
    [2] = {
        label = "cola", 
        description = "make cola", 
        item = "kurkakola", --item that will be given
        required = {}, -- required items to make (empty if no items required)
        progressbar = "makeing", -- text to display on progressbar
        progresstime = 5000, -- time required to make in milliseconds
        dictionary = 'amb@prop_human_bbq@male@idle_a', --dictionary name for animation
        animname = "idle_b", --animation name
    },
}]]

Prep = {
    [1] = {
        label = "Make Pizza Sauce", 
        description = "Mushrooms = 1 | Onion = 1 | Tomatoes = 2 ", 
        item = "sauce", --item that will be given
        required = {
            [1] = {itemName = "mushrooms", amount = 1},
            [2] = {itemName = "onion", amount = 1},
            [3] = {itemName = "tomato", amount = 2},
        },
        progressbar = "Making Pizza Sauce", -- text to display on progressbar
        progresstime = 3000, -- in milliseconds
        dictionary = "mini@repair", --dictionary name for animation
        animname = "fixing_a_player", --animation name
    },
}

specialp = {
    [1] = {
        label = "Make special pizza", 
        description = "coca_leaf = 1 | tomato = 1 | dough = 1 | mushrooms = 1", 
        item = "specialp", --item that will be given
        required = {
            [1] = {itemName = "coca_leaf", amount = 1},
            [2] = {itemName = "pizza-dough", amount = 1},
            [3] = {itemName = "tomato", amount = 1},
            [4] = {itemName = "mushrooms", amount = 1},
            [5] = {itemName = "greenpepper", amount = 1},
        },
        progressbar = "Making special pizza", -- text to display on progressbar
        progresstime = 4000, -- in milliseconds
        dictionary = "mini@repair", --dictionary name for animation
        animname = "fixing_a_player", --animation name
    },
}

-- Oven = {
--     [1] = {
--         label = "Make Cheese Pizza", 
--         description = "Pizza Dough = 1 | Sauce = 3 | Cheese = 4 ", 
--         item = "cheese-pizza", --item that will be given
--         required = {
--             [1] = {itemName = "pizza-dough", amount = 1},
--             [2] = {itemName = "sauce", amount = 3},
--             [3] = {itemName = "cheese", amount = 4},
--         }, -- required items to make
--         progressbar = "Making Cheese Pizza", -- text to display on progressbar
--         progresstime = 4000, -- in milliseconds
--         dictionary = "anim@mp_player_intmenu@key_fob@", --dictionary name for animation
--         animname = "fob_click", --animation name
--     },

--     [2] = {
--         label = "Make Slice Pizza", 
--         description = "Pizza Dough = 1 | Sauce = 2 | Cheese = 2 | tomato = 1 | chillypepper = 2", 
--         item = "cheese-pizza", --item that will be given
--         required = {
--             [1] = {itemName = "pizza-dough", amount = 1},
--             [2] = {itemName = "sauce", amount = 2},
--             [3] = {itemName = "cheese", amount = 2},
--             [4] = {itemName = "tomato", amount = 1},
--             [5] = {itemName = "chillypepper", amount = 1},
--         }, -- required items to make
--         progressbar = "Making Cheese Pizza", -- text to display on progressbar
--         progresstime = 4000, -- in milliseconds
--         dictionary = "anim@mp_player_intmenu@key_fob@", --dictionary name for animation
--         animname = "fob_click", --animation name
--     },
-- }
-- 
fries = {
    [1] = {
        label = "Make Dough", 
        description = "pizza-potato = 1 ", 
        item = "burger-fries", --item that will be given
        required = {
            [1] = {itemName = "burger-potato", amount = 1},
        }, -- required items to make
        progressbar = "Making fries", -- text to display on progressbar
        progresstime = 4000, -- in milliseconds
        dictionary = "mini@repair", --dictionary name for animation
        animname = "fixing_a_player", --animation name
    },
}

Dough = {
    [1] = {
        label = "Make Dough", 
        description = "Yeast = 1 | Flour = 2 | Salt = 3 ", 
        item = "pizza-dough", --item that will be given
        required = {
            [1] = {itemName = "yeast", amount = 1},
            [2] = {itemName = "salt", amount = 3},
            [3] = {itemName = "flour", amount = 2},
        }, -- required items to make
        progressbar = "Making Pizza Dough", -- text to display on progressbar
        progresstime = 4000, -- in milliseconds
        dictionary = "mini@repair", --dictionary name for animation
        animname = "fixing_a_player", --animation name
    },
}

Cheese = {
    [1] = {
        label = "Cheese", 
        description = "", 
        item = "cheese", --item that will be given
        required = {}, -- required items to make
        progressbar = "Grabbing Cheese", -- text to display on progressbar
        progresstime = 3000, -- in milliseconds
        dictionary = "mini@repair", --dictionary name for animation
        animname = "fixing_a_player", --animation name
    }
}

Config.Items = {
    label = "Shop",
        slots = 9,
        items = {
            [1] = {
                name = "mushrooms",
                price = 4,
                amount = 50,
                info = {},
                type = "item",
                slot = 1,
            },
            [2] = {
                name = "onion",
                price = 3,
                amount = 50,
                info = {},
                type = "item",
                slot = 2,
            },
            [3] = {
                name = "tomato",
                price = 35,
                amount = 50,
                info = {},
                type = "item",
                slot = 3,
            },
            [4] = {
                name = "yeast",
                price = 6,
                amount = 50,
                info = {},
                type = "item",
                slot = 4,
            },
            [5] = {
                name = "salt",
                price = 2,
                amount = 50,
                info = {},
                type = "item",
                slot = 5,
            },
            [6] = {
                name = "flour",
                price = 6,
                amount = 50,
                info = {},
                type = "item",
                slot = 6,
            },
            [7] = {
                name = "cheese",
                price = 6,
                amount = 50,
                info = {},
                type = "item",
                slot = 7,
            },
            [8] = {
                name = "burger-potato",
                price = 20,
                amount = 50,
                info = {},
                type = "item",
                slot = 8,
            },
            [9] = {
                name = "burger-mshakeformula",
                price = 10,
                amount = 50,
                info = {},
                type = "item",
                slot = 9,
            },
            [10] = {
                name = "greenpepper",
                price = 33,
                amount = 50,
                info = {},
                type = "item",
                slot = 10,
            },
            [11] = {
                name = "chillypepper",
                price = 33,
                amount = 50,
                info = {},
                type = "item",
                slot = 11,
            },
        }
    }