FROM alpine:3.9

LABEL maintainer "David Clutter<cluttered.code@gmail.com>"

ENV MONGO_USERNAME root
ENV MONGO_PASSWORD password

RUN apk update &&\
    apk upgrade &&\
    apk add --no-cache mongodb

COPY entrypoint.sh /entrypoint.sh
COPY mongod.conf /etc/mongod.conf

VOLUME /data/db

EXPOSE 27017 28017

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mongod", "--bind_ip_all"]
