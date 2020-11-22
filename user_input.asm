section .data
    question db "Whats your name? "
    hello    db "Hello, "

section .bss
    name resb 16 ;reserves 16 bytes starting with the address we named as 'name'

section .text
    global _start

_start:

    ;print the message asking the name of the user

    mov rax, 1          ;sys_write()
    mov rdi, 1          ;standart output
    mov rsi, question   ;address of the buffer
    mov rdx, 17         ;length of the buffer
    syscall             ;

    ;read the name of the user

    mov rax, 0          ;sys_read()
    mov rdi, 0          ;standart input
    mov rsi, name       ;address of the buffer
    mov rdx, 16         ;maximum length of the buffer
    syscall             ;

    ;print the 'hello' text

    mov rax, 1          ;sys_write()
    mov rdi, 1          ;standart output
    mov rsi, hello      ;address of the buffer
    mov rdx, 7          ;length of the buffer
    syscall             ;

    ;print the name of the user

    mov rax, 1          ;sys_write()
    mov rdi, 1          ;standart output
    mov rsi, name       ;address of the buffer
    mov rdx, 16         ;length of the buffer
    syscall             ;

    ;exit returning 0

    mov rax, 60         ;sys_exit()
    mov rdi, 0          ;return value
    syscall             ;
