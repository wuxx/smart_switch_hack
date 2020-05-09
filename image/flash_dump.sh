#!/bin/bash


#esptool.py -p /dev/ttyUSB0 write_flash -fm dout 0x0000 /home/pi/deauther_2.1.0_4mb.bin
#exit 0

#TARGET=server.ino.bin
TARGET=flash-image-esp8285.bin

SER_PORT=/dev/ttyUSB0
#SER_PORT=/dev/ttyS0
BAUDRATE=460800

#32Mbit/4MByte
esptool.py --port ${SER_PORT} \
        --baud ${BAUDRATE} read_flash \
        0x00000 0x100000 ${TARGET}
