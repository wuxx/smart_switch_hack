CC = gcc

ROOT = .

INCLUDE=$(ROOT)/locallib/include/wiringPi

CFLAGS = -Wall -I$(INCLUDE) 

HOST = 192.168.31.153

.PHONY: all

all: 
	$(CC) main.c $(ROOT)/locallib/lib/libwiringPi.a -lpthread -o main

switch_on: 
	curl -X POST "http://${HOST}/gpio?&gpio12=1"

switch_off: 
	curl -X POST "http://${HOST}/gpio?&gpio12=0"

clean:	
	-rm -f *.o
	-rm -f main
