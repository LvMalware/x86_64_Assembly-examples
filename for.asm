;a simple code to print a text multiple times using a for-like control structure
section .data
    text db "Some text",10
section .text
    global _start

_start:
    mov rbx, 0          ;sets the value of rbx to 0
    _for:               ;a label to simulate the 'for' control structure
        mov rax, 1      ;sets the value of rax to 1
        mov rdi, 1      ;sets the value of rdi to 1
        mov rsi, text   ;sets the the address named text as the value of rsi
        mov rdx, 10     ;sets the value of rdx to 10 (the length of the buffer)
        syscall         ;initiates the system call to sys_write (rax is 1)
        add rbx,0x1     ;increments by one the value stored into rbx
        cmp rbx,0x9     ;compares the value of rbx with 9
        jle _for        ;if the previous comparition says that rbx is less than  
                        ;or equal to 9, jump to the label _for

    ;this part will only be executed when rbx is bigger than 9
    mov rax, 60         ;sets the value of rax as 60 (the sys_exit() system call)
    mov rdi, 0          ;sets the value of rdi as 0 (the value to return by 
                        ;sys_exit)
    syscall             ;initiates the system call

