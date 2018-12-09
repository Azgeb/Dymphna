#assemble boot.s file
as --32 boot.s -o boot.o

#compile kernel.c file
gcc -m32 -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -fPIC -Wall -Wextra

#linking the kernel with kernel.o and boot.o files
gcc -m32 -T linker.ld -o Dymphna.bin -ffreestanding -O2 -nostdlib kernel.o boot.o -lgcc 

#check MyOS.bin file is x86 multiboot file or not
grub-file --is-x86-multiboot Dymphna.bin

#building the iso file
mkdir -p isodir/boot/grub
cp Dymphna.bin isodir/boot/MyOS.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o Dymphna.iso isodir

#run it in qemu
qemu-system-x86_64 -cdrom Dymphna.iso -m 512
