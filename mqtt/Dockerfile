FROM eclipse-mosquitto:latest

WORKDIR /mosquitto

COPY . /mosquitto/

RUN chmod 0700 config/pwfile
RUN chmod +x scripts/docker-entrypoint.sh
RUN chmod +r config/mosquitto.conf

EXPOSE 1883
ENTRYPOINT ["scripts/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]