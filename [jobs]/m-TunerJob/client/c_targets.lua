if Config.Framework == "NEW" then
    QBCore = exports[Config.CoreName]:GetCoreObject()
elseif Config.Framework == "OLD" then 
        local QBCore = nil
        CreateThread(function()
        while QBCore == nil do 
            TriggerEvent(Config.CoreName, function(obj)QBCore = obj end) 
            Wait(200) 
        end 
    end) 
else
    print("The Framework '", Config.Framework, "' is not support, please change in config.lua")
end

CreateThread(function()
    --========================================================= Billing
    for k, v in pairs(Config["BillLocation"]) do
        name = "BillLocation"..k
        exports[Config.Target]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 2.2, {name= name,heading = 22,debugPoly=false,
        }, {options = {{  event = 'm-TunerJob:client:Faturamento', icon = Config.BillIconTarget, label = Config.BillTarget, job = Config.Job },
        {  event   = 'm-TunerJob:client:SeguroCarrozinho', icon = Config.InsuranceIconTarget, label = Config.InsuranceTarget, job = Config.Job },}, distance = Config.BillDistTarget})
    end
    --========================================================= Warehouse
    for k, v in pairs(Config["Warehouse"]) do
        name = "Warehouse"..k
        exports[Config.Target]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 2.2, {name= name,heading = 22,debugPoly=false,}, {
        options = {{event = 'm-TunerJob:client:AbrirArmazem', icon = Config.WarehouseIconTarget, label = Config.WarehouseTarget, job = Config.Job}}, distance = Config.WarehouseDistTarget})
    end
    --========================================================= Shops
    for k, v in pairs(Config["ShopLocation"]) do
        name = "ShopLocation"..k
        exports[Config.Target]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 2.2, {name= name,heading = 22,debugPoly=false,
        }, {options = {{event   = 'm-TunerJob:AbrirLoja', icon = Config.ShopIconTarget, label = Config.ShopTarget, job = Config.Job}}, distance = Config.ShopDistTarget})
    end
    --========================================================= CheckTunes
    for k, v in pairs(Config["TuningLocation"]) do
        name = "TuningLocation"..k
        exports[Config.Target]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 2.2, {name= name,heading = 22,debugPoly=false,}, {
        options = {{event = "m-TunerJob:CheckVehStatus", icon = Config.TuningIconTarget, label = Config.TuningTarget, job = Config.Job}}, distance = Config.TuningDistTarget})
    end
    --========================================================= Nitro
    for k, v in pairs(Config["NitroLocation"]) do
        name = "NitroLocation"..k
        exports[Config.Target]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 2.2, {name= name, heading = 22, debugPoly=false,
        }, {options = {{event = "m-TunerJob:ReabestecerNitro", icon = Config.NitroIconTarget, label = Config.NitroTarget, job = Config.Job}}, distance = Config.NitroDistTarget})
    end
    --========================================================= Duty
    for k, v in pairs(Config["DutyLocation"]) do
        name = "DutyLocation"..k
        exports[Config.Target]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 2.2, {name= name,heading = 22,debugPoly=false,}, {
        options = {{event = 'm-TunerJob:client:EntrarSairServico', icon = Config.DutyIconTarget, label = Config.DutyTarget, job = Config.Job}}, distance = Config.DutyDistTarget})
    end
    --========================================================= Vehicles
    for k, v in pairs(Config["VeiculosZinhos"]) do
        name = "VeiculosZinhos"..k
        exports[Config.Target]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 2.2, {name= name,heading = 22,debugPoly=false,}, {
        options = {{event   = 'm-TunerJob:client:MenuVeiculos', icon = Config.VehicleIconTarget, label = Config.VehicleTarget, job = Config.Job}}, distance = Config.VehicleDistTarget})
    end
    --========================================================= ChopChop
    if Config.EnableChopChop == true then
        for k, v in pairs(Config["ChopChopLocation"]) do
        name = "Chop"..k
        exports[Config.Target]:AddBoxZone(name, vector3(v.x, v.y, v.z), 4, 4.2, {name = name,heading = 22,debugPoly = false,
        }, {options = {{event = "m-TunerJob:client:ComecarChop", icon = Config.ChopChopIcon, label = Config.ChopChopLabel },}, distance =  5.0})
        end
    else
        print("no chopchop")
    end
    --========================================================= Windows
    local windows = {
        "windscreen",
        "windscreen_r",
        "window_lf",
        "window_rf",
        "window_lr",
        "window_rr",
        "window_lm",
        "window_rm",
    }
    exports['qb-target']:AddTargetBone(windows, {
        options = {
            {
                event = "m-TunerJob:client:openWindowTintMenu",
                icon = Config.WindowsIconTarget,
                label = Config.WindowsTarget,
                item = 'tint_supplies',
            },
        },
        distance = 1.5
    })
end)