section .data;
  ; myeagle: dt  3.141592653589793238462;
  mytext: db "abckdfdkaadfasdf", 0Ah;
  textlen equ $-mytext;
  a1 db 0x55            ;1 byte (8 bit): byte, DB, RESB
  a2 db 0x55,0x56,0x57  ;x3: byte
  a3 db 'a',0x55        ;character constants are OK
  a4 db 0x55;1 byte (8 bit): byte, DB, RESB
  a5 db 0x55;1 byte (8 bit): byte, DB, RESB
  b1 dw 0x1234;2 bytes (16 bit): word, DW, RESW
  b2 dw 'ABC'; 0x61 0x62 0x63 0x00 (string)
  c dd 0x12345678;4 bytes (32 bit): dword, DD, RESD
  d1 dq 0x1122334455667788;8 bytes (64 bit): qword, DQ, RESQ
  d2 dq 1.e-10; 10,000,000,000
  d3 dq 1.e10; 0.000 000 000 1 
  e dt 3.141592653589793238462;10 bytes (80 bit): tword, DT, REST
  ;f do 0x112233445566778899; 16 bytes (128 bit): oword, DO, RESO, DDQ, RESDQ ; nie wiem jak to zainicjalizować
  ; g dy ;32 bytes (256 bit): yword, DY, RESY ; nie wiem jak to zainicjalizować
  ; h dz ;64 bytes (512 bit): zword, DZ, RESZ ; nie wiem jak to zainicjalizować
section .bss;
  ;RESB, RESW, RESD, RESQ and REST are designed to be used in the BSS
  ;section of a module: they declare uninitialised storage space. 
  buffer: resb 64; reserve 64 bytes 
  wordvar: resw 1; reserve a word 
  realarray resq 10; array of ten reals
section .text;
  global _start
_start:
  mov rcx, 1