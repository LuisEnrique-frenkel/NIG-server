#!/bin/ash
set -e
chmod 0700 config/pwfile
mosquitto_passwd -H sha512-pbkdf2 -c -b config/pwfile $MQTT_USERNAME $MQTT_PASSWORD

# Set permissions
user="$(id -u)"
if [ "$user" = '0' ]; then
	[ -d "/mosquitto" ] && chown -R mosquitto:mosquitto /mosquitto || true
fi

exec "$@"