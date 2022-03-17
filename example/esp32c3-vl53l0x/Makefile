CC = gcc

ROOT = .

INCLUDE=$(ROOT)/locallib/include/wiringPi

CFLAGS = -Wall -I$(INCLUDE) 

HOST = 192.168.123.171

.PHONY: all

all: 
	$(CC) main.c $(ROOT)/locallib/lib/libwiringPi.a -lpthread -o main

switch_on: 
	curl http://192.168.123.171/cm?cmnd=POWER+ON

switch_off: 
	curl http://192.168.123.171/cm?cmnd=POWER+OFF

clean:	
	-rm -f *.o
	-rm -f main
