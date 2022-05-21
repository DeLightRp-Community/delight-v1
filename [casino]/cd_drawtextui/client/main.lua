RegisterNetEvent('cd_drawtextui:ShowUI')
AddEventHandler('cd_drawtextui:ShowUI', function(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end)

RegisterNetEvent('cd_drawtextui:HideUI')
AddEventHandler('cd_drawtextui:HideUI', function()
	SendNUIMessage({
		action = 'hide'
	})
end)

function DrawTextUi(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end

function HideTextUi()
	SendNUIMessage({
		action = 'hide'
	})
end
