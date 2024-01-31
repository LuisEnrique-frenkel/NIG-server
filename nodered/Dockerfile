FROM nodered/node-red:latest

EXPOSE 1880

WORKDIR /data
COPY /data/package.json /data
RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production
RUN npm audit fix --force
WORKDIR /usr/src/node-red

# COPY settings.js /data/settings.js
# RUN chmod 777 /data/settings.js

COPY entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]