if Config.Framework == "NEW" then
    QBCore = exports[Config.CoreName]:GetCoreObject()
elseif Config.Framework == "OLD" then 
    QBCore = nil
    TriggerEvent(Config.CoreName, function(obj) QBCore = obj end) 
else
    print("The Framework '", Config.Framework, "' is not support, please change in config.lua")
end

QBCore.Commands.Add(Config.GiveMechanicJob, Config.GiveMechanicJobHelp, {{
    name = "id",
    help = Config.GiveMechanicJobHelp2
}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local TargetId = tonumber(args[1])
    if TargetId ~= nil then
        local TargetData = QBCore.Functions.GetPlayer(TargetId)
        if TargetData ~= nil then
            TargetData.Functions.SetJob(Config.Job)
            TriggerClientEvent('QBCore:Notify', TargetData.PlayerData.source, Language["Contratado"])
            TriggerClientEvent('QBCore:Notify', source, Language["OJogador"] .. TargetData.PlayerData.charinfo.firstname ..Language["FoiContratado"])
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Language["FaltaIDJogador"])
    end
end)

QBCore.Commands.Add(Config.FireMechanicJob, Config.FireMechanicJobHelp, {{
    name = "id",
    help = Config.FireMechanicJobHelp2
}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local TargetId = tonumber(args[1])
    if TargetId ~= nil then
        local TargetData = QBCore.Functions.GetPlayer(TargetId)
        if TargetData ~= nil then
            if TargetData.PlayerData.job.name == Config.Job then
                TargetData.Functions.SetJob(Config.Unemployed)
                TriggerClientEvent('QBCore:Notify', TargetData.PlayerData.source, Language["FosteDespedido"])
                TriggerClientEvent('QBCore:Notify', source, Language["OJogador"] .. TargetData.PlayerData.charinfo.firstname .. Language["FoiDespedido"])
            else
                TriggerClientEvent('QBCore:Notify', source, Language["NaoTrabalhas"], "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Language["FaltaIDJogador"], "error")
    end
end)

QBCore.Commands.Add(Config.BillPlayer, 'Bill a player', {{name = 'id', help = 'Player ID'}, {name = 'amount', help = 'Amount'}}, false, function(source, args)
    local biller = QBCore.Functions.GetPlayer(source)
    local billed = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local amount = tonumber(args[2])
    if biller.PlayerData.job.name == Config.Job then
        if billed ~= nil then
            if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                if amount and amount > 0 then
                    MySQL.Async.insert(
                        'INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)',
                        {billed.PlayerData.citizenid, amount, biller.PlayerData.job.name,
                         biller.PlayerData.charinfo.firstname, biller.PlayerData.citizenid})
                    TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                    TriggerClientEvent('QBCore:Notify', source, Language["FaturaEnviadaSucesso"], 'success')
                    TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, Language["FaturaRecebida"])
                else
                    TriggerClientEvent('QBCore:Notify', source, Language["ValorSuperior0"], 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', source, Language["FaturarProprio"], 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, Language["PlayerOffline"], 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Language["NoPermission"], 'error')
    end
end)
