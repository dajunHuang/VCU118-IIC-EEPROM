CROSS_COMPILE = ../../workspace/gcc/riscv/bin/riscv64-unknown-elf-

CC=$(CROSS_COMPILE)gcc
OBJCOPY=$(CROSS_COMPILE)objcopy
OBJDUMP=$(CROSS_COMPILE)objdump

CFLAGS = -march=rv64imfd -mabi=lp64d -fno-builtin -ffreestanding

CCFLAGS = $(CFLAGS)
CCFLAGS += -mcmodel=medany -O0 -Wall
CCFLAGS += -fno-pic -fno-common -g -I. -Icommon

LFLAGS = -static -nostartfiles -T common/main.lds
SRCFILES:=$(wildcard *.c) $(wildcard common/*.c)
all: boot.elf

boot.elf: common/head.S $(SRCFILES)
	$(CC) $(CCFLAGS) $(LFLAGS) -o $@ common/head.S $(SRCFILES)
	$(OBJDUMP) -d $@ > boot.asm

clean:
	rm -f *.elf
