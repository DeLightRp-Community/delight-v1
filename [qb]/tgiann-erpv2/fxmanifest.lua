fx_version 'cerulean'
game 'gta5'

lua54 'yes'

escrow_ignore {
  'config.lua',
  "editable.lua",
}

shared_scripts {
	"config.lua"
}

client_scripts {
	"editable.lua",
	"client.lua",
}

server_scripts {
	"server.lua"
}

dependency '/assetpacks'