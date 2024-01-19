# Mosquitto autentication
docker-compose up -d
source .env
echo -n "" > ./mqtt/config/pwfile
chmod 0700 ./mqtt/config/pwfile
docker exec mqtt mosquitto_passwd -H sha512-pbkdf2 -c -b ./mosquitto/config/pwfile "$MQTT_USERNAME" "$MQTT_PASSWORD"
