

Citizen.CreateThread(function()
    exports['qb-target']:AddBoxZone("uwu-servico", vector3(-593.99, -1052.34, 22.34), 1, 1.2, {
        name = "uwu-servico",
        heading = 91,
        debugpoly = false,
        minZ=21.0,
        maxZ=24.6,
    }, {
        options = {
            {  
            event = "mt-UwUCafe:client:Servico",
            icon = "far fa-clipboard",
            label = "Clock in/out",
            job = "uwu",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("uwu-balcao", vector3(-587.59, -1059.67, 22.5), 1.6, 3.6, {
        name="uwu-balcao",
        heading=89,
        debugpoly = false,
    }, {
        options = {
            {
            event = "mt-UwUCafe:client:Balcao",
            icon = "far fa-clipboard",
            label = "Counter",
            },
        },
        distance = 3.5
    })

    exports['qb-target']:AddBoxZone("uwu-tabuleiro1", vector3(-584.1, -1062.1, 22.6), 0.5, 0.7, {
        name = "uwu-tabuleiro1",
        heading = 87.8,
        debugpoly = false,
    }, {
        options = {
            {
            event = "mt-UwUCafe:client:Tabuleiro1",
            icon = "far fa-clipboard",
            label = "Board",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("uwu-tabuleiro2", vector3(-584.11, -1059.39, 22.67), 0.5, 0.7, {
        name="uwu-tabuleiro2",
        heading=87.8,
        debugpoly = false,
    }, {
        options = {
            {
            event = "mt-UwUCafe:client:Tabuleiro1",
            icon = "far fa-clipboard",
            label = "Board",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("uwu-frigorifico", vector3(-591.05, -1058.69, 22.34), 1.6, 1, {
        name="uwu-frigorifico",
        heading=89.0,
        debugpoly = false,
    }, {
            options = {
                {
                    event = "mt-UwUCafe:client:FrigorificoComida",
                    icon = "fas fa-laptop",
                    label = "Food Fridge",
                    job = "uwu",
                },
            },
            distance = 1.5
        })

    exports['qb-target']:AddBoxZone("uwu-fogao", vector3(-590.95, -1056.56, 22.28), 0.7, 1.5, {
        name="uwu-fogao",
        heading=91.25,
        debugPoly=false,

    }, {
            options = {
                {
                    event = "mt-UwUCafe:client:MenuComidas",
                    icon = "fas fa-rocket",
                    label = "Use Stove",
                    job = "uwu",
                },
            },
            distance = 1.5
        })

    exports['qb-target']:AddBoxZone("uwu-ementa1", vector3(-584.25, -1058.8, 22.37), 0.5, 0.4, {
        name="uwu-ementa1",
        debugpoly = false,
        heading=270,
    }, {
            options = {
                {
                    event = "mt-UwUCafe:client:VerEmenta",
                    icon = "fas fa-clipboard",
                    label = "See Menu",
                },
                {
                    event = "mt-UwUCafe:client:FaturarPlayer",
                    icon = "fas fa-clipboard",
                    label = "Bill Player",
                    job = "uwu",
                },
            },
            distance = 1.5
        })

    exports['qb-target']:AddBoxZone("uwu-ementa2", vector3(-584.25, -1061.5, 22.37), 0.6, 0.5, {
        name="uwu-ementa2",
        debugpoly = false,
        heading=270,
        }, {
                options = {
                    {
                        event = "mt-UwUCafe:client:VerEmenta",
                        icon = "fas fa-clipboard",
                        label = "See Menu",
                    },
                    {
                        event = "mt-UwUCafe:client:FaturarPlayer",
                        icon = "fas fa-clipboard",
                        label = "Bill Player",
                        job = "uwu",
                    },
                },
                distance = 1.5
            })
            
    exports['qb-target']:AddTargetModel(`a_c_cat_01`, {
        options = {
            {
                event = "mt-UwUCafe:client:AcariciarGato",
                icon = "fas fa-cat",
                label = "Caress cat",
            },
        },
        distance = 2.0
    })
    
    exports['qb-target']:AddBoxZone("uwu-bebidas", vector3(-586.95, -1061.92, 22.34), 1, 1, {
        name="uwu-bebidas",
        heading=0,
        debugpoly = false,
    }, {
        options = {
            {
            event = "mt-UwUCafe:client:MenuBebidas",
            icon = "far fa-coffee",
            label = "Use Coffe Machine",
            job = "uwu",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("uwu-roupas", vector3(-585.91, -1050.11, 22.36), 1.5, 1, {
        name="uwu-roupas",
        heading=0,
        debugpoly = false,
    }, {
        options = {
            {
            event = "fivem-appearance:client:changeOutfitMenu",
            icon = "far fa-tshirt",
            label = "Change Outfit",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("uwu-storage", vector3(-588.12, -1067.09, 22.34), 3, 1, {
        name="uwu-roupas",
        heading=0,
        debugpoly = false,
    }, {
        options = {
            {
            type = "server",            
            event = "mt-UwUCafe:server:FrigorificoIngredients",
            icon = "far fa-tshirt",
            label = "Storage(Boss Only)",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("uwu-miz", vector3(-578.54, -1051.1, 22.35), 0.5, 0.5, {
        name="uwu-miz",
        heading=0,
        debugpoly = false,
    }, {
        options = {
            {
            type = "client",            
            event = "mt-UwUCafe:client:miz",
            icon = "far fa-table",
            label = "UWU Miz",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("uwu-miz2", vector3(-586.82, -1066.2, 22.34), 4, 0.5, {
        name="uwu-miz2",
        heading=0,
        debugpoly = true,
    }, {
        options = {
            {
            type = "client",            
            event = "mt-UwUCafe:client:miz2",
            icon = "far fa-table",
            label = "UWU Miz",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("uwu-miz3", vector3(-586.39, -1076.03, 22.33), 2.2, 2, {
        name="uwu-miz3",
        heading=0,
        debugpoly = true,
    }, {
        options = {
            {
            type = "client",            
            event = "mt-UwUCafe:client:miz3",
            icon = "far fa-table",
            label = "UWU Miz",
            },
        },
        distance = 2.5
    })

    exports['qb-target']:AddBoxZone("uwu-miz4", vector3(-591.24, -1080.2, 22.33), 2.2, 2, {
        name="uwu-miz4",
        heading=0,
        debugpoly = true,
    }, {
        options = {
            {
            type = "client",            
            event = "mt-UwUCafe:client:miz4",
            icon = "far fa-table",
            label = "UWU Miz",
            },
        },
        distance = 2.5
    })

    exports['qb-target']:AddBoxZone("uwu-miz5", vector3(-586.4, -1081.66, 22.33), 2.2, 2, {
        name="uwu-miz5",
        heading=0,
        debugpoly = true,
    }, {
        options = {
            {
            type = "client",            
            event = "mt-UwUCafe:client:miz5",
            icon = "far fa-table",
            label = "UWU Miz",
            },
        },
        distance = 2.5
    })

end)