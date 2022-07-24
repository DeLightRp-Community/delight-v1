-- Variables
local currentGarage = 0
local inFingerprint = false
local FingerPrintSessionId = nil
local inDuty = false
local inStash = false
local inTrash = false
local inAmoury = false
local inHelicopter = false
local inBoat = false
local inImpound = false
local inGarage = false

-- Functions
local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

local function GetClosestPlayer() -- interactions, job, tracker
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

local function openFingerprintUI()
    SendNUIMessage({
        type = "fingerprintOpen"
    })
    inFingerprint = true
    SetNuiFocus(true, true)
end

local function SetCarItemsInfo()
	local items = {}
	for k, item in pairs(Config.CarItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = item.info,
			label = itemInfo["label"],
			description = itemInfo["description"] and itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
		}
	end
	Config.CarItems = items
end

local function doCarDamage(currentVehicle, veh)
	local smash = false
	local damageOutside = false
	local damageOutside2 = false
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0

	if engine < 200.0 then engine = 200.0 end
    if engine  > 1000.0 then engine = 950.0 end
	if body < 150.0 then body = 150.0 end
	if body < 950.0 then smash = true end
	if body < 920.0 then damageOutside = true end
	if body < 920.0 then damageOutside2 = true end

    Citizen.Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)

	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end

	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end

	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end

	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.1)
	end
end

function TakeOutImpound(vehicle)
    local coords = Config.Locations["impound"][currentGarage]
    if coords then
        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                QBCore.Functions.SetVehicleProperties(veh, properties)
                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, coords.w)
                exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                doCarDamage(veh, vehicle)
                TriggerServerEvent('police:server:TakeOutImpound',vehicle.plate)
                closeMenuFull()
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)
        end, coords, true)
    end
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][currentGarage]
    if coords then
        QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
            SetCarItemsInfo()
            SetVehicleNumberPlateText(veh, Lang:t('info.police_plate')..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.w)
            exports['LegacyFuel']:SetFuel(veh, 100.0)
            closeMenuFull()
            if Config.VehicleSettings[vehicleInfo] ~= nil then
                if Config.VehicleSettings[vehicleInfo].extras ~= nil then 
			QBCore.Shared.SetDefaultVehicleExtras(veh, Config.VehicleSettings[vehicleInfo].extras)
		end
		if Config.VehicleSettings[vehicleInfo].livery ~= nil then 
			SetVehicleLivery(veh, Config.VehicleSettings[vehicleInfo].livery)
		end
            end
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.CarItems)
            SetVehicleEngineOn(veh, true, true)
        end, coords, true)
    end
end

local function IsArmoryWhitelist() -- being removed
    local retval = false

    if QBCore.Functions.GetPlayerData().job.name == 'police' then
        retval = true
    end
    return retval
end

local function SetWeaponSeries()
    for k, v in pairs(Config.Items.items) do
        if k < 6 then
            Config.Items.items[k].info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
        end
    end
end

function MenuGarage(currentSelection)
    local vehicleMenu = {
        {
            header = Lang:t('menu.garage_title'),
            isMenuHeader = true
        }
    }

    local authorizedVehicles = Config.AuthorizedVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for veh, label in pairs(authorizedVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "police:client:TakeOutVehicle",
                args = {
                    vehicle = veh,
                    currentSelection = currentSelection
                }
            }
        }
    end

    if IsArmoryWhitelist() then
        for veh, label in pairs(Config.WhitelistedVehicles) do
            vehicleMenu[#vehicleMenu+1] = {
                header = label,
                txt = "",
                params = {
                    event = "police:client:TakeOutVehicle",
                    args = {
                        vehicle = veh,
                        currentSelection = currentSelection
                    }
                }
            }
        end
    end

    vehicleMenu[#vehicleMenu+1] = {
        header = Lang:t('menu.close'),
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

function MenuImpound(currentSelection)
    local impoundMenu = {
        {
            header = Lang:t('menu.impound'),
            isMenuHeader = true
        }
    }
    QBCore.Functions.TriggerCallback("police:GetImpoundedVehicles", function(result)
        local shouldContinue = false
        if result == nil then
            QBCore.Functions.Notify(Lang:t("error.no_impound"), "error", 5000)
        else
            shouldContinue = true
            for _ , v in pairs(result) do
                local enginePercent = QBCore.Shared.Round(v.engine / 10, 0)
                local bodyPercent = QBCore.Shared.Round(v.body / 10, 0)
                local currentFuel = v.fuel
                local vname = QBCore.Shared.Vehicles[v.vehicle].name

                impoundMenu[#impoundMenu+1] = {
                    header = vname.." ["..v.plate.."]",
                    txt =  Lang:t('info.vehicle_info', {value = enginePercent, value2 = currentFuel}),
                    params = {
                        event = "police:client:TakeOutImpound",
                        args = {
                            vehicle = v,
                            currentSelection = currentSelection
                        }
                    }
                }
            end
        end


        if shouldContinue then
            impoundMenu[#impoundMenu+1] = {
                header = Lang:t('menu.close'),
                txt = "",
                params = {
                    event = "qb-menu:client:closeMenu"
                }
            }
            exports['qb-menu']:openMenu(impoundMenu)
        end
    end)

end

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

--NUI Callbacks
RegisterNUICallback('closeFingerprint', function()
    SetNuiFocus(false, false)
    inFingerprint = false
end)

--Events
RegisterNetEvent('police:client:showFingerprint', function(playerId)
    openFingerprintUI()
    FingerPrintSessionId = playerId
end)

RegisterNetEvent('police:client:showFingerprintId', function(fid)
    SendNUIMessage({
        type = "updateFingerprintId",
        fingerprintId = fid
    })
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNUICallback('doFingerScan', function(data)
    TriggerServerEvent('police:server:showFingerprintId', FingerPrintSessionId)
end)

RegisterNetEvent('police:client:SendEmergencyMessage', function(coords, message)
    TriggerServerEvent("police:server:SendEmergencyMessage", coords, message)
    TriggerEvent("police:client:CallAnim")
end)

RegisterNetEvent('police:client:EmergencySound', function()
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNetEvent('police:client:personalstash', function()
    if onDuty then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent("inventory:client:SetCurrentStash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
    else
        QBCore.Functions.Notify("You are not on duty!", "error")
    end
end)

RegisterNetEvent('police:client:evidenceTrash', function()
    if onDuty then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {
            maxweight = 4000000,
            slots = 300,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "policetrash")
    else
        QBCore.Functions.Notify("You must be on duty to access the Trash!", "error")
    end    
end)

RegisterNetEvent('police:client:CallAnim', function()
    local isCalling = true
    local callCount = 5
    loadAnimDict("cellphone@")
    TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 3.0, -1, -1, 49, 0, false, false, false)
    Citizen.Wait(1000)
    Citizen.CreateThread(function()
        while isCalling do
            Citizen.Wait(1000)
            callCount = callCount - 1
            if callCount <= 0 then
                isCalling = false
                StopAnimTask(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 1.0)
            end
        end
    end)
end)

RegisterNetEvent('police:client:ImpoundVehicle', function(fullImpound, price)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
    local engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
    local totalFuel = exports['LegacyFuel']:GetFuel(vehicle)
    if vehicle ~= 0 and vehicle ~= nil then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(vehicle)
        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
            QBCore.Functions.Progressbar("impond_vehicle", "Impound Vehicle..", 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@code_human_police_investigate@idle_a",
                anim = "idle_b",
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(PlayerPedId(), "amb@code_human_police_investigate@idle_a", "idle_b", 1.0)
                local plate = QBCore.Functions.GetPlate(vehicle)
                TriggerServerEvent("police:server:Impound", plate, fullImpound, price, bodyDamage, engineDamage, totalFuel)			
                QBCore.Functions.DeleteVehicle(vehicle)
            end, function() -- Cancel
                StopAnimTask(PlayerPedId(), "amb@code_human_police_investigate@idle_a", "idle_b", 1.0)
                QBCore.Functions.Notify("Canceled..", "error")
            end)
        end
    end
end)

RegisterNetEvent('police:client:DeleteVehicle', function(fullImpound, price)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
    local engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
    local totalFuel = exports['LegacyFuel']:GetFuel(vehicle)
    if vehicle ~= 0 and vehicle ~= nil then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(vehicle)
        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
            QBCore.Functions.Progressbar("impond_vehicle", "Impound Vehicle..", 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@code_human_police_investigate@idle_a",
                anim = "idle_b",
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(PlayerPedId(), "amb@code_human_police_investigate@idle_a", "idle_b", 1.0)
                local plate = QBCore.Functions.GetPlate(vehicle)
                TriggerServerEvent("police:server:mamoliImpound", plate, fullImpound, price, bodyDamage, engineDamage, totalFuel)			
                QBCore.Functions.DeleteVehicle(vehicle)
            end, function() -- Cancel
                StopAnimTask(PlayerPedId(), "amb@code_human_police_investigate@idle_a", "idle_b", 1.0)
                QBCore.Functions.Notify("Canceled..", "error")
            end)
        end
    end
end)

RegisterNetEvent('police:client:CheckStatus', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "police" then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                QBCore.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
                    if result then
                        for k, v in pairs(result) do
                            QBCore.Functions.Notify(''..v..'')
                        end
                    end
                end, playerId)
            else
                QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
            end
        end
    end)
end)

RegisterNetEvent("police:client:VehicleMenuHeader", function (data)
    MenuGarage(data.currentSelection)
    currentGarage = data.currentSelection
end)


RegisterNetEvent("police:client:ImpoundMenuHeader", function (data)
    MenuImpound(data.currentSelection)
    currentGarage = data.currentSelection
end)

RegisterNetEvent('police:client:TakeOutImpound', function(data)
    if inImpound then
        local vehicle = data.vehicle
        TakeOutImpound(vehicle)
    end
end)

RegisterNetEvent('police:client:TakeOutVehicle', function(data)
    if inGarage then
        local vehicle = data.vehicle
        TakeOutVehicle(vehicle)
    end
end)

RegisterNetEvent('police:client:EvidenceStashDrawer', function(data)
    local currentEvidence = data.currentEvidence
    local pos = GetEntityCoords(PlayerPedId())
    local takeLoc = Config.Locations["evidence"][currentEvidence]

    if not takeLoc then return end

    if #(pos - takeLoc) <= 1.0 then
        local drawer = exports['qb-input']:ShowInput({
            header = Lang:t('info.evidence_stash', {value = currentEvidence}),
            submitText = "open",
            inputs = {
                {
                    type = 'number',
                    isRequired = true,
                    name = 'slot',
                    text = Lang:t('info.slot')
                }
            }
        })
        if drawer then
            if not drawer.slot then return end
            TriggerServerEvent("inventory:server:OpenInventory", "stash", Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawer.slot}), {
                maxweight = 4000000,
                slots = 500,
            })
            TriggerEvent("inventory:client:SetCurrentStash", Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawer.slot}))
        end
    else
        exports['qb-menu']:closeMenu()
    end
end)

-- Toggle Duty in an event.
RegisterNetEvent('qb-policejob:ToggleDuty', function()
    onDuty = not onDuty
    TriggerServerEvent("QBCore:ToggleDuty")
    TriggerServerEvent("police:server:UpdateCurrentCops")
    TriggerServerEvent("police:server:UpdateBlips")
end)

RegisterNetEvent('qb-police:client:scanFingerPrint', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:showFingerprint", playerId)
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('qb-police:client:openArmoury', function()
    local authorizedItems = {
        label = Lang:t('menu.pol_armory'),
        slots = 30,
        items = {}
    }
    local index = 1
    for _, armoryItem in pairs(Config.Items.items) do
        for i=1, #armoryItem.authorizedJobGrades do
            if armoryItem.authorizedJobGrades[i] == PlayerJob.grade.level then
                authorizedItems.items[index] = armoryItem
                authorizedItems.items[index].slot = index
                index = index + 1
            end
        end
    end
    SetWeaponSeries()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", authorizedItems)
end)

RegisterNetEvent('qb-police:client:spawnHelicopter', function(k)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
    else
        local coords = Config.Locations["helicopter"][k]
        if not coords then coords = GetEntityCoords(PlayerPedId()) end
        QBCore.Functions.SpawnVehicle(Config.PoliceHelicopter, function(veh)
            SetVehicleLivery(veh , 0)
            SetVehicleMod(veh, 0, 48)
            SetVehicleNumberPlateText(veh, "Heli"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.w)
            exports['LegacyFuel']:SetFuel(veh, 100.0)
            closeMenuFull()
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
        end, coords, true)
    end
end)
RegisterNetEvent('qb-police:client:spawnBoat', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
    else
        local coords = vector4(-775.53, -1428.51, 0.27, 136.17)
        if not coords then coords = GetEntityCoords(PlayerPedId()) end
        QBCore.Functions.SpawnVehicle(Config.PoliceBoat, function(veh)
            SetVehicleLivery(veh , 0)
            SetVehicleMod(veh, 0, 48)
            SetVehicleNumberPlateText(veh, "Boat"..tostring(math.random(1000, 9999)))
            --SetEntityHeading(veh, Config.Locations["boat"][k].w)
            exports['LegacyFuel']:SetFuel(veh, 100.0)
            closeMenuFull()
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
        end, vector4(-775.53, -1428.51, 0.27, 320.6), true)
    end
end)

-- Threads

if Config.UseTarget then
    for k, v in pairs(Config.Locations["duty"]) do
        exports['qb-target']:AddBoxZone("PoliceDuty_"..k, vector3(v.x, v.y, v.z), 1, 1, {
            name = "PoliceDuty_"..k,
            heading = 11,
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        }, {
            options = {
                {
                    type = "client",
                    event = "qb-policejob:ToggleDuty",
                    icon = "fas fa-sign-in-alt",
                    label = "Sign In",
                    job = "police",
                },
            },
            distance = 1.5
        })
    end
    -- Vest location
    local models = {
        'prop_armour_pickup',
      }
      exports['qb-target']:AddTargetModel(models, { -- This defines the models, can be a string or a table
        options = { 
          { 
            type = "clienta", 
            event = "consumables:client:UseHeavyArmor",
            label = 'Pickup Vest',
            job = 'police',
          }
        },
        distance = 2.5,
      })
else
    -- Toggle Duty
    local dutyZones = {}
    for k, v in pairs(Config.Locations["duty"]) do
        dutyZones[#dutyZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 1.75, 1, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local dutyCombo = ComboZone:Create(dutyZones, {name = "dutyCombo", debugPoly = false})
    dutyCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inDuty = true
            if not onDuty then
                exports['qb-core']:DrawText(Lang:t('info.on_duty'),'left')
            else
                exports['qb-core']:DrawText(Lang:t('info.off_duty'),'left')
            end
        else
            inDuty = false
            exports['qb-core']:HideText()
        end
    end)

    -- Toggle Duty Thread
    CreateThread(function ()
        Wait(1000)
        while true do
            local sleep = 1000
            if inDuty and PlayerJob.name == "police" then
                sleep = 5
                if IsControlJustReleased(0, 38) then
                    onDuty = not onDuty
                    TriggerServerEvent("police:server:UpdateCurrentCops")
                    TriggerServerEvent("QBCore:ToggleDuty")
                    TriggerServerEvent("police:server:UpdateBlips")
                end
            else
                sleep = 1000
            end
            Wait(sleep)
        end
    end)
end

local inHeliMRPD = false
local inHeliSandy = false

local LSPDMRPDHeliBOX = BoxZone:Create(vector3(449.5, -980.9, 43.69), 10, 10, {
    name="Heli Location",
    heading=0,
    -- debugPoly=true,
    minZ=42.69,
    maxZ=47.69
  })
LSPDMRPDHeliBOX:onPlayerInOut(function(isPointInside, point)
    inHeliMRPD = isPointInside
end)

local LSPDSANDYHEliBOX = BoxZone:Create(vector3(-475.48, 5988.16, 31.34), 20, 20, {
    name="police sandy heli",
    heading=315,
    -- debugPoly=true,
    minZ=30.34,
    maxZ=34.34
  }) 

LSPDSANDYHEliBOX:onPlayerInOut(function(isPointInside, point)
    inHeliSandy = isPointInside
end)

RegisterNetEvent('qb-police:client:changeLivery', function(id)
    if inHeliMRPD or inHeliSandy then
        local playerInVehicle =GetVehiclePedIsIn(PlayerPedId(), false)
        if playerInVehicle > 0 then
            local vehicle =GetDisplayNameFromVehicleModel(GetEntityModel(playerInVehicle))
            if vehicle=="POLAS350" then
                local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
                SetVehicleLivery(Veh,id) --CHANGE livery(id)
            end
        end
    end
end)

CreateThread(function()
    -- Helicopter
    local helicopterZones = {}
    for k, v in pairs(Config.Locations["helicopter"]) do
        helicopterZones[#helicopterZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 10, 10, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end
    

    local helicopterCombo = ComboZone:Create(helicopterZones, {name = "helicopterCombo", debugPoly = false})
    helicopterCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inHelicopter = true
            if onDuty then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    exports['qb-core']:HideText()
                    exports['qb-core']:DrawText(Lang:t('info.store_heli'), 'left')
                else
                    exports['qb-core']:DrawText(Lang:t('info.take_heli'), 'left')
                end
            end
        else
            inHelicopter = false
            exports['qb-core']:HideText()
        end
    end)

-- Boat
    --[[local boatZones = {}
    for k, v in pairs(Config.Locations["boat"]) do
        boatZones[#boatZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 10, 10, {
            name="box_zone",
            debugPoly = true,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end
    local boatCombo = ComboZone:Create(boatZones, {name = "boatCombo", debugPoly = false})
    boatCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inBoat = true
            if onDuty then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    exports['qb-core']:HideText()
                    exports['qb-core']:DrawText(Lang:t('info.store_boat'), 'left')
                else
                    exports['qb-core']:DrawText(Lang:t('info.take_boat'), 'left')
                end
            end
        else
            inBoat = false
            exports['qb-core']:HideText()
        end
    end)]]
    -- Police Impound
    local impoundZones = {}
    for k, v in pairs(Config.Locations["impound"]) do
        impoundZones[#impoundZones+1] = BoxZone:Create(
            vector3(v.x, v.y, v.z), 1, 1, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local impoundCombo = ComboZone:Create(impoundZones, {name = "impoundCombo", debugPoly = false})
    impoundCombo:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            inImpound = true
            if onDuty then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    exports['qb-core']:DrawText(Lang:t('info.impound_veh'), 'left')
                else
                    local currentSelection = 0

                    for k, v in pairs(Config.Locations["impound"]) do
                        if #(point - vector3(v.x, v.y, v.z)) < 4 then
                            currentSelection = k
                        end
                    end
                    exports['qb-menu']:showHeader({
                        {
                            header = Lang:t('menu.pol_impound'),
                            params = {
                                event = 'police:client:ImpoundMenuHeader',
                                args = {
                                    currentSelection = currentSelection,
                                }
                            }
                        }
                    })
                end
            end
        else
            inImpound = false
            exports['qb-menu']:closeMenu()
            exports['qb-core']:HideText()
        end
    end)

    -- Police Garage
    local garageZones = {}
    for k, v in pairs(Config.Locations["vehicle"]) do
        garageZones[#garageZones+1] = BoxZone:Create(
            vector3(v.x, v.y, v.z), 3, 3, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local garageCombo = ComboZone:Create(garageZones, {name = "garageCombo", debugPoly = false})
    garageCombo:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            inGarage = true
            if onDuty and PlayerJob.name == 'police' then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    exports['qb-core']:DrawText(Lang:t('info.store_veh'), 'left')
                else
                    local currentSelection = 0

                    for k, v in pairs(Config.Locations["vehicle"]) do
                        if #(point - vector3(v.x, v.y, v.z)) < 4 then
                            currentSelection = k
                        end
                    end
                    exports['qb-menu']:showHeader({
                        {
                            header = Lang:t('menu.pol_garage'),
                            params = {
                                event = 'police:client:VehicleMenuHeader',
                                args = {
                                    currentSelection = currentSelection,
                                }
                            }
                        }
                    })
                end
            end
        else
            inGarage = false
            exports['qb-menu']:closeMenu()
            exports['qb-core']:HideText()
        end
    end)
end)

CreateThread(function()
    -- Toggle Armor
    for k, v in pairs(Config.Locations["armory"]) do
        exports['qb-target']:AddBoxZone("PoliceArmory_"..k, vector3(v.x, v.y, v.z), 1, 1, {
            name = "PoliceArmory_"..k,
            heading = 11,
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        }, {
            options = {
                {
                    type = "client",
                    event = "qb-police:client:openArmoury",
                    icon = "fas fa-sign-in-alt",
                    label = "Armory",
                    job = "police",
                },
            },
            distance = 1.5
        })
    end
    -- Toggle Stash
    for k, v in pairs(Config.Locations["stash"]) do
        exports['qb-target']:AddBoxZone("PoliceStash_"..k, vector3(v.x, v.y, v.z), 1, 1, {
            name = "PoliceStash_"..k,
            heading = 11,
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        }, {
            options = {
                {
                    type = "client",
                    event = "police:client:personalstash",
                    icon = "fas fa-sign-in-alt",
                    label = "Stash",
                    job = "police",
                },
            },
            distance = 1.5
        })
    end
    -- Toggle Evidence
    for k, v in pairs(Config.Locations["evidence"]) do
        exports['qb-target']:AddBoxZone("PoliceEvidence_"..k, vector3(v.x, v.y, v.z), 1, 1, {
            name = "PoliceEvidence_"..k,
            heading = 11,
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        }, {
            options = {
                {
                    type = "client",
                    event = "police:client:EvidenceStashDrawer",
                    icon = "fas fa-sign-in-alt",
                    label = "Evidence",
                    job = "police",
                },
            },
            distance = 1.5
        })
    end
end)

-- CreateThread(function()
--     Wait(10)
-- 	policePeds()
-- end)

-- function policePeds()
--     --ped fingerprint
--     model = GetHashKey("mp_m_fibsec_01")
--     RequestModel(model)
--     while not HasModelLoaded(model) do
--         Wait(1)
--     end
--     ped1 = CreatePed(0, model , 475.54, -1014.1, 25.27, true)
--     FreezeEntityPosition(ped1, true)
--     SetEntityHeading(ped1, 2.4 )
--     SetEntityInvincible(ped1, true)
--     SetBlockingOfNonTemporaryEvents(ped1, true)
--     TaskStartScenarioInPlace(ped1, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
-- end

exports['qb-target']:SpawnPed({
    model = 'mp_m_fibsec_01',
    coords = vector4(475.54, -1014.1, 26.27, 2.4),
    minusOne = true, 
    freeze = true,
    invincible = true, 
    blockevents = true,
    animDict = 'abigail_mcs_1_concat-0', 
    anim = 'csb_abigail_dual-0',
    flag = 1,
    scenario = 'WORLD_HUMAN_STAND_IMPATIENT', 
    target = { 
      useModel = false, 
      options = {
        { 
          num = 1, 
          type = "client", 
          label = 'Finger Print',
          event = "qb-police:client:scanFingerPrint",
          job = 'police', 
        }
      },
      distance = 2.5,
    },
})


exports['qb-target']:SpawnPed({
    model = 'mp_m_boatstaff_01',
    coords = vector4(-773.5, -1430.62, 1.6, 233.78),
    minusOne = true, 
    freeze = true,
    invincible = true, 
    blockevents = true,
    animDict = 'abigail_mcs_1_concat-0', 
    anim = 'csb_abigail_dual-0',
    flag = 1,
    scenario = 'WORLD_HUMAN_STAND_IMPATIENT', 
    target = { 
      useModel = false, 
      options = {
        { 
          num = 1, 
          type = "client", 
          label = 'Police Boat/Store',
          event = "qb-police:client:spawnBoat",
          canInteract = function(entity) 
            if IsPedAPlayer(entity) then return false end 
            print(onDuty)
            if onDuty then
                return true
            else
                return false
            end
            
          end,
          icon = "fas fa-boat",
          job = 'police', 
        }
      },
      distance = 5.5,
    },
})


-- Helicopter Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        local PlayerData = QBCore.Functions.GetPlayerData()
        if inHelicopter and PlayerJob.name == "police" and PlayerData.metadata["division"] == "xray" then
            if onDuty then sleep = 5 end
            if IsControlJustReleased(0, 38) then
                PoliceHelicopter(k)
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

local CheckHeli = false
function PoliceHelicopter(k)
    CheckHeli = true
    CreateThread(function()
        while CheckHeli do
                exports['qb-core']:KeyPressed(38)
                CheckHeli = false
                local ped = PlayerPedId()
                    if IsPedInAnyVehicle(ped, false) then
                        QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(ped))
                    else
                        exports['qb-menu']:openMenu({
                            {
                                header = "Helicopter",
                                isMenuHeader = true,
                            },
                            {
                                header = "BCSO", 
                                txt = "BCSO helicopter",
                                params = {
                                    event = "qb-police:client:xray",
                                    args = 1
                                }
                            },
                            {
                                header = "Sasp", 
                                txt = "Sasp Helicopter",
                                params = {
                                    event = "qb-police:client:sasp",
                                    args = 1
                                }
                            },
                        })
                    end
            
            Wait(1)
        end
    end)
end

RegisterNetEvent('qb-police:client:xray', function(k)
    local ped = PlayerPedId()
    currentHelictoper = k
    local coords = Config.Locations["helicopter"][currentHelictoper]
    QBCore.Functions.SpawnVehicle(Config.PoliceHelicopter, function(veh)
        SetVehicleNumberPlateText(veh, Lang:t('info.heli_plate')..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        SetVehicleLivery(veh, 1) -- Ambulance Livery
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)

RegisterNetEvent('qb-police:client:sasp', function(k)
    local ped = PlayerPedId()
    currentHelictoper = k
    local coords = Config.Locations["helicopter"][currentHelictoper]
    QBCore.Functions.SpawnVehicle(Config.PoliceHelicopter, function(veh)
        SetVehicleNumberPlateText(veh, Lang:t('info.heli_plate')..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        SetVehicleLivery(veh, 2) -- Ambulance Livery
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)

-- Boat Thread
--[[CreateThread(function ()
    Wait(5000)
    while true do
        local sleep = 5000
        local PlayerData = QBCore.Functions.GetPlayerData()
        if inBoat and PlayerJob.name == "police" then
            if onDuty then sleep = 5 end
            if IsControlJustReleased(0, 38) then
                TriggerEvent("qb-police:client:spawnBoat")
            end
        else
            sleep = 5000
        end
        Wait(sleep)
    end
end)]]


-- Police Impound Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if inImpound and PlayerJob.name == "police" then
            if onDuty then sleep = 5 end
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                if IsControlJustReleased(0, 38) then
                    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                end
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

-- Police Garage Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if inGarage and PlayerJob.name == "police" then
            if onDuty then sleep = 5 end
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                if IsControlJustReleased(0, 38) then
                    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                end
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)
