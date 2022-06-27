fx_version 'cerulean'
game 'gta5'

ui_page 'html/index.html'

shared_script 'config.lua'

client_scripts {
	'client/**.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/**.lua'
}

files {
    'html/*',
}

escrow_ignore {
  "client/**.lua",
  "server/**.lua",
  "html/**",
  "config.lua",
  "fxmanifest.lua"
}



lua54 "yes"
dependency '/assetpacks'