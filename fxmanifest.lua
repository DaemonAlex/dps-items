fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'dps-items'
author 'DelPerroSands'
description 'DelPerroSands item rules on ox_inventory hooks: item lock, glovebox seats, exploit watch'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

server_scripts {
    'server/main.lua',
    'server/lock.lua',
    'server/glovebox.lua',
    'server/watch.lua',
}

dependencies {
    'ox_lib',
    'ox_inventory',
}
