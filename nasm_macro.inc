;standart I/O file descriptors

STDIN  equ 0
STDOUT equ 1
STDERR equ 2

;system calls

SYS_READ  equ 0
SYS_WRITE equ 1
SYS_EXIT  equ 60

;reserve some memory for future use

section .bss
    __rsv_byte resb 1

%macro exit 1
    mov rax, SYS_EXIT
    mov rdi, %1
    syscall
%endmacro

%macro strlen 1
    push rsi
    mov rsi, %1
    mov rdx, 0
    %%count_loop:
        mov cl, [rsi]
        cmp cl, 0
        je %%end_count
        inc rsi
        inc rdx
        jmp %%count_loop
    %%end_count:
        pop rsi
%endmacro

%macro print 1
    mov rsi, %1
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    strlen rsi
    syscall
%endmacro

%macro print_int 1
    mov rax, %1
    mov rbx, 10
    mov r9, 0
    
    %%digits_loop:
        mov rdx, 0
        div rbx
        add rdx, 48
        push rdx
        inc r9
        cmp rax, 0
        jg %%digits_loop

    mov rsi, __rsv_byte
    
    %%print_loop:
        pop rbx
        mov [rsi], bl
        mov rax, 1
        mov rdi, 1
        mov rdx, 1
        syscall
        dec r9
        cmp r9, 0
        jg %%print_loop
%endmacro
