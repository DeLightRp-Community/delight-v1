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
                payment = 250
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
                payment = 700
            },
			['1'] = {
                name = "Cadet",
                payment = 1000
            },
			['2'] = {
                name = "Solo Cadet",
                payment = 1100
            },
			['3'] = {
                name = "Officer",
                payment = 1150
            },
			['4'] = {
                name = "Senior Officer",
                payment = 1200
            },
			['5'] = {
                name = "Corporal",
                payment = 1275
            },
			['6'] = {
                name = "Sergeant",
                payment = 1350
            },
			['7'] = {
                name = "Sergeant O",
                payment = 1500
            },
			['8'] = {
                name = "Lieutenant",
                payment = 1700
            },
			['9'] = {
                name = "Captain",
                payment = 1800
            },
			['10'] = {
                name = "Ast. Chief",
				isboss = true,
                payment = 1900
            },
			['11'] = {
                name = "Chief of Police",
				isboss = true,
                payment = 2000
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
                payment = 700
            },
			['1'] = {
                name = "Trainee",
                payment = 1000
            },
			['2'] = {
                name = "EMT",
                payment = 1100
            },
			['3'] = {
                name = "Paramedic",
                payment = 1200
            },
			['4'] = {
                name = "FTO",
                payment = 1400
            },
			['5'] = {
                name = "Lieutenant",
                payment = 1600
            },
			['6'] = {
                name = "Captain",
                payment = 1800
            },
			['7'] = {
                name = "EMS Chief",
				isboss = true,
                payment = 2000
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
                payment = 700
            },
			['1'] = {
                name = "House Sales",
                payment = 1200
            },
			['2'] = {
                name = "Business Sales",
                payment = 1300
            },
			['3'] = {
                name = "Broker",
                payment = 1400
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 1500
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
                payment = 700
            },
			['1'] = {
                name = "Driver",
                payment = 1000
            },
			['2'] = {
                name = "Event Driver",
                payment = 1100
            },
			['3'] = {
                name = "Sales",
                payment = 1150
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 1300
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
                payment = 700
            },
		},
	},
    ['shenails'] = {
		label = 'She Nail',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'nailer',
                payment = 700
            },
		},
	},
    ['sydpawn'] = {
		label = 'PawnShop',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 700
            },
            ['1'] = {
                name = "Trainee",
                payment = 1000
            },
			['2'] = {
                name = "Employee",
                payment = 1100
            },
			['3'] = {
                name = "Trader",
                payment = 1200
            },
			['4'] = {
                name = "Manager",
                payment = 1250
            },
			['5'] = {
                name = "CEO",
				isboss = true,
                payment = 1300
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
                payment = 700
            },
			['1'] = {
                name = "Showroom Sales",
                payment = 1000
            },
			['2'] = {
                name = "Business Sales",
                payment = 1150
            },
			['3'] = {
                name = "Finance",
                payment = 1250
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 1350
            },
        },
	},
    ['sandersmotor'] = {
		label = 'Sanders Motor',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 700
            },
			['1'] = {
                name = "Showroom Sales",
                payment = 1000
            },
			['2'] = {
                name = "Business Sales",
                payment = 1150
            },
			['3'] = {
                name = "Finance",
                payment = 1250
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 1350
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
                payment = 700
            },
			['1'] = {
                name = "Novice",
                payment = 1000
            },
			['2'] = {
                name = "Experienced",
                payment = 1150
            },
			['3'] = {
                name = "Advanced",
                payment = 1250
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 1300
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
                payment = 1500
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
                payment = 1350
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
                payment = 1300
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
                payment = 700
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
                payment = 700
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
                payment = 700
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
                payment = 700
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
                payment = 700
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
                payment = 700
            },
        },
    },

    ['bestbuds'] = {
		label = 'bestbuds',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'bestbuds',
                payment = 700
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
                payment = 700
            },
			['1'] = {
                name = "Employee",
                payment = 1000
            },
			['2'] = {
                name = "Burger Flipper",
                payment = 1100
            },
			['3'] = {
                name = "Manager",
                payment = 1150
            },
			['4'] = {
                name = "CEO",
				isboss = true,
                payment = 1300
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
                payment = 1000
            },
            ['1'] = {
                name = 'Manger',
                payment = 1300
            },
        },
	},
	["uwu"] = { --  UwU Cafe Job
		label = "UwU Cafe",
		defaultDuty = true,
        offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Trainee",
                payment = 700
            },
            ['1'] = {
                name = "Cashier",
                payment = 1000
            },
			['2'] = {
                name = "Cook",
                payment = 1100
            },
			['3'] = {
                name = "Manager",
				isboss = true,
                payment = 1150
            },
			['4'] = {
                name = "Store Owner",
				isboss = true,
                payment = 1300
            },
        },
	},
	["nightclub"] = {
		label = "Galaxy",
		defaultDuty = true,
        offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Trainee",
                payment = 700
            },
			['1'] = {
                name = 'DJ',
                payment = 1000
            },
            ['2'] = {
                name = 'Bartender',
                payment = 1100
            },
			['3'] = {
                name = 'Security',
                payment = 1150
            },
			['4'] = {
                name = 'Assisstant',
                payment = 1200
            },
            ['5'] = {
                name = 'Galaxy Club Owner',
				isboss = true,
                payment = 1300	
            },
        },
	},
}