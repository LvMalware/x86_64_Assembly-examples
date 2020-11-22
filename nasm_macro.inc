;standart I/O file descriptors

STDIN  equ 0
STDOUT equ 1
STDERR equ 2

;system calls

SYS_READ  equ 0
SYS_WRITE equ 1
SYS_EXIT  equ 60

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
    push rax
    push rdi
    push rsi
    push rdx
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, %1
    strlen %1
    syscall
    pop rdx
    pop rsi
    pop rdi
    pop rax
%endmacro
