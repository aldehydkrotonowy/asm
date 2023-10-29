;calculate length of a string


;  IN:	RSI = string location
; OUT:	RCX = length (not including the NULL terminator)
section .data
    numb: db "0123456789", 0Ah
    test: db "aaa",0Ah
    
section .bss

section .text
    global _start
_start:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi

    mov rsi, test
    mov rdi, rsi    ;RDI points current byte

    xor rcx, rcx    ;used by REPNE?
    xor rax, rax    ;compare RDI with AL

    not rcx
    cld
    repne scasb
    not rcx
	dec rcx

    ; print how many bytes was found
    mov rax,1       ;sys call
    mov rdi,1       ;fd
    mov rsi,numb    ;buf
    mov rdx,rcx     ;count
    syscall

    mov rax,60
    mov rdi,0
    syscall