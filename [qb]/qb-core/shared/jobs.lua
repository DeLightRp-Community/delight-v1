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
				isboss = true,
                payment = 1600
            },
			['6'] = {
                name = "Captain",
				-- isboss = true,
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
                payment = 300
            },
			['1'] = {
                name = "House Sales",
                payment = 350
            },
			['2'] = {
                name = "Business Sales",
                payment = 400
            },
			['3'] = {
                name = "Broker",
                payment = 450
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 500
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
                payment = 300
            },
			['1'] = {
                name = "Driver",
                payment = 350
            },
			['2'] = {
                name = "Event Driver",
                payment = 400
            },
			['3'] = {
                name = "Sales",
                payment = 450
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 500
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
                payment = 400
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
                payment = 350
            },
		},
	},
    ['pawnshop'] = {
		label = 'PawnShop',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 300
            },
            ['1'] = {
                name = "Trainee",
                payment = 350
            },
			['2'] = {
                name = "Employee",
                payment = 400
            },
			['3'] = {
                name = "Trader",
                payment = 450
            },
			['4'] = {
                name = "Manager",
                payment = 475
            },
			['5'] = {
                name = "CEO",
				isboss = true,
                payment = 500
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
                payment = 300
            },
			['1'] = {
                name = "Showroom Sales",
                payment = 350
            },
			['2'] = {
                name = "Business Sales",
                payment = 400
            },
			['3'] = {
                name = "Finance",
                payment = 450
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 500
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
                payment = 300
            },
			['1'] = {
                name = "Showroom Sales",
                payment = 350
            },
			['2'] = {
                name = "Business Sales",
                payment = 400
            },
			['3'] = {
                name = "Finance",
                payment = 450
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 500
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
                payment = 300
            },
			['1'] = {
                name = "Novice",
                payment = 350
            },
			['2'] = {
                name = "Experienced",
                payment = 400
            },
			['3'] = {
                name = "Advanced",
                payment = 450
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 500
            },
        },
	},
    ['tuner'] = {
		label = 'Tuner',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 300
            },
			['1'] = {
                name = "Novice",
                payment = 350
            },
			['2'] = {
                name = "Experienced",
                payment = 400
            },
			['3'] = {
                name = "Advanced",
                payment = 450
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 500
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 700
            },
            ['1'] = {
                name = 'Lawyer',
                payment = 1000
            },
            ['2'] = {
                name = 'U.S Lawyer',
                payment = 1200
            },
            ['3'] = {
                name = 'Local Judge',
                payment = 1300
            },
            ['4'] = {
                name = 'U.S Judge',
                isboss = true,
                payment = 1400
            },
            ['5'] = {
                name = 'Chief Justice of U.S',
                isboss = true,
                payment = 1500
            },
        },
	},
	-- ['lawyer'] = {
	-- 	label = 'Law Firm',
	-- 	defaultDuty = true,
	-- 	offDutyPay = false,
	-- 	grades = {
    --         ['0'] = {
    --             name = 'Associate',
    --             payment = 500
    --         },
    --     },
	-- },
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Journalist',
                payment = 500
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
                payment = 500
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
                payment = 300
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
                payment = 300
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
                payment = 300
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
                payment = 300
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
                payment = 300
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
                payment = 300
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
                payment = 300
            },
			['1'] = {
                name = "Employee",
                payment = 350
            },
			['2'] = {
                name = "Burger Flipper",
                payment = 400
            },
			['3'] = {
                name = "Manager",
                isboss = true,
                payment = 450
            },
			['4'] = {
                name = "CEO",
				isboss = true,
                payment = 500
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
                payment = 500
            },
            ['1'] = {
                name = 'Manger',
                isboss = true,
                payment = 600
            },
        },
	},
    ['pizza'] = {
		label = 'Pizza Shop',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Employee',
                payment = 300
            },
            ['1'] = {
                name = 'Manger',
                isboss = true,
                payment = 500  
            },
        },
	},
    ['uwu'] = {
		label = 'UwU Cat Cafe',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Novice',
                payment = 300
            },
			['1'] = {
                name = 'Employee',
                payment = 350
            },
			['2'] = {
                name = 'Experienced',
                payment = 400
            },
			['3'] = {
                name = 'Advanced',
                payment = 450
            },
			['4'] = {
                name = 'Boss',
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
                name = "Trainee",
                payment = 300
            },
			['1'] = {
                name = 'DJ',
                payment = 350
            },
            ['2'] = {
                name = 'Bartender',
                payment = 400
            },
			['3'] = {
                name = 'Security',
                payment = 450
            },
			['4'] = {
                name = 'Assisstant',
                payment = 475
            },
            ['5'] = {
                name = 'Galaxy Club Owner',
				isboss = true,
                payment = 500	
            },
        },
	},
    ["records"] = {
        label = "Records",
        offDutyPay = false,
        defaultDuty = false,
        grades = {
            ['0'] = {
                name = 'Worker',
                payment = 300,
            },
            ['1'] = {
                name = 'Vice Boss',
                payment = 400,
            },
            ['2'] = {
                name = 'Boss',
                isboss = true,
                payment = 500,
            },
        }
    },

    ["digitalden"] = {
        label = "Digital Den",
        offDutyPay = false,
        defaultDuty = true,
        grades = {
            ['0'] = {
                name = 'Newbie',
                payment = 300,
            },
            ['1'] = {
                name = 'Hacker',
                payment = 400,
            },
            ['2'] = {
                name = 'Boss',
                isboss = true,
                payment = 500,
            },
        }
    },
}