#!/bin/bash

#https://item.taobao.com/item.htm?spm=a1z09.2.0.0.28f12e8d4oF0QE&id=557748825353&_u=i6lgp6ha75d

#FIXME: use mdns get the IP or esp-link.local
#sudo avahi-browse -a -v
#HOST=esp-link.local
HOST=192.168.31.153

IR_GPIO=25
LED_GPIO=2

gpio mode $IR_GPIO in

gpio mode $LED_GPIO out
gpio write $LED_GPIO 1

#50cm
#TH=40
#TH=50
#TH=80
DIST_TH=100

DISTANCE_CURR=0
DISTANCE_PREV_1=0
DISTANCE_PREV_2=0
DISTANCE_PREV_3=0
DISTANCE=0
#under threshold
NEAR_COUNT=0
NEAR_COUNT_TH=2

#beyond threshold
FAR_COUNT=0

#1 ON; 
#0 OFF;
RELAY_STATUS=0

#10min = 600s
RELAY_ON_COUNT=0
RELAY_ON_HOLD_COUNT=600

RELAY_ON=
RELAY_OFF=

CURRENT_DIR=$(cd $(dirname $0); pwd)

#curl http://${HOST}/gpio
#curl -X POST "http://${HOST}/gpio?&gpio13=1"

#RELAY_STATUS=$(curl http://${HOST}/gpio | jq '.gpio12')

echo "INIT RELAY_STATUS: $RELAY_STATUS"

while [ 1 ]; do

    HOUR=$(date +%H)
    echo "DATE: [$(date)]"
    #echo "HOUR: [${HOUR}]"
    if [ $HOUR -gt 0 ] && [ $HOUR -lt 8 ]; then
        echo "sleep 1 hour"
        sleep 3600
    fi

    DISTANCE_CURR=$(timeout 10 ${CURRENT_DIR}/get_dist.sh)
    echo "DISTANCE_PREV_3: ${DISTANCE_PREV_3}"
    echo "DISTANCE_PREV_2: ${DISTANCE_PREV_2}"
    echo "DISTANCE_PREV_1: ${DISTANCE_PREV_1}"
    echo "DISTANCE_CURR:   ${DISTANCE_CURR}"
    if [ ${DISTANCE_PREV_3} -lt ${DIST_TH} ] && [ ${DISTANCE_PREV_2} -lt ${DIST_TH} ] && [ ${DISTANCE_PREV_1} -lt ${DIST_TH} ] && [ ${DISTANCE_CURR} -lt ${DIST_TH} ]; then
    #if [ ${DISTANCE} -lt ${TH} ]; then
        echo "-- near --"
        gpio write $LED_GPIO 0

        FAR_COUNT=0
        NEAR_COUNT=$[$NEAR_COUNT+1]
        echo "NEAR_COUNT: ${NEAR_COUNT}"

        if [ ${NEAR_COUNT} -gt ${NEAR_COUNT_TH} ]; then

            if [ ${RELAY_STATUS} -eq 0 ]; then

                echo "open the relay"
                #RELAY ON
                #TODO: get the gpio status to ensure op succ
                timeout 30 curl -X POST "http://${HOST}/gpio?&gpio12=1"

                RELAY_STATUS=1
            fi

        fi

    else
        echo "-- far --"
        gpio write $LED_GPIO 1
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
    DISTANCE_PREV_3=${DISTANCE_PREV_2}
    DISTANCE_PREV_2=${DISTANCE_PREV_1}
    DISTANCE_PREV_1=${DISTANCE_CURR}

    sleep 1.5

done


