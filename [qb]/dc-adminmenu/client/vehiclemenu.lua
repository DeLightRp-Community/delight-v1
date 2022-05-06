local function OpenCarModelsMenu(category)
    VehNameMenu:ClearItems()
    MenuV:OpenMenu(VehNameMenu)
    for k, v in pairs(category) do
        local menu_button10 = VehNameMenu:AddButton({
            label = v["name"],
            value = k,
            description = 'Spawn ' .. v["name"],
            select = function(btn)
                TriggerServerEvent('qb-admin:server:spawnVehicle', k)
            end
        })
    end
end

local VehicleMenuButton1 = VehicleMenu:AddButton({
    icon = '🚗',
    label = Lang:t("menu.spawn_vehicle"),
    value = VehCategorieMenu,
    description = Lang:t("desc.spawn_vehicle_desc")
})
local vehicles = {}
VehicleMenuButton1:On('Select', function(item)
    VehCategorieMenu:ClearItems()
    for k, v in pairs(QBCore.Shared.Vehicles) do
        local category = v["category"]
        if vehicles[category] == nil then
            vehicles[category] = { }
        end
        vehicles[category][k] = v
    end
    for k, v in pairs(vehicles) do
        local menu_button10 = VehCategorieMenu:AddButton({
            label = k,
            value = v,
            description = Lang:t("menu.category_name"),
            select = function(btn)
                local select = btn.Value
                OpenCarModelsMenu(select)
            end
        })
    end
end)

local VehicleMenuButton2 = VehicleMenu:AddButton({
    icon = '🔧',
    label = Lang:t("menu.fix_vehicle"),
    value = 'fix',
    description = Lang:t("desc.fix_vehicle_desc")
})
VehicleMenuButton2:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "fix", {})
end)

local VehicleMenuButton3 = VehicleMenu:AddButton({
    icon = '💲',
    label = Lang:t("menu.buy"),
    value = 'buy',
    description = Lang:t("desc.buy_desc")
})
VehicleMenuButton3:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "admincar", {})
end)

local VehicleMenuButton4 = VehicleMenu:AddButton({
    icon = '☠',
    label = Lang:t("menu.remove_vehicle"),
    value = 'remove',
    description = Lang:t("desc.remove_vehicle_desc")
})
VehicleMenuButton4:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "dv", {})
end)
