fx_version "adamant"
game "gta5"

name "Hexus policejob"
description "Script for Justice Roleplay"
author ".Hexus"
version "1.0.0"
lua54 'yes'

client_scripts {
	"cl/*.lua",
}

server_scripts {
	"sv/*.lua",
	'@oxmysql/lib/MySQL.lua',
}

shared_script { 
	'@es_extended/imports.lua',
	'sh/*.lua',
	'@ox_lib/init.lua'
}