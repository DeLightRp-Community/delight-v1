fx_version 'cerulean'
game 'gta5'

description 'qb-digitalden'
version '1.0.0'

shared_scripts {
	'config.lua'
}

server_scripts {
	'server/main.lua',
	'server/craft.lua'
}

client_scripts {
	'client/main.lua',
	'client/craft.lua'
}

lua54 'yes'
