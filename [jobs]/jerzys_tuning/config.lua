Config = {}
-- JERZY'S TUNING [0.7]
-- FINAL VERSION WILL BE [1]
--[[

Welcome to Jerzy's Tuning.
Firstly, I wanted to thank you, that you bought my product!
I really appreciate that.

~ Installation
-- To hide the HUD inside the Tuner.
Insert this code into QB-HUD :
RegisterNetEvent('hud:client:hideHUD', function (boolean)
    local hideMenu = boolean
    if hideMenu then
        SendNUIMessage({
            action = 'closeUi'
        })
    else
        SendNUIMessage({
            action = 'showUi'
        })
    end
end)
Insert/Replace this in Javascript in QBHUD | Line: 606
 $(document).ready(function () {
  window.addEventListener("message", function (event) {
    switch (event.data.action) {
    case "open":
      Open(event.data);
      break;
    case "showUi":
      $('#main-container').show()
      break;
    case "closeUi":
      $('#main-container').hide()
      break;
    }
  });
});

~ GitHub
https://github.com/JZSandbox

~ Youtube
https://www.youtube.com/channel/UCjl_VAo39z2U2nqJFnzRFYQ

~ Tebex
https://jerzy.tebex.io/

~ Discord
https://discord.gg/r6qpKtqJ

]]--
-- [[ UPDATE : 0.7]] --
-- Hotfix: Cleaning, CarPrices and CarHeading

-- ## IMPORTANT
-- Car's needs to be in QBShared Vehicle, otherwise this scripts gives your errors!

Config.useMultiPlaces = true -- Use MultiePlaces
Config.debugPolyZone = false -- If true PolyZone Debug

-- Price Options :
Config.useQBShared = true -- If false | Then go to line 259 and set your car price

--- ONLY USEABLE IF YOU HAVE useQBShared == TRUE, Keep in mind, you have to have the the vehicles in QB Shared
Config.variableEnginePrice = false -- If True, it uses QBShared.Vehicle Prices
Config.variableEngineFactor = 5 -- Example : Calc : 5% - 10% - 15% of Total Price of Car

Config.variableSupensionPrice = false -- If True, it uses QBShared.Vehicle Prices
Config.variableSupensionFactor = 5 -- Example : Calc : 5% - 10% - 15% of Total Price of Car

Config.variableBrakePrice = false -- If True, it uses QBShared.Vehicle Prices
Config.variableBrakeFactor = 1 -- Example : Calc : 5% - 10% - 15% of Total Price of Car

Config.variableTransmissionPrice = false -- If True, it uses QBShared.Vehicle Prices
Config.variableTransmissionFactor = 1 -- Example : Calc : 5% - 10% - 15% of Total Price of Car

-- Car Options
Config.revertCarCustoms = true -- If true, it doesnt save the mods until you buy it. So after Leaving the Tuner it will unload the customs

-- Variable Price Enable | Only Recommend when only Mechanice can trigger the Tuner
Config.variablePrice = false -- Set to true, you can manipulate !!every price!!


-- Multiple Place Setup
if Config.useMultiPlaces then
    Config.locations = {
        ['bennys-paint'] = {
            name = 'Bennys Paint', -- Showen in the Top Left while Entering
            accentColor = 'rgb(64, 147, 173)', -- Accent Color of the Tuner
            accentDarkColor = 'rgb(37, 95, 113)', -- Accentt Dark Color of Tuner
            tuning = true, -- If false you still need to use / setup the Camera
            -- Camera Settings you need to setup if you are Using | Camera Angle Self Explained :
            camera = {
                front = {-30.39, -1045.8, 28.58, 342.97,60.00},  -- How to :
                wheel = {-27.68, -1045.21, 28.63, 47.3,70.00}, -- How to :
                back = {-27.76, -1038.69, 28.63, 157.28,60.00},-- How to :
                left = {-26.88, -1043.01, 28.63, 64.67,60.00 },-- How to :
                right = {-31.65, -1041.94, 28.63, 255.22,70.00}, -- How to :
            },
            -- Location Settings
            location = {
                label = 'Bennys Paitings', -- This will be the Blip Name vector3(-28.94, -1041.44, 28.63)
                coords = {x = -29.15, y = -1042.28, z = 28.63}, -- This is location where the Blip will be shown
                color = 10, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
                blipId = 72, -- https://docs.fivem.net/docs/game-references/blips/#blips
                show = false, -- if the Blip should be shown
                -- ATTENTION : For the sake of the tuner "Trigger Points", please leave lenght,width,heading,minZ,maxZ be!! Dont Change it! 
                carHeading = 160.0, -- Set the car direction in the Tuner | If carHeading == false then default is 88.02
                triggerZone = {
                    {
                        coords = vector3(-29.15, -1042.28, 28.63),  -- This you can change!| The Place you set the "Zone" you enter
                        length = 6.0,
                        width = 4.0,
                        heading = 160.0,
                        minZ = 27.68,
                        maxZ = 30.48,
                    },
                }
            },
            -- Jobs can trigger this Menu | If everyone can trigger it, write "all"
            jobs = {
                'mechanic'
            },
            -- Other Staff can trigger it
            others = {
                'admin',
                'gods',
            },
            vehicles = 'both', -- Options: car | bike | both - This vehicles will be allowed to enter
            -- Which Menu will be shown
            menus = {
                -- 'care',
                'painting',
                -- 'motor',
                -- 'tuning'
            },
            management = 'mechanic', -- Which Managment Job should get the Money | Empty if no one gets money
            usePercentage = true, -- If true you need to setup percantage for the one who makes the car
            percentageForTuner = '30', -- Tuner will get 5% of the total price of tuning
            payment = 'bank' -- Which Payment Method should be Used
        },
        ['bennys-care'] = {
            name = 'Bennys Care', -- Showen in the Top Left while Entering
            accentColor = 'rgb(64, 147, 173)', -- Accent Color of the Tuner
            accentDarkColor = 'rgb(37, 95, 113)', -- Accentt Dark Color of Tuner
            tuning = true, -- If false you still need to use / setup the Camera
            -- Camera Settings you need to setup if you are Using | Camera Angle Self Explained :
            camera = {
                front = {-37.91, -1049.12, 28.4, 162.04,60.00},  -- How to :
                wheel = {-40.23, -1050.3, 28.4, 240.39,70.00}, -- How to :
                back = {-40.23, -1055.7, 28.4, 342.58,60.00},-- How to :
                left = {-40.89, -1052.27, 28.4, 257.65,60.00 },-- How to :
                right = {-37.27, -1053.34, 28.4, 72.48,70.00}, -- How to :
            },
            -- Location Settings
            location = {
                label = 'Bennys Care', -- This will be the Blip Name vector3(-39.18, -1053.0, 28.4)
                coords = {x = -39.18, y = -1053.0, z = 28.4}, -- This is location where the Blip will be shown
                color = 10, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
                blipId = 72, -- https://docs.fivem.net/docs/game-references/blips/#blips
                show = true, -- if the Blip should be shown
                -- ATTENTION : For the sake of the tuner "Trigger Points", please leave lenght,width,heading,minZ,maxZ be!! Dont Change it! 
                carHeading = 340.91, -- Set the car direction in the Tuner | If carHeading == false then default is 88.02
                triggerZone = {
                    {
                        coords = vector3(-39.18, -1053.0, 28.4),  -- This you can change!| The Place you set the "Zone" you enter
                        length = 6.0,
                        width = 4.0,
                        heading = 340.91,
                        minZ = 27.4,
                        maxZ = 30.48,
                    },
                }
            },
            -- Jobs can trigger this Menu | If everyone can trigger it, write "all"
            jobs = {
                'mechanic'
            },
            -- Other Staff can trigger it
            others = {
                'admin',
                'gods',
            },
            vehicles = 'both', -- Options: car | bike | both - This vehicles will be allowed to enter
            -- Which Menu will be shown
            menus = {
                'care',
                -- 'painting',
                -- 'motor',
                -- 'tuning'
            },
            management = 'mechanic', -- Which Managment Job should get the Money | Empty if no one gets money
            usePercentage = true, -- If true you need to setup percantage for the one who makes the car
            percentageForTuner = '30', -- Tuner will get 5% of the total price of tuning
            payment = 'bank' -- Which Payment Method should be Used
        },
        ['bennys-tune'] = {
            name = 'Bennys Tune', -- Showen in the Top Left while Entering
            accentColor = 'rgb(64, 147, 173)', -- Accent Color of the Tuner
            accentDarkColor = 'rgb(37, 95, 113)', -- Accentt Dark Color of Tuner
            tuning = true, -- If false you still need to use / setup the Camera
            -- Camera Settings you need to setup if you are Using | Camera Angle Self Explained :
            camera = {
                front = {-31.34, -1062.83, 28.4, 159.6,60.00},  -- How to :
                wheel = {-33.84, -1063.69, 28.4, 208.09,70.00}, -- How to :
                back = {-34.07, -1070.6, 28.4, 342.66,60.00},-- How to :
                left = {-35.06, -1065.64, 28.4, 249.81,60.00 },-- How to :
                right = {-30.44, -1067.19, 28.4, 72.17,70.00}, -- How to :
            },
            -- Location Settings
            location = {
                label = 'Bennys Tune', -- This will be the Blip Name vector3(-32.77, -1066.9, 28.4)
                coords = {x = -32.77, y = -1066.9, z = 28.4}, -- This is location where the Blip will be shown
                color = 10, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
                blipId = 72, -- https://docs.fivem.net/docs/game-references/blips/#blips
                show = false, -- if the Blip should be shown
                -- ATTENTION : For the sake of the tuner "Trigger Points", please leave lenght,width,heading,minZ,maxZ be!! Dont Change it! 
                carHeading = 340.91, -- Set the car direction in the Tuner | If carHeading == false then default is 88.02
                triggerZone = {
                    {
                        coords = vector3(-32.77, -1066.9, 28.4),  -- This you can change!| The Place you set the "Zone" you enter
                        length = 6.0,
                        width = 4.0,
                        heading = 340.91,
                        minZ = 27.4,
                        maxZ = 30.48,
                    },
                }
            },
            -- Jobs can trigger this Menu | If everyone can trigger it, write "all"
            jobs = {
                'mechanic'
            },
            -- Other Staff can trigger it
            others = {
                'admin',
                'gods',
            },
            vehicles = 'both', -- Options: car | bike | both - This vehicles will be allowed to enter
            -- Which Menu will be shown
            menus = {
                -- 'care',
                -- 'painting',
                -- 'motor',
                'tuning'
            },
            management = 'mechanic', -- Which Managment Job should get the Money | Empty if no one gets money
            usePercentage = true, -- If true you need to setup percantage for the one who makes the car
            percentageForTuner = '30', -- Tuner will get 5% of the total price of tuning
            payment = 'bank' -- Which Payment Method should be Used
        },
        -- ['policeMechanic'] = {
        --     name = 'Police Mechanic', -- Showen in the Top Left while Entering
        --     accentColor = 'rgb(64, 147, 173)', -- Accent Color of the Tuner
        --     accentDarkColor = 'rgb(37, 95, 113)', -- Accentt Dark Color of Tuner
        --     tuning = true, -- If false you still need to use / setup the Camera
        --     -- Camera Settings you need to setup if you are Using | Camera Angle Self Explained :
        --     camera = {
        --         front = {446.58, -975.98, 25.7, 265.99,60.00},  -- How to :
        --         wheel = {447.95, -977.8, 25.7, 319.27,70.00}, -- How to :
        --         back = {453.97, -975.51, 25.7, 91.98,60.00},-- How to :
        --         left = {450.69, -977.99, 25.7, 2.66,60.00 },-- How to :
        --         right = {450.37, -973.51, 25.7, 183.67,70.00}, -- How to :
        --     },
        --     -- Location Settings
        --     location = {
        --         label = 'Police Mechanic', -- This will be the Blip Name vector3(-32.77, -1066.9, 28.4)
        --         coords = {x = -450.66, y = -975.68, z = 25.7}, -- This is location where the Blip will be shown
        --         color = 10, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        --         blipId = 72, -- https://docs.fivem.net/docs/game-references/blips/#blips
        --         show = false, -- if the Blip should be shown
        --         -- ATTENTION : For the sake of the tuner "Trigger Points", please leave lenght,width,heading,minZ,maxZ be!! Dont Change it! 
        --         carHeading = 90.0, -- Set the car direction in the Tuner | If carHeading == false then default is 88.02
        --         triggerZone = {
        --             {
        --                 coords = vector3(450.66, -975.68, 25.7),  -- This you can change!| The Place you set the "Zone" you enter
        --                 length = 6.0,
        --                 width = 4.0,
        --                 heading = 90.0,
        --                 minZ = 24.7,
        --                 maxZ = 26.7,
        --             },
        --         }
        --     },
        --     -- Jobs can trigger this Menu | If everyone can trigger it, write "all"
        --     jobs = {
        --         'police'
        --     },
        --     -- Other Staff can trigger it
        --     others = {
        --         'admin',
        --         'gods',
        --     },
        --     vehicles = 'both', -- Options: car | bike | both - This vehicles will be allowed to enter
        --     -- Which Menu will be shown
        --     menus = {
        --         'care',
        --         'painting',
        --         'motor',
        --         'tuning'
        --     },
        --     management = 'mechanic', -- Which Managment Job should get the Money | Empty if no one gets money
        --     usePercentage = false, -- If true you need to setup percantage for the one who makes the car
        --     percentageForTuner = '10', -- Tuner will get 5% of the total price of tuning
        --     payment = 'bank' -- Which Payment Method should be Used
        -- },
        
    }
else
    Config.locations = {
        
    }
end

-- Custom Car Prices if QBShared is turned off
carPrices = {
    -- ["adder"] = { -- Get the Car hash name
    --     price = 300 -- Set the car price
    -- },
    -- ["neon"] = { -- Get the Car hash name
    -- price = 300 -- Set the car price
    -- },
}

-- Car Menu | Do not change anything, besides prices
menu = {
    care = {
        clean = {
            {name = 'Clean', price = 50, id= -1, type = 23}
        },
        repair = {
             {name = 'Repair', price = 500, id= -1, type = 23}
        }
    },
    motor = {
        engine = {
            {name = "Engine Upgrade", price = 00, id = 11}
        },
        hydraulic = {
            {name = "Hydraulic", price = 200, id = 38},
        },
        block = {
            {name = "Engine Block", price = 200, id = 39},
        },
        armor = {
            {name = "Armour Upgrade", price = 200, id = 39},
        },
        suspension = {
            {name = "Suspension Upgrade", price = 200, id = 15},
        },
        transmission = {
            {name = "Transmission Upgrade", price = 200, id = 13},
        },
        brake = {
            {name = "Brake Upgrade", price = 200, id = 12},
        },
    },
    tuning = {
        front = {
            {name = "Mirror", id = 46,
            items = {
                    {name = "None", id = 0, price = 500},
                    {name = "Pure Black", id = 1, price = 500},
                    {name = "Darksmoke", id = 2,  price = 1000},
                    {name = "Lightsmoke", id = 3,  price = 700}
                }
            },
            {name = "Horns" , id = 14 ,
            items = {
                {name = "Truck Horn", id = 0, price = 500},
                {name = "Cop Horn", id = 1, price = 500},
                {name = "Clown Horn", id = 2, price = 500},
                {name = "Musical Horn 1", id = 3, price = 500},
                {name = "Musical Horn 2", id = 4, price = 500},
                {name = "Musical Horn 3", id = 5, price = 500},
                {name = "Musical Horn 4", id = 6, price = 500},
                {name = "Musical Horn 5", id = 7, price = 500},
                {name = "Sad Trombone", id = 8, price = 500},
                {name = "Classical Horn 1", id = 9, price = 500},
                {name = "Classical Horn 2", id = 10, price = 500},
                {name = "Classical Horn 3", id = 11, price = 500},
                {name = "Classical Horn 4", id = 12, price = 500},
                {name = "Classical Horn 5", id = 13, price = 500},
                {name = "Classical Horn 6", id = 14, price = 500},
                {name = "Classical Horn 7", id = 15, price = 500},
                {name = "Scale - Do", id = 16, price = 500},
                {name = "Scale - Re", id = 17, price = 500},
                {name = "Scale - Mi", id = 18, price = 500},
                {name = "Scale - Fa", id = 19, price = 500},
                {name = "Scale - Sol", id = 20, price = 500},
                {name = "Scale - La", id = 21, price = 500},
                {name = "Scale - Ti", id = 22, price = 500},
                {name = "Scale - Do", id = 23, price = 500},
                {name = "Jazz Horn 1", id = 24, price = 500},
                {name = "Jazz Horn 2", id = 25, price = 500},
                {name = "Jazz Horn 3", id = 26, price = 500},
                {name = "Jazz Horn Loop", id = 27, price = 500},
                {name = "Star Spangled Banner 1", id = 28, price = 500},
                {name = "Star Spangled Banner 2", id = 29, price = 500},
                {name = "Star Spangled Banner 3", id = 30, price = 500},
                {name = "Star Spangled Banner 4", id = 31, price = 500},
                {name = "Classical Horn 8 Loop", id = 32, price = 500},
                {name = "Classical Horn 9 Loop", id = 33, price = 500},
                {name = "Classical Horn 10 Loop", id = 34, price = 500},
                {name = "Classical Horn 8", id = 35, price = 500},
                {name = "Classical Horn 9", id = 36, price = 500},
                {name = "Classical Horn 10", id = 37, price = 500},
                {name = "Funeral Loop", id = 38, price = 500},
                {name = "Funeral", id = 39, price = 500},
                {name = "Spooky Loop", id = 40, price = 500},
                {name = "Spooky", id = 41, price = 500},
                {name = "San Andreas Loop", id = 42, price = 500},
                {name = "San Andreas", id = 43, price = 500},
                {name = "Liberty City Loop", id = 44, price = 500},
                {name = "Liberty City", id = 45, price = 500},
                {name = "Festive 1 Loop", id = 46, price = 500},
                {name = "Festive 1", id = 47, price = 500},
                {name = "Festive 2 Loop", id = 48, price = 500},
                {name = "Festive 2", id = 49, price = 500},
                {name = "Festive 3 Loop", id = 50, price = 500},
                {name = "Festive 3", id = 51, price = 500},
            },
            },
            {name = "Vanity Plates", id = 26, price = 1000},
            {name = 'Left Fender', id = 8, price = 1000},
            {name = 'Roll Cage', id = 7, price = 1000},
            {name = "Hood", id = 7, price = 1000},
            {name = "Grill", id = 6, price = 1000},
            {name = "Bumper Front", id = 1, price = 1000},
        },
        back = {
            {name = "Plate Holder", id = 25, price = 1000},
            {name = "Spoiler", id = 0, price = 1000},
            {name = "Plates", id = 25 ,
            items = {
                {name = "Blue/White", id = 0, price = 1000},
                {name = "Yellow/black", id = 1, price = 1000},
                {name = "Yellow/Blue", id = 2, price = 1000},
                {name = "Blue/White2", id = 3, price = 1000},
                {name = "Blue/White3", id = 4, price = 1000},
                {name = "Yankton", id = 5, price = 1000},
            },
            },
            {name = "Trunk", id = 37, price = 1000},
            {name = "Bumper Back", id = 2, price = 1000},
            {name = 'Exhaust', id = 4, price = 1000},
        },
        left = {
            {name = "Left Fender", id = 8, price = 1000},
            {name = "Door Speaker", id = 31, price = 1000},
            {name = "Seats", id = 32, price = 1000},
        },
        right = {
            {name = 'Side Skirt', id = 3, price = 1000},
            {name = "Right Fender", id = 9, price = 1000},
        },
        wheel = {
            {name = "Sport", id = 0, price = 1000, extra = "wheel"},
            {name = "Muscle", id = 1, price = 1000, extra = "wheel"},
            {name = "Lowrider", id = 2, price = 1000, extra = "wheel"},
            {name = "SUV", id = 3, price = 1000, extra = "wheel"},
            {name = "Offroad", id = 4, price = 1000, extra = "wheel"},
            {name = "Tuner", id = 5, price = 1000, extra = "wheel"},
            {name = "Motorcycle", id = 6, price = 1000, extra = "wheel"},
            {name = "Highend", id = 7, price = 1000, extra = "wheel"},
            {name = "BennysWheel", id = 8, price = 1000, extra = "wheel"},
            {name = "BespokeWheel", id = 9, price = 1000, extra = "wheel"},
            {name = "Dragster", id = 10, price = 1000, extra = "wheel"},
            {name = "Street", id = 11, price = 1000, extra = "wheel"},
            {name = "Rally", id = 12, price = 1000, extra = "wheel"},
        },
    },
    painting = {
        livery = {
            name = "livery", id = 48, price = 200,
        },
        primary = {
            name = 'Primary', price = 2000, type = "color",
        },
        secondary = {
            name = 'Secondary', price = 1000, type = "color"
        },
        neon = {
            name = "Neon", price = 1000, type = "color",
        },
        xenon = {
            name = "Xenon" , id = 22,
            items = {
                {name = "Default", id = -1, price = 1000},
                {name = "White", id = 0, price = 1000},
                {name = "Blue", id = 1, price = 1000},
                {name = "Electric Blue", id = 2, price = 1000},
                {name = "Mint Green", id = 3, price = 1000},
                {name = "Yellow", id = 5, price = 1000},
                {name = "Golden Shower", id = 6, price = 1000},
                {name = "Red", id = 8, price = 1000},
                {name = "Pony Pink", id = 9, price = 1000},
                {name = "Hot Pink", id = 10, price = 1000},
                {name = "Purple", id = 11, price = 1000},
                {name = "Blacklight", id = 12, price = 1000},
            },
        },
        dashboard = {
            name = 'Dashboard', id = 4,
            items = {
                { name="Black", id=0 ,price= 1000},
                { name="Carbon Black", id=14, price= 1000},
                { name="Graphite",id=1 ,price= 1000},
                { name="Anhracite Black", id=11 ,price= 1000},
                { name="Black Steel" ,id=2, price= 1000},
                { name="Dark Steel", id=3, price= 1000},
                { name="Silver" ,id=4 ,price= 1000},
                { name="Bluish Silver", id=5, price= 1000},
                { name="Rolled Steel", id=6, price= 1000},
                { name="Shadow Silver", id=7, price= 1000},
                { name="Stone Silver", id=8, price= 1000},
                {name="Midnight Silver", id=9, price= 1000},
                {name="Cast Iron Silver" ,id=10, price= 1000},
                {name="Red", id="27", price= 1000},
                {name="Torino Red", id=28,price= 1000},
                {name="Formula Red" ,id=29 , price = 1000 },
                {name="Lava Red", id=150 , price = 1000 },
                {name="Blaze Red" ,id=30 , price = 1000 },
                {name="Grace Red" ,id=31 , price = 1000 },
                {name="Garnet Red" ,id=32 , price = 1000 },
                {name="Sunset Red" ,id=33 , price = 1000 },
                {name="Cabernet Red", id=34 , price = 1000 },
                {name="Wine Red" ,id=143 , price = 1000 },
                {name="Candy Red", id=35 , price = 1000 },
                {name="Hot Pink" ,id=135 , price = 1000 },
                {name="Pfsiter Pink" ,id=137 , price = 1000 },
                {name="Salmon Pink" ,id=136 , price = 1000 },
                {name="Sunrise Orange", id=36 , price = 1000 },
                {name="Orange", id=38 , price = 1000 },
                {name="Bright Orange" ,id=138 , price = 1000 },
                {name="Gold", id=99 , price = 1000 },
                {name="Bronze", id=90 , price = 1000 },
                {name="Yellow", id=88 , price = 1000 },
                {name="Race Yellow", id=89 , price = 1000 },
                {name="Dew Yellow", id=91 , price = 1000 },
                {name="Dark Green", id=49 , price = 1000 },
                {name="Racing Green", id=50 , price = 1000 },
                {name="Sea Green", id=51 , price = 1000 },
                {name="Olive Green", id=52 , price = 1000 },
                {name="Bright Green", id=53 , price = 1000 },
                {name="Gasoline Green", id=54 , price = 1000 },
                {name="Lime Green", id=92 , price = 1000 },
                {name="Midnight Blue" ,id=141 , price = 1000 },
                {name="Galaxy Blue", id=61 , price = 1000 },
                {name="Dark Blue", id=62 , price = 1000 },
                {name="Saxon Blue", id=63 , price = 1000 },
                {name="Blue", id=64 , price = 1000 },
                {name="Mariner Blue", id=65 , price = 1000 },
                {name="Harbor Blue", id=66 , price = 1000 },
                {name="Diamond Blue", id=67 , price = 1000 },
                {name="Surf Blue", id=68 , price = 1000 },
                {name="Nautical Blue", id=69 , price = 1000 },
                {name="Racing Blue", id=73 , price = 1000 },
                {name="Ultra Blue", id=70 , price = 1000 },
                {name="Light Blue", id=74 , price = 1000 },
                {name="Chocolate Brown", id=96 , price = 1000 },
                {name="Bison Brown" ,id=101 , price = 1000 },
                {name="Creeen Brown", id=95 , price = 1000 },
                {name="Feltzer Brown", id=94 , price = 1000 },
                {name="Maple Brow", id=97 , price = 1000 },
                {name="Beechwood Brown" ,id=103 , price = 1000 },
                {name="Sienna Brown" ,id=104 , price = 1000 },
                {name="Saddle Brown", id=98 , price = 1000 },
                {name="Moss Brown" ,id=100 , price = 1000 },
                {name="Woodbeech Brown" ,id=102 , price = 1000 },
                {name="Straw Brown", id=99 , price = 1000 },
                {name="Sandy Brown" ,id=105 , price = 1000 },
                {name="Bleached Brown" ,id=106 , price = 1000 },
                {name="Schafter Purple", id=71 , price = 1000 },
                {name="Spinnaker Purple", id=72 , price = 1000 },
                {name="Midnight Purple" ,id=142 , price = 1000 },
                {name="Bright Purple" ,id=145 , price = 1000 },
                {name="Cream" ,id=107 , price = 1000 },
                {name="Ice White" ,id=111 , price = 1000 },
                {name="Frost White" ,id=112 , price = 1000 },
                {name="Black", id=12 , price = 1000 },
                {name="Gray", id=13 , price = 1000 },
                {name="Light Gray", id=14 , price = 1000 },
                {name="Ice White" ,id=131 , price = 1000 },
                {name="Blue", id=83 , price = 1000 },
                {name="Dark Blue", id=82 , price = 1000 },
                {name="Midnight Blue", id=84 , price = 1000 },
                {name="Midnight Purple" ,id=149 , price = 1000 },
                {name="Schafter Purple" ,id=148 , price = 1000 },
                {name="Red", id=39 , price = 1000 },
                {name="Dark Red", id=40 , price = 1000 },
                {name="Orange", id=41 , price = 1000 },
                {name="Yellow", id=42 , price = 1000 },
                {name="Lime Green", id=55 , price = 1000 },
                {name="Green" ,id=128 , price = 1000 },
                {name="Forest Green" ,id=151 , price = 1000 },
                {name="Foliage Green" ,id=155 , price = 1000 },
                {name="Olive Darb" ,id=152 , price = 1000 },
                {name="Dark Earth" ,id=153 , price = 1000 },
                {name="Desert Tan" ,id=154 , price = 1000 },
                {name="Brushed Steel" ,id=117 , price = 1000 },
                {name="Brushed Black Steel" ,id=118 , price = 1000 },
                {name="Brushed Aluminum" ,id=119 , price = 1000 },
                {name="Pure Gol" ,id=158 , price = 1000 },
                {name="Brushed Gold" ,id=159 , price = 1000 },
            }
        },
        interior = {
            name = 'Interior', id = 5,
            items = {
                { name="Black", id=0 ,price= 1000},
                { name="Carbon Black", id=14, price= 1000},
                { name="Graphite",id=1 ,price= 1000},
                { name="Anhracite Black", id=11 ,price= 1000},
                { name="Black Steel" ,id=2, price= 1000},
                { name="Dark Steel", id=3, price= 1000},
                { name="Silver" ,id=4 ,price= 1000},
                { name="Bluish Silver", id=5, price= 1000},
                { name="Rolled Steel", id=6, price= 1000},
                { name="Shadow Silver", id=7, price= 1000},
                { name="Stone Silver", id=8, price= 1000},
                {name="Midnight Silver", id=9, price= 1000},
                {name="Cast Iron Silver" ,id=10, price= 1000},
                {name="Red", id="27", price= 1000},
                {name="Torino Red", id=28,price= 1000},
                {name="Formula Red" ,id=29 , price = 1000 },
                {name="Lava Red", id=150 , price = 1000 },
                {name="Blaze Red" ,id=30 , price = 1000 },
                {name="Grace Red" ,id=31 , price = 1000 },
                {name="Garnet Red" ,id=32 , price = 1000 },
                {name="Sunset Red" ,id=33 , price = 1000 },
                {name="Cabernet Red", id=34 , price = 1000 },
                {name="Wine Red" ,id=143 , price = 1000 },
                {name="Candy Red", id=35 , price = 1000 },
                {name="Hot Pink" ,id=135 , price = 1000 },
                {name="Pfsiter Pink" ,id=137 , price = 1000 },
                {name="Salmon Pink" ,id=136 , price = 1000 },
                {name="Sunrise Orange", id=36 , price = 1000 },
                {name="Orange", id=38 , price = 1000 },
                {name="Bright Orange" ,id=138 , price = 1000 },
                {name="Gold", id=99 , price = 1000 },
                {name="Bronze", id=90 , price = 1000 },
                {name="Yellow", id=88 , price = 1000 },
                {name="Race Yellow", id=89 , price = 1000 },
                {name="Dew Yellow", id=91 , price = 1000 },
                {name="Dark Green", id=49 , price = 1000 },
                {name="Racing Green", id=50 , price = 1000 },
                {name="Sea Green", id=51 , price = 1000 },
                {name="Olive Green", id=52 , price = 1000 },
                {name="Bright Green", id=53 , price = 1000 },
                {name="Gasoline Green", id=54 , price = 1000 },
                {name="Lime Green", id=92 , price = 1000 },
                {name="Midnight Blue" ,id=141 , price = 1000 },
                {name="Galaxy Blue", id=61 , price = 1000 },
                {name="Dark Blue", id=62 , price = 1000 },
                {name="Saxon Blue", id=63 , price = 1000 },
                {name="Blue", id=64 , price = 1000 },
                {name="Mariner Blue", id=65 , price = 1000 },
                {name="Harbor Blue", id=66 , price = 1000 },
                {name="Diamond Blue", id=67 , price = 1000 },
                {name="Surf Blue", id=68 , price = 1000 },
                {name="Nautical Blue", id=69 , price = 1000 },
                {name="Racing Blue", id=73 , price = 1000 },
                {name="Ultra Blue", id=70 , price = 1000 },
                {name="Light Blue", id=74 , price = 1000 },
                {name="Chocolate Brown", id=96 , price = 1000 },
                {name="Bison Brown" ,id=101 , price = 1000 },
                {name="Creeen Brown", id=95 , price = 1000 },
                {name="Feltzer Brown", id=94 , price = 1000 },
                {name="Maple Brow", id=97 , price = 1000 },
                {name="Beechwood Brown" ,id=103 , price = 1000 },
                {name="Sienna Brown" ,id=104 , price = 1000 },
                {name="Saddle Brown", id=98 , price = 1000 },
                {name="Moss Brown" ,id=100 , price = 1000 },
                {name="Woodbeech Brown" ,id=102 , price = 1000 },
                {name="Straw Brown", id=99 , price = 1000 },
                {name="Sandy Brown" ,id=105 , price = 1000 },
                {name="Bleached Brown" ,id=106 , price = 1000 },
                {name="Schafter Purple", id=71 , price = 1000 },
                {name="Spinnaker Purple", id=72 , price = 1000 },
                {name="Midnight Purple" ,id=142 , price = 1000 },
                {name="Bright Purple" ,id=145 , price = 1000 },
                {name="Cream" ,id=107 , price = 1000 },
                {name="Ice White" ,id=111 , price = 1000 },
                {name="Frost White" ,id=112 , price = 1000 },
                {name="Black", id=12 , price = 1000 },
                {name="Gray", id=13 , price = 1000 },
                {name="Light Gray", id=14 , price = 1000 },
                {name="Ice White" ,id=131 , price = 1000 },
                {name="Blue", id=83 , price = 1000 },
                {name="Dark Blue", id=82 , price = 1000 },
                {name="Midnight Blue", id=84 , price = 1000 },
                {name="Midnight Purple" ,id=149 , price = 1000 },
                {name="Schafter Purple" ,id=148 , price = 1000 },
                {name="Red", id=39 , price = 1000 },
                {name="Dark Red", id=40 , price = 1000 },
                {name="Orange", id=41 , price = 1000 },
                {name="Yellow", id=42 , price = 1000 },
                {name="Lime Green", id=55 , price = 1000 },
                {name="Green" ,id=128 , price = 1000 },
                {name="Forest Green" ,id=151 , price = 1000 },
                {name="Foliage Green" ,id=155 , price = 1000 },
                {name="Olive Darb" ,id=152 , price = 1000 },
                {name="Dark Earth" ,id=153 , price = 1000 },
                {name="Desert Tan" ,id=154 , price = 1000 },
                {name="Brushed Steel" ,id=117 , price = 1000 },
                {name="Brushed Black Steel" ,id=118 , price = 1000 },
                {name="Brushed Aluminum" ,id=119 , price = 1000 },
                {name="Pure Gol" ,id=158 , price = 1000 },
                {name="Brushed Gold" ,id=159 , price = 1000 },
            }
        },
        material = {
            name = 'Material', id = 14,
                items = {
                    {name = 'Normal', id = 0, price = 100},
                    {name = 'Metallic', id = 1,price = 1000},
                    {name = 'Metal',  id = 4, price = 5000},
                    {name = 'Matte', id = 3, price = 3000,},
                    {name = 'Chrome', id = 5, price = 4000},
                },
        },
        pearl = {
            name = 'Pearl', id = 2,
            items = {
                { name="Black", id=0 ,price= 1000},
                { name="Carbon Black", id=14, price= 1000},
                { name="Graphite",id=1 ,price= 1000},
                { name="Anhracite Black", id=11 ,price= 1000},
                { name="Black Steel" ,id=2, price= 1000},
                { name="Dark Steel", id=3, price= 1000},
                { name="Silver" ,id=4 ,price= 1000},
                { name="Bluish Silver", id=5, price= 1000},
                { name="Rolled Steel", id=6, price= 1000},
                { name="Shadow Silver", id=7, price= 1000},
                { name="Stone Silver", id=8, price= 1000},
                {name="Midnight Silver", id=9, price= 1000},
                {name="Cast Iron Silver" ,id=10, price= 1000},
                {name="Red", id="27", price= 1000},
                {name="Torino Red", id=28,price= 1000},
                {name="Formula Red" ,id=29 , price = 1000 },
                {name="Lava Red", id=150 , price = 1000 },
                {name="Blaze Red" ,id=30 , price = 1000 },
                {name="Grace Red" ,id=31 , price = 1000 },
                {name="Garnet Red" ,id=32 , price = 1000 },
                {name="Sunset Red" ,id=33 , price = 1000 },
                {name="Cabernet Red", id=34 , price = 1000 },
                {name="Wine Red" ,id=143 , price = 1000 },
                {name="Candy Red", id=35 , price = 1000 },
                {name="Hot Pink" ,id=135 , price = 1000 },
                {name="Pfsiter Pink" ,id=137 , price = 1000 },
                {name="Salmon Pink" ,id=136 , price = 1000 },
                {name="Sunrise Orange", id=36 , price = 1000 },
                {name="Orange", id=38 , price = 1000 },
                {name="Bright Orange" ,id=138 , price = 1000 },
                {name="Gold", id=99 , price = 1000 },
                {name="Bronze", id=90 , price = 1000 },
                {name="Yellow", id=88 , price = 1000 },
                {name="Race Yellow", id=89 , price = 1000 },
                {name="Dew Yellow", id=91 , price = 1000 },
                {name="Dark Green", id=49 , price = 1000 },
                {name="Racing Green", id=50 , price = 1000 },
                {name="Sea Green", id=51 , price = 1000 },
                {name="Olive Green", id=52 , price = 1000 },
                {name="Bright Green", id=53 , price = 1000 },
                {name="Gasoline Green", id=54 , price = 1000 },
                {name="Lime Green", id=92 , price = 1000 },
                {name="Midnight Blue" ,id=141 , price = 1000 },
                {name="Galaxy Blue", id=61 , price = 1000 },
                {name="Dark Blue", id=62 , price = 1000 },
                {name="Saxon Blue", id=63 , price = 1000 },
                {name="Blue", id=64 , price = 1000 },
                {name="Mariner Blue", id=65 , price = 1000 },
                {name="Harbor Blue", id=66 , price = 1000 },
                {name="Diamond Blue", id=67 , price = 1000 },
                {name="Surf Blue", id=68 , price = 1000 },
                {name="Nautical Blue", id=69 , price = 1000 },
                {name="Racing Blue", id=73 , price = 1000 },
                {name="Ultra Blue", id=70 , price = 1000 },
                {name="Light Blue", id=74 , price = 1000 },
                {name="Chocolate Brown", id=96 , price = 1000 },
                {name="Bison Brown" ,id=101 , price = 1000 },
                {name="Creeen Brown", id=95 , price = 1000 },
                {name="Feltzer Brown", id=94 , price = 1000 },
                {name="Maple Brow", id=97 , price = 1000 },
                {name="Beechwood Brown" ,id=103 , price = 1000 },
                {name="Sienna Brown" ,id=104 , price = 1000 },
                {name="Saddle Brown", id=98 , price = 1000 },
                {name="Moss Brown" ,id=100 , price = 1000 },
                {name="Woodbeech Brown" ,id=102 , price = 1000 },
                {name="Straw Brown", id=99 , price = 1000 },
                {name="Sandy Brown" ,id=105 , price = 1000 },
                {name="Bleached Brown" ,id=106 , price = 1000 },
                {name="Schafter Purple", id=71 , price = 1000 },
                {name="Spinnaker Purple", id=72 , price = 1000 },
                {name="Midnight Purple" ,id=142 , price = 1000 },
                {name="Bright Purple" ,id=145 , price = 1000 },
                {name="Cream" ,id=107 , price = 1000 },
                {name="Ice White" ,id=111 , price = 1000 },
                {name="Frost White" ,id=112 , price = 1000 },
                {name="Black", id=12 , price = 1000 },
                {name="Gray", id=13 , price = 1000 },
                {name="Light Gray", id=14 , price = 1000 },
                {name="Ice White" ,id=131 , price = 1000 },
                {name="Blue", id=83 , price = 1000 },
                {name="Dark Blue", id=82 , price = 1000 },
                {name="Midnight Blue", id=84 , price = 1000 },
                {name="Midnight Purple" ,id=149 , price = 1000 },
                {name="Schafter Purple" ,id=148 , price = 1000 },
                {name="Red", id=39 , price = 1000 },
                {name="Dark Red", id=40 , price = 1000 },
                {name="Orange", id=41 , price = 1000 },
                {name="Yellow", id=42 , price = 1000 },
                {name="Lime Green", id=55 , price = 1000 },
                {name="Green" ,id=128 , price = 1000 },
                {name="Forest Green" ,id=151 , price = 1000 },
                {name="Foliage Green" ,id=155 , price = 1000 },
                {name="Olive Darb" ,id=152 , price = 1000 },
                {name="Dark Earth" ,id=153 , price = 1000 },
                {name="Desert Tan" ,id=154 , price = 1000 },
                {name="Brushed Steel" ,id=117 , price = 1000 },
                {name="Brushed Black Steel" ,id=118 , price = 1000 },
                {name="Brushed Aluminum" ,id=119 , price = 1000 },
                {name="Pure Gol" ,id=158 , price = 1000 },
                {name="Brushed Gold" ,id=159 , price = 1000 },
            }
        },
    }
}
