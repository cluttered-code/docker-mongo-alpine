#!/bin/sh

# short circuit if first arg is not 'mongod'
[ "$1" = "mongod" ] || exec "$@" || exit $?

: ${MONGO_USERNAME}
: ${MONGO_PASSWORD}

# Database owned by mongodb
[ "$(stat -c %U /data/db)" = mongodb ] || chown -R mongodb /data/db

if ! [ -f /data/db/.passwords_set ]; then

    eval su -s /bin/sh -c "mongod" mongodb &

    RET=1
    while [ $RET -ne 0 ]; do
        sleep 3
        mongo admin --eval "help" >/dev/null 2>&1
        RET=$?
    done

    # set root user
    mongo admin --eval \
        "db.createUser({user: '$MONGO_USERNAME',
            pwd: '$MONGO_PASSWORD',
            roles: [{role: 'root', db: 'admin'}]
        });"

    echo "Used by clutteredcode/mongo-alpine docker container." > /data/db/.passwords_set
    echo "DO NOT DELETE" >> /data/db/.passwords_set
    mongod --shutdown
fi

cmd="$@"
[ $# -eq 1 ] && cmd="$cmd --auth"

exec su -s /bin/sh -c "$cmd" mongodb