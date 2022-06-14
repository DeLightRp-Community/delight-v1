fx_version 'cerulean'
game 'gta5'

description 'qb-ottosRepair'

shared_script 'config.lua'

client_scripts {
	'client.lua',
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/CircleZone.lua',
}

server_scripts {
	'server.lua'
}

lua54 'yes'
