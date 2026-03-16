.section .multiboot
.align 4
.long 0x1BADB002
.long 0x00000000
.long -(0x1BADB002)

.section .bss
.align 16
stack_bottom:
.skip 16384
stack_top:

.section .text
.global _start
.type _start, @function
.extern kmain
_start:
    mov $stack_top, %esp
    cli
    cld
    push %ebx
    push %eax
    call josh
hang:
    hlt
    jmp hang
.section .note.GNU-stack,"",@progbits
.section .build_note, "a", @note
.align 4
.long 8
.long 15
.long 70
.asciz "made by"
.align 4
.asciz "voxj. (or orcapet i mean they coded this)"
.align 4
