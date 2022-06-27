
function showHelpText(text)
    exports['qb-core']:DrawText(text,'left')
end

function deleteHelpText(text)
    exports['qb-core']:HideText()
end


function SpawnVehicle(model)
    local coords = {
        x = Config.Locations["vehicle"].x,
        y = Config.Locations["vehicle"].y,
        z = Config.Locations["vehicle"].z,
        w = Config.Locations["vehicle"].w,
    }

    QBCore.Functions.SpawnVehicle(model, function(veh)
        SetCarItemsInfo()
        SetVehicleNumberPlateText(veh, Config.PlateText)
        SetEntityHeading(veh, coords.w)
        exports[Config.FuelSystem]:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent(Config.VehicleKeysTrigger, QBCore.Functions.GetPlate(veh))
        --TriggerEvent(Config.VehicleKeysTrigger, veh)
        TriggerServerEvent("inventory:server:addGloveboxItems", QBCore.Functions.GetPlate(veh), Config.CarItems)
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end

-------------------- Functions

function CleanVehicle(vehicle)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_MAID_CLEAN", 0, true)
    QBCore.Functions.Progressbar("cleaning_vehicle", ProgressBars["LimparVeiculo"], math.random(10000, 20000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        QBCore.Functions.Notify(Language["VeiculoLimpoComSucesso"])
        SetVehicleDirtLevel(vehicle, 0.1)
        SetVehicleUndriveable(vehicle, false)
        WashDecalsFromVehicle(vehicle, 1.0)
        TriggerServerEvent('m-TunerJob:server:removewashingkit', vehicle)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["cleaningkit"], "remove")
        ClearAllPedProps(ped)
        ClearPedTasks(ped)
    end, function()
        QBCore.Functions.Notify(Language["Falhaste"], "error")
        ClearAllPedProps(ped)
        ClearPedTasks(ped)
    end)
end

function RepairVehicleFull(vehicle)
    if (IsBackEngine(GetEntityModel(vehicle))) then
        SetVehicleDoorOpen(vehicle, 5, false, false)
    else
        SetVehicleDoorOpen(vehicle, 4, false, false)
    end
    
    QBCore.Functions.Progressbar("repair_vehicle", ProgressBars["RepararVeiculo"], math.random(20000, 30000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify(Language["VeiculoReparado"])
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehicleEngineOn(vehicle, true, false)
        SetVehicleTyreFixed(vehicle, 0)
        SetVehicleTyreFixed(vehicle, 1)
        SetVehicleTyreFixed(vehicle, 2)
        SetVehicleTyreFixed(vehicle, 3)
        SetVehicleTyreFixed(vehicle, 4)
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorShut(vehicle, 5, false)
        else
            SetVehicleDoorShut(vehicle, 4, false)
        end
        TriggerServerEvent('m-TunerJob:removeItem', "advancedrepairkit")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify(Language["Falhaste"], "error")
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorShut(vehicle, 5, false)
        else
            SetVehicleDoorShut(vehicle, 4, false)
        end
    end)
end

function RepairVehicle(vehicle)
    if (IsBackEngine(GetEntityModel(vehicle))) then
        SetVehicleDoorOpen(vehicle, 5, false, false)
    else
        SetVehicleDoorOpen(vehicle, 4, false, false)
    end
    QBCore.Functions.Progressbar("repair_vehicle", ProgressBars["RepararVeiculo"], 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify(Language["VeiculoReparado"])
        SetVehicleEngineHealth(vehicle, 500.0)
        SetVehicleEngineOn(vehicle, true, false)
        SetVehicleTyreFixed(vehicle, 0)
        SetVehicleTyreFixed(vehicle, 1)
        SetVehicleTyreFixed(vehicle, 2)
        SetVehicleTyreFixed(vehicle, 3)
        SetVehicleTyreFixed(vehicle, 4)
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorShut(vehicle, 5, false)
        else
            SetVehicleDoorShut(vehicle, 4, false)
        end
        TriggerServerEvent('m-TunerJob:removeItem', "repairkit")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify(Language["Falhaste"], "error")
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorShut(vehicle, 5, false)
        else
            SetVehicleDoorShut(vehicle, 4, false)
        end
    end)
end

-------------------- Commands
RegisterCommand(Config.StatusVehicle, function()
    local ped = PlayerPedId()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    if PlayerJob.name == Config.Job then
        TriggerEvent('m-TunerJob:CheckVehStatus')
    else
        QBCore.Functions.Notify(Language["SemPermissoes"])
    end
end)

RegisterCommand('cleanvehicle', function()
    CleanVehicle(vehicle)
end)
