#!/bin/bash

cd /home/pi/oss/VL53L0X_rasp_python/python
./VL53L0X_read.py | grep mm | awk  '{print $3}'
