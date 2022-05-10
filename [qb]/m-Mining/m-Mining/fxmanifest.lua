fx_version 'cerulean'
game 'gta5'

author '! marcinhu.#6158'

dependencies {
    'qb-menu',
    'qb-target',
}

shared_scripts {
    'config.lua',
}

client_scripts{
    'client/**.lua',
}

server_scripts{
    'server/**.lua',
}

escrow_ignore {
  "config.lua",
  "Dependencies/**",
  "fxmanifest.lua",
  "README.lua",
  "Images/**",
}


lua54 'yes'

dependency '/assetpacks'