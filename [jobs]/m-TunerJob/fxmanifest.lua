fx_version 'cerulean'
game 'gta5'

shared_script 'configs/**.lua'

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
  "client/c_targets.lua",
  "server/s_commands.lua",
  "configs/**.lua",
  "README.lua",
  "images/**",
  "HowToInstall.lua"
}


lua54 "yes"
dependency '/assetpacks'