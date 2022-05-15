local QBCore = exports['qb-core']:GetCoreObject()
local OnlinePlayers = {}

--- Standard round function
local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

--- Add specific jobs here to check. So that unemployed etc doesn't get logged.
local function HasJob(Job)
    if Job == 'police' or Job == 'ambulance' or Job == 'realestate' or Job == 'taxi' then
        return true
    end
    return false
end

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    if not HasJob(Player.PlayerData.job.name) then return end
    OnlinePlayers[#OnlinePlayers + 1] = {
        Name = GetPlayerName(Player.PlayerData.source),
        CID = Player.PlayerData.citizenid,
        Job = Player.PlayerData.job.name,
        Label = Player.PlayerData.job.label,
        Duty = Player.PlayerData.job.onduty,
        StartDate = os.date("%d/%m/%Y %H:%M:%S"),
        StartTime = os.time()
    }
end)

RegisterNetEvent('qb-shiftlog:server:OnPlayerUnload', function()
    local src = source
    local Player = OnlinePlayers[src]
    -- print(Player.Job)
    if not Player then return end -- if this is somehow still nill
    if not HasJob(Player.Job) then return end

    if Player.Duty then
        TriggerEvent('qb-log:server:CreateLog', Player.Job..'_shiftlog', 'Shift Log', 'green',
        string.format("**%s** (CitizenID: %s | ID: %s) \n**Started Shift:** %s. \n**Stopped Shift:** %s. \n**Job:** %s \n**Duration:** %s minutes",
        Player.Name, Player.CID, src, Player.StartDate, os.date("%d/%m/%Y %H:%M:%S"), Player.Label, round(os.difftime(os.time(), Player.StartTime) / 60, 2)))
    end
end)

AddEventHandler("playerDropped", function()
    local src = source
    local Player = OnlinePlayers[src]
    -- print(Player.Job)
    if not Player then return end -- if this is somehow still nill
    if not HasJob(Player.Job) then return end

    if Player.Duty then
        TriggerEvent('qb-log:server:CreateLog', Player.Job..'_shiftlog', 'Shift Log', 'green',
        string.format("**%s** (CitizenID: %s | ID: %s) \n**Started Shift:** %s. \n**Stopped Shift:** %s. \n**Job:** %s \n**Duration:** %s minutes",
        Player.Name, Player.CID, src, Player.StartDate, os.date("%d/%m/%Y %H:%M:%S"), Player.Label, round(os.difftime(os.time(), Player.StartTime) / 60, 2)))
    end
end)

RegisterNetEvent('qb-shiftlog:server:SetPlayerData', function(NewPlayer)
    local src = source
    local OldPlayer = OnlinePlayers[src]
    -- print(OldPlayer.Job)
    if not OldPlayer then return end -- if this is somehow still nill

    --- Check if the job has changed
    if NewPlayer.job.label ~= OldPlayer.Label then
        if OldPlayer.Duty then
            OnlinePlayers[src] = {Name = GetPlayerName(NewPlayer.source), CID = NewPlayer.citizenid, Job = NewPlayer.job.name, Label = NewPlayer.job.label, Duty = NewPlayer.job.onduty, StartDate = os.date("%d/%m/%Y %H:%M:%S"), StartTime = os.time()}
            if not HasJob(OldPlayer.Job) then return end
            TriggerEvent('qb-log:server:CreateLog', OldPlayer.Job..'_shiftlog', 'Shift Log', 'green',
            string.format("**%s** (CitizenID: %s | ID: %s) \n**Started Shift:** %s. \n**Stopped Shift:** %s. \n**Job:** %s \n**Duration:** %s minutes",
            OldPlayer.Name, OldPlayer.CID, src, OldPlayer.StartDate, os.date("%d/%m/%Y %H:%M:%S"), OldPlayer.Label, round(os.difftime(os.time(), OldPlayer.StartTime) / 60, 2)))
        else
            OnlinePlayers[src] = {Name = GetPlayerName(NewPlayer.source), CID = NewPlayer.citizenid, Job = NewPlayer.job.name, Label = NewPlayer.job.label, Duty = NewPlayer.job.onduty, StartDate = os.date("%d/%m/%Y %H:%M:%S"), StartTime = os.time()}
        end
    end
    
    --- Check if the duty has changed.
    if not NewPlayer.job.onduty and OldPlayer.Duty then
        OnlinePlayers[src] = {Name = GetPlayerName(NewPlayer.source), CID = NewPlayer.citizenid, Job = NewPlayer.job.name, Label = NewPlayer.job.label, Duty = NewPlayer.job.onduty, StartDate = os.date("%d/%m/%Y %H:%M:%S"), StartTime = os.time()}
        if not HasJob(OldPlayer.Job) then return end
        TriggerEvent('qb-log:server:CreateLog', OldPlayer.Job..'_shiftlog', 'Shift Log', 'green',
        string.format("**%s** (CitizenID: %s | ID: %s) \n**Started Shift:** %s. \n**Stopped Shift:** %s. \n**Job:** %s \n**Duration:** %s minutes",
        OldPlayer.Name, OldPlayer.CID, src, OldPlayer.StartDate, os.date("%d/%m/%Y %H:%M:%S"), OldPlayer.Label, round(os.difftime(os.time(), OldPlayer.StartTime) / 60, 2)))
    elseif not OldPlayer.Duty and NewPlayer.job.onduty then
        OnlinePlayers[src] = {Name = GetPlayerName(NewPlayer.source), CID = NewPlayer.citizenid, Job = NewPlayer.job.name, Label = NewPlayer.job.label, Duty = NewPlayer.job.onduty, StartDate = os.date("%d/%m/%Y %H:%M:%S"), StartTime = os.time()}
    end
end)