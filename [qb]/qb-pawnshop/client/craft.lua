local QBCore = exports['qb-core']:GetCoreObject()

local inventoryUnderCraft = false
local craftTimeout = 1000


RegisterNetEvent('qb-pawnshop:client:openCraftMenu', function()
    local craftCategory = {{
        header = "Craft Category",
        isMenuHeader = true, -- Set to true to make a nonclickable title
    },}
    for i, v in pairs(Config.cfg.crafts) do
        local tempData= {
            header = i,
            txt = i.." Levels",
			params = {
                isServer = false,
                event = "qb-pawnshop:client:openCraftSub",
                args = {
                    type = i,
                }
            }
        }
        table.insert(craftCategory, tempData)
    end
    
    exports['qb-menu']:openMenu(craftCategory)
end)

RegisterNetEvent('qb-pawnshop:client:craftAmountItem', function(data)

	local dialog = exports['qb-input']:ShowInput({
		header = "Input Amount of Craft ",
        submitText = "Bill",
        inputs = {
			{
                text = "Citizen ID (#)", -- text you want to be displayed as a place holder
                name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                -- default = "CID-1234", -- Default text option, this is optional
            },
		},
	})

    if dialog ~= nil then
        for k,v in pairs(dialog) do
            print(k .. " : " .. v)
        end
    end

end)

RegisterNetEvent('qb-pawnshop:client:craftItem', function(data)

    QBCore.Functions.TriggerCallback('qb-pawnshop:server:craftItem', function(result)
        if result then

            QBCore.Functions.Notify("Item Crafting Start", "primary")
            
        else
            QBCore.Functions.Notify("Item Crafting Failed", "error")
        end
    end, data)
end)


RegisterNetEvent('qb-pawnshop:client:openCraftSub', function(data)
    local craftSubs = {

    }
	if data.type == "Material" then
		if not inventoryUnderCraft then
			TriggerEvent("inventory:client:SetCurrentStash", "pawnshopcraft")
    		TriggerServerEvent("inventory:server:OpenInventory", "stash", "pawnshopcraft", {
        		maxweight = 100000,
        		slots = 1,
   		})
        else
            QBCore.Functions.Notify("Craft in progress please wait for around "..craftTimeout/1000 .." Second", "error")

		end
	else
		for i, v in pairs(Config.cfg.crafts[data.type]) do
			local txt= ""
			for k, vv in pairs(v.items) do
				txt =txt..k.." "..vv.." "
			end
			local tempData= {
				header = QBCore.Shared.Items[i].label,
				txt = txt,
				params = {
					isServer = false,
					event = "qb-pawnshop:client:craftItem",
					args = {
						material = v.items,
						name = i
					}
				}
			}
			table.insert(craftSubs, tempData)
		end
		
		exports['qb-menu']:openMenu(craftSubs)
	end
    
end)

RegisterNetEvent('qb-pawnshop:craft:disable', function (amount)
    inventoryUnderCraft=true
    craftTimeout=craftTimeout*(amount)
    Wait(craftTimeout)
    inventoryUnderCraft =false
    craftTimeout =1000
    -- while inventoryUnderCraft do
    --     Wait(5000)
    --     craftTimeout=craftTimeout-5000
    --     print(craftTimeout == 0)
    --     if craftTimeout == 0 then
    --         inventoryUnderCraft =false
    --         craftTimeout =1000
    --         break;
    --     end
    -- end
end)


RegisterNetEvent('qb-pawnshop:carf:choose', function(data)
    -- print(json.encode(data))
    local craftSubs = {}
    for i, v in pairs(Config.cfg.crafts.Material) do
        local txt= ""
        local amount = ""
        for k, vv in pairs(v.items) do
            txt = txt..k.." "..data.."x"
            amount = tointeger(data/vv)
        end
        local tempData= {
            header = QBCore.Shared.Items[i].label.." "..amount.."x",
            txt = txt,
            params = {
                isServer = false,
                event = "qb-pawnshop:client:craftItem",
                args = {
                    material = v.items,
                    name = i,
                    count = tointeger(amount)
                }
            }
        }
        table.insert(craftSubs, tempData)
    end
    
    exports['qb-menu']:openMenu(craftSubs)
end)

function tointeger(x)
    num = tonumber(x)
    return num < 0 and math.ceil( num ) or math.floor( num )
end