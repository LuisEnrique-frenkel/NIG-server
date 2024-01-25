# NIG Server with Node-RED, InfluxDB, Grafana, and MQTT

## Overview

This Docker Compose configuration allows you to easily set up a NIG (Node-RED, InfluxDB, Grafana) server with added security features for MQTT communication. This setup is designed for quick and straightforward installation, ensuring you have the latest versions of the components.

## Prerequisites

Make sure you have Docker and Docker Compose installed on your system.

- [Docker Installation Guide](https://docs.docker.com/get-docker/)
- [Docker Compose Installation Guide](https://docs.docker.com/compose/install/)

## Quick Start

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/LuisEnrique-frenkel/NIG-server.git
    ```

2. Navigate to the project directory:

    ```bash
    cd nig-server
    ```

3. Create a `.env` file and configure the following environment variables:

    ```env
    NODE_RED_USERNAME=admin
    NODE_RED_PASSWORD=admin_password
    INFLUXDB_USERNAME=influxdb_user
    INFLUXDB_PASSWORD=influxdb_password
    INFLUXDB_ORG=my_org
    INFLUXDB_BUCKET=my_bucket
    INFLUXDB_ADMIN_TOKEN=token
    INFLUXD_SESSION_LENGTH=86400
    GRAFANA_ADMIN_USERNAME=grafana_admin
    GRAFANA_ADMIN_PASSWORD=grafana_password
    MQTT_USERNAME=mqtt_user
    MQTT_PASSWORD=mqtt_password
    ```
   Replace the values with your desired usernames and passwords.

4. Start the NIG server:

    ```bash
    chmod +x CertsMaker.sh 
    ```

5. Start the NIG server:

    ```bash
    docker-compose up -d 
    ```

6. Access the services:

    - **Node-RED**: http://localhost:1880
    - **Influx**: http://localhost:8086
    - **Grafana**: http://localhost:3000 (login with Grafana admin credentials)
    - **MQTT Broker**: Use port 1883 with the configured MQTT credentials

## Configuration Details

### Node-RED

- Access Node-RED at http://localhost:1880
- Username: `admin`
- Password: `admin_password`

### InfluxDB

- - Access Node-RED at http://localhost:8086
- Username: `influxdb_user`
- Password: `influxdb_password`

### Grafana

- Access Grafana at http://localhost:3000
- Username: `grafana_admin`
- Password: `grafana_password`

### MQTT Broker

- MQTT broker is running on port 1883.
- Username: `mqtt_user`
- Password: `mqtt_password`

## Cleanup

To stop and remove the containers, use the following command:

```bash
docker-compose down
```

## Notes
* Make sure to secure your credentials and regularly update passwords for security.
* Update the .env file for customized configuration.
* Usefull page for certificates: https://www.laub-home.de/wiki/Eclipse_Mosquitto_Secure_MQTT_Broker_Docker_Installation

Feel free to contribute or report issues at GitHub Repository.
