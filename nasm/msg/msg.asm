section .text
global _start
_start:
  push rax
  push rdi
  push rsi
  push rdx

; sys_write(1, msg, 13) then syscall
  mov rax, 0x01           ;sys_write
  mov rdi, 0x01           ;to stdout
  mov rsi, msg            ;
  mov rdx, 0x12           ;msg length
  syscall
; sys_read() 
  mov rax, 0x00           ;syscall read
  mov rdi, 0x02           ;from stdin
  mov rsi, inp_buf        ;to buffer
  mov rdx, 0x0A           ;how many characters
  syscall

;sys_pring()
  mov rax,0x01            ;sys_write
  mov rdi,0x01            ;to stdout
  mov rsi,inp_buf         ;buffer content
  mov rdx,0x0A            ;number of characters
  syscall

  pop rax
  pop rdi
  pop rsi
  pop rdx

  mov rax,0x3c            ;syscall for exit
  mov rdi,0x0
  syscall

section .data
  msg db "input some data: ",10
  msg_size equ $-msg



  msg2 db "You entered: ",10
  msg2_size equ $-msg2
section .bss
  inp_buf: resq 100
