# asm

nasm -f elf64 -o test.o test.asm \
ld test.o -o test

---

## debuging

nasm -g -F dwarf -f elf64 hello.asm \  
ld -o hello hello.o \
gdb ./hello

---
## man pages
[section 2](https://man7.org/linux/man-pages/dir_section_2.html)
[syscall list](https://hackeradam.com/x86-64-linux-syscalls/)
## arguments order for syscalls

| Argument | ID  | #1  | #2  | #3  | #4  | #5  | #6  |
| -------- | --- | --- | --- | --- | --- | --- | --- |
|          | rax | rdi | rsi | rdx | r10 | r8  | r9  |

## registers
| **type** | **bits** | **registers** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| general | 8 | al        | bl | cl | dl |  |  |  |  | r8b | r9b | r10b | r11b | r12b | r13b | r14b | r15b |
|  |  | ah | bh | ch | dh |  |  |  |  |  |  |  |  |  |  |  |  |
|  | 16 | ax | bx | cx | dx | si | di | sp | bp | r8w | r9w | r10w | r11w | r12w | r13w | r14w | r15w |
|  | 32 | eax | ebx | ecx | edx | esi | edi | esp | ebp | r8d | r9d | r10d | r11d | r12d | r13d | r14d | r15d |
|  | 64 | rax | rbx | rcx | rdx | rsi | rdi | rsp | rbp | r8 | r9 | r10 | r11 | r12 | r13 | r14 | r15 |
| debug | 32 | dr0 | dr1 | dr2 | dr3 |  |  | dr6 | dr7 |  |  |  |  |  |  |  |  |
| FPU | 80 | st0 | st1 | st2 | st3 | st4 | st5 | st6 | st7 |  |  |  |  |  |  |  |  |
| mmx | 64 | mm0 | mm1 | mm2 | mm3 | mm4 | mm5 | mm6 | mm7 |  |  |  |  |  |  |  |  |
| sse | 128 | xmm0 | xmm1 | xmm2 | xmm3 | xmm4 | xmm5 | xmm6 | xmm7 |  |  |  |  |  |  |  |  |
| avx | 256 | ymm0 | ymm1 | ymm2 | ymm3 | ymm4 | ymm5 | ymm6 | ymm7 |  |  |  |  |  |  |  |  |
| avx-512 | 512 | zmm0 | zmm1 | zmm2 | zmm3 | zmm4 | zmm5 | zmm6 | zmm7 |  |  |  |  |  |  |  |  |
| opmask | 64 | k0 | k1 | k2 | k3 | k4 | k5 | k6 | k7 |  |  |  |  |  |  |  |  |
| bounds | 128 | bnd0 | bnd1 | bnd2 | bnd3 |  |  |  |  |  |  |  |  |  |  |  |  |

r8w - r15w - in AMD 'w' must be replaced with 'l' r8l - r15l

## syscall examples

#filedesc = 0 - standard input, 1 - standard output, 2 - standard error
syscall | ID | Arg1 | Arg2 | Arg3 | Arg4 |
---|---|---|---|---|---|---|---|---|---|
sys_read | 0 | #filedesc | $buff | #count
sys_write | 1 | #filedesc | $buff | #count
sys_open | 2 | $filename | #flags | #mode
sys_close | 3 | #filedesc
pwritev2 | 328

---

full syscall [list](https://filippo.io/linux-syscall-table/)

---

## int vs syscall [StackOverflow](https://stackoverflow.com/questions/12806584/what-is-better-int-0x80-or-syscall-in-32-bit-code-on-linux)

- **syscall** is the default way of entering kernel mode on x86-64. This instruction is not available in 32 bit modes of operation on Intel processors.
- **sysenter** is an instruction most frequently used to invoke system calls in 32 bit modes of operation. It is similar to syscall, a bit more difficult to use though, but that is the kernel's concern.
- **int 0x80** is a legacy way to invoke a system call and should be avoided.

---

- **vDSO** (_virtual dynamic shared object_) is a kernel mechanism for exporting a carefully selected set of kernel space routines to user space applications so that applications can call these kernel space routines in-process

---

## Reading

- [The Linux kernel - system calls](https://www.win.tue.nl/~aeb/linux/lk/lk-4.html)
- [Sysenter Based System Call Mechanism in Linux 2.6](https://articles.manugarg.com/systemcallinlinux2_6.html)
- [Dynamiczna alokacja pamięci pod Linuksem - sys_brk()](http://bogdro.evai.pl/linux/alloc_tut_linux.html)

complicated instruction

- Addsubps
- PEXT
- PDEP
- PSHUFB
- PMADDWD
- RDSEED
- DPPS
- CMPXCHG
- PCLMULQDQ
- MPSADBW
- PCMPxSTrx

### Taksonomia Flynna

- SISD (single instruction, single data)
- SIMD (single instruction, multiple data)
- MISD (multiple instruction, single data)
- MIMD (multiple instruction, multiple data)

Streaming SIMD Extensions (SSE)

bash
-e file - true if file exists (for example /dev/null returns true)
-f file - ture is file exists and is regular file

strace
strace ./myprogram
-c count number of system calls
-e trace=write find particular syscall

git submodule add https://github.com/ReturnInfinity/BareMetal-OS-legacy.git submodules/BareMetal-OS-legacy

CODE EXAMPLES AND EXPLANATIONS
; -----------------------------------------------------------------------------
; os_string_length -- Return length of a string
; IN: RSI = string location
; OUT: RCX = length (not including the NULL terminator)
; All other registers preserved
os_string_length:
push rdi
push rax

    xor ecx, ecx
    xor eax, eax
    mov rdi, rsi
    not rcx         ; 1's complement of "0111" is "1000", for example 9 becomes -9

https://en.wikipedia.org/wiki/Direction_flag
https://learn.microsoft.com/en-us/cpp/c-runtime-library/direction-flag?view=msvc-170
; This flag is used to determine the direction ('forward' or 'backward') in which several ;bytes of data will be copied from one place in the memory, to another. The direction is important mainly when the original data position in memory and the target data position overlap. If it is set to 0 (using the clear-direction-flag instruction CLD) — it means that string is processed beginning from lowest to highest address; such instructions mode is called auto-incrementing mode. Both the source index and destination index (like MOVS) will increase them;
cld ; Clears the DF flag in the EFLAGS register.
; When the DF flag is set to 0, string operations increment the index
; registers (ESI and/or EDI). Operation is the same in all modes.

                  ; The SCAS instruction subtracts the destination string element from the contents of the EAX, AX, or AL register (depending on operand length) and updates the status flags according to the results. The string element and register contents are not modified. The following “short forms” of the SCAS instruction specify the operand length: SCASB (scan byte string), SCASW (scan word string), and SCASD (scan doubleword string).
                  REPNE - REPeat while Not Equal
									termination condition RCX or (E)CX = 0 or ZF=1
                  ; So it looks like this code is searching for byte 0 stored in eax
                  ; current byte is pointed by RDI
                  ; and becouse of CLD command RDI is incremented
                  ; RCX/ECX (counter) and RDI/EDI (address)
                  ; repne is using RCX
; -----------------------------------------------------------------------------
	repne scasb			; Compare AL with byte at ES:(E)DI or RDI then set status flags
	not rcx
	dec rcx

	pop rax
	pop rdi
	ret
; -----------------------------------------------------------------------------

linux-x86_64 syscall calling convention is:

RDI -> first parameter
RSI -> second parameter
RDX -> third parameter
R10 -> fourth parameter
R8  -> fifth parameter
R9  -> sixth parameter
R11 -> ... (for all syscalls)
RCX -> ... (for all syscalls)
RAX -> return


REPNE
	 default CountReg is RCX in 64bit
WHILE CountReg !== 0
	CountReg--
	IF CountReg === 0 exit
	IF ZF === 1 exit


SCAS
compare memory operand EDI, RDI with register operand AL, AX, EAX
THEN IF DF = 0 
	THEN RDI++
	ELSE RDI--

## how scab works - pseudocode
```C
if(IsByteComparison()) {
	Temporary = AL - Source;
	SetStatusFlags(Temporary);
	if(DF == 0) {
		(E)SI = (E)SI + 1;
		(E)DI = (E)DI + 1;
	}
	else {
		(E)SI = (E)SI - 1;
		(E)DI = (E)DI - 1;
	}
}
else if(IsWordComparison()) {
	Temporary = AX - Source;
	SetStatusFlags(Temporary);
	if(DF == 0) {
		(E)SI = (E)SI + 2;
		(E)DI = (E)DI + 2;
	}
	else {
		(E)SI = (E)SI - 2;
		(E)DI = (E)DI - 2;
	}
}
else { //doubleword comparison
	Temporary = EAX - Source;
	SetStatusFlags(Temporary);
	if(DF == 0) {
		(E)SI = (E)SI + 4;
		(E)DI = (E)DI + 4;
	}
	else {
		(E)SI = (E)SI - 4;
		(E)DI = (E)DI - 4;
	}
}
```
## Convert Character to binary [link](https://stackoverflow.com/questions/40769766/convert-character-to-binary-assembly-language)
```asm
 cx = 8   ; 8 bits to output
bin_loop:
    rcl al,1 ; move most significant bit into CF
    setc bl  ; bl = 0 or 1 by CF (80386 instruction)
    add bl,'0' ; turn that 0/1 into '0'/'1' ASCII char
    call display_bl ; must preserve al and cx
    loop bin_loop
```