section .data
    question db "Give me some number: "
    text db "hello from loop ",10
section .bss
    userNumber resb 32
section .text
    global _start
_start:
    ; print question
    mov rax,1
    mov rdi,1
    mov rsi,question
    mov rdx,21
    syscall
_read_number:
    mov rax,0
    mov rdi,0
    mov rsi,userNumber
    mov rdx,32
    syscall

;     mov rcx,userNumber
;     sub rcx,'0' 
;     cmp rcx,0
;     je end
; myLoop:
;     mov rax,1
;     mov rdi,1
;     mov rsi,userNumber
;     mov rdx,17
;     syscall
;     loop myLoop

; end:
    mov rax,60
    mov rdi,0
    syscall
