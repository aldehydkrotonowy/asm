section .data 
    text db "djaksd", Ah0
section .bss
section .text
global _start
_start:
    mov rcx, text
    mov rbx, rcx

next:
    cmp [rbx], 0
    jz end
    inc rbx
    loop next

end:
    sub rbx, rcx

    mov rax, 1
    mov rdi, 1
    mov rsi, text
    mov rdx, rbx
    syscall

    mov rax, 60,
    mov rdi, 0
    syscall