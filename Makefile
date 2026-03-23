CCFLAGS = -ffreestanding -fno-pie -no-pie
CCFLAGSC = -ffreestanding -fno-exceptions -fno-stack-protector -fno-pie -fno-pic -fno-unwind-tables -fno-asynchronous-unwind-tables -I include -nostdlib -Wall -Wextra -fno-ident
PREFIX = i686-linux-gnu-
all:
	@mkdir build -p
	@$(PREFIX)gcc -c src/boot.s -o build/boot.o $(CCFLAGS)
	@$(PREFIX)gcc -c src/entry.c -o build/entry.o $(CCFLAGSC)
	@$(PREFIX)gcc -c src/vga.c -o build/vga.o $(CCFLAGSC)
	@$(PREFIX)gcc -c src/port.c -o build/port.o $(CCFLAGSC)
	@$(PREFIX)gcc -c src/kb.c -o build/kb.o $(CCFLAGSC)
	@rm -f build/kernel.elf
	@cd build; ld.lld -m elf_i386 -T ../kernel.ld *.o -o kernel.elf
	@cp build/kernel.elf iso
	@grub-mkrescue -d /usr/lib/grub/i386-pc -o build/boot.iso iso

qemu-vnc:
	@qemu-system-i386 build/boot.iso -display vnc=:1

clean:
	@rm -rf build
