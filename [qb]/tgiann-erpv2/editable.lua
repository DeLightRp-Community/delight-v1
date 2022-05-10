function showNotification(msg)
	BeginTextCommandThefeedPost('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandThefeedPostTicker(0,1)
end

function taskBar(time)
    return exports["tgiann-skillbar"]:taskBar(time*1000)
end

TriggerEvent('chat:addSuggestion', '/'..commands["erp"], 'Sends E-RP Request to Player! / E-RP Commands: /'..commands["p1"]..', /'..commands["p2"]..', /'..commands["p3"]..', /'..commands["p4"]..', /'..commands["p5"]..', /'..commands["p6"]..', /'..commands["p7"]..', /'..commands["erpcancel"], {{ name="id", help="Player Server ID!"}})
TriggerEvent('chat:addSuggestion', '/'..commands["erpcancel"], 'Revokes the permission of the permitted player')
TriggerEvent('chat:addSuggestion', '/'..commands["p1"], 'Sex position 1')
TriggerEvent('chat:addSuggestion', '/'..commands["p2"], 'Sex position 2 (Car)')
TriggerEvent('chat:addSuggestion', '/'..commands["p3"], 'Sex position 3')
TriggerEvent('chat:addSuggestion', '/'..commands["p4"], 'Sex position 4 (Car)')
TriggerEvent('chat:addSuggestion', '/'..commands["p5"], 'Sex position 6 (Car)')
TriggerEvent('chat:addSuggestion', '/'..commands["p6"], 'Sex position 6 (Car)')
TriggerEvent('chat:addSuggestion', '/'..commands["p7"], 'Sex position 7 (Car)')