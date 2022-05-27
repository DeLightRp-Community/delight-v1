Config = {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.Jobs = {
    ["electrician"] = "Electrician"
}

Config.Locations = {
    jobs = {
        ["electrician"] = {
            [1] = {
                coords = vector4(1761.46, 2540.41, 45.56, 272.249)
            },
            [2] = {
                coords = vector4(1718.54, 2527.802, 45.56, 272.249)
            },
            [3] = {
                coords = vector4(1700.199, 2474.811, 45.56, 272.249)
            },
            [4] = {
                coords = vector4(1664.827, 2501.58, 45.56, 272.249)
            },
            [5] = {
                coords = vector4(1621.622, 2509.302, 45.56, 272.249)
            },
            [6] = {
                coords = vector4(1627.936, 2538.393, 45.56, 272.249)
            },
            [7] = {
                coords = vector4(1625.1, 2575.988, 45.56, 272.249)
            }
        }
    },
    ["freedom"] = {
        coords = vector4(1790.86, 2550.33, 45.67, 86.35)
    },
    ["outside"] = {
        coords = vector4(1848.13, 2586.05, 45.67, 269.5)
    },
    ["yard"] = {
        coords = vector4(1765.67, 2565.91, 45.56, 1.5)
    },
    ["middle"] = {
        coords = vector4(1693.33, 2569.51, 45.55, 123.5)
    },
    ["shop"] = {
        coords = vector4(1786.19, 2557.77, 45.62, 0.5)
    },
    spawns = {
        [1] = {
            animation = "bumsleep",
            coords = vector4(1661.046, 2524.681, 45.564, 260.545)
        },
        [2] = {
            animation = "lean",
            coords = vector4(1766.65, 2477.47, 49.69, 301.57)
        },
        [3] = {
            animation = "lean",
            coords = vector4(1769.7, 2479.95, 45.74, 336.1)
        },
        [4] = {
            animation = "lean",
            coords = vector4(1765.71, 2499.28, 45.74, 116.77)
        },
        [5] = {
            animation = "sitchair4",
            coords = vector4(1768.38, 2490.7, 45.24, 21.68)
        },
        [6] = {
            animation = "sitchair",
            coords = vector4(1763.4, 2487.78, 45.34, 36.4)
        },
        [7] = {
            animation = "sitchair4",
            coords = vector4(1752.1, 2475.01, 45.24, 243.4)
        },
        [8] = {
            animation = "finger2",
            coords = vector4(1770.59, 2536.064, 45.564, 258.113)
        },
        [9] = {
            animation = "smoke",
            coords = vector4(1748.83, 2490.02, 45.74, 197.44)
        },
        [10] = {
            animation = "smoke",
            coords = vector4(1753.86, 2479.41, 49.69, 303.59)
        },
        [11] = {
            animation = "smoke",
            coords = vector4(1754.33, 2488.52, 49.69, 212.64)
        }
    }
}

Config.CanteenItems = {
    [1] = {
        name = "sandwich",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 1
    },
    [2] = {
        name = "water_bottle",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 2
    }
}
