local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local PlayerJob = {}
local floorsMenu = {}

AddEventHandler('onResourceStart', function(resource)
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerJob = PlayerData.job
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerJob = PlayerData.job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerJob = job
end)

local DrawText3Ds = function(x, y, z, text)
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

local function openFloorsMenu(lift, floor)
    floorsMenu = {
        {
            header = Config.Elevators[lift].Name,
            text = Config.Language[Config.UseLanguage].CurrentFloor .. Config.Elevators[lift].Floors[floor].Label,
            isMenuHeader = true
        },
    }

    for j = 1, #Config.Elevators[lift].Floors, 1 do
        if j ~= floor then
            floorsMenu[#floorsMenu + 1] = {
                header = '' .. Config.Elevators[lift].Floors[j].Label ..'',
                txt = '' .. Config.Elevators[lift].Floors[j].FloorDesc ..'',
                params = {
                    event = 'qb-lift:checkFloorPermission',
                    args = {
                        lift = lift,
                        floor = Config.Elevators[lift].Floors[j],
                    }
                }
            }
        end
	end
    exports['qb-menu']:openMenu(floorsMenu)
end

local function changeFloor(data)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("callLift", Config.Language[Config.UseLanguage].Waiting, 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@apt_trans@elevator",
        anim = "elev_1",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@apt_trans@elevator", "elev_1", 1.0)
        DoScreenFadeOut(500)
        TriggerEvent('qb-lift:music')
--        TriggerServerEvent("InteractSound_SV:PlayOnSource", "elevator", 0.15)
        Citizen.Wait(11000)
        exports['textUi']:HideTextUi('hide')
        if Config.UseSoundEffect then
            TriggerServerEvent("InteractSound_SV:PlayOnSource", Config.Elevators[data.lift].Sound, 0.05)
        end
        SetEntityCoords(ped, data.floor.Coords.x, data.floor.Coords.y, data.floor.Coords.z, 0, 0, 0, false)
        SetEntityHeading(ped, data.floor.ExitHeading)
        Citizen.Wait(1000)
        DoScreenFadeIn(600)

    end)
end

--[[CreateThread(function()
    Wait(1000)
    while true do
        Wait(5)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inLiftRange = false
        for k, v in pairs(Config.Elevators) do
            for i, b in pairs(Config.Elevators[k].Floors) do
                local liftDist = #(pos - b.Coords)
                if liftDist <= 1.5 then
                    inLiftRange = true
                    if liftDist <= 1.5 then
                        if not IsPedInAnyVehicle(ped) then
                            if IsControlJustPressed(0, 38) then
                                openFloorsMenu(k, i)
                            end
                        end
                    end
                end
            end
        end
        if not inLiftRange then
        end
    end
end)]]

RegisterNetEvent('qb-lift:checkFloorPermission')
AddEventHandler('qb-lift:checkFloorPermission', function(data)
    if Config.Elevators[data.lift].Job then
        if data.floor.Restricted then
            if IsAuthorized(PlayerJob.name, data.lift) then
                changeFloor(data)
            else
                QBCore.Functions.Notify(Config.Language[Config.UseLanguage].Restricted, "error")
            end
        else
            changeFloor(data)
        end
    else
        changeFloor(data)
    end
end)

RegisterNetEvent('qb-lift:nearestElevator')
AddEventHandler('qb-lift:nearestElevator', function()
    Wait(100)
    while true do
        Wait(5)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        for k, v in pairs(Config.Elevators) do
            for i, b in pairs(Config.Elevators[k].Floors) do
                local liftDist = #(pos - b.Coords)
                if liftDist <= 1.5 then
                    inLiftRange = true
                    if liftDist <= 1.5 then
                        if not IsPedInAnyVehicle(ped) then
                                openFloorsMenu(k, i)
                            end
                        end
                    end
                end
            end
        TriggerEvent('qb-lift:checkFloorPermission')
    end
end)

RegisterNetEvent('qb-lift:music')
AddEventHandler('qb-lift:music', function()
    local src = source
        for i = 1, 4 do
        local randomChance = math.random(1, 3)
            if randomChance <= 1 then
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "elevator" , 0.05)
		elseif randomChance >= 2 and randomChance <= 2 then
	        TriggerServerEvent("InteractSound_SV:PlayOnSource", "elevator2" , 0.05)
         else
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "elevator3" , 0.05)
	    end
    end
end)

--helper function
function IsAuthorized(job, lift)
    for a=1, #Config.Elevators[lift].Job do
        if job == Config.Elevators[lift].Job[a] then
            return true
        end
    end
    return false
end

-- QB TARGET

-- Casino

CreateThread(function()
    exports['qb-target']:AddBoxZone("CasinoFloorLift", vector3(960.1, 42.28, 71.7), 0.2, 0.2, {
        name="CasinoFloorLift",
        heading=15,
        debugPoly=false,
        minZ=71.7,
        maxZ=72.1
    },{
       options = {
               {
                  type = "client",
                  event = "qb-lift:nearestElevator",
                  icon = "fas fa-list",
                  label = "Take Elevator",
--                  item = "casino_keyfob",
               },
            },
            distance = 2
        })
    end)

    CreateThread(function()
        exports['qb-target']:AddBoxZone("CasinoHotelLift", vector3(910.02, -52.08, 21.0), 0.2, 0.2, {
            name="CasinoHotelLift",
            heading=55,
            debugPoly=false,
            minZ=21.0,
            maxZ=21.4
        },{
           options = {
                   {
                      type = "client",
                      event = "qb-lift:nearestElevator",
                      icon = "fas fa-list",
                      label = "Take Elevator",
    --                  item = "casino_keyfob",
                   },
                },
                distance = 2
            })
        end)

        CreateThread(function()
            exports['qb-target']:AddBoxZone("CasinoRoofLift", vector3(964.43, 57.58, 112.55), 0.2, 0.2, {
                name="CasinoRoofLift",
                heading=0,
                debugPoly=false,
                minZ=112.35,
                maxZ=112.75
            },{
               options = {
                       {
                          type = "client",
                          event = "qb-lift:nearestElevator",
                          icon = "fas fa-list",
                          label = "Take Elevator",
        --                  item = "casino_keyfob",
                       },
                    },
                    distance = 2
                })
            end)

-- Paleto Sheriff

CreateThread(function()
    exports['qb-target']:AddBoxZone("PaletoSTop", vector3(-449.59, 6009.43, 37.0), 0.4, 1.6, {
        name="PaletoSTop",
        heading=135,
        debugPoly=false,
        minZ=34.4,
        maxZ=38.4
    },{
       options = {
               {
                  type = "client",
                  event = "qb-lift:nearestElevator",
                  icon = "fas fa-list",
                  label = "Take Elevator",
--                  item = "casino_keyfob",
               },
            },
            distance = 2
        })
    end)

    CreateThread(function()
        exports['qb-target']:AddBoxZone("PaletoSMain", vector3(-450.55, 6010.86, 32.29), 2.0, 0.8, {
            name="PaletoSMain",
            heading=45,
            debugPoly=false,
            minZ=29.0,
            maxZ=33.7
        },{
           options = {
                   {
                      type = "client",
                      event = "qb-lift:nearestElevator",
                      icon = "fas fa-list",
                      label = "Take Elevator",
    --                  item = "casino_keyfob",
                   },
                },
                distance = 2
            })
        end)

        CreateThread(function()
            exports['qb-target']:AddBoxZone("PaletoSBottom", vector3(-450.4, 6010.8, 27.58), 0.4, 1.8, {
                name="PaletoSBottom",
                heading=0,
                debugPoly=false,
                minZ=24.98,
                maxZ=28.98
            },{
               options = {
                       {
                          type = "client",
                          event = "qb-lift:nearestElevator",
                          icon = "fas fa-list",
                          label = "Take Elevator",
        --                  item = "casino_keyfob",
                       },
                    },
                    distance = 2
                })
            end)

-- Pillbox Medical

CreateThread(function()
    exports['qb-target']:AddBoxZone("PillboxRoof", vector3(338.29, -583.73, 74.16), 0.2, 3.2, {
        name="PillboxRoof",
        heading=135,
        debugPoly=false,
        minZ=71.56,
        maxZ=75.56
    },{
       options = {
               {
                  type = "client",
                  event = "qb-lift:nearestElevator",
                  icon = "fas fa-list",
                  label = "Take Elevator",
--                  item = "casino_keyfob",
               },
            },
            distance = 2
        })
    end)

    CreateThread(function()
        exports['qb-target']:AddBoxZone("PillboxMain", vector3(327.06, -604.02, 43.29), 2.8, 0.4, {
            name="PillboxMain",
            heading=45,
            debugPoly=false,
            minZ=40.69,
            maxZ=44.69
        },{
           options = {
                   {
                      type = "client",
                      event = "qb-lift:nearestElevator",
                      icon = "fas fa-list",
                      label = "Take Elevator",
    --                  item = "casino_keyfob",
                   },
                },
                distance = 2
            })
        end)

        CreateThread(function()
            exports['qb-target']:AddBoxZone("PillboxLower", vector3(344.53, -584.66, 28.8), 0.2, 0.4, {
                name="PillboxLower",
                heading=339,
                debugPoly=false,
                minZ=25.1,
                maxZ=29.3
            },{
               options = {
                       {
                          type = "client",
                          event = "qb-lift:nearestElevator",
                          icon = "fas fa-list",
                          label = "Take Elevator",
        --                  item = "casino_keyfob",
                       },
                    },
                    distance = 2
                })
            end)

                CreateThread(function()
                    exports['qb-target']:AddBoxZone("realestatemain", vector3(-78.57, -826.15, 243.39), 1.8, 2, {
                        name="realestatemain",
                        heading=344,
                        debugPoly=false,
                        minZ=241.59,
                        maxZ=245.59
                    },{
                       options = {
                               {
                                  type = "client",
                                  event = "qb-lift:nearestElevator",
                                  icon = "fas fa-list",
                                  label = "Take Elevator",
                --                  item = "casino_keyfob",
                               },
                            },
                            distance = 2
                        })
                    end)

                    CreateThread(function()
                        exports['qb-target']:AddBoxZone("realestatentrance", vector3(-68.97, -802.48, 44.23), 1.4, 6.6, {
                            name="realestatentrance",
                            heading=344,
                            debugPoly=false,
                            minZ=43.23,
                            maxZ=47.23
                        },{
                           options = {
                                   {
                                      type = "client",
                                      event = "qb-lift:nearestElevator",
                                      icon = "fas fa-list",
                                      label = "Take Elevator",
                    --                  item = "casino_keyfob",
                                   },
                                },
                                distance = 2
                            })
                        end)

                        CreateThread(function()
                            exports['qb-target']:AddBoxZone("realestateroof", vector3(-73.73, -810.07, 243.39), 0.6, 2, {
                                name="realestateroof",
                                heading=250,
                                debugPoly=false,
                                minZ=240.79,
                                maxZ=244.79
                            },{
                               options = {
                                       {
                                          type = "client",
                                          event = "qb-lift:nearestElevator",
                                          icon = "fas fa-list",
                                          label = "Take Elevator",
                        --                  item = "casino_keyfob",
                                       },
                                    },
                                    distance = 2
                                })
                            end)

                            CreateThread(function()
                                exports['qb-target']:AddBoxZone("realestategarage", vector3(-84.98, -826.16, 36.03), 4.2, 1.6, {
                                    name="realestategarage",
                                    heading=81,
                                    debugPoly=false,
                                    minZ=34.03,
                                    maxZ=38.03
                                },{
                                   options = {
                                           {
                                              type = "client",
                                              event = "qb-lift:nearestElevator",
                                              icon = "fas fa-list",
                                              label = "Take Elevator",
                            --                  item = "casino_keyfob",
                                           },
                                        },
                                        distance = 2
                                    })
                                end)

                                CreateThread(function()
                                    exports['qb-target']:AddBoxZone("realestateroof2", vector3(-74.89, -823.97, 321.29), 0.4, 2, {
                                        name="realestateroof2",
                                        heading=340,
                                        debugPoly=false,
                                        minZ=318.69,
                                        maxZ=322.69
                                    },{
                                       options = {
                                               {
                                                  type = "client",
                                                  event = "qb-lift:nearestElevator",
                                                  icon = "fas fa-list",
                                                  label = "Take Elevator",
                                --                  item = "casino_keyfob",
                                               },
                                            },
                                            distance = 2
                                        })
                                    end)


                                    CreateThread(function()
                                        exports['qb-target']:AddBoxZone("realestategaragemain", vector3(-69.02, -828.22, 285.0), 1.6, 0.6, {
                                            name="realestategaragemain",
                                            heading=340,
                                            debugPoly=false,
                                            minZ=282.4,
                                            maxZ=286.6,
                                        },{
                                           options = {
                                                   {
                                                      type = "client",
                                                      event = "qb-lift:nearestElevator",
                                                      icon = "fas fa-list",
                                                      label = "Take Elevator",
                                    --                  item = "casino_keyfob",
                                                   },
                                                },
                                                distance = 2
                                            })
                                        end)
