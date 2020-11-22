%include "nasm_macro.inc"

section .data
    text db "Hello, World!",10,0

section .text
    global _start

_start:
    print text
    exit 0
