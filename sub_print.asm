;implements a sub routine to print a string independently of its length

section .data
    ;the strings must end with a null byte (0) as in C
    text db "Hello, World!",10,0
    text2 db "Printing a larger string ... blah blah blah",10,0

section .text
    global _start

_start:
    mov rsi, text   ;moves the address named text to the rsi register
    call _printstr  ;call the sub-routine to print the text

    mov rsi, text2  ;moves the address named text2 to the rsi register
    call _printstr  ;

    mov rax, 60     ;sys_exit()
    mov rdi, 0      ;return 0
    syscall         ;

;_printstr: print a zero-termined string
;input: rsi register (address of the string)
_printstr:
    mov rax, 1      ;sys_write()
    mov rdi, 1      ;standart output
    call _strlen    ;counts the length of the string and stores into rdx
    syscall         ;
    ret             ;returns to the address from where it was called

;_strlen: counts the length of a zero-termined string
;input: rsi register (address of the zero-termined string)
;output: rdx register (length of the string)
_strlen:
    push rsi        ;copies the value from rsi (the address of the string) into
                    ;the stack
    mov rdx, 0      ;stores the value 0 into rdx
    _count_loop:
        mov cl, [rsi]       ;reads the lower bits from the address stored in
                            ;rsi to the cl register (a 8-bit equivalent of the
                            ;rcx register)
        cmp cl, 0           ;compares the value into cl with 0
        je _end_count_loop  ;jumps to _end_count_loop if cl is equal to 0
        inc rsi             ;increments rsi by one (moves one byte ahead)
        inc rdx             ;increments rdx by one
        jmp _count_loop     ;repeat the loop
    _end_count_loop:
        pop rsi             ;pops the value at the top of the stack back into rsi
        ret                 ;return to the address from where it was called
