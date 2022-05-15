Framework = exports["qb-core"]:GetCoreObject()

settings = {}

Animation = {
    Prop = GetHashKey('prop_cs_hand_radio'),
    Bone = 28422,
	Offset = vector3(0.0, 0.0, 0.0),
	Rotation = vector3(0.0, 0.0, 0.0),
	Dictionary = {
		"cellphone@",
		"cellphone@in_car@ds",
		"cellphone@str",    
		"random@arrests"
	},
	Animation = {
		"cellphone_text_in",
		"cellphone_text_out",
		"cellphone_call_listen_a",
		"generic_radio_chatter"
	}
}

isOpen = false
local RadioChannel = 0
local onRadio = false

function open()
    if isOpen == false then
        RequestModel(Animation.Prop)
    
        while not HasModelLoaded(Animation.Prop) do
            Citizen.Wait(150)
        end

        Handle = CreateObject(Animation.Prop, 0.0, 0.0, 0.0, true, true, false)

        local bone = GetPedBoneIndex(PlayerPedId(), Animation.Bone)

        SetCurrentPedWeapon(PlayerPedId(), GetHashKey('weapon_unarmed'), true)
        AttachEntityToEntity(Handle, PlayerPedId(), bone, Animation.Offset.x, Animation.Offset.y, Animation.Offset.z, Animation.Rotation.x, Animation.Rotation.y, Animation.Rotation.z, true, false, false, false, 2, true)

        SetModelAsNoLongerNeeded(Handle)

        SetNuiFocus(true,true)
        SendNUIMessage({
            action = "open",
            data = {}
        })
        isOpen = true
    end
end

RegisterNetEvent("zerio-radio:client:open")
AddEventHandler("zerio-radio:client:open", function()
    open()
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false,false)
    isOpen = false

    local dictionaryType = 1 + (IsPedInAnyVehicle(PlayerPedId(), false) and 1 or 0)
    local animationType = 1 + (isOpen and 0 or 1)
    local dictionary = Animation.Dictionary[dictionaryType]
    local animation = Animation.Animation[animationType]

    TaskPlayAnim(PlayerPedId(), dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)

    Citizen.Wait(700)

    StopAnimTask(PlayerPedId(), dictionary, animation, 1.0)

    NetworkRequestControlOfEntity(Handle)

    while not NetworkHasControlOfEntity(Handle) do
        Citizen.Wait(0)
    end
    
    DetachEntity(Handle, true, false)
    DeleteEntity(Handle)
end)

Citizen.CreateThread(function()
    while true do
        if isOpen then
            local dictionaryType = 1 + (IsPedInAnyVehicle(PlayerPedId(), false) and 1 or 0)
            local animationType = 1 + (isOpen and 0 or 1)
            local dictionary = Animation.Dictionary[dictionaryType]
            local animation = Animation.Animation[animationType]
    
            RequestAnimDict(dictionary)
    
            while not HasAnimDictLoaded(dictionary) do
                Citizen.Wait(150)
            end
            
            if IsEntityPlayingAnim(PlayerPedId(), dictionary, animation, 3) ~= 1 then
                TaskPlayAnim(PlayerPedId(), dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)
            end
            Citizen.Wait(500)
        else
            Citizen.Wait(1000)
        end
    end
end)

local function closeEvent()
    TriggerEvent("InteractSound_CL:PlayOnOne", "click", 0.6)
end    

local function onbabatradio()
    RadioChannel = 1
    onRadio = true
    exports["pma-voice"]:setRadioChannel(1)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
    Framework.Functions.Notify(Config.messages['turn_radio'], 'success')
end 

local function leavebabatradio()
    closeEvent()
    RadioChannel = 0 
    onRadio = false
    exports["pma-voice"]:setRadioChannel(0)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    Framework.Functions.Notify(Config.messages['you_leave'], 'error')
end    

RegisterNetEvent('zerio-radio:client:onRadioDrop', function()
    if RadioChannel ~= 0 then
        leavebabatradio()
    end
end)

RegisterNetEvent('zerio-radio:client:onbabat', function ()
    if RadioChannel == 0 then
        onbabatradio()   
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        if LocalPlayer.state.isLoggedIn and onRadio then
            Framework.Functions.TriggerCallback('zerio-radio:server:GetbabatItem', function(hasItem)
                if not hasItem then
                    if RadioChannel ~= 0 then
                        leavebabatradio()
                    end
                end
            end, "radio")
        end
    end
end)

RegisterNetEvent('zerio-radio:client:JoinRadioChannel1')
AddEventHandler('zerio-radio:client:JoinRadioChannel1', function(channel)
    local channel = 1
    exports["pma-voice"]:setRadioChannel(channel)
    Framework.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
end)

RegisterNetEvent('zerio-radio:client:JoinRadioChannel2')
AddEventHandler('zerio-radio:client:JoinRadioChannel2', function(channel)
    local channel = 2
    exports["pma-voice"]:setRadioChannel(channel)
    Framework.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
end)

RegisterNetEvent('zerio-radio:client:JoinRadioChannel3')
AddEventHandler('zerio-radio:client:JoinRadioChannel3', function(channel)
    local channel = 3
    exports["pma-voice"]:setRadioChannel(channel)
    Framework.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
end)

RegisterNetEvent('zerio-radio:client:JoinRadioChannel4')
AddEventHandler('zerio-radio:client:JoinRadioChannel4', function(channel)
    local channel = 4
    exports["pma-voice"]:setRadioChannel(channel)
    Framework.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
end)

RegisterNetEvent('zerio-radio:client:JoinRadioChannel5')
AddEventHandler('zerio-radio:client:JoinRadioChannel5', function(channel)
    local channel = 5
    exports["pma-voice"]:setRadioChannel(channel)
    Framework.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
end)

RegisterNetEvent('zerio-radio:client:JoinRadioChannel6')
AddEventHandler('zerio-radio:client:JoinRadioChannel6', function(channel)
    local channel = 6
    exports["pma-voice"]:setRadioChannel(channel)
    Framework.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
end)

RegisterNetEvent('zerio-radio:client:JoinRadioChannel7')
AddEventHandler('zerio-radio:client:JoinRadioChannel7', function(channel)
    local channel = 7
    exports["pma-voice"]:setRadioChannel(channel)
    Framework.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
end)

RegisterNetEvent('zerio-radio:client:JoinRadioChannel8')
AddEventHandler('zerio-radio:client:JoinRadioChannel8', function(channel)
    local channel = 8
    exports["pma-voice"]:setRadioChannel(channel)
    Framework.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
end)

RegisterNetEvent('zerio-radio:client:JoinRadioChannel9')
AddEventHandler('zerio-radio:client:JoinRadioChannel9', function(channel)
    local channel = 9
    exports["pma-voice"]:setRadioChannel(channel)
    Framework.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
end)

RegisterNetEvent('zerio-radio:client:JoinRadioChannel10')
AddEventHandler('zerio-radio:client:JoinRadioChannel10', function(channel)
    local channel = 10
    exports["pma-voice"]:setRadioChannel(channel)
    Framework.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
end)