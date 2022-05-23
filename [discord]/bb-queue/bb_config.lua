Config = {}

local Prefix = "[DelightRP Queue] "
Config.DiscordServerID = 856277326475296788 -- Discord Server ID
Config.DiscordBotToken = "OTc2OTQ5NTQ4MjEzNzYwMTEy.GttQCT.EXkEVE_yWvtAmGFNw8fteMd_L-6rUjWNoihsjs" -- Discord Bot Token. You can create one on https://discord.com/developers/applications
Config.ApiLink = "" -- API Stuff
Config.ApiKey = ""-- API Stuff
Config.maxServerSlots = 64

Config.Roles = {
	Example = {
		roleID = "930782320942800916",
		points = 10,
		name = "WhiteList"
	},

	Example2 = {
		roleID = "930782284880183306",
		points = 15,
		name = "VIP"
	},
}

Config.Colors = {
	"accent",
	"good",
	"warning",
	"attention",
}

Config.Verifiying = Prefix .. "Please wait, Downloading content from DelightRP database."
Config.VerifiyingLauncher = Prefix .. "Please wait, Verifiying you entered through the launcher."
Config.VerifiyingDiscord = Prefix .. "Please wait, Verifiying your Discord ID."
Config.VerifiyingSteam = Prefix .. "Please wait, Verifiying your Steam."
Config.VerifiyingQueue = Prefix .. "Please wait, Adding you to the queue."

Config.NotWhitelisted = Prefix .. "Sorry, I didn't find you in our database."
Config.NoDiscord = Prefix .. "Please make sure your Discord is open."
Config.NoSteam = Prefix .. "Please make sure your Steam is open."
Config.NoLauncher = Prefix .. "The server can only be accessed through its launcher."
Config.Blacklisted = Prefix .. "You're blacklisted from the server, fuck off please."

Config.Welcome = Prefix .. "Welcome Sir."
Config.Error = Prefix .. "Error, Please try again later."
Config.HandshakingWith = Prefix .. "Handshaking With DeLightRP Queue."
