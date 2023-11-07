;calculate length of a string
;sh compile-nasm-exercise.sh 3 strLength e

;  IN:	RSI = string location
; OUT:	RCX = length (not including the NULL terminator)
section .data
    numb: db "0123456789", 0Ah
    test: db "aaaaaabiiijyy",00h
    test_l: equ $-test
    
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
    std
    mov r9, test_l
    mov rsi, test
    mov rdi, rsi    ;RDI points current byte

    xor rcx, rcx    ;used by REPNE? rcx=0
    xor rax, rax    ;compare RDI with AL

_rcx:
    not rcx         ; RCX=-1
_cld:
    cld             ;DF=0 index++, lowest-to-highest address, auto-incrementing

                    ;repne termination (R|E|C)X=0 or ZF=1 (ZF is set by scasb ZF=1 found, ZF=0 not found) 
                    ;Use RCX for CountReg
_repne_do:
    repne scasb     ;RDI=current byte, if (cld) DF=0 then (R|E)DI++, RCX--, compare AL<->RDI
    mov r10, [RDI]
_repne_done:
    not rcx
	dec rcx

    ; print how many bytes was found
    mov rax,1       ;sys_write
    mov rdi,1       ;fd
    mov rsi,numb    ;buf
    mov rdx,rcx     ;count
    syscall

    mov rax,60
    mov rdi,0
    syscall