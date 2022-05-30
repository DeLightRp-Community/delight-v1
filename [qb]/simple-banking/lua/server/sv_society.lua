function GetSociety(name)
    local result = MySQL.Sync.fetchAll('SELECT * FROM management_funds WHERE job_name= ?', {name}) --exports['ghmattimysql']:execute("SELECT * FROM `society` WHERE `name` ='"..name.."' ")
    local data = result[1]

    return data
end


RegisterNetEvent('qb-banking:society:server:WithdrawMoney')
AddEventHandler('qb-banking:society:server:WithdrawMoney', function(pSource, a, n)
    local src = pSource
    if not src then return end
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end

    if not a then return end
    if not n then return end

    local s = GetSociety(n)
    local sMoney = tonumber(s.amount)
    local amount = tonumber(a)
    local withdraw = sMoney - amount
    local setter = MySQL.Sync.fetchAll("UPDATE management_funds  SET amount = ? WHERE job_name = ?", {withdraw, n})
end)

RegisterServerEvent('qb-banking:society:server:DepositMoney')
AddEventHandler('qb-banking:society:server:DepositMoney', function(pSource, a, n)
    local src = pSource
    if not src then return end


    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end

    if not a then return end
    if not n then return end

    local s = GetSociety(n)
    local sMoney = tonumber(s.amount)
    local amount = tonumber(a)
    local deposit = sMoney + amount

    
    local setter = MySQL.Sync.fetchAll("UPDATE management_funds SET amount =  ? WHERE job_name = ?", {deposit, n})
end)