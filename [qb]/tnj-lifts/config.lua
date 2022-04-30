Config = {}

Config.UseLanguage = "en"                                                           -- Select the language you want to use in the script (the translation is at the end of the file)
Config.UseSoundEffect = true                                                        -- Only use this if you use InteractSound

Config.Elevators = {
    -- The following tags are not required! You can add them if you want
    -- Job = "jobname" -> Only player with this job can can go to the restricted floors
    -- Sound = "soundname" -> Use custom sound when player reaches the new floor | You can add your custom sound with .ogg extension in interactSound folder /client/html/sounds
    -- Simple example with restricted floors and custom sound
    ["Real Estates Lobby"] = {
        Name = "MazeBank",
        Floors = {
            [1] = {
                Label = "Main Lobby",
                FloorDesc = "Description for floor 2",
                Coords = vector3(-77.74, -826.28, 243.39),
                ExitHeading = "28.74"
            },
            [2] = {
                Label = "Maze Bank",
                FloorDesc = "Exit",
                Coords = vector3(-66.82, -802.64, 44.23),
                ExitHeading = "28.74"
            },
        }
    },
    ["diamonindustries"] = {
        Job = {"diamonindustries"},                                  -- Leave blank if you don't want to use Player Job
        Sound = "liftSoundBellRing",                                                -- Leave blank if you don't want to use Custom Sound
        Name = "Diamon Industries",
        Floors = {
            [1] = {
                Label = "Main Lobby",
                FloorDesc = "Diamon Industries Main Lobby",
                Restricted = true,                                                  -- Only players with defined job (Job = "") can change to this floor
                Coords = vector3(-73.98, -809.79, 243.39),
                ExitHeading = "28.74"
            },
            [2] = {
                Label = "Garage Floor",
                FloorDesc = "Diamon Industries Garage Lobby",
                Restricted = true,
                Coords = vector3(-84.65, -825.1, 36.03),
                ExitHeading = "297.06"
            },
            [3] = {
                Label = "Helipad",
                FloorDesc = "Roof for Helicopter Landings",
                Restricted = true,
                Coords = vector3(-74.99, -824.09, 321.31),
                ExitHeading = "28.74"
            },
            [4] = {
                Label = "Garage Room",
                FloorDesc = "Diamon Industries Garage Room",
                Restricted = true,
                Coords = vector3(-69.52, -827.95, 285.00),
                ExitHeading = "28.74"
            },
        }
    },
    ["casino"] = {
        Job = {""},                                  -- Leave blank if you don't want to use Player Job
        Sound = "liftSoundBellRing",                                                -- Leave blank if you don't want to use Custom Sound
        Name = "Diamond Casino",
        Floors = {
            [1] = {
                Label = "Casino Floor",
                FloorDesc = "Casino Floor",
                Restricted = false,
                Coords = vector3(960.4490, 43.2640, 71.7010),
                ExitHeading = "285.0"
            },
            [2] = {
                Label = "Hotel",
                FloorDesc = "Hotel Main Lobby",
                Restricted = false,                                                  -- Only players with defined job (Job = "") can change to this floor
                Coords = vector3(910.5739, -52.8315, 21.0001),
                ExitHeading = "135.0"
            },
            [3] = {
                Label = "Rooftop",
                FloorDesc = "Rooftop",
                Restricted = false,
                Coords = vector3(964.7076, 58.7363, 112.5530),
                ExitHeading = "60.0"
            },
        }
    },
    ["paletopd"] = {
        Job = {"police"},                                  -- Leave blank if you don't want to use Player Job
        Sound = "liftSoundBellRing",                                                -- Leave blank if you don't want to use Custom Sound
        Name = "Sheriff Paleto Bay",
        Floors = {
            [1] = {
                Label = "Main Floor",
                FloorDesc = "Main Lobby",
                Restricted = true,
                Coords = vector3(-450.15, 6010.48, 32.29),
                ExitHeading = "225.0"
            },
            [2] = {
                Label = "Bottom Floor",
                FloorDesc = "Cells and Processing",
                Restricted = false,                                                  -- Only players with defined job (Job = "") can change to this floor
                Coords = vector3(-450.03, 6010.28, 27.58),
                ExitHeading = "225.0"
            },
            [3] = {
                Label = "Top Floor",
                FloorDesc = "Offices and Armory // OUT OF SERVICE",
                Restricted = true,
                Coords = vector3(-448.49, 6008.49, 37.0),
                ExitHeading = "225.0"
            },
        }
    },
    ["pillbox"] = {
        Job = {"police", "ambulance"},                                  -- Leave blank if you don't want to use Player Job
        Sound = "liftSoundBellRing",                                                -- Leave blank if you don't want to use Custom Sound
        Name = "Pillbox Medical",
        Floors = {
            [1] = {
                Label = "Main Floor",
                FloorDesc = "Main Lobby",
                Restricted = true,
                Coords = vector3(327.45, -603.31, 43.28),
                ExitHeading = "335.0"
            },
            [2] = {
                Label = "Bottom Floor",
                FloorDesc = "Bottom Enterance and Lobby",
                Restricted = true,                                                  -- Only players with defined job (Job = "") can change to this floor
                Coords = vector3(344.94, -586.47, 28.8),
                ExitHeading = "245.0"
            },
            [3] = {
                Label = "Rooftop",
                FloorDesc = "Helipad",
                Restricted = true,
                Coords = vector3(339.51, -584.3, 74.16),
                ExitHeading = "245.0"
            },
        }
    },
    -- Simple example without custom sound and without restricted floors
    ["noRestricted"] = {
        Name = "Without Sound & Restricted Floor",
        Floors = {
            [1] = {
                Label = "Floor 2",
                FloorDesc = "Description for floor 2",
                Coords = vector3(-1078.34, -254.08, 44.02),
                ExitHeading = "28.74"
            },
            [2] = {
                Label = "Floor 1",
                FloorDesc = "Description for floor 1",
                Coords = vector3(-1078.34, -254.08, 37.76),
                ExitHeading = "28.74"
            },
        }
    },
}

Config.Language = {
    ["en"] = {
        Call = "~g~E~w~ - Call Lift",
        Waiting = "Waiting for Lift...",
        Restricted = "Restricted floor!",
        CurrentFloor = "Current floor: "
    },
    ["pt"] = {
        Call = "~g~E~w~ - Chamar elevador",
        Waiting = "À espera do Elevador...",
        Restricted = "Piso restrito!",
        CurrentFloor = "Piso Atual: "
    }
}
