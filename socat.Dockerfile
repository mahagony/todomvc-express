FROM alpine:3.5

RUN apk add --no-cache socat

RUN echo $'#!/bin/sh\n\
PORT=$1 \n\
TARGET_IP=$2 \n\
TARGET_PORT=$3 \n\
socat TCP-LISTEN:${PORT},fork TCP-CONNECT:${TARGET_IP}:${TARGET_PORT} \n\
tail -f /dev/null \n'\
>> /socat.sh

ENTRYPOINT ["sh", "/socat.sh"]