Config = {}

Config.Job = "pizza"

Config.FolderName = "qb-restaurantjob"

Config.Locations = {
    [1] = {coords = vector3(813.7376, -749.700, 27.529), text = "Drink Station", config = Drink},
    [2] = {coords = vector3(809.89, -761.22, 26.78), text = "Prep Station", config = Prep},
    [3] = {coords = vector3(806.64, -757.7, 26.78), text = "Dough Station", config = Dough},
    [4] = {coords = vector3(806.21, -763.18, 26.78), text = "Oven", config = Oven},
    [5] = {coords = vector3(814.72, -760.01, 22.3), text = "Cheese", config = Cheese},
}


Config.JobStash = {
    [1] =  {coords = vector3(803.23, -757.42, 26.78), name = 'Generic Restaurant Name', size = 4000000, slots = 100},
}

Drink = {
    [1] = {
        label = "Water", 
        description = "Water Bottle", 
        item = "water_bottle", --item that will be given
        required = {}, -- required items to make (empty if no items required)
        progressbar = "Grabbing Water", -- text to display on progressbar
        progresstime = 5000, -- time required to make in milliseconds
        dictionary = 'amb@prop_human_bbq@male@idle_a', --dictionary name for animation
        animname = "idle_b", --animation name
    },
}

Prep = {
    [1] = {
        label = "Make Pizza Sauce", 
        description = "Mushrooms = 1 | Onion = 1 | Tomatoes = 4 ", 
        item = "sauce", --item that will be given
        required = {
            [1] = {itemName = "mushrooms", amount = 1},
            [2] = {itemName = "onion", amount = 1},
            [3] = {itemName = "burger-tomato", amount = 4},
        },
        progressbar = "Making Pizza Sauce", -- text to display on progressbar
        progresstime = 10000, -- in milliseconds
        dictionary = "mini@repair", --dictionary name for animation
        animname = "fixing_a_player", --animation name
    },
}

Oven = {
    [1] = {
        label = "Make Cheese Pizza", 
        description = "Pizza Dough = 1 | Sauce = 3 | Cheese = 4 ", 
        item = "cheese-pizza", --item that will be given
        required = {
            [1] = {itemName = "pizza-dough", amount = 1},
            [2] = {itemName = "sauce", amount = 3},
            [3] = {itemName = "cheese", amount = 4},
        }, -- required items to make
        progressbar = "Making Cheese Pizza", -- text to display on progressbar
        progresstime = 15000, -- in milliseconds
        dictionary = "anim@mp_player_intmenu@key_fob@", --dictionary name for animation
        animname = "fob_click", --animation name
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
        progresstime = 10000, -- in milliseconds
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
        progresstime = 10000, -- in milliseconds
        dictionary = "mini@repair", --dictionary name for animation
        animname = "fixing_a_player", --animation name
    }
}

Config.Items = {
    label = "Shop",
        slots = 7,
        items = {
            [1] = {
                name = "mushrooms",
                price = 100,
                amount = 50,
                info = {},
                type = "item",
                slot = 1,
            },
            [2] = {
                name = "onion",
                price = 300,
                amount = 50,
                info = {},
                type = "item",
                slot = 2,
            },
            [3] = {
                name = "burger-tomato",
                price = 50,
                amount = 5,
                info = {},
                type = "item",
                slot = 3,
            },
            [4] = {
                name = "yeast",
                price = 100,
                amount = 50,
                info = {},
                type = "item",
                slot = 4,
            },
            [5] = {
                name = "salt",
                price = 200,
                amount = 5,
                info = {},
                type = "item",
                slot = 5,
            },
            [6] = {
                name = "flour",
                price = 200,
                amount = 50,
                info = {},
                type = "item",
                slot = 6,
            },
        }
    }