;this is a comment
;programs have basically 3 sections of memory: data, text and bss

;the 'data' section holds the data that is defined before compilation
section .data
    text db "Hello, World!", 10
    ;db - define bytes - indicates the definition of raw bytes in the code
    ;'text' is the name assigned to the address where these bytes will be located
    ;between quotes we have the raw bytes that will be stored somewhere in the
    ;memory. The number 10 indicates a new line ("\n")

;section 'text' holds the instructions of the program
section .text
    global _start   ;set the label _start as global (the linker needs this to 
    ;know the address of this label)

;the label _start is the point from where the program starts to execute
_start:

    mov rax, 1      ;set the value 1 to the register rax
    mov rdi, 1      ;set the value 1 to the register rdi
    mov rsi, text   ;sets the rsi register as the address that we named 'text'
    mov rdx, 14     ;sets the value 14 to the register rdx
    syscall         ;initiates a system call accordingly to the arguments defined
    ;the syscalls receive the arguments via the registers like in the table below

    ;argument  |  register
    ;   ID     |     rax
    ;   1      |     rdi
    ;   2      |     rsi
    ;   3      |     rdx
    ;   4      |     r10
    ;   5      |     r8
    ;   6      |     r9

    ;the value 1 in the register rax refers the the sys_write() system call
    ;the rdi register refers to the file descriptor of the standart output (1)
    ;the rsi register holds the address of the buffer to be written to output
    ;the rdx register holds the length (in bytes) of the buffer

    mov rax, 60     ;sets the value of rax to 60 (the sys_exit() system call)
    mov rdi, 0      ;sets the value of rdi to 0 (the value return when exitting)
    syscall         ;initiates the system call
