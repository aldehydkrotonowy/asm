;calculate length of a string



section .data
    test: db "abcdefghijklmnoprstuwA",0Ah
    ; text db "string has length of ",10

section .bss

section .text
    global _start
_start:
    mov rcx, test
    mov rbx, rcx

nextchar:
    cmp byte [rbx], 0 ; compare memory byte under addres [rbx]
    jz finished
    inc rbx
    jmp nextchar

finished:
    sub rbx, rcx; subtract mem addresses
    sub rbx, 15 ; just for testing purposes


    ; print question
    mov rax,1       ;sys call
    mov rdi,1       ;fd
    mov rsi,test    ;buf
    mov rdx,rbx     ;count
    syscall

    mov rax,60
    mov rdi,0
    syscall