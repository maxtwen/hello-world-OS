#!/bin/bash

docker run -v $PWD:/tmp -w /tmp gcc gcc -ffreestanding -c kernel.c -o kernel.o
docker run -v $PWD:/tmp -w /tmp gcc ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary