-- Variables

local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()




function getNearestVeh()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end
local mdfTime = cfg.modifyTime
local function saveVehicle()
    local plyPed = PlayerPedId()
    local veh = QBCore.Functions.GetClosestVehicle()
    local vehicleMods = {
        mods = {},
    }
    vehicleMods.mods[11] = GetVehicleMod(veh,11)
    vehicleMods.mods[12] = GetVehicleMod(veh,12)
    vehicleMods.mods[13] = GetVehicleMod(veh,13)
    vehicleMods.mods[15] = GetVehicleMod(veh,15)
    vehicleMods.mods[18] = IsToggleModOn(veh, 18)

    local myCar = QBCore.Functions.GetVehicleProperties(veh)
    TriggerServerEvent('re2-tunerjob:updateVehicle',myCar)
end

local bones = {
    'bonnet'
  }
  exports['qb-target']:AddTargetBone(bones, { 
    options = { 
      { 
        label = 'Mechanic',
        targeticon = 'fas fa-cogs', 
        action = function(entity) 
          if IsPedAPlayer(entity) then return false end
          TriggerEvent('re2-tunerjob:client:openTunerStash')
        end,
        canInteract = function(entity, distance, data)
          local ped = PlayerPedId()
          local closestVehicle = getNearestVeh()
          if GetVehicleDoorAngleRatio(closestVehicle, 4) > 0 then
              return true
          else
              return false
          end
        end,
      }
    },
    distance = 2.5,
})

RegisterNetEvent('re2-tunerjob:client:openTunerStash', function()
    local closestVehicle = getNearestVeh()
    local plate=GetVehicleNumberPlateText(closestVehicle)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "tunerStash_"..plate, {
        maxweight = 1000,
        slots = 5,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "tunerStash_"..plate)
end)

RegisterNetEvent('re2-tunerjob:client:openStash', function(type)
    local closestVehicle = getNearestVeh()
    local plate=GetVehicleNumberPlateText(closestVehicle)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "tuner"..type.."Storage", {
        maxweight = 10000000,
        slots = 500,
    })
    TriggerEvent("inventory:client:SetCurrentStash",  "tuner"..type.."Storage")
end)

-- 

RegisterNetEvent('re2-tunerjob:client:openCraftMenu', function()
    local craftCategory = {{
        header = "Craft Category",
        isMenuHeader = true, -- Set to true to make a nonclickable title
    },}
    for i, v in pairs(cfg.crafts) do
        local tempData= {
            header = i,
            txt = i.." Levels",
			params = {
                isServer = false,
                event = "re2-tunerjob:client:openCraftSub",
                args = {
                    type = i,
                }
            }
        }
        table.insert(craftCategory, tempData)
    end
    
    exports['qb-menu']:openMenu(craftCategory)
end)

RegisterNetEvent('re2-tunerjob:client:craftItem', function(data)

    QBCore.Functions.Progressbar('craft',"Craft "..QBCore.Shared.Items[data.name].label, 10000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = '"anim@amb@clubhouse@tutorial@bkr_tut_ig3@"@',
        anim = 'machinic_loop_mechandplayer',
        flags = 16,
    }, {}, {}, function() 
        QBCore.Functions.TriggerCallback('re2-tunerjob:server:craftItem', function(result)
            if result then

                QBCore.Functions.Notify("Item Craft Sucessfuly", "primary")
                
            else
                QBCore.Functions.Notify("You Dont Have the Material", "error")
            end
        end, data)
        ClearPedTasks(PlayerPedId())
    end, function() -- Play When Cancel
        QBCore.Functions.Notify("Cancelled", "error")
        ClearPedTasks(PlayerPedId())
    end)
end)


RegisterNetEvent('re2-tunerjob:client:openCraftSub', function(data)
    local craftSubs = {

    }
    for i, v in pairs(cfg.crafts[data.type]) do
        local txt= ""
        for k, vv in pairs(v.items) do
            txt =txt..k.." "..vv.." "
        end
        local tempData= {
            header = QBCore.Shared.Items[i].label,
            txt = txt,
			params = {
                isServer = false,
                event = "re2-tunerjob:client:craftItem",
                args = {
                    material = v.items,
                    name = i
                }
            }
        }
        table.insert(craftSubs, tempData)
    end
    
    exports['qb-menu']:openMenu(craftSubs)
end)

RegisterNetEvent('re2-tunerjob:client:startTuningRequest', function(plate)
    print(plate)
    TriggerServerEvent('re2-tunerjob:requestTuning',plate)
end)




exports['qb-target']:AddBoxZone("tunerstash", vector3(128.82, -3014.15, 7.01), 1, 2.5, {
    name = 'tunerstash',
    debugPoly = false,
    heading =179.76,
    maxZ = 8,
    minZ = 6.5,
    }, {
        options = {
            {
                icon = 'fas fa-boxes',
                label = 'TunersStash',
                action = function()
                    TriggerEvent('re2-tunerjob:client:openStash',"stash")
                end,
                job = 'tuner',
            },
    },
    distance = 2.5
})
exports['qb-target']:AddBoxZone("tunerMaterialStorage", vector3(121.0, -3027.85, 7.01), 1, 2.5, {
    name = 'tunerMaterialStorage',
    debugPoly = false,
    heading =85.08,
    maxZ = 8,
    minZ = 6.5,
    }, {
        options = {
            {
                icon = 'fas fa-boxes',
                label = 'Material Stash',
                action = function()
                    TriggerEvent('re2-tunerjob:client:openStash',"material")
                end,
                job = 'tuner',
            },
    },
    distance = 2.5
})


local toolBoxModels = {
    `imp_prop_impexp_radiator_02`,
    `imp_prop_impexp_spoiler_01a`,
    `imp_prop_impexp_exhaust_06`,
    `imp_prop_impexp_wheel_04a`,
    `imp_prop_impexp_wheel_05a`,
    `imp_prop_impexp_gearbox_01`,
    `prop_rub_carpart_04`,
    `imp_prop_impexp_exhaust_01`,
    `imp_prop_impexp_engine_part_01a`
}
exports['qb-target']:AddTargetModel(toolBoxModels, {
        options = {
            
            {
                event = "re2-tunerjob:client:openCraftMenu",
                icon = "fas fa-wrench",
                label = "Item Crafting", 
                job = 'tuner',
            },
        },
    distance = 1.0
})






RegisterNetEvent('re2-tunerjob:modify:upgrade', function(data)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    for kk,vv in pairs(data) do
        local items = json.decode(vv.items)
        Wait(100)
        QBCore.Functions.Progressbar("tuner_modification", "Check Modification",mdfTime , false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            }, {
                animDict = "mini@repair",
                anim = "fixing_a_player",
                flags = 16,
            }, {}, {}, function() -- Done
                ClearPedTasksImmediately(PlayerPedId())
                SetVehicleModKit(vehicle, 0)
                SetVehicleMod(vehicle, 11, -1, true) -- remove engine
                SetVehicleMod(vehicle, 12, -1, true) -- remove brake
                SetVehicleMod(vehicle, 13, -1, true) -- remove transmision
                SetVehicleMod(vehicle, 15, -1, true) -- remove suspension
                ToggleVehicleMod(vehicle, 18, false) -- remove turbo

            saveVehicle()
        end)
        Wait(mdfTime+1000)
        
        for k, v in pairs(items) do
            Wait(100)
            if v.name== "engine1" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 11, 0, true) -- engine 1
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "engine2" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 11, 1, true) -- engine 2
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "engine3" then
                
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 11, 2, true) -- engine 3
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "engine4" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 11, 3, true) -- engine 4
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "brake1" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 12, 0, true) -- brake 1
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "brake2" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 12, 1, true) -- brake 2
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "brake3" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 12, 2, true) -- brake 3
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "transmission1" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 13, 0, true) -- transmision 1
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "transmission2" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 13, 1, true) -- transmision 2
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "transmission3" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 13, 2, true) -- transmision 3
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "suspension1" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 15, 0, true) -- suspension 1
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "suspension2" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 15, 1, true) -- suspension 2
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "suspension3" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 15, 2, true) -- suspension 3
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "suspension4" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 15, 3, true) -- suspension 4
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            elseif v.name== "turbo1" then
                QBCore.Functions.Progressbar("tuner_engine", "Check / Change "..v.label, mdfTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    SetVehicleModKit(vehicle, 0)
                    ToggleVehicleMod(vehicle, 18, true) -- add turbo
                    
                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                    saveVehicle()
                end)
                 
            end
            Wait(mdfTime+400)
        end
    end
end)

RegisterNetEvent('re2-tuner:client:show-image', function(url)
    SendNUIMessage({type = "show",image = url})
end)