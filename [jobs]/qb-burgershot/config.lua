Config = {}

Config.GaragePedLocations = {
    {coords = vector4(-1178.588, -891.9196, 13.799622, 302.58825)},
}

Config.SQL = 'oxmysql' --- oxmysql or ghmattisql

Config.Eye = "true" -- If you are using the QB Target then change this to true. IF FALSE it will show 3D text

Config.Items = {
label = "Shop",
    slots = 7,
    items = {
        [1] = {
            name = "burger-bun",
            price = 100,
            amount = 5,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "burger-raw",
            price = 300,
            amount = 5,
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
            name = "burger-lettuce",
            price = 50,
            amount = 5,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "burger-potato",
            price = 100,
            amount = 2,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "burger-mshakeformula",
            price = 100,
            amount = 5,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "burger-sodasyrup",
            price = 200,
            amount = 5,
            info = {},
            type = "item",
            slot = 7,
        },
    }
}
