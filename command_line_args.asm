%include "nasm_macro.inc"

section .data
    new_line  db 10,0
    arg_count db "Number of arguments: ",0
    arg_desc  db "Argument #",0
    points_r  db  ": ",0

section .bss
    argc resb 8 ;reserve 8 bytes (64 bits) to store the number of arguments
                ;(maybe a little too much?)

section .text
    global _start

_start:

    mov r10, argc   ;stores the address of argc into r10
    pop rcx         ;pops the first item on the stack (the number of arguments)
    mov [r10], rcx  ;moves the number of arguments to the address argc
    print arg_count
    print_int [r10]
    print new_line
    mov r8, 0
    _show_args_loop:
        print arg_desc
        print_int r8
        print points_r
        mov r10, argc   ;ensure that r10 contains the address argc
        pop rax         ;get the next arguments from the stack
        print rax
        print new_line
        inc r8
        cmp r8,[r10]
        jl _show_args_loop
    exit 0
