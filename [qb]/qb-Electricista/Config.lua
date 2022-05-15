Config = {}
Config.distance = 1.5
Config.Car = "comet2"
Config.Plate = "ELECTRIC"
Config.framework = "qbcore" -- Esx or qbcore, easy to adapt to your framework.

Config.Pay = math.random(1000,4000)
Config.Account = 'bank' --This is where the money is go.

Config.postes = {
	{prop = 'prop_streetlight_01', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0, angularOffset = 180.0},
	{prop = 'prop_streetlight_01b', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0, angularOffset = 180.0},
	{prop = 'prop_streetlight_03b', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0, angularOffset = 180.0},
	{prop = 'prop_telegraph_01b', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0, angularOffset = 180.0},
}

Config.TiempoParaArreglar = 6  -- Segundos

Config.Locales = {
	iniciarrepa = "Press  ~b~Y~w~  TO START THE REPAIR",
	ponerescalera = "Press  ~b~Y~w~  TO STORE THE LADDER",
	sacarescalera = "Press  ~b~Y~w~  TO TAKE THE LADDER",
	espera = "Waiting ~b~ ", -- ..seconds 
	tofinish = "~w~ seconds to finish repairing.",
	startjob = "Press  ~b~E~w~  TO START WORK",
	jobiniciado = "Work started, go to a parking lot.",
	endjob = "Press  ~b~E~w~  TO FINISH THE JOB	",
	jobterminado = "You finished your work, I'll wait for you another day!",
	saveescalera = "Press  ~b~E~w~  TO STORE THE LADDER",
	cogerescala = "Press  ~b~E~w~  TO TAKE THE LADDER"
}


--ESX CLOTHES--
--Clothes
Config.Clothes = {
    male = {
        ['tshirt_1'] = 0,  ['tshirt_2'] = 0,
        ['torso_1'] = 122,   ['torso_2'] = 0,
        ['arms'] = 1,  ['pants_1'] = 5,
    },
    female = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 4,   ['torso_2'] = 14,
        ['arms'] = 4,
        ['pants_1'] = 25,   ['pants_2'] = 1,
        ['shoes_1'] = 16,   ['shoes_2'] = 4,
    }
}

---qbcore clothes--

Config.Uniforms = {
	['male'] = {
		outfitData = {
			['t-shirt'] = {item = 15, texture = 0},
			['torso2']  = {item = 56, texture = 0},
			['arms']    = {item = 85, texture = 0},
			['pants']   = {item = 45, texture = 4},
			['shoes']   = {item = 42, texture = 2},
		}
	},
	['female'] = {
	 	outfitData = {
			['t-shirt'] = {item = 14, texture = 0},
			['torso2']  = {item = 22, texture = 0},
			['arms']    = {item = 85, texture = 0},
			['pants']   = {item = 47, texture = 4},
			['shoes']   = {item = 98, texture = 1},
	 	}
	},
}
