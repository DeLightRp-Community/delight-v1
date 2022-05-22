fx_version 'cerulean'
game 'gta5'

description 're2-tunerjob'
version '1.0.0'

shared_scripts {
    'config.lua'
}

ui_page 'html/index.html'

client_scripts {
    '@menuv/menuv.lua',
	'client/*.lua',
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua'
}

server_scripts  {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

lua54 'yes'
