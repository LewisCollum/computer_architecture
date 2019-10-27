NAME = p1
TOOLCHAIN = arm-none-eabi
LDFLAGS = -nostdlib
OBJ = $(SRC:.c=.o) $(ASRC:.s=.o)

all: $(NAME).bin

%.bin: %.elf
	$(TOOLCHAIN)-objcopy $< -O binary $@

.SECONDARY : $(TARGET).elf
.PRECIOUS : $(OBJ)
%.elf: $(OBJ)
	$(TOOLCHAIN)-ld $(LDFLAGS) $^ -o $@

%.o: %.s
	$(TOOLCHAIN)-as -o $@ $<

%.o: %.c
	$(TOOLCHAIN)-gcc $(CFLAGS) -c $< -o $@

%.list: %.o
	$(TOOLCHAIN)-objdump -d $< > $@

run: $(NAME).bin
	qemu-system-aarch64 \
		-M raspi2 \
		-m 1G \
		-no-reboot \
		-nographic \
		-monitor telnet:127.0.0.1:1234,server,nowait \
		-kernel $<
