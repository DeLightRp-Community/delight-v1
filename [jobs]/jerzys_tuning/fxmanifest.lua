fx_version 'cerulean'

games { 'gta5' }

author 'jerzy'

discord 'jerzy#5989'

tebex 'https://jerzy.tebex.io/'

ui_page 'web/index.html'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    'client/cl_fun.lua',
    'client/cl_use.lua',
    'client/cl_ui.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

files {
    'config.lua',
    'web/**.*'
}

shared_scripts {
    '@qb-core/shared/vehicles.lua',
    'config.lua',
    'client/cl_use.lua',
    'client/cl_fun.lua',
}

lua54 'yes'
use_fxv2_oal 'yes'

escrow_ignore {
    'config.lua',
    'fxmanifest.lua',
    'client/cl_use.lua',
}
dependency '/assetpacks'