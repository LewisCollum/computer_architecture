IMAGE=02_recursiveSum.afx
OBJS = 02_recursiveSum.o mysum.o

CC=aarch64-elf-gcc
LD=aarch64-elf-gcc
AS=aarch64-elf-gcc
CFLAGS=-march=armv8-a -O0

# Select build rules based on Windows or Unix
ifdef WINDIR
	DONE=@if exist $(1) echo Build completed.
	RM=if exist $(1) del /q $(1)
	SHELL=$(WINDIR)\system32\cmd.exe

else
	ifdef windir
		DONE=@if exist $(1) echo Build completed.
		RM=if exist $(1) del /q $(1)
		SHELL=$(windir)\system32\cmd.exe

	else
		DONE=@if [ -f $(1) ]; then echo Build completed.; fi
		RM=rm -f $(1)
	endif
endif


all: $(IMAGE)
	$(call DONE,$(IMAGE))

rebuild: clean all

clean:
	$(call RM,*.o)
	$(call RM,$(IMAGE))
	$(call RM,linkmap.txt)

%.o: %.S
	$(AS) -g -c $< -o $@ 

$(IMAGE): $(OBJS)
# Link with specific base address to suit VE model memory layout
	$(CC) $(OBJS) $(CFLAGS) --specs=aem-ve.specs -Wl,--build-id=none,-Map=linkmap.txt -o $@
