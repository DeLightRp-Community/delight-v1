fx_version 'bodacious'
games { 'rdr3', 'gta5' }

dependencies {
    "mka-lasers"
  }

client_scripts {
    "config.lua", 
    "client/cl_main.lua",
    '@mka-lasers/client/client.lua',
}

server_scripts {
    "config.lua", 
    "server/sv_*.lua"
}