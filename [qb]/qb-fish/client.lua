local isFishing = false
local inZone = false
local cancel = false
local veh = 0
local canSpawn = true
local QBCore = exports['qb-core']:GetCoreObject()
local zones = {
    'OCEANA',
    'ELYSIAN',
    'CYPRE',
    'DELSOL',
    'LAGO',
    'ZANCUDO',
    'ALAMO',
    'NCHU',
    'CCREAK',
    'PALCOV',
    'PALETO',
    'PROCOB',
    'ELGORL',
    'SANCHIA',
    'PALHIGH',
    'DELBE',
    'PBLUFF',
    'SANDY',
    'GRAPES',
}
local fishped = {
    "s_m_m_autoshop_02"
}

exports["qb-target"]:AddTargetModel(fishped, {
    options = {
        {
            type = "client",
            event = "qb-fish:ped",
            icon = "fas fa-circle",
            label = "Rent Boat",
            job = false,
        },

        {
            type = "client",
            event = "qb-fish:return",
            icon = "fas fa-circle",
            label = "Return Boat",
            job = false,
        },
    },
    distance = 3.0
})


RegisterNetEvent('qb-fish:ped', function(data)
local Getmecuh = PlayerPedId()
local plyCoords = GetEntityCoords(Getmecuh)
local car = GetHashKey('marquis')
    if canSpawn == true then
        TriggerServerEvent('fish:checkAndTakeDepo')
        Citizen.Wait(500)
        canSpawn = false
        RequestModel(car)
        while not HasModelLoaded(car) do
            Citizen.Wait(0)
        end
        veh = CreateVehicle(car, -3448.48, 971.98, 1.91, 0.0, true, false)
        SetEntityAsMissionEntity(veh, true, true)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        SetVehicleNumberPlateText(veh, "ACBV"..tostring(math.random(1000, 9999)))
        --SetEntityHeading(veh, coords.w)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
    else 

    end
end)


RegisterNetEvent('qb-fish:return', function(data)
	local Getmecuh = PlayerPedId()
	local plyCoords = GetEntityCoords(Getmecuh)
        DeleteVehicle(veh)
        veh = 0
        TriggerEvent('DoLongHudText', 'Vehicle Returned and your Deposit was Refunded!', 1)
        TriggerServerEvent('fish:returnDepo')
        SetEntityCoords(GetPlayerPed(-1), 3865.944, 4463.568, 2.73844)
        Citizen.Wait(2000)
        canSpawn = true
end)


function checkZone()
    local ply = PlayerPedId()
    local coords = GetEntityCoords(ply)
    local currZone = GetNameOfZone(coords)
    for k,v in pairs(zones) do
        if currZone == v then
            inZone = true
            break
        else
            inZone = false
        end
    end
    
end


function StartFish()
    local ply = PlayerPedId()
    local onBoat = false
    local function GetEntityBelow()
        local Ent = nil
        local CoA = GetEntityCoords(ply, 1)
        local CoB = GetOffsetFromEntityInWorldCoords(ply, 0.0, 0.0, 5.0)
        local RayHandle = CastRayPointToPoint(CoA.x, CoA.y, CoA.z, CoB.x, CoB.y, CoB.z, 10, ply, 0)
        local A,B,C,D,Ent = GetRaycastResult(RayHandle)
        return Ent
    end
    local boat = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 10.000, 0, 12294)
    checkZone()
    Citizen.Wait(250)
    if IsEntityInWater(boat) and IsPedSwimming(ply) == false and inZone == true then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
            isFishing = true
            cancel = false
            Fish()
            else
                QBCore.Functions.Notify("Cant fish right now", "error")
            end
        end, "fishingrod")
    elseif IsEntityInWater(ply) and IsPedSwimming(ply) == false and inZone == true then 
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
            isFishing = true
            cancel = false
            Fish()
            else
                QBCore.Functions.Notify("Cant fish right now", "error")
            end
        end, "fishingrod")
    else
        QBCore.Functions.Notify("You cant fish here.", "error")
    end
end  


function Fish()
    if cancel == false then
        local ply = PlayerPedId()
       --playerAnim() 
        TaskStartScenarioInPlace(ply, 'WORLD_HUMAN_STAND_FISHING', 0, true)
        timer = math.random(5000,10000)
        Citizen.Wait(timer)
        Catch()
    end
end

function Repeat()
    timer = math.random(5000,10000)
    if cancel == false then
        Citizen.Wait(timer)
        Catch()
    end
end

function Catch()
    if cancel == false then
        local ply = PlayerPedId()
        QBCore.Functions.Notify("There is a fish on the line.", "success")
        Citizen.Wait(1000)
        local count=math.random(2,3)
        local time = math.random(2,3)
        local finished = exports['qb-lock']:StartLockPickCircle(count, time)
        if finished then
                isFishing = false
                local rdn = math.random(1,100)
                if rdn <= 10 then
                    Citizen.Wait(2000)
                    SetCurrentPedWeapon(ply, `WEAPON_UNARMED`, true)
                    ClearPedTasksImmediately(ply)
                    Repeat()
                    TriggerServerEvent('QBCore:Server:AddItem', "fishingmackerel", 1)
                    QBCore.Functions.Notify("You caught a Fish", "success")
                    SetCurrentPedWeapon(ply, `WEAPON_UNARMED`, true)
                    ClearPedTasksImmediately(ply)
                elseif rdn > 11 then
                    QBCore.Functions.Notify("fish got away.", "error")
                    Repeat()
                end
        else
            SetCurrentPedWeapon(ply, `WEAPON_UNARMED`, true)
            ClearPedTasksImmediately(ply)
            isFishing = false
        end
    end
end

local blips = {
    {title="Boat Rental", colour=4, id=427, scale=0.7, x = -3424.41, y = 982.81, z = 8.43},
    {title="Boat Rental", colour=4, id=427, scale=0.7, x = 1308.91, y = 4362.29, z = 41.55},
    {title="Boat Rental", colour=4, id=427, scale=0.7, x = 3807.98, y = 4478.62, z = 6.37},
 }
     
Citizen.CreateThread(function()
   for _, info in pairs(blips) do
     info.blip = AddBlipForCoord(info.x, info.y, info.z)
     SetBlipSprite(info.blip, info.id)
     SetBlipDisplay(info.blip, 4)
     SetBlipScale(info.blip, info.scale)
     SetBlipColour(info.blip, info.colour)
     SetBlipAsShortRange(info.blip, true)
     BeginTextCommandSetBlipName("STRING")
     AddTextComponentString(info.title)
     EndTextCommandSetBlipName(info.blip)
   end
end)


function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

RegisterNetEvent('qb-fishing:skin')
AddEventHandler('qb-fishing:skin', function()
        local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
	    LoadDict(dict)
	    FreezeEntityPosition(GetPlayerPed(-1),true)
	    TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	    local PedCoords = GetEntityCoords(GetPlayerPed(-1))
	    prop = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	    AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
	    SetEntityHeading(GetPlayerPed(-1), 263.72814941406)
        QBCore.Functions.Progressbar("fish_skin", "Lighting cigarette...", 5 * 1000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
            }, {}, {}, {}, function() -- Done
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                TriggerEvent("inventory:removeItem", "fish", 1)
                        TriggerEvent('player:receiveItem', 'deskinedfish', 1)
                        FreezeEntityPosition(GetPlayerPed(-1),false)
                        DeleteEntity(prop)
                        ClearPedTasks(GetPlayerPed(-1))
                        Citizen.Wait(1000)
            else
                QBCore.Functions.Notify("Canceled...", "error")
            end
        
        end)
end)