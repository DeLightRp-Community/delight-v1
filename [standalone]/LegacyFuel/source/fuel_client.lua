local isNearPump = false
local isFueling = false
local currentFuel = 0.0
local currentCost = 0.0
local currentCash = 1000
local fuelSynced = false
local inBlacklisted = false
local QBCore = exports['qb-core']:GetCoreObject()
-- Pros/models for fuel pumps around map 
local prop = {
	"prop_gas_pump_1d",
	"prop_gas_pump_1a",
	"prop_gas_pump_1b",
	"prop_gas_pump_1c",
	"prop_vintage_pump",
	"prop_gas_pump_old2",
	"prop_gas_pump_old3",
}
-- Bones for vehicle doors
local bones = {
	"door_dside_f",
	"door_dside_r",
	"door_pside_f",
	"door_pside_r",
}

exports['qb-target']:AddTargetBone(bones, {
	options = {
		{
			type = "client",
			event = "LegacyFuel:client:fuel",
			icon = "fas fa-gas-pump",
			label = "Refuel Car",
			item = 'weapon_petrolcan',
		},
	},
		distance = 1.5
})

  exports['qb-target']:AddTargetModel(prop, {
	options = {
		{
			type = "client",
			event = "LegacyFuel:client:fuelMenu",
			icon = "fas fa-gas-pump",
			label = "Refuel Car",
		},
		{
			type = "client",
			event = "LegacyFuel:client:buyJerryCanMenu",
			icon = "fas fa-burn",
			label = "Buy Jerry Can",
		},
		{
			type = "client",
			event = "LegacyFuel:client:refuelJerryCanMenu",
			icon = "fas fa-gas-pump",
			label = "Refuel Jerry Can",
			item = "weapon_petrolcan",
		},
	},
		distance = 2.0
})

-- Fuel pump menu and refuel at gas stations

RegisterNetEvent('LegacyFuel:client:fuelMenu')
AddEventHandler('LegacyFuel:client:fuelMenu', function()
    local gasmenu = {
        {
            header = "Gas Station",
            isMenuHeader = true
        }
    }
        gasmenu[#gasmenu+1] = {
            header = "Gas Station",
            txt = "Use fuel pump. Remember there will be a 10% tax fee.",
            params = {
                event = "LegacyFuel:client:fuel",
                args = {
                    vehicle = veh
                }
            }
        }
    
    gasmenu[#gasmenu+1] = {
        header = "Close Menu",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(gasmenu)
end)

RegisterNetEvent('LegacyFuel:client:fuel')
AddEventHandler('LegacyFuel:client:fuel', function()
        local ped = PlayerPedId()
        if not isFueling and ((isNearPump and GetEntityHealth(isNearPump) > 0) or (GetSelectedPedWeapon(ped) == 883325847 and not isNearPump)) then
            if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped then
                local pumpCoords = GetEntityCoords(isNearPump)
                --DrawText3Ds(pumpCoords.x, pumpCoords.y, pumpCoords.z + 1.2, Config.Strings.ExitVehicle)
            else
                local vehicle = GetPlayersLastVehicle()
                local vehicleCoords = GetEntityCoords(vehicle)
                if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(ped), vehicleCoords) < 2.5 then
                    if not DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
                        local stringCoords = GetEntityCoords(isNearPump)
                        local canFuel = true
                        if GetSelectedPedWeapon(ped) == 883325847 then
                            stringCoords = vehicleCoords

                            if GetAmmoInPedWeapon(ped, 883325847) < 100 then
                                canFuel = false
                            end
                        end
                        if GetVehicleFuelLevel(vehicle) < 95 and canFuel then
                            if currentCash > 0 then
                                --DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.EToRefuel)
                                    isFueling = true
									QBCore.Functions.Progressbar("refuel", "Starting to Refuel Vehicle", 2000, false, true, {
										disableMovement = true,
										disableCarMovement = false,
										disableMouse = false,
										disableCombat = true,
									}, {}, {}, {}, function()
									LoadAnimDict("timetable@gardener@filling_can")
                                    TriggerEvent('fuel:refuelFromPump', isNearPump, ped, vehicle)
									end)
                            else
                               --DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCash)
							   TriggerEvent('QBCore:Notify', "Not enough cash!", "error")
                            end
                        elseif not canFuel then
                            --DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.JerryCanEmpty)
							TriggerEvent('QBCore:Notify', "Jerry can is empty!", "error")
                        else
                            --DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.FullTank)
							TriggerEvent('QBCore:Notify', "Tank is full!", "error")
                        end
                    end
                else
                    Citizen.Wait(250)
                end
            end
        else
            Citizen.Wait(250)
        end
        Citizen.Wait(0)
    
end)

-- Buy jerry can at fuel pump menu and refuel jerry can at gas stations


RegisterNetEvent('LegacyFuel:client:buyJerryCanMenu')
AddEventHandler('LegacyFuel:client:buyJerryCanMenu', function()
    local gasmenu2 = {
        {
            header = "Gas Station",
            isMenuHeader = true
        }
    }
        gasmenu2[#gasmenu2+1] = {
            header = "Gas Station",
            txt = "Buy jerry can. Remember there will be a 10% tax fee.",
            params = {
                event = "LegacyFuel:client:buyJerryCan",
                args = {
                    vehicle = veh
                }
            }
        }
    
    gasmenu2[#gasmenu2+1] = {
        header = "Close Menu",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(gasmenu2)
end)

RegisterNetEvent('LegacyFuel:client:buyJerryCan')
AddEventHandler('LegacyFuel:client:buyJerryCan', function()
	local stringCoords = GetEntityCoords(isNearPump)
	if currentCash >= Config.JerryCanCost then
		if not HasPedGotWeapon(ped, 883325847) then
			--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.PurchaseJerryCan)
				TriggerServerEvent('QBCore:Server:AddItem', "weapon_petrolcan", 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["weapon_petrolcan"], "add")
				TriggerServerEvent('fuel:pay', Config.JerryCanCost, GetPlayerServerId(PlayerId()))
			else
		end
	end
end)


RegisterNetEvent('LegacyFuel:client:buyJerryCanMenu')
AddEventHandler('LegacyFuel:client:buyJerryCanMenu', function()
    local gasmenu3 = {
        {
            header = "Gas Station",
            isMenuHeader = true
        }
    }
        gasmenu3[#gasmenu3+1] = {
            header = "Gas Station",
            txt = "Refuel jerry can. Remember there will be a 10% tax fee.",
            params = {
                event = "LegacyFuel:client:refuelJerryCan",
                args = {
                }
            }
        }
    
    gasmenu3[#gasmenu3+1] = {
        header = "Close Menu",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(gasmenu3)
end)


RegisterNetEvent('LegacyFuel:client:refuelJerryCan')
AddEventHandler('LegacyFuel:client:refuelJerryCan', function()
	local stringCoords = GetEntityCoords(isNearPump)
	local refillCost = Round(Config.RefillCost * (1 - GetAmmoInPedWeapon(ped, 883325847) / 4500))

	if refillCost > 0 then
		if currentCash >= refillCost then
				TriggerServerEvent('fuel:pay', refillCost, GetPlayerServerId(PlayerId()))
	
				SetPedAmmo(ped, 883325847, 4500)
			end
		else
			--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCashJerryCan)
			TriggerEvent('QBCore:Notify', "Not enough cash", "error")
		end
end)


function ManageFuelUsage(vehicle)
	if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))

		fuelSynced = true
	end

	if IsVehicleEngineOn(vehicle) then
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
	end
end

Citizen.CreateThread(function()
	DecorRegister(Config.FuelDecor, 1)

	for index = 1, #Config.Blacklist do
		if type(Config.Blacklist[index]) == 'string' then
			Config.Blacklist[GetHashKey(Config.Blacklist[index])] = true
		else
			Config.Blacklist[Config.Blacklist[index]] = true
		end
	end

	for index = #Config.Blacklist, 1, -1 do
		table.remove(Config.Blacklist, index)
	end

	while true do
		Citizen.Wait(1000)

		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)

			if Config.Blacklist[GetEntityModel(vehicle)] then
				inBlacklisted = true
			else
				inBlacklisted = false
			end

			if not inBlacklisted and GetPedInVehicleSeat(vehicle, -1) == ped then
				ManageFuelUsage(vehicle)
			end
		else
			if fuelSynced then
				fuelSynced = false
			end

			if inBlacklisted then
				inBlacklisted = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)

		local pumpObject, pumpDistance = FindNearestFuelPump()

		if pumpDistance < 2.5 then
			isNearPump = pumpObject
			currentCash = QBCore.Functions.GetPlayerData().money['cash']
		else
			isNearPump = false

			Citizen.Wait(math.ceil(pumpDistance * 20))
		end
	end
end)

AddEventHandler('fuel:startFuelUpTick', function(pumpObject, ped, vehicle)
	currentFuel = GetVehicleFuelLevel(vehicle)

	while isFueling do
		Citizen.Wait(500)

		local oldFuel = DecorGetFloat(vehicle, Config.FuelDecor)
		local fuelToAdd = math.random(10, 20) / 10.0
		local extraCost = fuelToAdd / 1.5 * Config.CostMultiplier

		if not pumpObject then
			if GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100 >= 0 then
				currentFuel = oldFuel + fuelToAdd

				SetPedAmmo(ped, 883325847, math.floor(GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100))
			else
				isFueling = false
			end
		else
			currentFuel = oldFuel + fuelToAdd
		end

		if currentFuel > 100.0 then
			currentFuel = 100.0
			isFueling = false
		end

		currentCost = currentCost + extraCost

		if currentCash >= currentCost then
			SetFuel(vehicle, currentFuel)
		else
			isFueling = false
		end
	end

	if pumpObject then
		TriggerServerEvent('fuel:pay', currentCost, GetPlayerServerId(PlayerId()))
	end

	currentCost = 0.0
end)

AddEventHandler('fuel:refuelFromPump', function(pumpObject, ped, vehicle)
	TaskTurnPedToFaceEntity(ped, vehicle, 1000)
	Citizen.Wait(1000)
	SetCurrentPedWeapon(ped, -1569615261, true)
	LoadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)

	TriggerEvent('fuel:startFuelUpTick', pumpObject, ped, vehicle)

	while isFueling do
		for _, controlIndex in pairs(Config.DisableKeys) do
			DisableControlAction(0, controlIndex)
		end

		local vehicleCoords = GetEntityCoords(vehicle)

		if pumpObject then
			local stringCoords = GetEntityCoords(pumpObject)
			local extraString = "\n" .. Config.Strings.TotalCost .. ": ~g~$" .. Round(currentCost, 1)

			--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.CancelFuelingPump .. extraString)
			--DrawText3Ds(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z + 0.5, Round(currentFuel, 1) .. "%")
		else
			--DrawText3Ds(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z + 0.5, Config.Strings.CancelFuelingJerryCan .. "\nGas can: ~g~" .. Round(GetAmmoInPedWeapon(ped, 883325847) / 4500 * 100, 1) .. "% | Vehicle: " .. Round(currentFuel, 1) .. "%")
		end

		if not IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
			TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
		end

		if IsControlJustReleased(0, 38) or DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) or (isNearPump and GetEntityHealth(pumpObject) <= 0) then
			isFueling = false
		end

		Citizen.Wait(0)
	end

	ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
	Citizen.Wait(120)
	TriggerEvent('QBCore:Notify', "Vehicle Refueled!", "success")
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if not isFueling and ((isNearPump and GetEntityHealth(isNearPump) > 0) or (GetSelectedPedWeapon(ped) == 883325847 and not isNearPump)) then
			if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped then
				local pumpCoords = GetEntityCoords(isNearPump)

				--DrawText3Ds(pumpCoords.x, pumpCoords.y, pumpCoords.z + 1.2, Config.Strings.ExitVehicle)
			else
				local vehicle = GetPlayersLastVehicle()
				local vehicleCoords = GetEntityCoords(vehicle)

				if DoesEntityExist(vehicle) and #(GetEntityCoords(ped) - vehicleCoords) < 2.5 then
					if not DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
						local stringCoords = GetEntityCoords(isNearPump)
						local canFuel = true

						if GetSelectedPedWeapon(ped) == 883325847 then
							stringCoords = vehicleCoords

							if GetAmmoInPedWeapon(ped, 883325847) < 100 then
								canFuel = false
							end
						end

						if GetVehicleFuelLevel(vehicle) < 95 and canFuel then
							if currentCash > 0 then
								--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.EToRefuel)

								if IsControlJustReleased(0, 38) then
									isFueling = true

									TriggerEvent('fuel:refuelFromPump', isNearPump, ped, vehicle)
									LoadAnimDict("timetable@gardener@filling_can")
								end
							else
								--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCash)
							end
						elseif not canFuel then
							--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.JerryCanEmpty)
						else
							--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.FullTank)
						end
					end
				elseif isNearPump then
					local stringCoords = GetEntityCoords(isNearPump)

					if currentCash >= Config.JerryCanCost then
						if not HasPedGotWeapon(ped, 883325847) then
							--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.PurchaseJerryCan)

							if IsControlJustReleased(0, 38) then
								TriggerServerEvent('QBCore:Server:AddItem', "weapon_petrolcan", 1)
								TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["weapon_petrolcan"], "add")
								TriggerServerEvent('fuel:pay', Config.JerryCanCost, GetPlayerServerId(PlayerId()))
							end
						else
							local refillCost = Round(Config.RefillCost * (1 - GetAmmoInPedWeapon(ped, 883325847) / 4500))

							if refillCost > 0 then
								if currentCash >= refillCost then
									--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.RefillJerryCan .. refillCost)

									if IsControlJustReleased(0, 38) then
										TriggerServerEvent('fuel:pay', refillCost, GetPlayerServerId(PlayerId()))

										SetPedAmmo(ped, 883325847, 4500)
									end
								else
									--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCashJerryCan)
								end
							else
								--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.JerryCanFull)
							end
						end
					else
						--DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCash)
					end
				else
					Citizen.Wait(250)
				end
			end
		else
			Citizen.Wait(250)
		end

		Citizen.Wait(0)
	end
end)

if Config.ShowNearestGasStationOnly then
	Citizen.CreateThread(function()
		local currentGasBlip = 0

		while true do
			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords

			for _, gasStationCoords in pairs(Config.GasStations) do
				local dstcheck = #(coords - gasStationCoords)

				if dstcheck < closest then
					closest = dstcheck
					closestCoords = gasStationCoords
				end
			end

			if DoesBlipExist(currentGasBlip) then
				RemoveBlip(currentGasBlip)
			end

			currentGasBlip = CreateBlip(closestCoords)

			Citizen.Wait(10000)
		end
	end)
elseif Config.ShowAllGasStations then
	Citizen.CreateThread(function()
		for _, gasStationCoords in pairs(Config.GasStations) do
			CreateBlip(gasStationCoords)
		end
	end)
end

if Config.EnableHUD then
	local function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
		SetTextFont(font)
		SetTextProportional(0)
		SetTextScale(sc, sc)
		N_0x4e096588b13ffeca(jus)
		SetTextColour(r, g, b, a)
		SetTextDropShadow(0, 0, 0, 0,255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(x - 0.1+w, y - 0.02+h)
	end

	local mph = 0
	local kmh = 0
	local fuel = 0
	local displayHud = false

	local x = 0.01135
	local y = 0.002

	Citizen.CreateThread(function()
		while true do
			local ped = PlayerPedId()

			if IsPedInAnyVehicle(ped) and not (Config.RemoveHUDForBlacklistedVehicle and inBlacklisted) then
				local vehicle = GetVehiclePedIsIn(ped)
				local speed = GetEntitySpeed(vehicle)

				mph = tostring(math.ceil(speed * 2.236936))
				kmh = tostring(math.ceil(speed * 3.6))
				fuel = tostring(math.ceil(GetVehicleFuelLevel(vehicle)))

				displayHud = true
			else
				displayHud = false

				Citizen.Wait(500)
			end

			Citizen.Wait(50)
		end
	end)

	Citizen.CreateThread(function()
		while true do
			if displayHud then
				--DrawAdvancedText(0.130 - x, 0.77 - y, 0.005, 0.0028, 0.6, mph, 255, 255, 255, 255, 6, 1)
				--DrawAdvancedText(0.174 - x, 0.77 - y, 0.005, 0.0028, 0.6, kmh, 255, 255, 255, 255, 6, 1)
				--DrawAdvancedText(0.2195 - x, 0.77 - y, 0.005, 0.0028, 0.6, fuel, 255, 255, 255, 255, 6, 1)
				--DrawAdvancedText(0.148 - x, 0.7765 - y, 0.005, 0.0028, 0.4, "mp/h              km/h              Fuel", 255, 255, 255, 255, 6, 1)
			else
				Citizen.Wait(750)
			end

			Citizen.Wait(0)
		end
	end)
end
