#!/bin/bash

cd build/

esptool.py esp32c3 \
        -p /dev/ttyACM0 \
        -b 460800 \
        --before=default_reset \
        --after=hard_reset \
        write_flash \
        --flash_mode dio \
        --flash_freq 80m \
        --flash_size 2MB \
        0x0 bootloader.bin \
        0x10000 vl53l0x_example.bin \
        0x8000 partition-table.bin
