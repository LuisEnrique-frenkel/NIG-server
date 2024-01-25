#!/usr/bin/env bash
#########################################################################
#Name: generate-certs.sh
#Subscription: This Script generates ssl certs
##by A. Laub
#andreas[-at-]laub-home.de
#
#License:
#This program is free software: you can redistribute it and/or modify it
#under the terms of the GNU General Public License as published by the
#Free Software Foundation, either version 3 of the License, or (at your option)
#any later version.
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
#or FITNESS FOR A PARTICULAR PURPOSE.
#########################################################################
#Set the language
export LANG="en_US.UTF-8"
#Load the Pathes
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# set the variables

if [ "$#" -ne 2 ]; then
  echo "Usage: sudo ./code.sh folder_name ip_address"
  exit 1
fi

COMPOSE_PROJECT_DIR="$1"

mkdir -p "$COMPOSE_PROJECT_DIR/certs" 
chmod -R u=rwx,g=rwx,o=rwx "$COMPOSE_PROJECT_DIR" 

# Just change to your belongings
#COMPOSE_PROJECT_DIR="./opt/mosquitto"
#IP="FQDN / IP ADRESS"
IP="$2"
SUBJECT_CA="/C=MX/ST=CDMX/L=CDMX/O=NIGServer/OU=CA/CN=$IP"
SUBJECT_SERVER="/C=MX/ST=CDMX/L=CDMX/O=NIGServer/OU=Server/CN=$IP"
SUBJECT_CLIENT="/C=MX/ST=CDMX/L=CDMX/O=NIGServer/OU=Client/CN=$IP"

### Do the stuff
function generate_CA() {
   echo "$SUBJECT_CA"
   openssl req -x509 -nodes -sha256 -newkey rsa:2048 -subj "$SUBJECT_CA" -days 3650 -keyout "$COMPOSE_PROJECT_DIR/certs/ca.key" -out "$COMPOSE_PROJECT_DIR/certs/ca.crt"

   # Establecer permisos más restrictivos
   chmod 400 "$COMPOSE_PROJECT_DIR/certs/ca.key"
   chmod 444 "$COMPOSE_PROJECT_DIR/certs/ca.crt"
}

function generate_server() {
   echo "$SUBJECT_SERVER"
   openssl req -nodes -sha256 -new -subj "$SUBJECT_SERVER" -keyout "$COMPOSE_PROJECT_DIR/certs/server.key" -out "$COMPOSE_PROJECT_DIR/certs/server.csr"
   openssl x509 -req -sha256 -in "$COMPOSE_PROJECT_DIR/certs/server.csr" -CA "$COMPOSE_PROJECT_DIR/certs/ca.crt" -CAkey "$COMPOSE_PROJECT_DIR/certs/ca.key" -CAcreateserial -out "$COMPOSE_PROJECT_DIR/certs/server.crt" -days 3650

   # Establecer permisos más restrictivos
   chmod 400 "$COMPOSE_PROJECT_DIR/certs/server.key"
   chmod 444 "$COMPOSE_PROJECT_DIR/certs/server.crt"
}

function generate_client() {
   echo "$SUBJECT_CLIENT"
   openssl req -new -nodes -sha256 -subj "$SUBJECT_CLIENT" -out "$COMPOSE_PROJECT_DIR/certs/client.csr" -keyout "$COMPOSE_PROJECT_DIR/certs/client.key"
   openssl x509 -req -sha256 -in "$COMPOSE_PROJECT_DIR/certs/client.csr" -CA "$COMPOSE_PROJECT_DIR/certs/ca.crt" -CAkey "$COMPOSE_PROJECT_DIR/certs/ca.key" -CAcreateserial -out "$COMPOSE_PROJECT_DIR/certs/client.crt" -days 3650

   # Establecer permisos más restrictivos
   chmod 400 "$COMPOSE_PROJECT_DIR/certs/client.csr"
   chmod 444 "$COMPOSE_PROJECT_DIR/certs/client.csr"
}

chmod o-w "$COMPOSE_PROJECT_DIR/certs"

generate_CA
generate_server
generate_client
