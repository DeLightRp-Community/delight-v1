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
            -- LSPD Ranks : start
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
                name = "Sergeant II",
                payment = 1350
            },
            ['7'] = {
                name = "Sergeant I",
                payment = 1400
            },
            ['8'] = {
                name = "Lieutenant",
                payment = 1500
            },
            ['9'] = {
                name = "Captain",
                payment = 1600
            },
            ['10'] = {
                name = "Assistant Chief",
                payment = 1700
            },
            ['11'] = {
                name = "Chief of Police",
                isboss = true,
                payment = 1800
            },
            -- LSPD Ranks : end
            -- BCSO Ranks : start
            ['12'] = {
                name = "Cadet (BCSO)",
                payment = 1000
            },
            ['13'] = {
                name = "Solo Cadet (BCSO)",
                payment = 1100
            },
            ['14'] = {
                name = "Deputy",
                payment = 1150
            },
            ['15'] = {
                name = "Senior Deputy",
                payment = 1200
            },
            ['16'] = {
                name = "Corporal (BCSO)",
                payment = 1200
            },
            ['17'] = {
                name = "Sergeant II (BCSO)",
                payment = 1350
            },
            ['18'] = {
                name = "Sergeant I (BCSO)",
                payment = 1400
            },
            ['19'] = {
                name = "Lieutenant (BCSO)",
                payment = 1500
            },
            ['20'] = {
                name = "Captain (BCSO)",
                payment = 1600,
                isboss = true,
            },
            ['21'] = {
                name = "Undersheriff",
                payment = 1700,
                isboss = true,
            },
            ['22'] = {
                name = "Sheriff",
                payment = 1800,
                isboss = true,
            },
            -- BCSO Ranks : end
            -- Ranger Ranks : start
            ['23'] = {
                name = "Junior Ranger",
                payment = 1100
            },
            ['24'] = {
                name = "Ranger",
                payment = 1150
            },
            ['25'] = {
                name = "Senior Ranger",
                payment = 1200
            },
            ['26'] = {
                name = "Corporal Ranger",
                payment = 1275
            },
            ['27'] = {
                name = "Sergeant II Ranger",
                payment = 1350
            },
            ['28'] = {
                name = "Sergeant I Ranger",
                payment = 1400
            },
            ['29'] = {
                name = "Lieutenant Ranger",
                payment = 1500
            },
            ['30'] = {
                name = "Assistant Game Warden",
                payment = 1600,
                isboss = true,
            },
            ['31'] = {
                name = "Game Warden",
                payment = 1700,
                isboss = true,
            },
            -- Ranger Ranks : end
            -- Trooper Ranks : start
            ['32'] = {
                name = "Senior Trooper",
                payment = 1200,
            },
            ['33'] = {
                name = "Corporal Trooper",
                payment = 1275,
            },
            ['34'] = {
                name = "Sergeant Trooper II",
                payment = 1350,
            },
            ['35'] = {
                name = "Sergeant Trooper I",
                payment = 1400,
            },
            ['36'] = {
                name = "Lieutenant Trooper",
                payment = 1500,
            },
            ['37'] = {
                name = "Second In Command (Boss)",
                isboss = true,
                payment = 1600,
            },
            ['38'] = {
                name = "Chief of SASP",
                isboss = true,
                payment = 1700,
            },
            -- Trooper Ranks : END
            ['39'] = {
                name = "Commissioner",
                isboss = true,
                payment = 2000,
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Trainee",
                payment = 1300
            },
			['1'] = {
                name = "EMS",
                payment = 1500
            },
			['2'] = {
                name = "Paramedic",
                payment = 1600
            },
			['3'] = {
                name = "Paramedic FTO",
                payment = 1700
            },
			['4'] = {
                name = "Resident",
                payment = 1900
            },
			['5'] = {
                name = "General Practitioner",
				isboss = true,
                payment = 2100
            },
			['6'] = {
                name = "Surgeon",
				-- isboss = true,
                payment = 2300
            },
            ['7'] = {
                name = "Commend Team",
				-- isboss = true,
                payment = 2300
            },
            ['8'] = {
                name = "Lieutenant",
				isboss = true,
                payment = 2300
            },

            ['9'] = {
                name = "Assistant Chief",
				isboss = true,
                payment = 2300
            },

			['10'] = {
                name = "Chief Of EMS",
				isboss = true,
                payment = 2500
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
                isboss = true,
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
    ['ottos'] = {
		label = 'Ottos Repair',
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
                payment = 400
            },
			['1'] = {
                name = "Employee",
                payment = 800
            },
			['2'] = {
                name = "Burger Flipper",
                payment = 1100
            },
			['3'] = {
                name = "Manager",
                isboss = true,
                payment = 1200
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
                name = 'Pizza Flipper',
                payment = 150
            },
            ['2'] = {
                name = 'Manger',
                isboss = true,
                payment = 300 
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
                payment = 200
            },
			['1'] = {
                name = 'Employee',
                payment = 400
            },
			['2'] = {
                name = 'Experienced',
                payment = 600
            },
			['3'] = {
                name = 'Advanced',
                payment = 800
            },
			['4'] = {
                name = 'Boss',
				isboss = true,
                payment = 1000
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