section .data
  text db "hellokdjfkdksjfsadjkfsdfsdkl jfklsdj flkj", 0Ah
section .bss
  buff resb 44
section .text
global _start
_start:
  push rax
  push rbx
  push rcx
  push rsi
  push rdi

  
  mov rcx, text
  mov rbx, rcx

next:
  cmp byte [rbx], 0
  jz end
  inc rbx
  jmp next

end:
  sub rbx, rcx
  mov rax, 1
  mov rdi, 1
  mov rsi, text
  mov rdx, rbx
  syscall

  mov rax, 60
  mov rdi, 1
  syscall
