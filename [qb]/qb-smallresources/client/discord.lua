-- To Set This Up visit https://forum.cfx.re/t/how-to-updated-discord-rich-presence-custom-image/157686

CreateThread(function()
    while true do
        local player = GetPlayerPed(-1)
        local playerName = GetPlayerName(PlayerId())
        -- This is the Application ID (Replace this with you own)
	    SetDiscordAppId(783739456267091979)

        -- Here you will have to put the image name for the "large" icon.
	    SetDiscordRichPresenceAsset('delight')
        
        -- (11-11-2018) New Natives:

        -- Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText(playerName .. " Is Walking In City")
       
        -- Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('delight2')

        -- Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText("https://delightrp.com")

        -- QBCore.Functions.TriggerCallback('stx-scoreboard:server:GetCurrentPlayers', function(result)
        --     SetRichPresence('Players: '..result..'/100')
        -- end)


        local playerCount= 0
        for _, player in ipairs(GetActivePlayers()) do
			if GetPlayerPed(player) then
                playerCount = playerCount+1
            end
		end

        SetRichPresence(string.format("%s - %s/%s", playerName, playerCount, '64'))
        -- (26-02-2021) New Native:

        --[[ 
            Here you can add buttons that will display in your Discord Status,
            First paramater is the button index (0 or 1), second is the title and 
            last is the url (this has to start with "fivem://connect/" or "https://") 
        ]]--
        SetDiscordRichPresenceAction(0, "Visit WebSite!", "https://delightrp.com/")
        SetDiscordRichPresenceAction(1, "Join Discord!", "https://discord.gg/DTfMR6HrtC")

        -- It updates every minute just in case.
	Citizen.Wait(60000)
    end
end)
