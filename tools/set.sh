#!/bin/bash

#IP=192.168.31.45
IP=192.168.31.153

curl -X POST "http://${IP}/gpio?gpio12=0&gpio13=0"

#curl http://192.168.31.45/gpio -X POST -d 'gpio12=0&gpio13=1'


