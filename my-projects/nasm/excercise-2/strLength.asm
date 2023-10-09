;calculate length of a string

section .data
    text db "hello from loop ",10
section .bss
    userNumber resb 32
section .text
    global _start
_start:
    ; print question
    mov rax,1
    mov rdi,1
    mov rsi,text
    mov rdx,21
    syscall

    mov rax,60
    mov rdi,0
    syscall