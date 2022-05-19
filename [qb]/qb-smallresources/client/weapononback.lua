local attached_weapons = {}
local slots = {}

local function inHotbar(hash)
  for slot, item in pairs(slots) do
    if item ~= nil and Config.compatable_weapon_hashes[item.name] ~= nil then
      if hash == Config.compatable_weapon_hashes[item.name].hash then
        return true
      end
    end
  end
  return false
end

local function loadmodel(model)
    RequestModel(model)
    local wait = 0
    while not HasModelLoaded(model) and wait < 10 do
        Wait(100)
        wait = wait + 1
    end
end

local function AttachWeapon(attachModel,modelHash,boneNumber,x,y,z,xR,yR,zR)
    local bone = GetPedBoneIndex(PlayerPedId(), boneNumber)
  loadmodel(modelHash)
  attached_weapons[attachModel] = {
    hash = modelHash,
    handle = CreateObject(attachModel, 1.0, 1.0, 1.0, true, true, false)
  }
    AttachEntityToEntity(attached_weapons[attachModel].handle, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end

CreateThread(function()
  while true do
    if LocalPlayer.state['isLoggedIn'] then
      local ped = PlayerPedId()
      local items = QBCore.Functions.GetPlayerData().items
      if items ~= nil then 
        slots = { items[1], items[2], items[3], items[4], items[5], items[6], items[7], items[8], items[9], items[10], items[11], items[12], items[13], items[14], items[15], items[16], items[17], items[18], items[19], items[20], items[21], items[22], items[23], items[24], items[25], items[26], items[27], items[28], items[29], items[30], items[31], items[32], items[33], items[34], items[35], items[36], items[37], items[38], items[39], items[40]}
        for slot, item in pairs(slots) do
          if item ~= nil and Config.compatable_weapon_hashes[item.name] ~= nil then
            local wep_model = Config.compatable_weapon_hashes[item.name].model
            local wep_hash = Config.compatable_weapon_hashes[item.name].hash
            if not attached_weapons[wep_model] and GetSelectedPedWeapon(ped) ~= wep_hash then
                AttachWeapon(wep_model, wep_hash, Config.compatable_weapon_hashes[item.name].bone, Config.compatable_weapon_hashes[item.name].x, Config.compatable_weapon_hashes[item.name].y, Config.compatable_weapon_hashes[item.name].z, Config.compatable_weapon_hashes[item.name].xr, Config.compatable_weapon_hashes[item.name].yr, Config.compatable_weapon_hashes[item.name].zr)
            end
          end
        end
        for key, attached_object in pairs(attached_weapons) do
            if GetSelectedPedWeapon(ped) == attached_object.hash or not inHotbar(attached_object.hash) then
              DeleteObject(attached_object.handle)
              attached_weapons[key] = nil
            end
        end
      end
      Wait(500)
    else
      Wait(2500)
    end
  end
end)