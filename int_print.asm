;print integers
section .bss
    num resb 100
section .text
    global _start

_start:
    mov rax, 103784787746
    mov rbx, num
    call _num_to_text
    mov rax, 1
    mov rdi, 1
    mov rsi, num
    syscall
    mov rax, 60
    mov rdi, 0
    syscall

_num_to_text:
    ;converts the number in rax to a "string", storing it in the address rbx
    ;points to and store the size of the string into rdx to be printed
    push rax            ;save tha values of rax, rsi and rdi into the stack
    push rsi
    push rdi
    ;note that the digits will be obtained in the reserve order (from right to
    ;left) so we will add them to the stack to recover them in the correct order
    push 10             ;the output string will end with a new line character
    mov rdi, 1          ;the is one character in the string already (new line)
    mov rsi, 10

    _div_loop:
        mov rdx, 0      ;rdx must be zero or its value will affect the division
        div rsi         ;divides rax by 10, rdx contains the remainder
        add rdx, 48     ;adds 48 (char "0") to rdx to obtain the equivalent char
        push rdx        ;pushes rdx to the stack
        inc rdi         ;increments rdi by one (to keep track on the number of
                        ;digits)
        cmp rax, 0      ;if rax is 0, we reached the end
        jg _div_loop    ;if rax is bigger than 0, repeat

    mov rdx, 0          ;sets rdx to 0

    _fill_loop:
        pop rsi         ;pops the first value on the stack to rsi
        mov [rbx], sil  ;load the lower bits of rsi to the address rbx points to
        inc rbx         ;increments rbx by one (move one position on the string)
        dec rdi         ;decrements rdi (number of digits left)
        inc rdx         ;increments rdx (number of digits in the string)
        cmp rdi, 0      ;if theres no more digits, we are done
        jg _fill_loop   ;repeat if the are more digits

    pop rdi             ;restore rdi, rsi and rax
    pop rsi
    pop rax
    ret                 ;return to the caller
