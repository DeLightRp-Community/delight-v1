# re2-tunerjob

## A Mechanic for QBCore Framework



## Dependencies :

QB Framework - https://github.com/qbcore-framework/qb-core

PolyZone - https://github.com/mkafrin/PolyZone

qb-target - https://github.com/BerkieBb/qb-target

## Credits : 

Hamid#7784

## To Do 
- Copy image to inventory Image Folder

## Insert into #qb-core - Shared.lua

```
QBShared.Items = {

	["engine1"] 		 	 	  = {["name"] = "engine1", 							["label"] = "Engine Upgrade B", 					["weight"] = 125, 		["type"] = "item", 		["image"] = "engine_parts_b.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Engine Upgrade 1"},
	["engine2"] 		 	 	  = {["name"] = "engine2", 							["label"] = "Engine Upgrade C", 					["weight"] = 125, 		["type"] = "item", 		["image"] = "engine_parts_c.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Engine Upgrade 2"},
	["engine3"] 		 	 	  = {["name"] = "engine3", 							["label"] = "Engine Upgrade D", 					["weight"] = 125, 		["type"] = "item", 		["image"] = "engine_parts_d.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Engine Upgrade 3"},
	["engine4"] 		 	 	  = {["name"] = "engine4", 							["label"] = "Engine Upgrade S", 					["weight"] = 125, 		["type"] = "item", 		["image"] = "engine_parts_s.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Engine Upgrade 4"},

	["brake1"] 		 	 	      = {["name"] = "brake1", 							["label"] = "Brakes Upgrade B", 					["weight"] = 125, 		["type"] = "item", 		["image"] = "brake_parts_b.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Brake Upgrade 1"},
	["brake2"] 		 	 		  = {["name"] = "brake2", 							["label"] = "Brakes Upgrade C", 					["weight"] = 125, 		["type"] = "item", 		["image"] = "brake_parts_c.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Brake Upgrade 2"},
	["brake3"] 		 	 		  = {["name"] = "brake3", 							["label"] = "Brakes Upgrade S", 					["weight"] = 125, 		["type"] = "item", 		["image"] = "brake_parts_s.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Brake Upgrade 3"},

	["transmission1"] 		 	  = {["name"] = "transmission1", 					["label"] = "Transmission Upgrade B", 				["weight"] = 125, 		["type"] = "item", 		["image"] = "transmission_parts_b.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Transmission Upgrade 1"},
	["transmission2"] 		 	  = {["name"] = "transmission2", 					["label"] = "Transmission Upgrade C", 				["weight"] = 125, 		["type"] = "item", 		["image"] = "transmission_parts_c.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Transmission Upgrade 2"},
	["transmission3"] 		 	  = {["name"] = "transmission3", 					["label"] = "Transmission Upgrade S", 				["weight"] = 125, 		["type"] = "item", 		["image"] = "transmission_parts_s.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Transmission Upgrade 3"},

	
	["suspension1"] 		 	  = {["name"] = "suspension1", 						["label"] = "Suspension Upgrade B", 				["weight"] = 125, 		["type"] = "item", 		["image"] = "stock_suspension.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Suspension Upgrade 1"},
	["suspension2"] 		 	  = {["name"] = "suspension2", 						["label"] = "Suspension Upgrade C", 				["weight"] = 125, 		["type"] = "item", 		["image"] = "stock_suspension.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Suspension Upgrade 2"},
	["suspension3"] 		 	  = {["name"] = "suspension3", 						["label"] = "Suspension Upgrade D", 				["weight"] = 125, 		["type"] = "item", 		["image"] = "race_suspension.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Suspension Upgrade 3"},
	["suspension4"] 		 	  = {["name"] = "suspension4", 						["label"] = "Suspension Upgrade S", 				["weight"] = 125, 		["type"] = "item", 		["image"] = "race_suspension.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Suspension Upgrade 4"},


	["turbo1"] 		 	 		  = {["name"] = "turbo1", 							["label"] = "Turbo Upgrade", 						["weight"] = 125, 		["type"] = "item", 		["image"] = "turbo.png", 						["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Turbo"},

}
```
