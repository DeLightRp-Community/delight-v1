fx_version 'cerulean'
games { 'gta5' }
author 'Jerzy'

tebex  'https://jerzy.tebex.io/'
discord 'Jerzy#9709'

ui_page 'html/index.html'

client_scripts {
    'client/client.lua',
}

shared_scripts {
    '@qb-apartments/config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua'
}

files {
    'config.lua',
    'html/assets/img/card.png',
    'html/assets/img/map.jpg',
    'html/assets/img/logo.png',
    'html/assets/css/bootstrap.min.css',
    'html/assets/css/main.css',
    'html/assets/js/*.js',
    'html/index.html',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

escrow_ignore {
  'locales/*.lua',
  'config.lua',
  'fxmainfest.lua',
  '**/*.**'
}

lua54 'yes'


dependency '/assetpacks'
dependency '/assetpacks'