#!/usr/bin/with-contenv bashio

declare deluge_uid
declare deluge_gid
declare uidgid

deluge_uid=$(bashio::config 'deluge_uid')
deluge_gid=$(bashio::config 'deluge_gid')

if bashio::config.has_value 'deluge_uid'; then
	uidgid=${deluge_uid}
fi

if bashio::config.has_value 'deluge_gid'; then
	uidgid+=:${deluge_gid}
fi

if [ ! -d /data/deluge ]; then
	mkdir -p /data/deluge
fi

if bashio::config.has_value 'deluge_uid' || bashio::config.has_value 'deluge_gid'; then
	chown -R "${uidgid}" /data/deluge
fi
