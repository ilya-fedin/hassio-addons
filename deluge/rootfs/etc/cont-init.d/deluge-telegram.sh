#!/usr/bin/with-contenv bashio

declare telegram_token
declare telegram_master
declare telegram_webui_password

telegram_token=$(bashio::config 'telegram_token')
telegram_master=$(bashio::config 'telegram_master')
telegram_webui_password=$(bashio::config 'telegram_webui_password')

if bashio::config.is_empty 'telegram_token' || 
bashio::config.is_empty 'telegram_master' ||
bashio::config.is_empty 'telegram_webui_password'; then
	rm -r /etc/services.d/deluge-telegram
fi
