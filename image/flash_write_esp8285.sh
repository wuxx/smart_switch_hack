#!/bin/bash

set -o errexit

IMAGE_DIR=esp-link-v3.0.14-g963ffbb

#SERIAL_PORT=/dev/ttyS0
SERIAL_PORT=/dev/ttyUSB0

#BAUDRATE=115200
BAUDRATE=460800
#BAUDRATE=576000

#esptool.py --port ${SERIAL_PORT} --baud ${BAUDRATE} erase_flash
#exit 0

esptool.py --port ${SERIAL_PORT} \
    --baud ${BAUDRATE} write_flash \
    -fs 1MB -ff 80m -fm dout \
    0x00000  boot_v1.7.bin \
    0x01000  user1.bin \
    0xFC000 $IMAGE_DIR/esp_init_data_default.bin \
    0xFE000 $IMAGE_DIR/blank.bin
exit 0

#8Mbit/1MByte
esptool.py --port ${SERIAL_PORT} \
        --baud ${BAUDRATE} write_flash \
        -fs 1MB -ff 40m -fm dout \
        0x00000  $IMAGE_DIR/boot_v1.6.bin \
        0x01000  user1.bin \
        0xFC000 $IMAGE_DIR/esp_init_data_default.bin \
        0xFE000 $IMAGE_DIR/blank.bin
