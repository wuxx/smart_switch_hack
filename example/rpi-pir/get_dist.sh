#!/bin/bash

IO25_VAL=$(gpio read 25)

if [ $IO25_VAL -eq 1 ]; then
    echo 10 #near
else
    echo 500 #far
fi

