#!/bin/bash

#FIXME: use mdns get the IP or esp-link.local
#sudo avahi-browse -a -v
#HOST=esp-link.local
HOST=192.168.31.153

#50cm
TH=100

DISTANCE_CURR=0
DISTANCE_PREV=0
#under threshold
NEAR_COUNT=0
#beyond threshold
FAR_COUNT=0

#1 ON; 
#0 OFF;
RELAY_STATUS=0

#10min = 600s
RELAY_ON_COUNT=0
#RELAY_ON_HOLD_COUNT=1200
RELAY_ON_HOLD_COUNT=200

RELAY_ON=
RELAY_OFF=

CURRENT_DIR=$(cd $(dirname $0); pwd)

#curl http://${HOST}/gpio
#curl -X POST "http://${HOST}/gpio?&gpio13=1"

while [ 1 ]; do

    DISTANCE_CURR=$(${CURRENT_DIR}/main | awk '{print $3}')
    echo "DISTANCE_CURR: ${DISTANCE_CURR}"

    if [ ${DISTANCE_CURR} -lt ${TH} ]; then
        echo "near"
        FAR_COUNT=0
        NEAR_COUNT=$[$NEAR_COUNT+1]
        echo "NEAR_COUNT: ${NEAR_COUNT}"

        if [ ${NEAR_COUNT} -gt 4 ]; then

            if [ ${RELAY_STATUS} -eq 0 ]; then

                echo "open the relay"
                #RELAY ON
                #TODO: get the gpio status to ensure op succ
                timeout 30 curl -X POST "http://${HOST}/gpio?&gpio12=1"

                RELAY_STATUS=1
            fi

        fi

    else
        echo "far"
        NEAR_COUNT=0
        if [ ${RELAY_STATUS} -eq 1 ]; then
            FAR_COUNT=$[$FAR_COUNT+1]
            echo "FAR_COUNT: ${FAR_COUNT}"
            if [ ${FAR_COUNT} -eq ${RELAY_ON_HOLD_COUNT} ]; then
                echo "close the relay"
                #RELAY OFF
                #TODO: get the gpio status to ensure op succ
                timeout 30 curl -X POST "http://${HOST}/gpio?&gpio12=0"

                RELAY_STATUS=0
            fi

        else
            echo "RELAY_STATUS: ${RELAY_STATUS}"
        fi


    fi
    DISTANCE_PREV=${DISTANCE_CURR}

    sleep 0.5

done


