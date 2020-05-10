CC = gcc

ROOT = .

INCLUDE=$(ROOT)/locallib/include/wiringPi

CFLAGS = -Wall -I$(INCLUDE) 

.PHONY: all

all: 
	$(CC) main.c $(ROOT)/locallib/lib/libwiringPi.a -lpthread -o main

clean:	
	-rm -f *.o
	-rm -f main
