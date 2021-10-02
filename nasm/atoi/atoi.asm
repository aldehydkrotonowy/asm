section .data
section .bss
section .text
  global ng_atoi
ng_atoi:
  mov rax, 0; initial sum
convert:
  mov rsi, byte [rdi]
  test rsi, rsi       ;check for \0
  je done

  cmp rsi, 48; if less then error
  jl error

  cmp rsi, 57; if more then also error
  jg error

  sub rsi, 48
  imul rax, 10
  add rax, rsi

  inc rdi
  jmp convert

error:
  move rax, -1

done:
  ret

