RegisterNetEvent("lambra-caravanHouse:server:buyCaravan", function(caravan)
  local src = source
  local vehicle = caravan
  local pData = QBCore.Functions.GetPlayer(src)
  local cid = pData.PlayerData.citizenid
  local bank = pData.PlayerData.money['bank']
  local vehiclePrice = Config.Caravans[caravan].price
  local plate = GeneratePlate()

  if bank >= vehiclePrice then
    MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
      pData.PlayerData.license,
      cid,
      vehicle,
      GetHashKey(vehicle),
      '{}',
      plate,
      0
    })
    TriggerClientEvent('QBCore:Notify', src, Locales["successBuy"], 'success')
    TriggerClientEvent('lambra-caravanHouse:client:buyCaravan', src, vehicle, plate)
    pData.Functions.RemoveMoney('bank', vehiclePrice)
  else
    TriggerClientEvent('QBCore:Notify', src, Locales["failBuy"], 'error')
  end
end)

function GeneratePlate()
  local plate = RandomInt(1) .. RandomStr(2) .. RandomInt(3) .. RandomStr(2)
  local result = MySQL.Sync.fetchScalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
  if result then
      return GeneratePlate()
  else
      return plate:upper()
  end
end