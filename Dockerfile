FROM alpine:latest

LABEL maintainer "David Clutter<cluttered.code@gmail.com>"

ENV MONGO_USERNAME root
ENV MONGO_PASSWORD password

RUN apk update && \
    apk upgrade && \
    apk add --no-cache mongodb && \
    echo "security.authorization: enabled" >> /etc/mongod.conf && \
    echo "storage.directoryPerDB: true" >> /etc/mongod.conf && \
    rm /usr/bin/mongoperf

COPY entrypoint.sh /entrypoint.sh

VOLUME /data/db

EXPOSE 27017 28017

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mongod"]