-- [ Code ] --

-- [ Functions ] --

function ToggleDevMode(Bool)
    TriggerEvent('qb-admin:client:ToggleDevmode')
    if Bool then
        while Bool do
            Wait(200)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
    end
end

function IsPlayerAdmin() 
    local Promise = promise:new()
    QBCore.Functions.TriggerCallback('iyc-adminmenu:server:get-permission', function(IsAdmin)
        Promise:resolve(IsAdmin)
    end)
    return Promise
end

function DebugLog(Message)
    if Config.MenuDebug then
        print('[DEBUG]: ', Message)
    end
end

function DeletePlayerBlips()
    if AllPlayerBlips ~= nil then
        for k, v in pairs(AllPlayerBlips) do
            RemoveBlip(v) 
        end
        AllPlayerBlips = {}
    end
end

function DrawEntityBoundingBox(entity)
    local color = {r = 255, g = 50, b = 50, a = 100}
    local color2 = {r = 255, g = 255, b = 255, a = 255}
    local model = GetEntityModel(entity)
    local min,max = GetModelDimensions(model)

    local top_front_right = GetOffsetFromEntityInWorldCoords(entity,max)
    local top_back_right = GetOffsetFromEntityInWorldCoords(entity,vector3(max.x,min.y,max.z))
    local bottom_front_right = GetOffsetFromEntityInWorldCoords(entity,vector3(max.x,max.y,min.z))
    local bottom_back_right = GetOffsetFromEntityInWorldCoords(entity,vector3(max.x,min.y,min.z))

    local top_front_left = GetOffsetFromEntityInWorldCoords(entity,vector3(min.x,max.y,max.z))
    local top_back_left = GetOffsetFromEntityInWorldCoords(entity,vector3(min.x,min.y,max.z))
    local bottom_front_left = GetOffsetFromEntityInWorldCoords(entity,vector3(min.x,max.y,min.z))
    local bottom_back_left = GetOffsetFromEntityInWorldCoords(entity,min)


    -- LINES

    -- RIGHT SIDE
    DrawLine(top_front_right,top_back_right,color2.r,color2.g,color2.b,color2.a)
    DrawLine(top_front_right,bottom_front_right,color2.r,color2.g,color2.b,color2.a)
    DrawLine(bottom_front_right,bottom_back_right,color2.r,color2.g,color2.b,color2.a)
    DrawLine(top_back_right,bottom_back_right,color2.r,color2.g,color2.b,color2.a)

    -- LEFT SIDE
    DrawLine(top_front_left,top_back_left,color2.r,color2.g,color2.b,color2.a)
    DrawLine(top_back_left,bottom_back_left,color2.r,color2.g,color2.b,color2.a)
    DrawLine(top_front_left,bottom_front_left,color2.r,color2.g,color2.b,color2.a)
    DrawLine(bottom_front_left,bottom_back_left,color2.r,color2.g,color2.b,color2.a)

    -- Connection
    DrawLine(top_front_right,top_front_left,color2.r,color2.g,color2.b,color2.a)
    DrawLine(top_back_right,top_back_left,color2.r,color2.g,color2.b,color2.a)
    DrawLine(bottom_front_left,bottom_front_right,color2.r,color2.g,color2.b,color2.a)
    DrawLine(bottom_back_left,bottom_back_right,color2.r,color2.g,color2.b,color2.a)


    -- POLYGONS

    -- FRONT
    DrawPoly(top_front_left,top_front_right,bottom_front_right,color.r,color.g,color.b,color.a)
    DrawPoly(bottom_front_right,bottom_front_left,top_front_left,color.r,color.g,color.b,color.a)

    -- TOP
    DrawPoly(top_front_right,top_front_left,top_back_right,color.r,color.g,color.b,color.a)
    DrawPoly(top_front_left,top_back_left,top_back_right,color.r,color.g,color.b,color.a)

    -- BACK
    DrawPoly(top_back_right,top_back_left,bottom_back_right,color.r,color.g,color.b,color.a)
    DrawPoly(top_back_left,bottom_back_left,bottom_back_right,color.r,color.g,color.b,color.a)

    -- LEFT
    DrawPoly(top_back_left,top_front_left,bottom_front_left,color.r,color.g,color.b,color.a)
    DrawPoly(bottom_front_left,bottom_back_left,top_back_left,color.r,color.g,color.b,color.a)

    -- RIGHT
    DrawPoly(top_front_right,top_back_right,bottom_front_right,color.r,color.g,color.b,color.a)
    DrawPoly(top_back_right,bottom_back_right,bottom_front_right,color.r,color.g,color.b,color.a)

    -- BOTTOM
    DrawPoly(bottom_front_left,bottom_front_right,bottom_back_right,color.r,color.g,color.b,color.a)
    DrawPoly(bottom_back_right,bottom_back_left,bottom_front_left,color.r,color.g,color.b,color.a)

    return true
end

function DrawText3D(Coords, Text)
    local OnScreen, _X, _Y = World3dToScreen2d(Coords.x, Coords.y, Coords.z)
    SetTextScale(0.3, 0.3)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 0, 0, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(Text)
    DrawText(_X, _Y)
end

function roundDecimals(num, decimals)
	local mult = math.pow(10, decimals or 0)
	return math.floor(num * mult + 0.5) / 100
end

function UpdateMenu()
    local Players = GetPlayers()
    SendNUIMessage({
        Action = 'Update',
        AllPlayers = Players,
        AdminItems = Config.AdminMenus,
        Favorited = Config.FavoritedItems,
        PinnedPlayers = Config.PinnedTargets,
        MenuSettings = Config.AdminSettings
    })
end

function SetKvp(Name, Data, Type)
    SetResourceKvp(Name, Data)
    RefreshMenu(Type)
end

function RefreshMenu(Type)
    if Type == 'Favorites' then
        -- Favorites
        if GetResourceKvpString("iyc-adminmenu-favorites") == nil or GetResourceKvpString("iyc-adminmenu-favorites") == "[]" then
            Config.FavoritedItems = GenerateFavorites()
            SetResourceKvp("iyc-adminmenu-favorites", json.encode(Config.FavoritedItems))
        else
            Config.FavoritedItems = json.decode(GetResourceKvpString("iyc-adminmenu-favorites"))
        end
    elseif Type == 'Targets' then
        if GetResourceKvpString("iyc-adminmenu-pinned_targets") == nil or GetResourceKvpString("iyc-adminmenu-pinned_targets") == "[]" then
            Config.PinnedTargets = GeneratePinnedPlayers()
            SetResourceKvp("iyc-adminmenu-pinned_targets", json.encode(Config.PinnedTargets))    
        else
            Config.PinnedTargets = json.decode(GetResourceKvpString("iyc-adminmenu-pinned_targets"))
        end
    elseif Type == 'Settings'then
        if GetResourceKvpString("iyc-adminmenu-settings") == nil or GetResourceKvpString("iyc-adminmenu-settings") == "[]" then
            Config.AdminSettings = GenerateAdminSettings()
            SetResourceKvp("iyc-adminmenu-settings", json.encode(Config.AdminSettings))
        else
            Config.AdminSettings = json.decode(GetResourceKvpString("iyc-adminmenu-settings"))
        end
    elseif Type == 'All' then
        if GetResourceKvpString("iyc-adminmenu-favorites") == nil or GetResourceKvpString("iyc-adminmenu-favorites") == "[]" then
            Config.FavoritedItems = GenerateFavorites()
            SetResourceKvp("iyc-adminmenu-favorites", json.encode(Config.FavoritedItems))
        else
            Config.FavoritedItems = json.decode(GetResourceKvpString("iyc-adminmenu-favorites"))
        end
        if GetResourceKvpString("iyc-adminmenu-pinned_targets") == nil or GetResourceKvpString("iyc-adminmenu-pinned_targets") == "[]" then
            Config.PinnedTargets = GeneratePinnedPlayers()
            SetResourceKvp("iyc-adminmenu-pinned_targets", json.encode(Config.PinnedTargets))    
        else
            Config.PinnedTargets = json.decode(GetResourceKvpString("iyc-adminmenu-pinned_targets"))
        end
        if GetResourceKvpString("iyc-adminmenu-settings") == nil or GetResourceKvpString("iyc-adminmenu-settings") == "[]" then
            Config.AdminSettings = GenerateAdminSettings()
            SetResourceKvp("iyc-adminmenu-settings", json.encode(Config.AdminSettings))
        else
            Config.AdminSettings = json.decode(GetResourceKvpString("iyc-adminmenu-settings"))
        end
    end
    UpdateMenu()
end

-- Get

function GetPlayersInArea(Coords, Radius)
	local Prom = promise:new()
	QBCore.Functions.TriggerCallback('iyc-admin:server:get-active-players-in-radius', function(Players)
		Prom:resolve(Players)
	end, Coords, Radius)
	return Citizen.Await(Prom)
end

function GetPlayers()
    local Promise = promise:new()
    QBCore.Functions.TriggerCallback("iyc-admin:server:get-players", function(Players)
        Promise:resolve(Players)
    end)
    return Citizen.Await(Promise)
end

function GetJobs()
    local JobList = {}
    for k, v in pairs(QBShared.Jobs) do
        JobList[#JobList+1] = {
            Text = v.label,
            Label = ' ['..k..']'
        }
    end
    table.sort(JobList, function(a, b)
        return a.Label < b.Label
    end)
    return JobList
end

--[[function GetInventoryItems()
    local Inventory = {}
    for k, v in pairs(QBShared.Items) do
        Inventory[#Inventory+1] = {
            --Text = "<img src=nui://lj-inventory/html/images/"..QBCore.Shared.Items[v.name].image.." width=40px>"..v['name']
            --Text = v.name,
        }
    end
    table.sort(Inventory, function(a, b)
        return a.Text < b.Text
    end)
    return Inventory
end]]

-- function GetInventoryItems()
--     local Inventory = {}
--     for k, v in pairs(QBShared.Items) do
--             table.insert(Inventory, {
--                 Text = "<img src=nui://aj-inventory/html/images/"..QBCore.Shared.Items[v.name].image.." width=40px height=auto bottom=30px>"..v['name'],
--                 Label = v.name
--             })
--     end
--     return Inventory
-- end

function GetAddonVehicles()
    local AddonVehicles = {}
    for k, v in pairs(QBShared.Vehicles) do
        -- if v['category'] == 'custom' then -- Enable if you don't want all cars but only cars with 'category' custom
            AddonVehicles[#AddonVehicles+1] = {
                Text = k,
                Label = ' ['..v['brand']..' '..v['name']..']'
            }
        -- end
        table.sort(AddonVehicles, function(a, b)
            return a.Text < b.Text
        end)
    end
    return AddonVehicles
end

-- Generate

function GenerateFavorites()
    local Retval = {}
    for _, Menu in pairs(Config.AdminMenus) do
        for k, v in pairs(Menu.Items) do
            Retval[v.Id] = false
        end
    end
    return Retval
end

function GeneratePinnedPlayers()
    local Retval = {}
    local Players = GetPlayers()
    for k, v in pairs(Players) do
        Retval[v.License] = false
    end
    return Retval
end

function GenerateAdminSettings()
    local Retval = {}
    -- Default Size
    Retval['DefaultSize'] = "Small"
    -- Tooltips
    Retval['Tooltips'] = true
    -- Bind Open
    Retval['BindOpen'] = true

    return Retval
end

-- Troll

-- Drunk
local DRUNK_ANIM_SET = "move_m@drunk@verydrunk"

local DRUNK_DRIVING_EFFECTS = {
    1, -- brake
    7, --turn left + accelerate
    8, -- turn right + accelerate
    23, -- accelerate
    4, -- turn left 90 + braking
    5, -- turn right 90 + braking
}

local function getRandomDrunkCarTask()
    math.randomseed(GetGameTimer())

    return DRUNK_DRIVING_EFFECTS[math.random(#DRUNK_DRIVING_EFFECTS)]
end

-- NOTE: We might want to check if a player already has an effect
function drunkThread()
    local playerPed = PlayerPedId()
    local isDrunk = true

    RequestAnimSet(DRUNK_ANIM_SET)
    while not HasAnimSetLoaded(DRUNK_ANIM_SET) do
        Wait(5)
    end

    SetPedMovementClipset(playerPed, DRUNK_ANIM_SET)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
    SetPedIsDrunk(playerPed, true)
    SetTransitionTimecycleModifier("spectator5", 10.00)

    CreateThread(function()
        while isDrunk do
            local vehPedIsIn = GetVehiclePedIsIn(playerPed)
            local isPedInVehicleAndDriving = (vehPedIsIn ~= 0) and (GetPedInVehicleSeat(vehPedIsIn, -1) == playerPed)

            if isPedInVehicleAndDriving then
                local randomTask = getRandomDrunkCarTask()
                TaskVehicleTempAction(playerPed, vehPedIsIn, randomTask, 500)
            end

            Wait(5000)
        end
    end)

    Wait(30 * 1000)
    isDrunk = false
    SetTransitionTimecycleModifier("default", 10.00)
    StopGameplayCamShaking(true)
    ResetPedMovementClipset(playerPed)
    RemoveAnimSet(DRUNK_ANIM_SET)
end

-- Wild attack

local attackAnimalHashes = {
    GetHashKey("a_c_chimp"),
    GetHashKey("a_c_rottweiler"),
    GetHashKey("a_c_coyote")
}
local animalGroupHash = GetHashKey("Animal")
local playerGroupHash = GetHashKey("PLAYER")

function startWildAttack()
    -- Consts
    local playerPed = PlayerPedId()
    local animalHash = attackAnimalHashes[math.random(#attackAnimalHashes)]
    local coordsBehindPlayer = GetOffsetFromEntityInWorldCoords(playerPed, 100, -15.0, 0)
    local playerHeading = GetEntityHeading(playerPed)
    local belowGround, groundZ, vec3OnFloor = GetGroundZAndNormalFor_3dCoord(coordsBehindPlayer.x, coordsBehindPlayer.y, coordsBehindPlayer.z)

    -- Requesting model
    RequestModel(animalHash)
    while not HasModelLoaded(animalHash) do
        Wait(5)
    end
    SetModelAsNoLongerNeeded(animalHash)

    -- Creating Animal & setting player as enemy
    local animalPed = CreatePed(1, animalHash, coordsBehindPlayer.x, coordsBehindPlayer.y, groundZ, playerHeading, true, false)
    SetPedFleeAttributes(animalPed, 0, 0)
    SetPedRelationshipGroupHash(animalPed, animalGroupHash)
    TaskSetBlockingOfNonTemporaryEvents(animalPed, true)
    TaskCombatHatedTargetsAroundPed(animalPed, 30.0, 0)
    ClearPedTasks(animalPed)
    TaskPutPedDirectlyIntoMelee(animalPed, playerPed, 0.0, -1.0, 0.0, 0)
    SetRelationshipBetweenGroups(5, animalGroupHash, playerGroupHash)
    SetRelationshipBetweenGroups(5, playerGroupHash, animalGroupHash)
end

function GetCoordsFromCam(distance, coords)
    local rotation = GetGameplayCamRot()
    local adjustedRotation = vector3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
    local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.sin(adjustedRotation[1]))
    return vector3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end

function GetCoordsScene()
    local Cam = GetGameplayCamCoord()
    local _, Hit, Coords, _, Entity = GetShapeTestResult(StartExpensiveSynchronousShapeTestLosProbe(Cam, GetCoordsFromCam(100, Cam), -1, PlayerPedId(), 4))
    return Coords
end