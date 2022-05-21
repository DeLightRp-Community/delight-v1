Config = {}

Config.TaxRate = 0.10 -- percentage
Config.StartupFee = 750000 -- Minimum required to start business
Config.Cooldown = 24 -- hours

Config.animDict = 'anim@amb@business@cfm@cfm_drying_notes@' -- https://alexguirre.github.io/animations-list/
Config.anim = 'loading_v3_worker'
Config.animTime = 5000 -- milliseconds

Config.Locations = {
    ['cityhall'] = { -- Where you can register/invest/sell
        coords = vector3(-1285.59, -567.0, 31.71),
        heading = 305.2,
        length = 1,
        width = 1,
        name = "regbus",
        debugPoly = false
    },
    ['washing'] = { -- Where you wash the money
        coords = vector3(4918.41, -5274.67, 5.65),
        heading = 122.49,
        length = 3,
        width = 16,
        name = "moneywash",
        debugPoly = false
    }
}