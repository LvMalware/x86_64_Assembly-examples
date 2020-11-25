%include "nasm_macro.inc"

section .data
    filename db "test_file.txt",0

section .bss
    data resb 100   ;allocate 100 bytes of data to be read

section .text
    global _start

_start:

    mov rax, SYS_OPEN       ;
    mov rdi, filename       ;
    mov rsi, O_RDONLY       ;
    mov rdx, 0644o          ;
    syscall                 ;

    mov rdi, rax            ;sys_open() returns the file descriptor into rax, but 
                            ;we will need it to be in rdi for the next syscall

    mov rax, SYS_READ       ;
    mov rsi, data           ;
    mov rdx, 35             ;the file we are reading contains 35 bytes
    syscall                 ;

    mov rax, SYS_CLOSE      ;
    syscall                 ;

    print data              ;print the data from the file

    exit 0                  ;exit returning 0
