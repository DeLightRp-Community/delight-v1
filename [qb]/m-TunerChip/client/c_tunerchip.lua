QBCore = exports['qb-core']:GetCoreObject()
LastEngineMultiplier = 1.0

function setVehData(veh,data)
    local multp = Config.MultipleTunerchip
    local dTrain = 0.0
    if tonumber(data.drivetrain) == 2 then dTrain = 0.5 elseif tonumber(data.drivetrain) == 3 then dTrain = 1.0 end
    if not DoesEntityExist(veh) or not data then return nil end
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", data.boost * multp)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", data.acceleration * multp)
    SetVehicleEnginePowerMultiplier(veh, data.gearchange * multp)
    LastEngineMultiplier = data.gearchange * multp
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", dTrain*1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", data.breaking * multp)
end

function resetVeh(veh)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", 1.0)
    SetVehicleEnginePowerMultiplier(veh, 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", 0.5)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", 1.0)
end

RegisterNUICallback('save', function(data)
    QBCore.Functions.TriggerCallback('m-TunerChip:server:HasChip', function(HasChip)
        if HasChip then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsUsing(ped)
            setVehData(veh, data)
            QBCore.Functions.Notify(Config['Notificacoes']['ReprogramadoComSucesso'], 'success', 3500)

            TriggerServerEvent('m-TunerChip:server:TuneStatus', QBCore.Functions.GetPlate(veh), true)
        end
    end)
end)

RegisterNetEvent('m-TunerChip:client:TuneStatus', function()
    local ped = PlayerPedId()
    local closestVehicle = GetClosestVehicle(GetEntityCoords(ped), 5.0, 0, 70)
    local plate = QBCore.Functions.GetPlate(closestVehicle)
    local vehModel = GetEntityModel(closestVehicle)
    if vehModel ~= 0 then
        QBCore.Functions.TriggerCallback('m-TunerChip:server:GetStatus', function(status)
            if status then
                QBCore.Functions.Notify(Config['Notificacoes']['VeiculoComRepro'], 'success', 3500)
            else
                QBCore.Functions.Notify(Config['Notificacoes']['VeiculoSemRepro'], 'error', 3500)
            end
        end, plate)
    else
        QBCore.Functions.Notify(Config['Notificacoes']['SemVeiculosPorPerto'], 'primary', 3500)
    end
end)

RegisterNUICallback('checkItem', function(data, cb)
    local retval = false
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            retval = true
        end
        cb(retval)
    end, data.item)
end)

RegisterNUICallback('reset', function(data)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    resetVeh(veh)
    QBCore.Functions.Notify(Config['Notificacoes']['TunerChipStock'], 'primary', 3500)
end)

RegisterNetEvent('m-TunerChip:client:openChip', function()
    local ped = PlayerPedId()
    local inVehicle = IsPedInAnyVehicle(ped)

    if Config.SkillBarRepro == "reload-skillbar" then
    local finished = exports["reload-skillbar"]:taskBar(math.random(5000,7500),math.random(2,4))
        if finished ~= 100 then
            QBCore.Functions.Notify(Config['Notificacoes']['Falhaste'], 'error', 3500)
            ClearPedTasks(playerPed)
        else
            local finished2 = exports["reload-skillbar"]:taskBar(math.random(2500,5000),math.random(3,5))
            if finished2 ~= 100 then
                QBCore.Functions.Notify(Config['Notificacoes']['Falhaste'], 'error', 3500)
                ClearPedTasks(playerPed)
            else
                local finished3 = exports["reload-skillbar"]:taskBar(math.random(900,2000),math.random(5,7))
                if finished3 ~= 100 then
                    QBCore.Functions.Notify(Config['Notificacoes']['Falhaste'], 'error', 3500)
                    ClearPedTasks(playerPed)
                else
                    if inVehicle then
                    QBCore.Functions.Progressbar("connect_laptop", Config['ProgressBars']['LigarTunerChip'], 2000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = Config.AnimationTurnON,
                        anim = Config.SubAnimationTurnON,
                        flags = 16,
                    }, {}, {}, function() -- Done
                        StopAnimTask(PlayerPedId(), Config.AnimationTurnON, Config.SubAnimationTurnON, 1.0)
                        openTunerLaptop(true)
                    end, function() -- Cancel
                        StopAnimTask(PlayerPedId(), Config.AnimationTurnON, Config.SubAnimationTurnON, 1.0)
                        QBCore.Functions.Notify(Config['Notificacoes']['Cancelado2'], 'error', 3500)
                    end)
                    else
                        QBCore.Functions.Notify(Config['Notificacoes']['NaoTemVeiculo'], 'error', 3500)
                    end
                end
            end
        end
        elseif Config.SkillBarRepro == "qb-skillbar" then 
        local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
            Skillbar.Start({
                duration = math.random(2500,5000),
                pos = math.random(10, 30),
                width = math.random(10, 20),
            }, function()
            if inVehicle then
                QBCore.Functions.Progressbar("connect_laptop", Config['ProgressBars']['LigarTunerChip'], 2000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.AnimationTurnON,
                    anim = Config.SubAnimationTurnON,
                    flags = 16,
                }, {}, {}, function() -- Done
                    StopAnimTask(PlayerPedId(), Config.AnimationTurnON, Config.SubAnimationTurnON, 1.0)
                    openTunerLaptop(true)
                end, function() -- Cancel
                    StopAnimTask(PlayerPedId(), Config.AnimationTurnON, Config.SubAnimationTurnON, 1.0)
                    QBCore.Functions.Notify(Config['Notificacoes']['Cancelado2'], 'error', 3500)
                end)
            else
                QBCore.Functions.Notify(Config['Notificacoes']['NaoTemVeiculo'], 'error', 3500)
            end
            end, function()
            QBCore.Functions.Notify(Config['Notificacoes']['Falhaste'], 'error', 3500)
            ClearPedTasks(playerPed)
        end)          
    end
end)

RegisterNUICallback('exit', function()
    openTunerLaptop(false)
    SetNuiFocus(false, false)
end)

function openTunerLaptop(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool
    })
end