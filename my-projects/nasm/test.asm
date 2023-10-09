section .data
    text db "Hello world",10
    question db "What is your name? "
    gret db "hello, "
    
section .bss
    name resb 16 ; reserve 16 baits

section .text   
    global _start
_start:
    call _print_hello
    call _print_question
    call _getName
    call _print_gret
    call _print_name

    mov rax,60
    mov rdi,0
    syscall

_getName:
    mov rax,0
    mov rdi,0
    mov rsi,name
    mov rdx,16
    syscall
    ret

_print_hello:
    mov rax,1
    mov rdi,1
    mov rsi,text
    mov rdx,14
    syscall
    ret

_print_question:
    mov rax,1
    mov rdi,1
    mov rsi,question
    mov rdx,19
    syscall
    ret

_print_gret:
    mov rax,1
    mov rdi,1
    mov rsi, gret
    mov rdx,7
    syscall
    ret

_print_name:
    mov rax,1
    mov rdi,1
    mov rsi,name
    mov rdx,16
    syscall
    ret
