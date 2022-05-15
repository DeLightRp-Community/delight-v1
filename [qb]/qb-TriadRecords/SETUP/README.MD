█▀▀ █░░ █▀▀█ █░░█ █▀▀▄ █▀▀▄ █▀▀ ▀█░█▀ █▀▀ █░░ █▀▀█ █▀▀█ █▀▄▀█ █▀▀ █▀▀▄ ▀▀█▀▀
█░░ █░░ █░░█ █░░█ █░░█ █░░█ █▀▀ ░█▄█░ █▀▀ █░░ █░░█ █░░█ █░▀░█ █▀▀ █░░█ ░░█░░
▀▀▀ ▀▀▀ ▀▀▀▀ ░▀▀▀ ▀▀▀░ ▀▀▀░ ▀▀▀ ░░▀░░ ▀▀▀ ▀▀▀ ▀▀▀▀ █▀▀▀ ▀░░░▀ ▀▀▀ ▀░░▀ ░░▀░░

█▀▀█ █▀▀ █▀▀ █▀▀█ █▀▀█ █▀▀▄ █▀▀   ░░▀ █▀▀█ █▀▀▄
█▄▄▀ █▀▀ █░░ █░░█ █▄▄▀ █░░█ ▀▀█   ░░█ █░░█ █▀▀▄
▀░▀▀ ▀▀▀ ▀▀▀ ▀▀▀▀ ▀░▀▀ ▀▀▀░ ▀▀▀   █▄█ ▀▀▀▀ ▀▀▀░

Thank you for your purchase please follow the steps before running the script:

1 - Add The boss menu:
go to the "qb-bossmenu" script then "config.lua" and add this under Config.Job :     ['records'] = vector3(-816.4669, -700.5065, 32.140789)

Video: https://streamable.com/hzd501

2 - Add items:
go to "qb-core" then shared folder > items.lua and add this : 

		--Records Job
		['rlime'] 						 = {['name'] = 'rlime', 			 	  	  	['label'] = 'Lime Slice', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rlime.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = {accept = {'rbeer'}, reward = 'rglasslime', anim = {['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@', ['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Adding Lime Slice', ['timeOut'] = 2000,}},   ['description'] = 'Nice To Add To A Drink'},
		['rlemon'] 						 = {['name'] = 'rlemon', 			 	  	  	['label'] = 'lemon Slice', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rlemon.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = {accept = {'rbeer'}, reward = 'rglasslemon', anim = {['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@', ['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Adding Lemon Slice', ['timeOut'] = 2000,}},   ['description'] = 'Nice To Add To A Drink'},
		['rkiwi'] 						 = {['name'] = 'rkiwi', 			 	  	  	['label'] = 'Kiwi Slice',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rkiwi.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	  ['combinable'] = {accept = {'rbeer'}, reward = 'rglasskiwi', anim = {['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@', ['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Adding Kiwi Slice', ['timeOut'] = 2000,}},   ['description'] = 'Nice To Add To A Drink'},
		['rorange'] 					 = {['name'] = 'rorange', 			 	  	  	['label'] = 'Orange Slice',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rorange.png', 				['unique'] = false, 	['useable'] = false,	['shouldClose'] = true,   ['combinable'] = {accept = {'rbeer'}, reward = 'rglassorange', anim = {['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@', ['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Adding Orange Slice', ['timeOut'] = 2000,}},   ['description'] = 'Nice To Add To A Drink'},
		['rpineapple'] 					 = {['name'] = 'rpineapple', 			 	  	['label'] = 'Pineapple Slice',			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rpineapple.png',			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = {accept = {'rbeer'}, reward = 'rglasspineapple', anim = {['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@', ['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Adding Pineapple Slice', ['timeOut'] = 2000,}},   ['description'] = 'Nice To Add To A Drink'},
		['rglass'] 					 	 = {['name'] = 'rglass', 			 	  		['label'] = 'Glass Cup',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rglass.png',				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Cup For Drinks'},
		['rglasslime'] 					 = {['name'] = 'rglasslime', 			 	  	['label'] = 'Drink With Lime',			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rglasslime.png',			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Beer With Lime'},
		['rglasslemon'] 				 = {['name'] = 'rglasslemon', 			 	  	['label'] = 'Drink With Lemon',			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rglasslemon.png',			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Beer With Lemon'},
		['rglasskiwi'] 				 	 = {['name'] = 'rglasskiwi', 			 	  	['label'] = 'Drink With Kiwi',			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rglasskiwi.png',			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Beer With Kiwi'},
		['rglassorange'] 				 = {['name'] = 'rglassorange', 			 	  	['label'] = 'Drink With Orange',		['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rglassorange.png',			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Beer With Orange'},
		['rglasspineapple'] 			 = {['name'] = 'rglasspineapple', 			 	['label'] = 'Drink With Pineapple',		['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rglasspineapple.png',		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Beer With Pineapple'},
		['rsmallglass'] 			 	 = {['name'] = 'rsmallglass', 			 		['label'] = 'Small Glass Cup',			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rsmallglass.png',			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Cup For Drinks'},
		['rabsinthe'] 			 	 	 = {['name'] = 'rabsinthe', 			 		['label'] = 'Absinthe',					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rabsintheglass.png',		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Fill With Absinthe'},
		['rglasstype2'] 			 	 = {['name'] = 'rglasstype2', 			 		['label'] = 'Glass Cup Absinthe',		['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rglasstype2.png',			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Cup For Absinthe'},
		['rpinksakebottle'] 			 = {['name'] = 'rpinksakebottle', 			 	['label'] = 'Pink Sake',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rpinksake.png',			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Pink Sake'},
		['rwhitesakebottle'] 			 = {['name'] = 'rwhitesakebottle', 			 	['label'] = 'White Sake',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rwhitesake.png',			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'White Sake'},
		['rsakebottle'] 			 	 = {['name'] = 'rsakebottle', 			 		['label'] = 'Sake',						['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rsake.png',				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Regular Sake'},
		['rgoldsakebottle'] 			 = {['name'] = 'rgoldsakebottle', 			 	['label'] = 'Gold Sake',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rgoldsake.png',			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Golden Sake'},
		['rsamuraisakebottle'] 			 = {['name'] = 'rsamuraisakebottle', 			['label'] = 'Samurai Sake',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rsamuraisake.png',			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Samurai Sake'},
		['rbottlewine'] 			 	 = {['name'] = 'rbottlewine', 			 		['label'] = 'Red Wine',					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rbottlewine.png',			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Red Wine Bottle'},
		['rwhitewinebottle'] 			 = {['name'] = 'rwhitewinebottle', 			 	['label'] = 'White Wine',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rwhitewine.png',			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'White Wine Bottle'},
		['rwhiskeybottle'] 			 	 = {['name'] = 'rwhiskeybottle', 			 	['label'] = 'Whiskey Bottle',			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rwhiskeybottle.png',		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Whiskey Bottle'},
		['rabsinthebottle'] 			 = {['name'] = 'rabsinthebottle', 			 	['label'] = 'Absinthe Bottle',			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rabsinthebottle.png',		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Absinthe Bottle'},
		['rwineglass'] 			 	 	 = {['name'] = 'rwineglass', 			 		['label'] = 'Glass For Wine',			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rglasswine.png',			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Cup For Wine'},
		['rwine'] 			 	 	 	 = {['name'] = 'rwine', 			 			['label'] = 'Red Wine',					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rwine.png',				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Fill With Red Wine'},
		['rwhiskey'] 			 	 	 = {['name'] = 'rwhiskey', 			 			['label'] = 'Whiskey',					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rwhiskey.png',				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Fill With Whiskey'},
		['rbeer'] 			 		 	 = {['name'] = 'rbeer', 			 			['label'] = 'Beer',						['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rbeerglass.png',			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Fill With Beer'},
		['rbeerbottle'] 			 	 = {['name'] = 'rbeerbottle', 			 		['label'] = 'Beer Bottle',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rbeerbottle.png',			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Beer'},
		['rwhitewine'] 			 	 	 = {['name'] = 'rwhitewine', 			 		['label'] = 'White Wine',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rwhitewineglass.png',		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Fill With White Wine'},
		['rsake'] 			 		 	 = {['name'] = 'rsake', 			 			['label'] = 'Sake',						['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rsakeglass.png',			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Fill With Sake'},
		['rsamuraisake'] 			 	 = {['name'] = 'rsamuraisake', 			 		['label'] = 'Samurai Sake',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rsamuraiglass.png',		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Fill With Samurai Sake'},
		['rgoldsake'] 			 	 	 = {['name'] = 'rgoldsake', 			 		['label'] = 'Gold Sake',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rgoldglass.png',			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Fill With Gold Sake'},
		['rpinksake'] 			 	 	 = {['name'] = 'rpinksake', 			 		['label'] = 'Pink Sake',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rpinkglass.png',			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Fill With Pink Sake'},
		['rwhitesake'] 			 	 	 = {['name'] = 'rwhitesake', 			 		['label'] = 'White Sake',				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rwhiteglass.png',			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Fill With White Sake'},
		['rcocktailglass'] 			 	 = {['name'] = 'rcocktailglass', 			 	['label'] = 'Glass For Cocktails',		['weight'] = 200, 		['type'] = 'item', 		['image'] = 'rcocktailglass.png',		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Glass Cup For Cocktails'},
    

Video: https://streamable.com/jpg4zd

3 - Add the job:
go to "qb-core" then shared folder > jobs.lua and at least under line 4 :

    ["records"] = {
        label = "Records",
        offDutyPay = false,
        defaultDuty = false,
        grades = {
            ['0'] = {
                name = 'Worker',
                payment = 30,
            },
            ['1'] = {
                name = 'Vice Boss',
                payment = 70,
            },
            ['2'] = {
                name = 'Boss',
                isboss = true,
                payment = 130,
            },
        }
    },

video: https://streamable.com/rizp4o

4 - Add images to inventory
here you have images folder copy the images inside that folder and put it inside "qb-inventory"

Video: https://streamable.com/yhabiw

Have more questions / issues ? feel free to open a ticket in our discord server : https://discord.gg/kGPECGG27Q