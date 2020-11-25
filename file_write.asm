section .data
    mydata db "Some data to write to the file",10
    filename db "test.txt",0
section .text
    global _start
_start:

    mov rax, 2          ;sys_open() system call
    mov rdi, filename   ;the full path to the file
    mov rsi, 1+64       ;1 - write only, 64 - create file
    mov rdx, 0644o      ;permissions: -rw-r--r--
    syscall             ;

    mov rdi, rax        ;the file descriptor is returned into rax, so we move it
                        ;to rdi, since it will need it there to the next syscall

    mov rax, 1          ;sys_write()
    mov rsi, mydata     ;rsi contains the address of the buffer to be written
    mov rdx, 31         ;the length of the buffer
    syscall             ;

    mov rax, 3          ;sys_close()
    syscall             ;rdi already contains the file descriptor

    mov rax, 60         ;sys_exit()
    mov rdi, 0          ;exit returning 0
    syscall             ;
