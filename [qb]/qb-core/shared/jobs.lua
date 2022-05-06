QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 10
            },
        },
	},
	['police'] = {
		label = 'Law Enforcement',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 55
            },
			['1'] = {
                name = "Cadet",
                payment = 80
            },
			['2'] = {
                name = "Solo Cadet",
                payment = 115
            },
			['3'] = {
                name = "Officer",
                payment = 165
            },
			['4'] = {
                name = "Senior Officer",
                payment = 255
            },
			['5'] = {
                name = "Corporal",
                payment = 345
            },
			['6'] = {
                name = "Sergeant",
                payment = 430
            },
			['7'] = {
                name = "Sergeant O",
                payment = 550
            },
			['8'] = {
                name = "Lieutenant",
                payment = 660
            },
			['9'] = {
                name = "Captain",
                payment = 775
            },
			['10'] = {
                name = "Ast. Chief",
				isboss = true,
                payment = 884
            },
			['11'] = {
                name = "Chief of Police",
				isboss = true,
                payment = 980
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 115
            },
			['1'] = {
                name = "Trainee",
                payment = 215
            },
			['2'] = {
                name = "EMT",
                payment = 315
            },
			['3'] = {
                name = "Paramedic",
                payment = 415
            },
			['4'] = {
                name = "FTO",
                payment = 515
            },
			['5'] = {
                name = "Lieutenant",
                payment = 615
            },
			['6'] = {
                name = "Captain",
                payment = 715
            },
			['7'] = {
                name = "EMS Chief",
				isboss = true,
                payment = 815
            },
        },
	},
	['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 50
            },
			['1'] = {
                name = "House Sales",
                payment = 75
            },
			['2'] = {
                name = "Business Sales",
                payment = 100
            },
			['3'] = {
                name = "Broker",
                payment = 125
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 150
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 90
            },
			['1'] = {
                name = "Driver",
                payment = 100
            },
			['2'] = {
                name = "Event Driver",
                payment = 120
            },
			['3'] = {
                name = "Sales",
                payment = 150
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 200
            },
        },
	},
    ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
		},
	},
    ['sydpawn'] = {
		label = 'PawnShop',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Trainee",
                payment = 0
            },
			['1'] = {
                name = "Employee",
                payment = 0
            },
			['2'] = {
                name = "Trader",
                payment = 0
            },
			['3'] = {
                name = "Manager",
                payment = 0
            },
			['4'] = {
                name = "CEO",
				isboss = true,
                payment = 0
            },
        },
	},
	['cardealer'] = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 100
            },
			['1'] = {
                name = "Showroom Sales",
                payment = 125
            },
			['2'] = {
                name = "Business Sales",
                payment = 150
            },
			['3'] = {
                name = "Finance",
                payment = 180
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 200
            },
        },
	},
	['mechanic'] = {
		label = 'Mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 100
            },
			['1'] = {
                name = "Novice",
                payment = 120
            },
			['2'] = {
                name = "Experienced",
                payment = 150
            },
			['3'] = {
                name = "Advanced",
                payment = 190
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 300
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Judge',
                payment = 100
            },
        },
	},
	['lawyer'] = {
		label = 'Law Firm',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 50
            },
        },
	},
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Journalist',
                payment = 50
            },
        },
	},
	['trucker'] = {
		label = 'Trucker',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['tow'] = {
		label = 'Towing',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['garbage'] = {
		label = 'Garbage',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Collector',
                payment = 50
            },
        },
	},
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Picker',
                payment = 50
            },
        },
	},
    ['ammuone'] = {
		label = 'Ammounation',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Owner',
                payment = 50
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Sales',
                payment = 50
            },
        },
	},
    ['lumberjack'] = {
		label = 'LumberJack',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Logger',
                payment = 50
            },
        },
    },
    ["burgershot"] = {
		label = "Burgershot Employee",
		defaultDuty = true,
        offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Trainee",
                payment = 60
            },
			['1'] = {
                name = "Employee",
                payment = 90
            },
			['2'] = {
                name = "Burger Flipper",
                payment = 120
            },
			['3'] = {
                name = "Manager",
                payment = 150
            },
			['4'] = {
                name = "CEO",
				isboss = true,
                payment = 200
            },
        },
	},
    ['banker'] = {
		label = 'Pacific Bank',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Employee',
                payment = 150
            },
            ['1'] = {
                name = 'Manger',
                payment = 250
            },
        },
	},
	["uwu"] = { --  UwU Cafe Job
		label = "UwU Cafe",
		defaultDuty = true,
        offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Cashier",
                payment = 100
            },
			['1'] = {
                name = "Cook",
                payment = 250
            },
			['2'] = {
                name = "Manager",
				isboss = true,
                payment = 350
            },
			['3'] = {
                name = "Store Owner",
				isboss = true,
                payment = 500
            },
        },
	},
	["nightclub"] = {
		label = "Galaxy",
		defaultDuty = true,
        offDutyPay = false,
		grades = {
			['0'] = {
                name = 'DJ',
                payment = 60
            },
            ['1'] = {
                name = 'Bartender',
                payment = 50
            },
			['2'] = {
                name = 'Security',
                payment = 70
            },
			['3'] = {
                name = 'Assisstant',
                payment = 90
            },
            ['4'] = {
                name = 'Galaxy Club Owner',
				isboss = true,
                payment = 110	
            },
        },
	},
}