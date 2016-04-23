#!/bin/sh


throw () {
    echo ${@:2}
    exit $1
}

[ -z "$(which docker)" ] && {
    throw 1 "Please make sure you have docker installed"
}

# Only allocate tty if we detect one
if [ -t 1 ]; then
    DOCKER_RUN_OPTIONS="-t"
fi
if [ -t 0 ]; then
    DOCKER_RUN_OPTIONS="$DOCKER_RUN_OPTIONS -i"
fi

exec docker run --rm $DOCKER_RUN_OPTIONS -v $PWD:/opt/openresty/nginx -p 8080:8080 fadlee/lapis lapis "$@"
