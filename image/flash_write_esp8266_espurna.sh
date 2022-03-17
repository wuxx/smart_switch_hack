#!/bin/bash

set -o errexit

#SERIAL_PORT=/dev/ttyS0
#SERIAL_PORT=/dev/ttyUSB0
SERIAL_PORT=/dev/ttyACM0

BAUDRATE=115200
#BAUDRATE=460800
#BAUDRATE=576000

#32Mbit/4MByte
esptool.py --port ${SERIAL_PORT} \
        --baud ${BAUDRATE} write_flash \
        -fs 4MB -ff 80m  \
        0x00000  espurna-1.14.1-itead-sonoff-basic.bin
