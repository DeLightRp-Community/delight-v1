fx_version 'cerulean'
game 'gta5'

description 'QB-Jewelry'
version '1.0.0'

dependencies {
    'qb-target',
    'memorygame'
} 

shared_script 'config.lua'
client_scripts {
    'client/main.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
}
server_script 'server/main.lua'

lua54 'yes'