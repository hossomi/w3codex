#!/bin/bash

for hex in $(find . -name *.hex); do
    xxd -r -p $hex ${hex%.hex}.bin
done