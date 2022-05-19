local QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}
local canTake = false
local inRange = false
local onDuty = false
local headerOpen = false

CreateThread(function()
	local blip = AddBlipForCoord(175.0, -1322.27, 29.36)
	SetBlipSprite(blip, 431)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.47)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName(Lang:t("info.title"))
	EndTextCommandSetBlipName(blip)
end)

-----------------------------------------------------------------------------------------
-- Job Details / Duty
-----------------------------------------------------------------------------------------
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "pawnshop" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

CreateThread(function()
	while true do
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			if onDuty and PlayerJob.Name == "pawnshop" then
				if #(pos - vector3(175.0, -1322.27, 29.36)) >= Config.ClockOutDist then 
					onDuty = not onDuty
					TriggerServerEvent("QBCore:ToggleDuty")
				end
			end
		Wait(100)
	end
end)

RegisterNetEvent('qb-pawnshop:toggleDuty', function()
	onDuty = not onDuty
	TriggerServerEvent('QBCore:ToggleDuty')
end)

--[[CreateThread(function()
	while true do
		Wait(500)
		local pos = GetEntityCoords(PlayerPedId())
		if #(pos - Config.PawnLocation) < 1.5 then
			inRange = true
		else
			inRange = false
		end
		if inRange and not headerOpen then
			headerOpen = true
			exports['qb-menu']:showHeader({
				{
					header = Lang:t('info.title'),
					txt = Lang:t('info.open_pawn'),
					params = {
						event = "qb-pawnshop:client:openMenu"
					}
				}
			})
		end
		if not inRange and headerOpen then
			headerOpen = false
			exports['qb-menu']:closeMenu()
		end
    end
end)]]

RegisterNetEvent('qb-pawnshop:client:openMenu', function()
	if Config.UseTimes then
		if GetClockHours() >= Config.TimeOpen and GetClockHours() <= Config.TimeClosed then
			local pawnShop = {
				{
					header = Lang:t('info.title'),
					isMenuHeader = true,
				},
				{
					header = Lang:t('info.sell'),
					txt = Lang:t('info.sell_pawn'),
					params = {
						event = "qb-pawnshop:client:openPawn",
						args = {
							items = Config.PawnItems
						}
					}
				}
			}
			exports['qb-menu']:openMenu(pawnShop)
		else
			QBCore.Functions.Notify(Lang:t('info.pawn_closed', {value = Config.TimeOpen, value2 = Config.TimeClosed}))
		end
	else
		local pawnShop = {
			{
				header = Lang:t('info.title'),
				isMenuHeader = true,
			},
			{
				header = Lang:t('info.sell'),
				txt = Lang:t('info.sell_pawn'),
				params = {
					event = "qb-pawnshop:client:openPawn",
					args = {
						items = Config.PawnItems
					}
				}
			}
		}
		exports['qb-menu']:openMenu(pawnShop)
	end
end)

RegisterNetEvent('qb-pawnshop:client:openPawn', function(data)
	QBCore.Functions.TriggerCallback('qb-pawnshop:server:getInv', function(inventory)
		local PlyInv = inventory
		local pawnMenu = {
			{
				header = Lang:t('info.title'),
				isMenuHeader = true,
			}
		}

		for k,v in pairs(PlyInv) do
			for i = 1, #data.items do
				if v.name == data.items[i].item then
					pawnMenu[#pawnMenu +1] = {
						header = QBCore.Shared.Items[v.name].label,
						txt = Lang:t('info.sell_items', {value = data.items[i].price}),
						params = {
							event = "qb-pawnshop:client:pawnitems",
							args = {
								label = QBCore.Shared.Items[v.name].label,
								price = data.items[i].price,
								name = v.name,
								amount = v.amount
							}
						}
					}
				end
			end
		end

		pawnMenu[#pawnMenu+1] = {
			header = Lang:t('info.back'),
			params = {
				event = "qb-pawnshop:client:openMenu"
			}
		}
		exports['qb-menu']:openMenu(pawnMenu)
	end)
end)

RegisterNetEvent("qb-pawnshop:client:pawnitems", function(item)
	local sellingItem = exports['qb-input']:ShowInput({
		header = Lang:t('info.title'),
		submitText = Lang:t('info.sell'),
		inputs = {
			{
				type = 'number',
				isRequired = false,
				name = 'amount',
				text = Lang:t('info.max', {value = item.amount})
			}
		}
	})

	if sellingItem then
		if not sellingItem.amount then
			return
		end

		if tonumber(sellingItem.amount) > 0 then
			TriggerServerEvent('qb-pawnshop:server:sellPawnItems', item.name, sellingItem.amount, item.price)
		else
			QBCore.Functions.Notify(Lang:t('error.negative'), 'error')
		end
	end
end)

RegisterNetEvent('qb-pawnshop:client:resetPickup', function()
	canTake = false
end)

-----------------------------------------------------------------------------------------
-- Billing
-----------------------------------------------------------------------------------------
RegisterNetEvent('qb-pawnshop:client:Charge', function()
	if not onDuty then TriggerEvent("QBCore:Notify", "Not clocked in!", "error") return end
    local dialog = exports['qb-input']:ShowInput({
        header = "Pay Customer",
        submitText = "Send",
        inputs = {
            { type = 'number', isRequired = true, name = 'citizen', text = 'CRN' },
            { type = 'number', isRequired = true, name = 'price', text = 'Payment Amount' },
        }
    })
    if dialog then
        if not dialog.citizen or not dialog.price then return end
        TriggerServerEvent('qb-pawnshop:server:Charge', dialog.citizen, dialog.price)
    end
end)

--- CUSTOMER TRAYS
RegisterNetEvent('qb-pawnshop:Stash')
AddEventHandler('qb-pawnshop:Stash',function(data)
	id = data.stash
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "pawnshop_"..id)
    TriggerEvent("inventory:client:SetCurrentStash", "pawnshop_"..id)
end)

-----------------------------------------------------------------------------------------
-- Target Exports
-----------------------------------------------------------------------------------------
---- DUTY 
exports['qb-target']:AddBoxZone("PawnClockin", vector3(168.88, -1313.76, 29.38), 0.75, 2, { name="PawnClockin", heading = 333, debugPoly=false, minZ=28.36, maxZ=29.96 }, 
{ options = { { event = "qb-pawnshop:toggleDuty", icon = "fas fa-user-check", label = "Toggle Duty", job = "pawnshop" }, },
  distance = 2.0
})
---- REGISTER 
exports['qb-target']:AddBoxZone("PawnRegister", vector3(174.02, -1322.66, 29.15), 0.75, 0.75, { name="PawnRegister", heading = 331, debugPoly=false, minZ=28.36, maxZ=29.96, }, 
{ options = { { event = "qb-pawnshop:client:Charge", icon = "fas fa-credit-card", label = "Pay Customer", job = "pawnshop" }, },
  distance = 2.0
})
---- TRAY 
exports['qb-target']:AddBoxZone("PawnCounter", vector3(173.48, -1320.72, 29.39), 0.75, 2, { name="PawnCounter", heading = 63, debugPoly=false, minZ=28.36, maxZ=29.56 }, 
{ options = { { event = "qb-pawnshop:Stash", icon = "fas fa-hamburger", label = "Counter", stash = "Counter" }, },
  distance = 2.0
})
---- COMPANY STASH 
exports['qb-target']:AddBoxZone("PawnStash", vector3(158.4, -1310.66, 29.38), 1.75, 1.75, { name="PawnStash", heading = 333, debugPoly=false, minZ=28.36, maxZ=29.51 }, 
{ options = { {  event = "qb-pawnshop:Stash", icon = "fas fa-credit-card", label = "Open Stash", stash = "Stash", job = "pawnshop"  }, },
  distance = 1.0
})

exports['qb-target']:AddBoxZone("PawnItemSell", vector3(157.34, -1316.77, 29.36), 1.6, 1, { name="PawnItemSell", heading=65, minZ=26.96,maxZ=30.96 }, 
{ options = { {  event = "qb-pawnshop:client:openMenu", icon = "fas fa-credit-card", label = "Sell Items", stash = "Stash", job = "pawnshop"  }, },
  distance = 1.0
})
