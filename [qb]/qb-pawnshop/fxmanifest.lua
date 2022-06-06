fx_version 'cerulean'
game 'gta5'

description 'Edited QB-Pawnshop for ANZ Gaming Networks'
version '1.0.0'

shared_scripts {
	'@qb-core/shared/locale.lua',
	'config.lua',
	'locales/en.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/craft.lua'
}

client_scripts {
	'client/main.lua',
	'client/craft.lua'
}

lua54 'yes'
