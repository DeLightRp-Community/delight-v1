fx_version 'adamant'
game 'gta5'

data_file 'DLC_ITYP_REQUEST' 'stream/Props/bz_prop_gift.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/Props/bz_prop_gift2.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/Props/bz_prop_milka.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/Props/bz_prop_jewel.ytyp'

client_scripts {
	'NativeUI.lua',
	'Config.lua',
	'Client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'Config.lua',
	'Server/*.lua'
}
