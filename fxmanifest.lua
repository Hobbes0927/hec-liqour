fx_version 'cerulean'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
lua54 'yes'

author 'Hobbes0927'
description 'VORP liquor consumables for RedM'
version '1.0.1'

shared_scripts {
    'config.lua',
    'locale/*.lua'
}

client_script 'client.lua'
server_script 'server.lua'

dependencies {
    'vorp_core',
    'vorp_inventory'
}
