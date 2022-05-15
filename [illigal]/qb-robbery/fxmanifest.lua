fx_version 'bodacious'
games {'gta5' }

dependencies {
    "mka-lasers"
  }

client_script {
    "paleto.lua",
    '@mka-lasers/client/client.lua',
    "config.lua",
}

srver_sscript {
    "server.lua",
    
}