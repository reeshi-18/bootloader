[org 0x7c00]                            ; bootloader offset
    mov bp, 0x9000                      ; set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print                          ; This will be written after the BIOS messages

    call switch_to_pm
    jmp $                               ; this will actually never be executed

%include "boot_sect_print.asm"
%include "gdt.asm"
%include "print.asm"
%include "switch.asm"

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

; bootsector
times 510-($-$$) db 0
dw 0xaa55