# asm

nasm -f elf64 -o test.o test.asm \
ld test.o -o test

---

## debuging 
nasm -g -F dwarf -f elf64 hello.asm \  
ld -o hello hello.o \
gdb ./hello

---

## arguments order for syscalls
Argument |ID | #1 | #2 | #3 | #4 | #5 | #6 |
--- |--- | --- | --- | --- |--- |--- |--- |
| | rax | rdi | rsi | rdx | r10 | r8 | r9 | 

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
- **vDSO** (*virtual dynamic shared object*) is a kernel mechanism for exporting a carefully selected set of kernel space routines to user space applications so that applications can call these kernel space routines in-process
---





## Reading
- [The Linux kernel - system calls](https://www.win.tue.nl/~aeb/linux/lk/lk-4.html)
- [Sysenter Based System Call Mechanism in Linux 2.6](https://articles.manugarg.com/systemcallinlinux2_6.html)
- [Dynamiczna alokacja pamięci pod Linuksem - sys_brk()](http://bogdro.evai.pl/linux/alloc_tut_linux.html)