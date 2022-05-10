fx_version 'cerulean'
game 'gta5'

author 'Grudge & Snipe'
description 'Body Cam for QBCore (One Sync Compatibility)'
version '1.0.0'

lua54 'yes'

files {
    'ui/app.js',
    'ui/index.html',
    'ui/style.css',
	'ui/logo.png',
}

ui_page {
    'ui/index.html'
}

shared_scripts { 
	'config.lua'
}

client_scripts {
    "client.lua",
}

server_script "server.lua"


escrow_ignore {
    'config.lua',
}
dependency '/assetpacks'