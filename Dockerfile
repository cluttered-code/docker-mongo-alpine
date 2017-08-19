FROM alpine:latest

LABEL maintainer "David Clutter<cluttered.code@gmail.com>"

ENV MONGO_USERNAME root
ENV MONGO_PASSWORD password
ENV MONGO_BIND_IP 127.0.0.1,0.0.0.0

RUN apk update && \
    apk upgrade && \
    apk add --no-cache mongodb && \
    echo "net.bindIp: $MONGO_BIND_IP" >> /etc/mongod.conf && \
    echo "security.authorization: enabled" >> /etc/mongod.conf && \
    echo "storage.directoryPerDB: true" >> /etc/mongod.conf && \
    rm /usr/bin/mongoperf

COPY entrypoint.sh /entrypoint.sh

VOLUME /data/db

EXPOSE 27017 28017

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mongod"]