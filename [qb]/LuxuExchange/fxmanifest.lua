fx_version 'adamant'
lua54 'on'

game 'gta5'

author 'Luxu'
description 'Luxu.gg'
version '1.3'

ui_page 'web/index.html'

files {
	'web/*.*',
	'web/images/*.*',
	'web/sounds/*.*',
	'web/avatars/*.*',
}

shared_script 'config.lua'

client_scripts {
	'client.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

escrow_ignore {
    'config.lua',
}
dependency '/assetpacks'