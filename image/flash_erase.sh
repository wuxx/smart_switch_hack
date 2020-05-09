#!/bin/bash

set -o errexit


#SERIAL_PORT=/dev/ttyS0
SERIAL_PORT=/dev/ttyUSB0

#BAUDRATE=115200
BAUDRATE=460800
#BAUDRATE=576000

#esptool.py --port ${SERIAL_PORT} --baud ${BAUDRATE} erase_flash
#exit 0

esptool.py --port ${SERIAL_PORT} \
    --baud ${BAUDRATE} erase_flash 

exit 0

