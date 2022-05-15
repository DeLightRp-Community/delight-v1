fx_version 'cerulean'
game 'gta5'

shared_scripts {
    'config.lua'
}

client_script 'client/main.lua'

server_script '@oxmysql/lib/MySQL.lua'
server_script 'server/main.lua'
server_script 'server/events.lua'

lua54 'yes'

this_is_a_map 'yes'

escrow_ignore {
    'config.lua',
    'server/events.lua'
}
dependency '/assetpacks'