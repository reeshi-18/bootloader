bits 16                 ; 16 bit mode
org 0x7c00              ; offset

boot:
    mov si, hello       ; point si register to hello label memory location
    mov ah, 0x0e        ; tty mode

.loop:
    lodsb               ; load string [DS:SI]into AL

    cmp al, 0
    je halt           

    int 0x10            
    jmp .loop

halt:
    cli                 ; clear interrupt flag
    hlt                 ; halt execution until wake up

hello: db "Hello world!",0

times 510 - ($-$$) db 0 ; padding
dw 0xaa55               ; magic word