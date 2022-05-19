QBCore = exports['qb-core']:GetCoreObject()

isLoggedIn = false

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    isLoggedIn = true
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(JobInfo)
    isLoggedIn = true
    PlayerJob = JobInfo
end)



Citizen.CreateThread(function()
    local idle = 1000
    local playerped = PlayerPedId()
    local PlayerData = QBCore.Functions.GetPlayerData()
    
        
    for k, v in pairs(Config.Locations) do
        exports['qb-target']:AddBoxZone(v.text, vector3(v.coords), 2, 2, {
            name=v.text,
            --heading= v.heading,
            debugPoly=false,
            minZ = v.coords.z - 2,
            maxZ = v.coords.z + 1 ,
          },{
            options = {
              {
                type = "client",
                action = function(entity)
                    TriggerEvent(Config.FolderName..":client:OpenMenu", v.config)
                end,
                icon = "fa fa-tint",  
                label = v.text,
                job = "pizza",
              },
            },
            distance = 2.0,
        })
    end

end)


RegisterNetEvent("qb-resturant:Storage")
AddEventHandler("qb-resturant:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "resturant")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "resturant", {
        maxweight = 2500000,
        slots = 50,
    })
end)

RegisterNetEvent("qb-resturant:shop")
AddEventHandler("qb-resturant:shop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "resturant", Config.Items)
end)

RegisterNetEvent('qb-resturant:OrderMenu', function(data)

    exports['qb-menu']:openMenu({
       {
           header = "Fridge",
           isMenuHeader = true, -- Set to true to make a nonclickable title
       },

       {
           header = "Purchase Ingredients",
           txt = "Order Items",
           params = {
               event = "qb-resturant:shop", 
               args = {
                   number = 0,
               }
           }
       },
       {
           header = "Fridge",
           txt = "Store items in the fridge",
           params = {
               event = "qb-resturant:Storage",
               args = {
                   number = 1,
               }
           }
       },

       {
           header = "close",
           txt = "",
           params = {
               event = "",
               args = {
                   number = 2,
               }
           }
       },
   })
end)

    exports["qb-target"]:AddBoxZone("yakhchal", vector3(805.68, -761.3, 26.78), 0.8, 1, {
        name = "yakhchal",
        heading = 350.0,
        debugPoly = false,
        minZ=24.38,
        maxZ=28.38
    }, {
        options = {
            {
                type = "client",
                event = "qb-resturant:OrderMenu",
                icon = "fas fa-vials",
                label = "Fridge & Storage",
                job = "pizza",
            },
        },
    distance = 2.5
    })


--Oven station--

--NH CONTEXT--
RegisterNetEvent(Config.FolderName..":client:OpenMenu")
AddEventHandler(Config.FolderName..":client:OpenMenu", function(config)
    for k, v in pairs(config) do
        exports['qb-menu']:openMenu({
            {
                id = k,
                header = v.label,
                txt = v.description,
                params = {
                    event = Config.FolderName..":menu:AllStations",
                    args = {
                        item = v.item, --item that will be given
                        required = v.required, -- required items to make
                        progressbar = v.progressbar, -- text to display on progressbar
                        progresstime = v.progresstime, -- in milliseconds
                        dictionary = v.dictionary, --dictionary name for animation
                        animname = v.animname --animation name
                    }
                }
            },
        })
    end 
end)


--[[RegisterNetEvent(Config.FolderName..":client:OpenMenu")
AddEventHandler(Config.FolderName..":client:OpenMenu", function(config)

    for k, v in pairs(config) do
        local pizzajob = {
            {
                header = v.label,
                isMenuHeader = true
            }
        }
            pizzajob[#pizzajob+1] = {
                header = v.label,
                txt = v.description,
                params = {
                    event = Config.FolderName..":menu:AllStations",
                    args = {
                        item = v.item, --item that will be given
                        required = v.required, -- required items to make
                        progressbar = v.progressbar, -- text to display on progressbar
                        progresstime = v.progresstime, -- in milliseconds
                        dictionary = v.dictionary, --dictionary name for animation
                        animname = v.animname --animation name
                    }
                }
            }
        
        pizzajob[#pizzajob+1] = {
            header = "Close Menu",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu"
            }

        }
    end
         exports['qb-menu']:openMenu(pizzajob)
end)]]

--QB Menu Option --

--[[RegisterNetEvent(Config.FolderName..":client:OpenMenu")
AddEventHandler(Config.FolderName..":client:OpenMenu", function(config)
    local restaurantMenu = {}
    for k, v in pairs(config) do
        table.insert(restaurantMenu, {
            header = v.label,
            txt = v.description,
            params = {
                event = Config.FolderName..':menu:AllStations',
                args = {
                    item = v.item, --item that will be given
                    required = v.required, -- required items to make
                    progressbar = v.progressbar, -- text to display on progressbar
                    progresstime = v.progresstime, -- in milliseconds
                    dictionary = v.dictionary, --dictionary name for animation
                    animname = v.animname --animation name
                }
            }
        })
    end
    exports['qb-menu']:openMenu(restaurantMenu) 
end)]]--

RegisterNetEvent(Config.FolderName..":menu:AllStations")
AddEventHandler(Config.FolderName..":menu:AllStations", function(data)
    QBCore.Functions.TriggerCallback(Config.FolderName..":server:get:ingredient", function(HasItems)
        if HasItems then
            local ped = PlayerPedId()
            local playerPed = PlayerPedId()
            local src = source 
            LoadAnim(data.dictionary)
            TaskPlayAnim(ped, data.dictionary, data.animname, 6.0, -6.0, -1, 46, 0, 0, 0, 0)
            FreezeEntityPosition(playerPed, true)
                QBCore.Functions.Progressbar("cutting_station", data.progressbar, data.progresstime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done    
                
                ClearPedTasksImmediately(ped)
                FreezeEntityPosition(playerPed, false)
            TriggerServerEvent(Config.FolderName..':server:cook', data.required, data.item)
            end)
        else
            QBCore.Functions.Notify("You don\'t have all the ingredients!", "error")
        end
    end, data.required)
end)

--stash--
RegisterNetEvent(Config.FolderName..":client:jobstash")
AddEventHandler(Config.FolderName..":client:jobstash", function(name, size, slots)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", name, {
        maxweight = size,
        slots = slots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", name)
end)

function LoadAnim(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end
