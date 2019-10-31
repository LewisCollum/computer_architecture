IMAGE := kernel.elf

CROSS_COMPILE = aarch64-linux-gnu-
CC = $(CROSS_COMPILE)gcc
CFLAGS = -Wall -fno-common -O0 -g -nostartfiles -ffreestanding -march=armv8-a

OBJS = startup.o main.o fibonacci.o

all: $(IMAGE)

$(IMAGE): kernel.ld $(OBJS)
	$(CC) $(OBJS) -T $< -o $(IMAGE) $(CFLAGS)

qemu: $(IMAGE)
	@qemu-system-aarch64 \
		-machine virt -cpu cortex-a53 \
		-smp 4 -m 4096 \
		-nographic -serial mon:stdio \
		-monitor telnet:127.0.0.1:1234,server,nowait \
		-kernel $(IMAGE)

clean:
	rm -f $(IMAGE) *.o

.PHONY: all qemu clean
