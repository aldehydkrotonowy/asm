; taken from https://eng.libretexts.org/Bookshelves/Computer_Science/Programming_Languages/Book%3A_x86-64_Assembly_Language_Programming_with_Ubuntu_(Jorgensen)/13%3A_System_Services/13.04%3A_Console_Input

; Example program to demonstrate console output.
; This example will send some messages to the screen.
; **********************************************

section .data 

; -----
;  Define standard constants.

LF             equ    10             ; line feed
NULL           equ    0              ; end of string 
TRUE           equ    1
FALSE          equ    0

EXIT_SUCCESS   equ    0              ; success code

STDIN          equ    0              ; standard input
STDOUT         equ    1              ; standard output
STDERR         equ    2              ; standard error

SYS_read       equ    0              ; read
SYS_write      equ    1              ; write
SYS_open       equ    2              ; file open
SYS_close      equ    3              ; file close
SYS_fork       equ    57             ; fork
SYS_exit       equ    60             ; terminate
SYS_creat      equ    85             ; file open/create
SYS_time       equ    201            ; get time

; -----
; Define some strings.

STRLEN         equ    50

pmpt           db     "Enter Text: ", NULL
newLine        db     LF, NULL

section    .bss
chr            resb   1
inLine         resb   STRLEN+2        ; total of 52

;------------------------------------------------------

section     .text 
global _start 
_start:

; -----
;  Display prompt.

    mov     rdi, pmpt 
    call    printString

; -----
;  Read characters from user (one at a time)
    mov    rbx, inLine                ; inline addr
    mov    r12, 0                     ; char count
readCharacters:
    mov    rax, SYS_read              ; system code for read
    mov    rdi, STDIN                 ; standard in
    lea    rsi, byte [chr]            ; address of chr
    mov    rdx, 1                     ; count (how many to read)
    syscall                           ; do syscall
    
    mov    a1, byte [chr]             ; get character just read
    cmp    a1, LF                     ; if linefeed, input done
    je     readDone
    
    inc    r12                        ; count++
    cmp    r12, STRLEN                ; if # chars >= STRLEN
    jae    readCharacters             ;   stop placing in buffer
    
    mov    byte [rbx], a1             ; inLine[i] = chr
    inc    rbx                        ; update tmpStr addr
    
    jmp    readCharacters
readDone:
    mov    byte [rbx], NULL           ; add NULL termination
    
; -----
;  Output the line to verify successful read

    mov    rdi, inLine 
    call   printString

; -----
;  Example done.

exampleDone:
    mov    rax, SYS_exit 
    mov    rdi, EXIT_SUCCESS 
    syscall

; ******************************************************
;  Generic procedure to display a string to the screen.
;  String must be NULL terminated.
;  Algorithm:
;     Count characters in string (excluding NULL)   
;  Use syscall to output characters
;  Arguments:
;  1) address, string 
;  Returns:
;  nothing

global printString 
printString:
    push     rbx

; -----
;  Count characters in string.

    mov     rbx, rdi 
    mov     rdx, 0  

strCountLoop:
    cmp     byte [rbx], NULL
    je      strCountDone
    inc     rdx
    inc     rbx
    jmp     strCountLoop
strCountDone:

    cmp     rdx, 0
    je      prtDone
    
; -----
; Call OS to output string.

    mov     rax, SYS_write     ; system code for write ()
    mov     rsi, rdi           ; address of char's to write
    mov     rdi, STDOUT        ; standard out
                               ; RDX=count to write, set above
    syscall                    ; system call
    
; -----
;  String printed, return to calling routine.

prtDone:
    pop     rbx
    ret                