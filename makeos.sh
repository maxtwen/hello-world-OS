#!/bin/bash

nasm boot_sect.asm -f bin -o boot_sect.bin
nasm kernel_entry.asm -f elf64 -o kernel_entry.o
docker run -v $PWD:/tmp -w /tmp gcc gcc -ffreestanding -c kernel.c -o kernel.o
docker run -v $PWD:/tmp -w /tmp gcc gcc -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o
cat boot_sect.bin kernel.bin > os-image
qemu-system-i386 os-image