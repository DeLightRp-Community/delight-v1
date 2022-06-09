Config = {}

Config.DefaultVolume = 0.1 -- Accepted values are 0.01 - 1

Config.Locations = {
    ['vanilla'] = {
        ['job'] = 'records', -- Required job to use booth
        ['radius'] = 23, -- The radius of the sound from the booth
        ['coords'] = vector3(-842.05, -719.09, 28.28), -- Where the booth is located
        ['playing'] = false
    }
}
