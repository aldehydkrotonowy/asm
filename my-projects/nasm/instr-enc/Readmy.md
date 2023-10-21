nasm -g -f elf64 -o asm.o asm.asm
objdump -d --disassembler-options=intel-mnemonic  asm.o

Disassembly of section .text:

0000000000000000 <_start>:
   0:   b8 0a 00 00 00          mov    eax,0xa
   5:   bb 0a 00 00 00          mov    ebx,0xa
   a:   b9 0a 00 00 00          mov    ecx,0xa
   f:   ba 0a 00 00 00          mov    edx,0xa
  14:   be 0a 00 00 00          mov    esi,0xa
  19:   bf 0a 00 00 00          mov    edi,0xa
  1e:   41 b8 0a 00 00 00       mov    r8d,0xa
  24:   41 b9 0a 00 00 00       mov    r9d,0xa
  2a:   41 ba 0a 00 00 00       mov    r10d,0xa
  30:   41 bb 0a 00 00 00       mov    r11d,0xa
  36:   41 bc 0a 00 00 00       mov    r12d,0xa
  3c:   41 bd 0a 00 00 00       mov    r13d,0xa
  42:   41 be 0a 00 00 00       mov    r14d,0xa
  48:   41 bf 0a 00 00 00       mov    r15d,0xa