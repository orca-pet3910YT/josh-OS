CCFLAGS = -ffreestanding -m32 -fno-pie -no-pie
CCFLAGSC = -ffreestanding -m32 -fno-exceptions -fno-stack-protector -fno-pie -fno-pic -fno-unwind-tables -fno-asynchronous-unwind-tables -I include -nostdlib -Wall -Wextra -fno-ident
all:
	@mkdir build -p
	@gcc -c src/boot.s -o build/boot.o $(CCFLAGS)
	@gcc -c src/entry.c -o build/entry.o $(CCFLAGSC)
	@gcc -c src/vga.c -o build/vga.o $(CCFLAGSC)
	@gcc -c src/port.c -o build/port.o $(CCFLAGSC)
	@gcc -c src/kb.c -o build/kb.o $(CCFLAGSC)
	@rm -f build/kernel.elf
	@cd build; gcc -T ../kernel.ld *.o -o kernel.elf $(CCFLAGSC)
	@cp build/kernel.elf iso
	@grub-mkrescue -d /usr/lib/grub/i386-pc -o build/boot.iso iso

clean:
	@rm -rf build
