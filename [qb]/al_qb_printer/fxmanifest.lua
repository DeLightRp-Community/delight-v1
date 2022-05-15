fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "./cl/assets/index.html"

shared_scripts {
    "./config.lua",
    "./translations/en.lua"
}

client_scripts {
    "./cl/main.lua",
    "./cl/utils.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "./sv/main.lua"
}

files {
    "./cl/assets/**/**"
}

escrow_ignore {
    "translations/en.lua",
    "config.lua",
}
dependency '/assetpacks'