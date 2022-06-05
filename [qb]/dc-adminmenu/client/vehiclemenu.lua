local function OpenCarModelsMenu(category)
    VehNameMenu:ClearItems()
    MenuV:OpenMenu(VehNameMenu)
    for k, v in pairs(category) do
        VehNameMenu:AddButton({
            label = v["name"],
            value = k,
            description = 'Spawn ' .. v["name"],
            select = function()
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
VehicleMenuButton1:On('Select', function()
    VehCategorieMenu:ClearItems()
    for k, v in pairs(QBCore.Shared.Vehicles) do
        local category = v["category"]
        if vehicles[category] == nil then
            vehicles[category] = { }
        end
        vehicles[category][k] = v
    end
    for k, v in pairs(vehicles) do
        VehCategorieMenu:AddButton({
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
VehicleMenuButton2:On('Select', function()
    TriggerServerEvent('QBCore:CallCommand', "fix", {})
end)

local VehicleMenuButton3 = VehicleMenu:AddButton({
    icon = '💲',
    label = Lang:t("menu.buy"),
    value = 'buy',
    description = Lang:t("desc.buy_desc")
})
VehicleMenuButton3:On('Select', function()
    TriggerServerEvent('QBCore:CallCommand', "admincar", {})
end)

local VehicleMenuButton4 = VehicleMenu:AddButton({
    icon = '☠',
    label = Lang:t("menu.remove_vehicle"),
    value = 'remove',
    description = Lang:t("desc.remove_vehicle_desc")
})
VehicleMenuButton4:On('Select', function()
    TriggerServerEvent('QBCore:CallCommand', "dv", {})
end)

local VehicleMenuButton5 = VehicleMenu:AddButton({
    icon = '🛠️',
    label = Lang:t("menu.tune_car"),
    value = '',
    description = Lang:t("desc.tune_car")
})
VehicleMenuButton5:On('Select', function()
    local ped = PlayerPedId()
    local override = {
        coords = GetEntityCoords(ped),
        heading = GetEntityHeading(ped),
        categories = {
            mods = true,
            repair = true,
            armor = true,
            respray = true,
            liveries = true,
            wheels = true,
            tint = true,
            plate = true,
            extras = true,
            neons = true,
            xenons = true,
            horn = true,
            turbo = true,
            cosmetics = true,
        },
    }
    TriggerEvent('qb-customs:client:EnterCustoms', override)
    MenuV:CloseAll()
end)

local VehicleMenuButton6 = VehicleMenu:AddButton({
    icon = '🪧',
    label = Lang:t("menu.plate_car"),
    value = '',
    description = Lang:t("desc.plate_car")
})
VehicleMenuButton6:On('Select', function()
    local dialog = exports['qb-input']:ShowInput({
        header = Lang:t("desc.plate_car"),
        submitText = "Confirm",
        inputs = {
            {
                text = "GEB654TY",
                name = "plate",
                type = "text",
                isRequired = true
            }
        }
    })
    if dialog then
        TriggerServerEvent('qb-admin:server:vehicleplate', dialog.plate)
    end
end)