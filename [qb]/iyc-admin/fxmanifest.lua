


fx_version 'cerulean'
game 'gta5'

ui_page "nui/index.html"

client_scripts {
    '@qb-core/shared/items.lua',
    '@qb-core/shared/jobs.lua',
    '@qb-core/shared/vehicles.lua',
    'client/cl_*.lua',
    'shared/sh_config.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_*.lua',
}

files {
    "nui/index.html",
    "nui/js/*.js",
    "nui/css/*.css",
    "nui/webfonts/*.css",
    "nui/webfonts/*.otf",
    "nui/webfonts/*.ttf",
    "nui/webfonts/*.woff2",
}

dependencies {
    'oxmysql',
    'qb-core'
}

escrow_ignore {
    'client/cl_main.lua',
    'shared/sh_config.lua',
    "nui/index.html",
    "nui/js/*.js",
    "nui/css/*.css",
    "nui/webfonts/*.css",
    "nui/webfonts/*.otf",
    "nui/webfonts/*.ttf",
    "nui/webfonts/*.woff2", 
  }

lua54 'yes'