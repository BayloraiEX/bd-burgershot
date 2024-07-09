fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Baylorai Development'
description 'QBCore Burgershot Job using ox_lib'
version '0.0.1'

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua'
}

client_script {
	'client/*.lua'
}

server_script 'server/*.lua'

files {
	'data/**/carvariations.meta',
	'data/**/handling.meta',
	'data/**/vehicles.meta',
	'data/**/*.meta',
}
data_file 'HANDLING_FILE'           'data/**/handling.meta'
data_file 'CARCOLS_FILE'            'data/**/carcols*.meta'
data_file 'VEHICLE_METADATA_FILE'   'data/**/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE'  'data/**/carvariations.meta'
data_file 'DLCTEXT_FILE'            'data/**/dlctext.meta'