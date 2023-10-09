; ====================================================
; Numery bledow systemowych Linuksa, skladnia NASM
; Numery funkcji systemowych
; Stale zwiazane z funkcjami systemowymi
; ====================================================

; Copyright (C) 2007-2021 Bogdan 'bogdro' Drozdowski, bogdandr @ op . pl
;
; Ta biblioteka jest wolnym oprogramowaniem; mozesz ja rozpowszechniac
; i/lub modyfikowac zgodnie z licencja GNU Lesser General Public License
; (GNU LGPL) w wersji wydanej przez Fundacje Wolnego Oprogramowania;
; wedlug wersji 3 Licencji lub (jesli wolisz) jednej z pozniejszych wersji.
;
; Ta biblioteka jest udostepniana z nadzieja, ze bedzie uzyteczna, lecz
; BEZ JAKIEJKOLWIEK GWARANCJI; nawet domyslnej gwarancji PRZYDATNOSCI
; HANDLOWEJ albo PRZYDATNOSCI DO OKRESLONYCH ZASTOSOWAN. W celu uzyskania
; blizszych informacji - Licencja GNU Lesser General Public License.
;
; Z pewnoscia wraz z niniejszym programem otrzymales tez egzemplarz
; Licencji GNU Lesser General Public License; jesli nie - napisz do
; Fundacji Wolnego Oprogramowania:
;		Free Software Foundation
;		51 Franklin Street, Fifth Floor
;		Boston, MA 02110-1301
;		USA
;
;     This library is free software; you can redistribute it and/or
;     modify it under the terms of the GNU Lesser General Public
;     License as published by the Free Software Foundation; either
;     version 3 of the License, or (at your option) any later version.
;
;     This library is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;     Lesser General Public License for more details.
;
;     You should have received a copy of the GNU Lesser General Public
;     License along with this library; if not, write to the Free Software
;     Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
;	 MA  02110-1301  USA

if ~defined __FASM_SYSTEM_LINUX | defined @f
__FASM_SYSTEM_LINUX	= 1
@@:

EPERM  		=  1	; Operacja niedozwolona
ENOENT  	=  2	; Nie ma takiego pliku/katalogu
ESRCH  		=  3	; Nie ma takiego procesu
EINTR  		=  4	; Przerwana funkcja systemowa
EIO  		=  5	; Blad I/O
ENXIO  		=  6	; Nie ma takiego urzadzenia/adresu
E2BIG  		=  7	; Za dluga lista argumentow
ENOEXEC  	=  8	; Blad formatu wykonywalnego
EBADF  		=  9	; Zly numer pliku
ECHILD  	= 10	; Nie ma procesow potomnych
EAGAIN  	= 11	; Sprobuj jeszcze raz
ENOMEM  	= 12	; Brak pamieci
EACCES  	= 13	; Odmowa dostepu
EFAULT  	= 14	; Zly adres
ENOTBLK  	= 15	; Wymagane jest urzadzenie blokowe
EBUSY  		= 16	; Urzadzenie/zasob zajety
EEXIST  	= 17	; Plik istnieje
EXDEV  		= 18	; Cross-device link
ENODEV  	= 19	; Nie ma takiego urzadzenia
ENOTDIR  	= 20	; To nie jest katalog
EISDIR  	= 21	; To jest katalog
EINVAL  	= 22	; Nieprawidlowy argument
ENFILE  	= 23	; Przepelnienie tablicy plikow
EMFILE  	= 24	; Za duzo otwartych plikow
ENOTTY  	= 25	; Not a typewriter
ETXTBSY  	= 26	; Plik testowy zajety
EFBIG  		= 27	; Plik za duzy
ENOSPC   	= 28	; Brak miejsca na urzadzeniu
ESPIPE  	= 29	; Nieprawidlowe przejscie w pliku (Illegal seek)
EROFS  		= 30	; System plikow tylko do odczytu
EMLINK  	= 31	; Za duzo linkow
EPIPE  		= 32	; Zly potok (Broken pipe)
EDOM  		= 33	; Argument poza dziedzina funkcji mat.
ERANGE  	= 34	; Wyniku nie da sie przedstawic
EDEADLK  	= 35	; Resource deadlock would occur
ENAMETOOLONG  	= 36	; Zbyt dluga nazwa pliku
ENOLCK  	= 37	; No record locks available
ENOSYS  	= 38	; Funkcja nie zaimplementowana
ENOTEMPTY  	= 39	; Katalog nie jest pusty
ELOOP  		= 40	; Zbyt duzo linkow symbolicznych
EWOULDBLOCK  	= EAGAIN	; Operation would block
ENOMSG  	= 42	; Nie ma wiadomosci zadanego typu
EIDRM  		= 43	; Identifier removed
ECHRNG  	= 44	; Numer kanalu spoza zasiegu
EL2NSYNC  	= 45	; Level 2 not synchronized
EL3HLT  	= 46	; Level 3 halted
EL3RST  	= 47	; Level 3 reset
ELNRNG  	= 48	; Link number out of range
EUNATCH	 	= 49	; Niepodlaczony sterownik protokolu
ENOCSI  	= 50	; No CSI structure available
EL2HLT  	= 51	; Level 2 halted
EBADE  		= 52	; Invalid exchange
EBADR  		= 53	; Nieprawidlowy deskryptor zadania
EXFULL  	= 54	; Exchange full
ENOANO  	= 55	; No anode
EBADRQC	 	= 56	; Nieprawidlowy kod zadania
EBADSLT	 	= 57	; Invalid slot
EDEADLOCK  	= EDEADLK
EBFONT  	= 59	; Bad font file format
ENOSTR  	= 60	; Device not a stream
ENODATA	 	= 61	; Nie ma danych
ETIME  		= 62	; Przekroczony limit czasu
ENOSR  		= 63	; Out of streams resources
ENONET  	= 64	; Machine is not on the network
ENOPKG  	= 65	; Package not installed
EREMOTE	 	= 66	; Obiekt jest zdalny
ENOLINK	 	= 67	; Link has been severed
EADV  		= 68	; Advertise error
ESRMNT  	= 69	; Srmount error
ECOMM  		= 70	; Blad komunikacji przy wysylaniu
EPROTO  	= 71	; Blad protokolu
EMULTIHOP  	= 72	; Multihop attempted
EDOTDOT	 	= 73	; RFS specific error
EBADMSG	 	= 74	; Not a data message
EOVERFLOW  	= 75	; Wartosc za duza dla okreslonego typu
ENOTUNIQ  	= 76	; Nazwa nie jest unikalna w sieci
EBADFD  	= 77	; Deskryptor pliku w zlym stanie
EREMCHG	 	= 78	; Zmiana adresu zdalnego
ELIBACC  	= 79	; Nie mozna sie dostac do wymaganej bibl.
ELIBBAD	 	= 80	; Accessing a corrupted shared library
ELIBSCN	 	= 81	; .lib section in a.out corrupted
ELIBMAX	 	= 82	; Attempting to link in too many shared libs
ELIBEXEC  	= 83	; Cannot exec a shared library directly
EILSEQ  	= 84	; Nieprawidlowa sekwencja bajtow
ERESTART  	= 85	; Interrupted system call should be restarted
ESTRPIPE  	= 86	; Streams pipe error
EUSERS  	= 87	; Za duzo uzytkownikow
ENOTSOCK  	= 88	; Socket operation on non-socket
EDESTADDRREQ  	= 89	; Wymagany adres docelowy
EMSGSIZE  	= 90	; Message too long
EPROTOTYPE  	= 91	; Protocol wrong type for socket
ENOPROTOOPT  	= 92	; Protokol niedostepny
EPROTONOSUPPORT = 93	; Protokol nieobslugiwany
ESOCKTNOSUPPORT = 94	; Socket type not supported
EOPNOTSUPP  	= 95	; Operation not supported on transport endpoint
EPFNOSUPPORT  	= 96	; Protocol family not supported
EAFNOSUPPORT  	= 97	; Address family not supported by protocol
EADDRINUSE  	= 98	; Adres juz jest uzywany
EADDRNOTAVAIL  	= 99	; Nie moge przydzielic zadanego adresu
ENETDOWN  	= 100	; Siec nie dziala
ENETUNREACH  	= 101	; Siec jest niedostepna
ENETRESET  	= 102	; Network dropped connection because of reset
ECONNABORTED  	= 103	; Software caused connection abort
ECONNRESET  	= 104	; Connection reset by peer
ENOBUFS	 	= 105	; No buffer space available
EISCONN	 	= 106	; Transport endpoint is already connected
ENOTCONN  	= 107	; Transport endpoint is not connected
ESHUTDOWN  	= 108	; Cannot send after transport endpoint shutdown
ETOOMANYREFS  	= 109	; Too many references: cannot splice
ETIMEDOUT  	= 110	; Przekroczony limit czasu polaczenia
ECONNREFUSED  	= 111	; Odmowa polaczenia
EHOSTDOWN  	= 112	; Host is down
EHOSTUNREACH  	= 113	; Nie ma drogi do hosta
EALREADY  	= 114	; Operacja juz trwa
EINPROGRESS  	= 115	; Operation now in progress
ESTALE  	= 116	; Stale NFS file handle
EUCLEAN	 	= 117	; Structure needs cleaning
ENOTNAM	 	= 118	; Not a XENIX named type file
ENAVAIL	 	= 119	; No XENIX semaphores available
EISNAM  	= 120	; Is a named type file
EREMOTEIO  	= 121	; Blad zdalnego I/O
EDQUOT  	= 122	; Przekroczony limit dyskowy Quota
ENOMEDIUM  	= 123	; No medium found
EMEDIUMTYPE  	= 124	; Wrong medium type

ECANCELED	= 125	; Zrezygnowano z operacji
ENOKEY		= 126	; Required key not available
EKEYEXPIRED	= 127	; Key has expired
EKEYREVOKED	= 128	; Key has been revoked
EKEYREJECTED	= 129	; Key was rejected by service

EOWNERDEAD	= 130	; Owner died
ENOTRECOVERABLE	= 131	; Stan nieodnawialny

ERESTARTSYS	= 512
ERESTARTNOINTR	= 513
ERESTARTNOHAND	= 514	; restart if no handler..
ENOIOCTLCMD	= 515	; No ioctl command
ERESTART_RESTARTBLOCK = 516 ; restart by calling sys_restart_syscall

; Zdefiniowane dla protokolu NFSv3
EBADHANDLE	= 521	; Illegal NFS file handle
ENOTSYNC	= 522	; Update synchronization mismatch
EBADCOOKIE	= 523	; Cookie is stale
ENOTSUPP	= 524	; Operation is not supported
ETOOSMALL	= 525	; Buffer or request is too small
ESERVERFAULT	= 526	; An untranslatable error occurred
EBADTYPE	= 527	; Type not supported by server
EJUKEBOX	= 528	; Request initiated, but will not complete before timeout
EIOCBQUEUED	= 529	; iocb queued, will get completion event
EIOCBRETRY	= 530	; iocb queued, will trigger a retry

EWOULDBLOCKIO	= 530	; Would block due to block-IO

;=====================================================
; stale systemowe
;=====================================================

 O_ACCMODE      = 0003o
 O_RDONLY       = 00o
 O_WRONLY       = 01o
 O_RDWR         = 02o
 O_CREAT        = 0100o
 O_EXCL         = 0200o
 O_NOCTTY       = 0400o
 O_TRUNC        = 01000o
 O_APPEND       = 02000o
 O_NONBLOCK     = 04000o
 O_NDELAY       = O_NONBLOCK
 O_SYNC         = 010000o   ; specyficzne dla ext2 i urzadzen blokowych
 FASYNC         = 020000o   ; fcntl, dla zgodnosci z BSD
 O_DIRECT       = 040000o   ; podpowiedz bezposredniego dostepu do dysku
 O_LARGEFILE    = 0100000o
 O_DIRECTORY    = 0200000o   ;      musi byc katalogiem
 O_NOFOLLOW     = 0400000o   ;      nie podazaj za linkami


 S_ISUID        = 04000o  ; ustaw ID uzytkownika przy wykonywaniu (suid)
 S_ISGID        = 02000o  ; ustaw ID grupy przy wykonywaniu (sgid)
 S_ISVTX        = 01000o  ; "sticky bit" - usuwac moze tylko wlasciciel
 S_IRUSR        = 00400o  ; czytanie przez wlascicela (S_IREAD)
 S_IWUSR        = 00200o  ; zapis przez wlascicela (S_IWRITE)
 S_IXUSR        = 00100o  ; wykonyw./przeszuk. przez wlascicela (S_IEXEC)
 S_IRGRP        = 00040o  ; czytanie przez grupe
 S_IWGRP        = 00020o  ; zapis przez grupe
 S_IXGRP        = 00010o  ; wykonywanie/przeszukiwanie przez grupe
 S_IROTH        = 00004o  ; czytanie przez innych (R_OK)
 S_IWOTH        = 00002o  ; zapis przez innych (W_OK)
 S_IXOTH        = 00001o  ; wykonywanie/przeszukiwanie przez innych (X_OK)

 S_IRWXU	= ( S_IRUSR or S_IWUSR or S_IXUSR )
 S_IRWXG	= ( S_IRGRP or S_IWGRP or S_IXGRP )
 S_IRWXO	= ( S_IROTH or S_IWOTH or S_IXOTH )
 S_IRWXUGO	= ( S_IRWXU or S_IRWXG or S_IRWXO )
 S_IALLUGO	= ( S_ISUID or S_ISGID or S_ISVTX or S_IRWXUGO )
 S_IRUGO	= ( S_IRUSR or S_IRGRP or S_IROTH )
 S_IWUGO	= ( S_IWUSR or S_IWGRP or S_IWOTH )
 S_IXUGO	= ( S_IXUSR or S_IXGRP or S_IXOTH )


 MS_MGC_MSK      = 0C0EDh  ; in m.s. 16-bit; 'magic', niezbedne przed 2.4?
 MS_RDONLY       = 1       ; Zamountuj tylko do odczytu
 MS_NOSUID       = 2       ; Ignoruj bity suid i sgid
 MS_NODEV        = 4       ; Zabron dostepu do specjalnych plikow/urzadzen
 MS_NOEXEC       = 8       ; Zabron wykonywania programow
 MS_SYNCHRONOUS  = 16      ; Zapisy sa synchronizowane natychmiast
 MS_REMOUNT      = 32      ; Zmien flagi zamontowanego systemu plikow
 MS_MANDLOCK     = 64      ; Pozwol na nakazane blokady na systemie plikow?
 MS_NOATIME      = 1024    ; Nie zmieniaj czasow dostepu
 MS_NODIRATIME   = 2048    ; Nie zmieniaj czasow dostepu do katalogow
 MS_BIND         = 4096
 MS_REC          = 16384
 MS_VERBOSE      = 32768
 MS_ACTIVE       = (1 shl 30)
 MS_NOUSER       = (1 shl 31)


 SEEK_SET	= 0
 SEKK_CUR 	= 1
 SEEK_END 	= 2


 PTRACE_PEEKTEXT         = 0
 PTRACE_PEEKDATA         = 1
 PTRACE_PEEKUSR          = 2
 PTRACE_POKETEXT         = 3
 PTRACE_POKEDATA         = 4
 PTRACE_POKEUSR          = 5
 PTRACE_TRACEME          = 6
 PTRACE_CONT             = 7
 PTRACE_KILL             = 8
 PTRACE_SINGLESTEP       = 9
 PTRACE_GETREGS          = 12
 PTRACE_SETREGS          = 13
 PTRACE_GETFPREGS        = 14
 PTRACE_SETFPREGS        = 15
 PTRACE_ATTACH           = 16
 PTRACE_DETACH           = 17
 PTRACE_GETFPXREGS       = 18
 PTRACE_SETFPXREGS       = 19
 PTRACE_SETOPTIONS       = 21
 PTRACE_SYSCALL          = 24


 F_DUPFD	= 0
 F_GETFD        = 1
 F_SETFD        = 2
 F_GETFL        = 3
 F_SETFL        = 4
 F_GETLK        = 5
 F_SETLK        = 6
 F_SETLKW       = 7
 F_SETOWN       = 8
 F_GETOWN       = 9


; podstawowe deskryptory plikow

stdin	= 0
stdout  = 1
stderr	= 2


; ====================================================
; numery funkcji systemowych Linuksa, skladnia FASM
;=====================================================


sys_setup		=  0
sys_exit		=  1
sys_fork		=  2
sys_read		=  3
sys_write		=  4
sys_open		=  5
sys_close		=  6
sys_waitpid		=  7
sys_creat		=  8
sys_link		=  9
sys_unlink		=  10
sys_execve		=  11
sys_chdir		=  12
sys_time		=  13
sys_mknod		=  14
sys_chmod		=  15
sys_lchown		=  16
sys_break		=  17
sys_oldstat		=  18
sys_stat		=  sys_oldstat
sys_lseek		=  19
sys_getpid		=  20
sys_mount		=  21
sys_umount		=  22
sys_oldumount		=  sys_umount
sys_setuid		=  23
sys_getuid		=  24
sys_stime		=  25
sys_ptrace		=  26
sys_alarm		=  27
sys_oldfstat		=  28
sys_fstat		=  sys_oldfstat
sys_pause		=  29
sys_utime		=  30
sys_stty		=  31
sys_gtty		=  32
sys_access		=  33
sys_nice		=  34
sys_ftime		=  35
sys_sync		=  36
sys_kill		=  37
sys_rename		=  38
sys_mkdir		=  39
sys_rmdir		=  40
sys_dup			=  41
sys_pipe		=  42
sys_times		=  43
sys_prof		=  44
sys_brk			=  45
sys_setgid		=  46
sys_getgid		=  47
sys_signal		=  48
sys_geteuid		=  49


sys_getegid		=  50
sys_acct		=  51
sys_umount2		=  52		; 2.2+
sys_lock		=  53
sys_ioctl		=  54
sys_fcntl		=  55
sys_mpx			=  56
sys_setpgid		=  57
sys_ulimit		=  58
sys_oldolduname		=  59
sys_umask		=  60
sys_chroot		=  61
sys_ustat		=  62
sys_dup2		=  63
sys_getppid		=  64
sys_getpgrp		=  65
sys_setsid		=  66
sys_sigaction		=  67
sys_sgetmask		=  68
sys_ssetmask		=  69
sys_setreuid		=  70
sys_setregid		=  71
sys_sigsuspend		=  72
sys_sigpending		=  73
sys_sethostname		=  74
sys_setrlimit		=  75
sys_getrlimit		=  76
sys_getrusage		=  77
sys_gettimeofday	=  78
sys_settimeofday	=  79
sys_getgroups		=  80
sys_setgroups		=  81
sys_select		=  82
sys_symlink		=  83
sys_oldlstat		=  84
sys_lstat		=  sys_oldlstat
sys_readlink		=  85
sys_uselib		=  86
sys_swapon		=  87
sys_reboot		=  88
sys_readdir		=  89
sys_mmap		=  90
sys_munmap		=  91
sys_truncate		=  92
sys_ftruncate		=  93
sys_fchmod		=  94
sys_fchown		=  95
sys_getpriority		=  96
sys_setpriority		=  97
sys_profil		=  98
sys_statfs		=  99


sys_fstatfs		=  100
sys_ioperm		=  101
sys_socketcall		=  102
sys_syslog		=  103
sys_setitimer		=  104
sys_getitimer		=  105
sys_stat		=  106
sys_newstat		=  sys_stat
sys_lstat		=  107
sys_newlstat		=  sys_lstat
sys_fstat		=  108
sys_newfstat		=  sys_fstat
sys_olduname		=  109
sys_iopl		=  110
sys_vhangup		=  111
sys_idle		=  112
sys_vm86old		=  113
sys_wait4		=  114
sys_swapoff		=  115
sys_sysinfo		=  116
sys_ipc			=  117
sys_fsync		=  118
sys_sigreturn		=  119
sys_clone		=  120
sys_setdomainname	=  121
sys_uname		=  122
sys_newuname		=  sys_uname
sys_modify_ldt		=  123
sys_adjtimex		=  124
sys_mprotect		=  125
sys_sigprocmask		=  126
sys_create_module	=  127
sys_init_module		=  128
sys_delete_module	=  129
sys_get_kernel_syms	=  130
sys_quotactl		=  131
sys_getpgid		=  132
sys_fchdir		=  133
sys_bdfulsh		=  134
sys_sysfs		=  135
sys_personality		=  136
sys_afs_syscall		=  137
sys_setfsuid		=  138
sys_setfsgid		=  139
sys__llseek		=  140
sys_llseek		=  sys__llseek
sys_getdents		=  141
sys_newselect		=  142
sys_flock		=  143
sys_msync		=  144
sys_readv		=  145
sys_writev		=  146
sys_getsid		=  147
sys_fdatasync		=  148
sys__sysctl		=  149
sys_sysctl		=  sys__sysctl


sys_mlock		=  150
sys_munlock		=  151
sys_mlockall		=  152
sys_munlockall		=  153
sys_sched_setparam	=  154
sys_sched_getparam	=  155
sys_sched_setscheduler	=  156
sys_sched_getscheduler	=  157
sys_sched_yield		=  158
sys_sched_get_priority_max	=	159
sys_sched_get_priority_min	=	160
sys_sched_rr_get_interval	=	161
sys_nanosleep		=  162
sys_mremap		=  163
sys_setresuid		=  164		; 2.2+
sys_getresuid		=  165		; 2.2+
sys_vm86		=  166
sys_query_module	=  167		; 2.2+
sys_poll		=  168		; 2.2+
sys_nfsservctl		=  169		; 2.2+
sys_setresgid		=  170		; 2.2+
sys_getresgid		=  171		; 2.2+
sys_prctl		=  172		; 2.2+
sys_rt_sigreturn	=  173		; 2.2+
sys_rt_sigaction	=  174		; 2.2+
sys_rt_sigprocmask	=  175		; 2.2+
sys_rt_sigpending	=  176		; 2.2+
sys_rt_sigtimedwait	=  177		; 2.2+
sys_rt_sigqueueinfo	=  178		; 2.2+
sys_rt_sigsuspen	=  179		; 2.2+
sys_pread		=  180		; 2.2+
sys_pwrite		=  181		; 2.2+
sys_chown		=  182		; 2.2+
sys_getcwd		=  183		; 2.2+
sys_capget		=  184		; 2.2+
sys_capset		=  185		; 2.2+
sys_sigaltstack		=  186		; 2.2+
sys_sendfile		=  187		; 2.2+
sys_getpmsg		=  188		; 2.2+
sys_putpmsg		=  189		; 2.2+
sys_vfork		=  190		; 2.2+

; 2.4.2

sys_getrlimit		=  191
sys_mmap2		=  192
sys_truncate64		=  193
sys_ftruncate64		=  194
sys_stat64		=  195
sys_lstat64		=  196
sys_fstat64		=  197

; 2.4.18

sys_lchown32		=  198
sys_getuid32		=  199
sys_getgid32		=  200
sys_geteuid32		=  201
sys_getegid32		=  202
sys_setreuid32		=  203
sys_setregid32		=  204
sys_getgroups32		=  205
sys_setgroups32		=  206
sys_fchown32		=  207
sys_setresuid32		=  208
sys_getresuid32		=  209
sys_setresgid32		=  210
sys_getresgid32		=  211
sys_chown32		=  212
sys_setuid32		=  213
sys_setgid32		=  214
sys_setfsuid32		=  215
sys_setfsgid		=  216
sys_pivot_root		=  217
sys_mincore		=  218
sys_madvise		=  219
sys_madvise1		=  sys_madvise
sys_getdents64		=  220
sys_fcntl64		=  221

sys_security		=  223
sys_gettid		=  224
sys_readahead		=  225
sys_setxattr		=  226
sys_lsetxattr		=  227
sys_fsetxattr		=  228
sys_getxattr		=  229
sys_lgetxattr		=  230
sys_fgetxattr		=  231
sys_listxattr		=  232
sys_llistxattr		=  233
sys_flistxattr		=  234
sys_removexattr		=  235
sys_lremovexattr	=  236
sys_fremovexattr	=  237

; 2.4.19

sys_tkill		=  238
sys_sendfile64		=  239
sys_futex		=  240
sys_sched_setaffinity	=  241
sys_sched_getaffinity	=  242

; 2.4.20

sys_set_thread_area	=  243
sys_get_thread_area	=  244
sys_io_setup		=  245
sys_io_destroy		=  246
sys_io_getevents	=  247
sys_io_submit		=  248
sys_io_cancel		=  249
sys_alloc_hugepages	=  250
sys_free_hugepages	=  251
sys_exit_group		=  252

; 2.6

sys_lookup_dcookie	=  253
sys_epoll_create	=  254
sys_epoll_ctl 		=  255
sys_epoll_wait		=  256
sys_remap_file_pages	=  257
sys_set_tid_address	=  258
sys_timer_create	=  259
sys_timer_settime	=  260
sys_timer_gettime	=  261
sys_timer_getoverrun	=  262
sys_timer_delete	=  263
sys_clock_settime	=  264
sys_clock_gettime	=  265
sys_clock_getres	=  266
sys_clock_nanosleep	=  267
sys_statfs64		=  268
sys_fstatfs64		=  269
sys_tgkill		=  270
sys_utimes		=  271
sys_fadvise64_64	=  272
sys_vserver		=  273
sys_mbind		=  274
sys_get_mempolicy	=  275
sys_set_mempolicy	=  276
sys_mq_open 		=  277
sys_mq_unlink		=  (sys_mq_open+1)
sys_mq_timedsend	=  (sys_mq_open+2)
sys_mq_timedreceive	=  (sys_mq_open+3)
sys_mq_notify		=  (sys_mq_open+4)
sys_mq_getsetattr	=  (sys_mq_open+5)
sys_sys_kexec_load	=  283
sys_waitid		=  284
;sys_sys_setaltroot	=  285
sys_add_key		=  286
sys_request_key		=  287
sys_keyctl		=  288
sys_ioprio_set		=  289
sys_ioprio_get		=  290
sys_inotify_init	=  291
sys_inotify_add_watch	=  292
sys_inotify_rm_watch	=  293
sys_migrate_pages	=  294
sys_openat		=  295
sys_mkdirat		=  296
sys_mknodat		=  297
sys_fchownat		=  298
sys_futimesat		=  299
sys_fstatat64		=  300
sys_unlinkat		=  301
sys_renameat		=  302
sys_linkat		=  303
sys_symlinkat		=  304
sys_readlinkat		=  305
sys_fchmodat		=  306
sys_faccessat		=  307
sys_pselect6		=  308
sys_ppoll		=  309
sys_unshare		=  310

; 3.0.3

sys_set_robust_list	=  311
sys_get_robust_list	=  312
sys_splice		=  313
sys_sync_file_range	=  314
sys_tee			=  315
sys_vmsplice		=  316
sys_move_pages		=  317
sys_getcpu		=  318
sys_epoll_pwait		=  319
sys_utimensat		=  320
sys_signalfd		=  321
sys_timerfd_create	=  322
sys_eventfd		=  323
sys_fallocate		=  324
sys_timerfd_settime	=  325
sys_timerfd_gettime	=  326
sys_signalfd4		=  327
sys_eventfd2		=  328
sys_epoll_create1	=  329
sys_dup3		=  330
sys_pipe2		=  331
sys_inotify_init1	=  332
sys_preadv		=  333
sys_pwritev		=  334
sys_rt_tgsigqueueinfo	=  335
sys_perf_event_open	=  336
sys_recvmmsg		=  337
sys_fanotify_init	=  338
sys_fanotify_mark	=  339
sys_prlimit64		=  340
sys_name_to_handle_at	=  341
sys_open_by_handle_at	=  342
sys_clock_adjtime	=  343
sys_syncfs		=  344
sys_sendmmsg		=  345
sys_setns		=  346
sys_process_vm_readv	=  347
sys_process_vm_writev	=  348
sys_kcmp		=  349

; 4.6.5

sys_finit_module	=  350
sys_sched_setattr	=  351
sys_sched_getattr	=  352
sys_renameat2		=  353
sys_seccomp		=  354
sys_getrandom		=  355
sys_memfd_create	=  356
sys_bpf			=  357
sys_execveat		=  358
sys_socket		=  359
sys_socketpair		=  360
sys_bind		=  361
sys_connect		=  362
sys_listen		=  363
sys_accept4		=  364
sys_getsockopt		=  365
sys_setsockopt		=  366
sys_getsockname		=  367
sys_getpeername		=  368
sys_sendto		=  369
sys_sendmsg		=  370
sys_recvfrom		=  371
sys_recvmsg		=  372
sys_shutdown		=  373
sys_userfaultfd		=  374
sys_membarrier		=  375
sys_mlock2		=  376
sys_copy_file_range	=  377
sys_preadv2		=  378
sys_pwritev2		=  379

; ====================================================
; numery funkcji systemowych Linuksa x86-64, skladnia FASM
;=====================================================

sys64_read			= 0
sys64_write			= 1
sys64_open			= 2
sys64_close			= 3
sys64_stat			= 4
sys64_fstat			= 5
sys64_lstat			= 6
sys64_poll			= 7
sys64_lseek			= 8
sys64_mmap			= 9
sys64_mprotect			= 10
sys64_munmap			= 11
sys64_brk			= 12
sys64_rt_sigaction		= 13
sys64_rt_sigprocmask		= 14
sys64_rt_sigreturn		= 15
sys64_ioctl			= 16
sys64_pread64			= 17
sys64_pwrite64			= 18
sys64_readv			= 19
sys64_writev			= 20
sys64_access			= 21
sys64_pipe			= 22
sys64_select			= 23
sys64_sched_yield		= 24
sys64_mremap			= 25
sys64_msync			= 26
sys64_mincore			= 27
sys64_madvise1			= 28
sys64_shmget			= 29
sys64_shmat			= 30
sys64_shmctl			= 31
sys64_dup			= 32
sys64_dup2			= 33
sys64_pause			= 34
sys64_nanosleep			= 35
sys64_getitimer			= 36
sys64_alarm			= 37
sys64_setitimer			= 38
sys64_getpid			= 39
sys64_sendfile64		= 40
sys64_socket			= 41
sys64_connect			= 42
sys64_accept			= 43
sys64_sendto			= 44
sys64_recvfrom			= 45
sys64_sendmsg			= 46
sys64_recvmsg			= 47
sys64_shutdown			= 48
sys64_bind			= 49
sys64_listen			= 50
sys64_getsockname		= 51
sys64_getpeername		= 52
sys64_socketpair		= 53
sys64_setsockopt		= 54
sys64_getsockopt		= 55
sys64_clone			= 56
sys64_fork			= 57
sys64_vfork			= 58
sys64_execve			= 59
sys64_exit			= 60
sys64_wait4			= 61
sys64_kill			= 62
sys64_uname			= 63
sys64_semget			= 64
sys64_semop			= 65
sys64_semctl			= 66
sys64_shmdt			= 67
sys64_msgget			= 68
sys64_msgsnd			= 69
sys64_msgrcv			= 70
sys64_msgctl			= 71
sys64_fcntl			= 72
sys64_flock			= 73
sys64_fsync			= 74
sys64_fdatasync			= 75
sys64_truncate			= 76
sys64_ftruncate			= 77
sys64_getdents			= 78
sys64_getcwd			= 79
sys64_chdir			= 80
sys64_fchdir			= 81
sys64_rename			= 82
sys64_mkdir			= 83
sys64_rmdir			= 84
sys64_creat			= 85
sys64_link			= 86
sys64_unlink			= 87
sys64_symlink			= 88
sys64_readlink			= 89
sys64_chmod			= 90
sys64_fchmod			= 91
sys64_chown			= 92
sys64_fchown			= 93
sys64_lchown			= 94
sys64_umask			= 95
sys64_gettimeofday		= 96
sys64_getrlimit			= 97
sys64_getrusage			= 98
sys64_sysinfo			= 99
sys64_times			= 100
sys64_ptrace			= 101
sys64_getuid			= 102
sys64_syslog			= 103
sys64_getgid			= 104
sys64_setuid			= 105
sys64_setgid			= 106
sys64_geteuid			= 107
sys64_getegid			= 108
sys64_setpgid			= 109
sys64_getppid			= 110
sys64_getpgrp			= 111
sys64_setsid			= 112
sys64_setreuid			= 113
sys64_setregid			= 114
sys64_getgroups			= 115
sys64_setgroups			= 116
sys64_setresuid			= 117
sys64_getresuid			= 118
sys64_setresgid			= 119
sys64_getresgid			= 120
sys64_getpgid			= 121
sys64_setfsuid			= 122
sys64_setfsgid			= 123
sys64_getsid			= 124
sys64_capget			= 125
sys64_capset			= 126
sys64_rt_sigpending		= 127
sys64_rt_sigtimedwait		= 128
sys64_rt_sigqueueinfo		= 129
sys64_rt_sigsuspend		= 130
sys64_sigaltstack		= 131
sys64_utime			= 132
sys64_mknod			= 133
sys64_uselib			= 134
sys64_personality		= 135
sys64_ustat			= 136
sys64_statfs			= 137
sys64_fstatfs			= 138
sys64_sysfs			= 139
sys64_getpriority		= 140
sys64_setpriority		= 141
sys64_sched_setparam		= 142
sys64_sched_getparam		= 143
sys64_sched_setsheduler		= 144
sys64_sched_getsheduler		= 145
sys64_sched_get_priority_max	= 146
sys64_sched_get_priority_min	= 147
sys64_sched_rr_get_interval	= 148
sys64_mlock			= 149
sys64_munlock			= 150
sys64_mlockall			= 151
sys64_munlockall		= 152
sys64_vhangup			= 153
sys64_modify_ldt		= 154
sys64_pivot_root		= 155
sys64_sysctl			= 156
sys64_prctl			= 157
sys64_arch_prctl		= 158
sys64_adjtimex			= 159
sys64_setrlimit			= 160
sys64_chroot			= 161
sys64_sync			= 162
sys64_acct			= 163
sys64_settimeofday		= 164
sys64_mount			= 165
sys64_umount2			= 166
sys64_swapon			= 167
sys64_swapoff			= 168
sys64_reboot			= 169
sys64_sethostname		= 170
sys64_setdomainname		= 171
sys64_iopl			= 172
sys64_ioperm			= 173
sys64_create_module		= 174
sys64_init_module		= 175
sys64_delete_module		= 176
sys64_get_kernel_syms		= 177
sys64_query_module		= 178
sys64_quotactl			= 179
sys64_nfsservctl		= 180
sys64_getpmsg			= 181
sys64_putpmsg			= 182
sys64_afs_syscall		= 183
sys64_tuxcall			= 184
sys64_security			= 185
sys64_gettid			= 186
sys64_readahead			= 187
sys64_setxattr			= 188
sys64_lsetxattr			= 189
sys64_fsetxattr			= 190
sys64_getxattr			= 191
sys64_lgetxattr			= 192
sys64_fgetxattr			= 193
sys64_listxattr			= 194
sys64_llistxattr		= 195
sys64_flistxattr		= 196
sys64_removexattr		= 197
sys64_lremovexattr		= 198
sys64_fremovexattr		= 199
sys64_tkill			= 200
sys64_time			= 201
sys64_futex			= 202
sys64_sched_setaffinity		= 203
sys64_sched_getaffinity		= 204
sys64_set_thread_area		= 205
sys64_io_setup			= 206
sys64_io_destroy		= 207
sys64_io_getevents		= 208
sys64_io_submit			= 209
sys64_io_cancel			= 210
sys64_get_thread_area		= 211
sys64_lookup_dcookie		= 212
sys64_epoll_create		= 213
sys64_epoll_ctl_old		= 214
sys64_epoll_wait_old		= 215
sys64_remap_file_pages		= 216
sys64_getdents64		= 217
sys64_set_tid_address		= 218
sys64_restart_syscall		= 219
sys64_semtimedop		= 220
sys64_fadvise64_64		= 221
sys64_timer_create		= 222
sys64_timer_settime		= 223
sys64_timer_gettime		= 224
sys64_timer_getoverrun		= 225
sys64_timer_delete		= 226
sys64_clock_settime		= 227
sys64_clock_gettime		= 228
sys64_clock_getres		= 229
sys64_clock_nanosleep		= 230
sys64_exit_group		= 231
sys64_epoll_wait		= 232
sys64_epoll_ctl			= 233
sys64_tgkill			= 234
sys64_utimes			= 235
sys64_vserver			= 236
sys64_mbind			= 237
sys64_set_mempolicy		= 238
sys64_get_mempolicy		= 239
sys64_mq_open			= 240
sys64_mq_unlink			= 241
sys64_mq_timedsend		= 242
sys64_mq_timederceive		= 243
sys64_mq_notify			= 244
sys64_mq_getsetattr		= 245
sys64_kexec_load		= 246
sys64_waitid			= 247
sys64_add_key			= 248
sys64_request_key		= 249
sys64_keyctl			= 250
sys64_ioprio_set		= 251
sys64_ioprio_get		= 252
sys64_inotify_init		= 253
sys64_inotify_add_watch		= 254
sys64_inotify_rm_watch		= 255
sys64_migrate_pages		= 256
sys64_openat			= 257
sys64_mkdirat			= 258
sys64_mknodat			= 259
sys64_fchownat			= 260
sys64_futimesat			= 261
sys64_fstatat64			= 262
sys64_ulinkat			= 263
sys64_renameat			= 264
sys64_linkat			= 265
sys64_symlinkat			= 266
sys64_readlinkat		= 267
sys64_fchmodat			= 268
sys64_faccessat			= 269
sys64_pselect6			= 270
sys64_ppoll			= 271
sys64_unshare			= 272
sys64_set_robust_list		= 273
sys64_get_robust_list		= 274
sys64_splice			= 275
sys64_tee			= 276
sys64_sync_file_range		= 277
sys64_vmsplice			= 278
sys64_move_pages		= 279
sys64_utimensat			= 280
sys64_epoll_pwait		= 281
sys64_signalfd			= 282
sys64_timerfd_create		= 283
sys64_eventfd			= 284
sys64_fallocate			= 285
sys64_timerfd_settime		= 286
sys64_timerfd_gettime		= 287
sys64_paccept			= 288
sys64_signalfd4			= 289
sys64_eventfd2			= 290
sys64_epoll_create1		= 291
sys64_dup3			= 292
sys64_pipe2			= 293
sys64_inotify_init1		= 294
sys64_preadv			= 295
sys64_pwritev			= 296
sys64_rt_tgsigqueueinfo		= 297
sys64_perf_counter_open		= 298
sys64_recvmmsg			= 299
sys64_fanotify_init		= 300
sys64_fanotify_mark		= 301
sys64_prlimit64			= 302
sys64_name_to_handle_at		= 303
sys64_open_by_handle_at		= 304
sys64_clock_adjtime		= 305
sys64_syncfs			= 306
sys64_sendmmsg			= 307
sys64_setns			= 308
sys64_getcpu			= 309
sys64_process_vm_readv		= 310
sys64_process_vm_writev		= 311
sys64_kcmp			= 312

; 4.6.5

sys64_finit_module		= 313
sys64_sched_setattr		= 314
sys64_sched_getattr		= 315
sys64_renameat2			= 316
sys64_seccomp			= 317
sys64_getrandom			= 318
sys64_memfd_create		= 319
sys64_kexec_file_load		= 320
sys64_bpf			= 321
sys64_execveat			= 322
sys64_userfaultfd		= 323
sys64_membarrier		= 324
sys64_mlock2			= 325
sys64_copy_file_range		= 326
sys64_preadv2			= 327
sys64_pwritev2			= 328



struc pt_regs
{
	._ebx:		rd 1
	._ecx:		rd 1
	._edx:		rd 1
	._esi:		rd 1
	._edi:		rd 1
	._ebp:		rd 1
	._eax:		rd 1
	._xds:		rw 1
	._xes:		rw 1
	.orig_eax:	rd 1
	._eip:		rd 1
	._xcs:		rw 1
	._eflags:	rd 1
	._esp:		rd 1
	._xss:		rw 1
}

struc tms
{
	.tms_utime:	rd 1
	.tms_stime:	rd 1
	.tms_cutime:	rd 1
	.tms_cstime:	rd 1
}

struc flock
{
 	.l_type:	rw 1
	.l_whence:      rw 1
	.l_start:       rd 1
	.l_len:         rd 1
	.l_pid:         rd 1
}

RLIMIT_CPU		= 0
RLIMIT_FSIZE		= 1
RLIMIT_DATA		= 2
RLIMIT_STACK		= 3
RLIMIT_CORE		= 4
RLIMIT_RSS		= 5
RLIMIT_NPROC		= 6
RLIMIT_NOFILE		= 7
RLIMIT_OFILE		= RLIMIT_NOFILE
RLIMIT_MEMLOCK		= 8
RLIMIT_AS		= 9
RLIMIT_LOCKS		= 10
RLIMIT_SIGPENDING	= 11
RLIMIT_MSGQUEUE		= 12
RLIMIT_NICE		= 13
RLIMIT_RTPRIO		= 14

struc rlimit
{
	.rlim_cur:      rd 1
	.rlim_max:      rd 1
}

struc timeval
{
 	.tv_sec:        rd 1
	.tv_usec:       rd 1
}

struc sigaction
{
	.sa_handler:	rd 1;	// procedura obslugi sygnalu
	.sa_flags:	rd 1
	.sa_restorer:	rd 1;	// procedura przywracajaca ???
	.sa_mask:	sigset_t;	// maska utrzymywana dla rozszerzalnosci
}

_NSIG		= 64
_NSIG_BPW	= 32
_NSIG_WORDS	= (_NSIG/_NSIG_BPW)

struc sigset_t
{
	.sig:		rd _NSIG_WORDS
}

RUSAGE_SELF	= 0
RUSAGE_CHILDREN	= (-1)
RUSAGE_BOTH	= (-2)

struc	rusage
{
	.ru_utime:      timeval
	.ru_stime:      timeval
	.ru_maxrss:     rd 1
	.ru_ixrss:      rd 1
	.ru_idrss:      rd 1
	.ru_isrss:      rd 1
	.ru_minflt:     rd 1
	.ru_majflt:     rd 1
	.ru_nswap:      rd 1
	.ru_inblock:    rd 1
	.ru_oublock:    rd 1
	.ru_msgsnd:     rd 1
	.ru_msgrcv:     rd 1
	.ru_nsignals:   rd 1
	.ru_nvcsw:      rd 1
	.ru_nivcsw:     rd 1
}


struc timezone
{
	.tz_minuteswest:	rd 1
	.tz_dsttime:            rd 1
}

UL_GETFSIZE     = 1
UL_SETFSIZE     = 2
__UL_GETMAXBRK  = 3
__UL_GETOPENMAX = 4

struc utimbuf
{
                .actime:        resd 1
                .modtime:       resd 1
}

struc timeb
{
	.time:		rd 1
	.millitm:       rw 1
	.timezone:      rw 1
	.dstflag:       rw 1
}

struc ustat
{
	.f_tfree:	rd 1;	/* calkowita liczba wolnych blokow */
	.f_tinode:	rd 1;	/* liczba wolnych wezlow i-node */
	.f_fname:	rb 6;	/* nazwa systemu plikow (nieuzywane) */
	.f_fpack:	rb 6;	/* nazwa paczki(?) systemu plikow (nieuzywane) */
}


SWAP_FLAG_PREFER        = 0x8000
SWAP_FLAG_PRIO_MASK     = 0x7fff
SWAP_FLAG_PRIO_SHIFT    = 0

LINUX_REBOOT_CMD_RESTART        = 0x01234567
LINUX_REBOOT_CMD_HALT           = 0xCDEF0123
LINUX_REBOOT_CMD_CAD_ON         = 0x89ABCDEF
LINUX_REBOOT_CMD_CAD_OFF        = 0x00000000
LINUX_REBOOT_CMD_POWER_OFF      = 0x4321FEDC
LINUX_REBOOT_CMD_RESTART2       = 0xA1B2C3D4

struc dirent
{
	.d_ino:		rd 1
	.d_off:         rd 1
	.d_reclen:      rw 1
	.d_name:        rb 256
}

PROT_READ       = 1
PROT_WRITE      = 2
PROT_EXEC       = 4
PROT_NONE       = 0

MAP_FIXED       = 0x10
MAP_GROWSDOWN   = 0x0100
MAP_DENYWRITE   = 0x0800
MAP_EXECUTABLE  = 0x1000
MAP_LOCKED      = 0x2000
MAP_NORESERVE   = 0x4000
MAP_FILE        = 0
MAP_ANONYMOUS   = 0x20
MAP_ANON        = MAP_ANONYMOUS

MAP_SHARED      = 0x01
MAP_PRIVATE     = 0x02


PRIO_PROCESS    = 0
PRIO_PGRP       = 1
PRIO_USER       = 2

struc fsid_t
{
	.__val:		rd 2
}

struc statfs
{
	.f_type:        rd 1
	.f_bsize:       rd 1
	.f_blocks:	rd 1
	.f_bfree:       rd 1
	.f_bavail:      rd 1
	.f_files:       rd 1
	.f_ffree:       rd 1
	.f_fsid         fsid_t
	.f_namelen:     rd 1
	.f_spare:       rd 6
}

AFFS_SUPER_MAGIC        = 0xADFF
EXT_SUPER_MAGIC         = 0x137D
EXT2_OLD_SUPER_MAGIC    = 0xEF51
EXT2_SUPER_MAGIC        = 0xEF53
HPFS_SUPER_MAGIC        = 0xF995E849
ISOFS_SUPER_MAGIC       = 0x9660
MINIX_SUPER_MAGIC       = 0x137F
MINIX_SUPER_MAGIC2      = 0x138F
MINIX2_SUPER_MAGIC      = 0x2468
MINIX2_SUPER_MAGIC2     = 0x2478
MSDOS_SUPER_MAGIC       = 0x4d44
NCP_SUPER_MAGIC         = 0x564c
NFS_SUPER_MAGIC         = 0x6969
PROC_SUPER_MAGIC        = 0x9fa0
SMB_SUPER_MAGIC         = 0x517B
XENIX_SUPER_MAGIC       = 0x012FF7B4
SYSV4_SUPER_MAGIC       = 0x012FF7B5
SYSV2_SUPER_MAGIC       = 0x012FF7B6
COH_SUPER_MAGIC         = 0x012FF7B7
UFS_MAGIC               = 0x00011954
_XIAFS_SUPER_MAGIC      = 0x012FD16D

ITIMER_REAL     = 0
ITIMER_VIRTUAL  = 1
ITIMER_PROF     = 2

struc itimerval
{
	.it_interval:	timeval
	.it_value:      timeval
}

struc stat
{
	.st_dev:      	rw 1
	.st_ino:      	rd 1
	.st_mode:     	rw 1
	.st_nlink:     	rw 1
	.st_uid:      	rw 1
	.st_gid:      	rw 1
	.st_rdev:     	rw 1
	.st_size:     	rd 1
	.st_blksize:	rd 1
	.st_blocks:   	rd 1
	.st_atime:    	rd 1
	.st_mtime:    	rd 1
	.st_ctime:    	rd 1
}

S_IFMT          = 0170000o
S_IFSOCK        = 0140000o
S_IFLNK         = 0120000o
S_IFREG         = 0100000o
S_IFBLK         = 0060000o
S_IFDIR         = 0040000o
S_IFCHR         = 0020000o
S_IFIFO         = 0010000o

struc vm86_regs
{
	._ebx:		rd 1
	._ecx:          rd 1
	._edx:          rd 1
	._esi:          rd 1
	._edi:          rd 1
	._ebp:          rd 1
	._eax:          rd 1
	.__null_ds:     rd 1
	.__null_es:     rd 1
	.__null_fs:     rd 1
	.__null_gs:     rd 1
	.orig_eax:      rd 1
	._eip:          rd 1
	._cs:           rw 1
	.__csh:         rw 1
	._eflags:       rd 1
	._esp:          rd 1
	._ss:           rw 1
	.__ssh:         rw 1

	._es:           rw 1
	.__esh:         rw 1
	._ds:           rw 1
	.__dsh:         rw 1
	._fs:           rw 1
	.__fsh:         rw 1
	._gs:           rw 1
	.__gsh:         rw 1
}

struc revectored_struct
{
	.__map:         rd 8
}


struc vm86_struct
{
	.regs:                  vm86_regs
	.flags:                 rd 1
	.screen_bitmap:		rd 1
	.cpu_type:              rd 1
	.int_revectored:        revectored_struct
	.int21_revectored:      revectored_struct
}

WNOHANG         = 1
WUNTRACED       = 2
WCONTINUED	= 8
WSTOPPED	= 2
WEXITED		= 4
WNOWAIT		= 0x01000000
__WNOTHREAD     = 0x20000000
__WALL          = 0x40000000
__WCLONE        = 0x80000000

struc sysinfo
{
	.uptime:        rd 1
	.loads:         rd 3
	.totalram:      rd 1
	.freeram:       rd 1
	.sharedram:	rd 1
	.bufferram:     rd 1
	.totalswap:     rd 1
	.freeswap:      rd 1
	.procs:         rw 1
	.totalhigh:     rd 1
	.freehigh:      rd 1
	.mem_unit:      rd 1
	._f:            rb 8  ; dopelnienie?
}

CSIGNAL         = 0x000000ff
CLONE_VM        = 0x00000100
CLONE_FS        = 0x00000200
CLONE_FILES     = 0x00000400
CLONE_SIGHAND   = 0x00000800
CLONE_PID       = 0x00001000
CLONE_PTRACE    = 0x00002000
CLONE_VFORK     = 0x00004000
CLONE_PARENT    = 0x00008000
CLONE_THREAD    = 0x00010000
CLONE_NEWNS     = 0x00020000
CLONE_SIGNAL    = (CLONE_SIGHAND or CLONE_THREAD)

_UTSNAME_LENGTH = 65

struc utsname
{
	.sysname:       rb _UTSNAME_LENGTH
	.nodename:      rb _UTSNAME_LENGTH
	.release:       rb _UTSNAME_LENGTH
	.version:       rb _UTSNAME_LENGTH
	.machine:       rb _UTSNAME_LENGTH
	.domainname:	rb _UTSNAME_LENGTH
}

struc timex
{
	.modes:         rd 1
	.offset:        rd 1
	.frequency:	rd 1
	.maxerror:      rd 1
	.esterror:      rd 1
	.status:        rd 1
	.constant:      rd 1
	.precision:     rd 1
	.tolerance:     rd 1
	.time:          timeval
	.tick:          rd 1
}

ADJ_OFFSET              = 0x0001
ADJ_FREQUENCY           = 0x0002
ADJ_MAXERROR            = 0x0004
ADJ_ESTERROR            = 0x0008
ADJ_STATUS              = 0x0010
ADJ_TIMECONST           = 0x0020
ADJ_TICK                = 0x4000
ADJ_OFFSET_SINGLESHOT   = 0x8001

TIME_OK         = 0
TIME_INS        = 1
TIME_DEL        = 2
TIME_OOP        = 3
TIME_WAIT       = 4
TIME_BAD        = 5

SIG_BLOCK       = 0
SIG_UNBLOCK     = 1
SIG_SETMASK     = 2


struc kernel_sym
{
	.value:		rd 1
	.name:          rb 60
}

Q_QUOTAON       = 0x0100  ; 0x800002
Q_QUOTAOFF      = 0x0200  ; 0x800003
Q_GETQUOTA      = 0x0300  ; 0x800007
Q_SETQUOTA      = 0x0400  ; 0x800008
Q_SETUSE        = 0x0500
Q_SYNC          = 0x0600  ; 0x800001
Q_SETQLIM       = 0x0700
Q_GETSTATS      = 0x0800
Q_GETINFO       = 0x800005
Q_SETINFO       = 0x800006
; Q_SETGRACE      = 0x800002
; Q_SETFLAGS      = 0x800002

struc mem_dqblk
{
	.dqb_bhardlimit:	rd 1
	.dqb_bsoftlimit:        rd 1
	.dqb_curspace:          rq 1
	.dqb_ihardlimit:        rd 1
	.dqb_isoftlimit:        rd 1
	.dqb_curinodes:         rd 1
	.dqb_btime:             rd 1
	.dqb_itime:             rd 1
}

struc dqstats
{
	.lookups:               rd 1
	.drops:                 rd 1
	.reads:                 rd 1
	.writes:                rd 1
	.cache_hits:            rd 1
	.allocated_dquots:	rd 1
	.free_dquots:           rd 1
	.syncs:                 rd 1
}

LOCK_SH         = 1
LOCK_EX         = 2
LOCK_NB		= 4
LOCK_UN         = 8

struc timespec
{
	.tv_sec:		rd 1
	.tv_nsec:		rd 1
}

MS_ASYNC	= 1
MS_INVALIDATE	= 2
MS_SYNC		= 4

struc iovec
{
	.iov_base:		rd 1
	.iov_len:		rd 1
}


struc __sysctl_args
{
	.name:			rd 1
	.nlen:			rd 1
	.oldval:		rd 1
	.oldlenp:		rd 1
	.newval:		rd 1
	.newlen:		rd 1
}

MCL_CURRENT	= 1
MCL_FUTURE	= 2

struc sched_param
{
	.__sched_priority:	rd 1
}

SCHED_OTHER	= 0
SCHED_FIFO	= 1
SCHED_RR	= 2

MREMAP_MAYMOVE	= 1
MREMAP_FIXED	= 2

VM86_PLUS_INSTALL_CHECK	= 0
VM86_ENTER		= 1
VM86_ENTER_NO_BYPASS	= 2
VM86_REQUEST_IRQ	= 3
VM86_FREE_IRQ		= 4
VM86_GET_IRQ_BITS	= 5
VM86_GET_AND_RESET_IRQ	= 6

QM_MODULES	= 1
QM_DEPS		= 2
QM_REFS		= 3
QM_SYMBOLS	= 4
QM_INFO		= 5

struc module_symbol
{
	.value:		rd 1
	.name:		rd 1;	/* adres lancucha znakow od poczatku bufora */
}

struc module_info
{
	.address:	rd 1;	/* adres modulu */
	.size:		rd 1;	/* zajmowana pamiec */
	.flags:		rd 1;	/* stan: MOD_RUNNING,  MOD_AUTOCLEAN, ... */
}

struc pollfd
{
	.fd:		rd 1;	/* deskryptor otwartego pliku */
	.events:	rw 1;	/* maska zdarzen (patrz nizej) do monitorowania */
	.revents:	rw 1;	/* powrotna maska zdarzen (patrz nizej) znalezionych */
}

POLLIN		= 0x0001
POLLRDNORM	= 0x0040
POLLRDBAND	= 0x0080
POLLNORM	= POLLRDNORM
POLLPRI		= 0x0002
POLLOUT		= 0x0004
POLLWRNORM	= POLLOUT
POLLWRBAND	= 0x0100
POLLERR		= 0x0008
POLLHUP		= 0x0010
POLLNVAL	= 0x0020

NFSCTL_SVC		= 0
NFSCTL_ADDCLIENT	= 1
NFSCTL_DELCLIENT	= 2
NFSCTL_EXPORT		= 3
NFSCTL_UNEXPORT		= 4
NFSCTL_UGIDUPDATE	= 5
NFSCTL_GETFH		= 6
NFSCTL_GETFD		= 7
NFSCTL_GETFS		= 8
NFSCTL_FODROP		= 50
NFSCTL_STOPFODROP	= 51
NFSCTL_FOLOCKS		= 52
NFSCTL_FOGRACE		= 53
NFSCTL_FOSERV		= 54

PR_SET_PDEATHSIG	= 1
PR_GET_PDEATHSIG	= 2
PR_GET_DUMPABLE		= 3
PR_SET_DUMPABLE		= 4
PR_GET_UNALIGN		= 5
PR_SET_UNALIGN		= 6
PR_GET_KEEPCAPS		= 7
PR_SET_KEEPCAPS		= 8
PR_GET_FPEMU		= 9
PR_SET_FPEMU		= 10
PR_GET_FPEXC		= 11
PR_SET_FPEXC		= 12
PR_GET_TIMING		= 13
PR_SET_TIMING		= 14

struc __user_cap_header_struct
{
	.version:	rd 1
	.pid:		rd 1
}

struc __user_cap_data_struct
{
	.effective:	rd 1
	.permitted:	rd 1
	.inheritable:	rd 1
}

SS_ONSTACK	= 0x0001
SS_DISABLE	= 0x0004

struc sigaltstack
{
	.ss_sp:		rd 1;		// int (dword)
	.ss_flags:	rd 1;		// int (dword), SS_ONSTACK or SS_DISABLE
	.ss_size:	rd 1;		// int (dword)
}

STAT64_HAS_BROKEN_ST_INO	= 1

struc stat64
{
	.st_dev:	rw 1
	.__pad0:	rb 10

	.__st_ino:	rd 1

	.st_mode:	rd 1
	.st_nlink:	rd 1

	.st_uid:	rd 1
	.st_gid:	rd 1

	.st_rdev:	rw 1
	.__pad3:	rb 10

	.st_size:	rq 1
	.st_blksize:	rd 1

	.st_blocks:	rd 1;	/* Number 512-byte blocks allocated. */
	.__pad4:	rd 1;		/* future possible st_blocks high bits */

	.st_atime:	rd 1
	.__pad5:	rd 1

	.st_mtime:	rd 1
	.__pad6:	rd 1

	.st_ctime:	rd 1
	.__pad7:	rd 1;		/* will be high 32 bits of ctime someday */

	.st_ino:	rq 1
}

MADV_NORMAL	= 0
MADV_RANDOM	= 1
MADV_SEQUENTIAL	= 2
MADV_WILLNEED	= 3
MADV_DONTNEED	= 4

SIGHUP		= 1
SIGINT		= 2
SIGQUIT		= 3
SIGILL		= 4
SIGTRAP		= 5
SIGABRT		= 6
SIGIOT		= 6	; tak, tez
SIGBUS		= 7
SIGFPE		= 8
SIGKILL		= 9
SIGUSR1		= 10
SIGSEGV		= 11
SIGUSR2		= 12
SIGPIPE		= 13
SIGALRM		= 14
SIGTERM		= 15
SIGSTKFLT	= 16
SIGCHLD		= 17
SIGCLD		= SIGCHLD
SIGCONT		= 18
SIGSTOP		= 19
SIGTSTP		= 20
SIGTTIN		= 21
SIGTTOU		= 22
SIGURG		= 23
SIGXCPU		= 24
SIGXFSZ		= 25
SIGVTALRM	= 26
SIGPROF		= 27
SIGWINCH	= 28
SIGPOLL		= 29
SIGIO		= SIGPOLL
SIGPWR		= 30
SIGSYS		= 31
SIGUNUSED	= 31	; tak, tez

FUTEX_WAIT	= 0
FUTEX_WAKE	= 1
FUTEX_FD	= 2

struc io_event
{
	.data:		rq 1;		/* pole danych */
	.obj:		rq 1;		/* skad przyszlo zdarzenie */
	.res:		rq 1;		/* kod wynikowy zdarzenia */
	.res2:		rq 1;		/* wynik drugorzedny */
}

struc iocb
{
	.aio_data:		rq 1
	.aio_key:		rd 1
	.aio_reserved1:		rd 1

	.aio_lio_opcode:	rw 1
	.aio_reqprio:		rw 1
	.aio_fildes:		rd 1

	.aio_buf:		rq 1
	.aio_nbytes:		rq 1
	.aio_offset:		rq 1

	.aio_reserved2:		rq 1
	.aio_reserved3:		rq 1
}

EPOLL_CTL_ADD	= 1
EPOLL_CTL_DEL	= 2
EPOLL_CTL_MOD	= 3

CLOCK_REALTIME			= 0
CLOCK_MONOTONIC			= 1
CLOCK_PROCESS_CPUTIME_ID	= 2
CLOCK_THREAD_CPUTIME_ID		= 3

MPOL_DEFAULT	= 0
MPOL_PREFERRED	= 1
MPOL_BIND	= 2
MPOL_INTERLEAVE	= 3

MPOL_MF_STRICT		= 1
MPOL_MF_MOVE		= 2
MPOL_MF_MOVE_ALL	= 4

struc mq_attr
{
	.mq_flags:	rd 1;     /* Flagi: 0 lub O_NONBLOCK */
	.mq_maxmsg:	rd 1;     /* Max. liczba wiadomosci w kolejce */
	.mq_msgsize:	rd 1;     /* Max. rozmiar wiadomosci w bajtach */
	.mq_curmsgs:	rd 1;     /* Liczba wiadomosci aktualnie w kolejce */
}

IN_ACCESS	= 0x00000001
IN_MODIFY	= 0x00000002
IN_ATTRIB	= 0x00000004
IN_CLOSE_WRITE	= 0x00000008
IN_CLOSE_NOWRITE= 0x00000010
IN_OPEN		= 0x00000020
IN_MOVED_FROM	= 0x00000040
IN_MOVED_TO	= 0x00000080
IN_CREATE	= 0x00000100
IN_DELETE	= 0x00000200
IN_DELETE_SELF	= 0x00000400
IN_MOVE_SELF	= 0x00000800
IN_UNMOUNT	= 0x00002000
IN_Q_OVERFLOW	= 0x00004000
IN_IGNORED	= 0x00008000
IN_ONLYDIR	= 0x01000000
IN_DONT_FOLLOW	= 0x02000000
IN_MASK_ADD	= 0x20000000
IN_ISDIR	= 0x40000000
IN_ONESHOT	= 0x80000000

SIG_DFL		= 0
SIG_IGN		= 1

TIMER_ABSTIME	= 1
MPOL_F_ADDR	= 2

AT_SYMLINK_NOFOLLOW	= 0x100
AT_REMOVEDIR		= 0x200
AT_EACCESS		= 0x200
AT_FDCWD		= -100

FALLOC_FL_KEEP_SIZE	= 1

IOPRIO_WHO_PROCESS	= 0
IOPRIO_WHO_PGRP		= 1
IOPRIO_WHO_USER		= 2

SYNC_FILE_RANGE_WAIT_BEFORE	= 1
SYNC_FILE_RANGE_WRITE		= 2
SYNC_FILE_RANGE_WAIT_AFTER	= 4

SIG_BLOCK	= 0
SIG_UNBLOCK	= 1
SIG_SETMASK	= 2

POSIX_FADV_NORMAL	= 0
POSIX_FADV_RANDOM	= 1
POSIX_FADV_SEQUENTIAL	= 2
POSIX_FADV_WILLNEED	= 3
POSIX_FADV_DONTNEED	= 4
POSIX_FADV_NOREUSE	= 5

SPLICE_F_MOVE		= 1
SPLICE_F_NONBLOCK	= 2
SPLICE_F_MORE		= 4
SPLICE_F_GIFT		= 8

struc getcpu_cache
{
	.blob:		rd 32
}

struc epoll_event
{
	.events:	rd 1;  /* zdarzenia Epoll */
	.data:		rq 1;  /* Zmienna danych uzytkownika */
}

TFD_NONBLOCK		= 4000o
TFD_CLOEXEC		= 2000000o
TFD_TIMER_ABSTIME	= 1

struc itimerspec
{
    		.it_interval:	timespec
    		.it_value:	timespec
}

SFD_NONBLOCK		= 4000o
SFD_CLOEXEC		= 2000000o

EFD_NONBLOCK		= 4000o
EFD_CLOEXEC		= 2000000o

EPOLL_CLOEXEC		= 2000000o

O_CLOEXEC		= 2000000o

IN_NONBLOCK		= 4000o
IN_CLOEXEC		= 2000000o

struc robust_list
{
		.next:		rd 1
}

struc robust_list_head
{
		.list:			robust_list
		.futex_offset:		rd 1
		.list_op_pending:	rd 1
}

KEYCTL_GET_KEYRING_ID           = 0
KEYCTL_JOIN_SESSION_KEYRING     = 1
KEYCTL_UPDATE                   = 2
KEYCTL_REVOKE                   = 3
KEYCTL_CHOWN                    = 4
KEYCTL_SETPERM                  = 5
KEYCTL_DESCRIBE                 = 6
KEYCTL_CLEAR                    = 7
KEYCTL_LINK                     = 8
KEYCTL_UNLINK                   = 9
KEYCTL_SEARCH                   = 10
KEYCTL_READ                     = 11
KEYCTL_INSTANTIATE              = 12
KEYCTL_NEGATE                   = 13
KEYCTL_SET_REQKEY_KEYRING       = 14
KEYCTL_SET_TIMEOUT              = 15
KEYCTL_ASSUME_AUTHORITY         = 16
KEYCTL_GET_SECURITY             = 17

;/* special process keyring shortcut IDs */
KEY_SPEC_THREAD_KEYRING         = -1
KEY_SPEC_PROCESS_KEYRING        = -2
KEY_SPEC_SESSION_KEYRING        = -3
KEY_SPEC_USER_KEYRING           = -4
KEY_SPEC_USER_SESSION_KEYRING   = -5
KEY_SPEC_GROUP_KEYRING          = -6
KEY_SPEC_REQKEY_AUTH_KEY        = -7
KEY_SPEC_REQUESTOR_KEYRING      = -8

;/* request-key default keyrings */
KEY_REQKEY_DEFL_NO_CHANGE               = -1
KEY_REQKEY_DEFL_DEFAULT                 = 0
KEY_REQKEY_DEFL_THREAD_KEYRING          = 1
KEY_REQKEY_DEFL_PROCESS_KEYRING         = 2
KEY_REQKEY_DEFL_SESSION_KEYRING         = 3
KEY_REQKEY_DEFL_USER_KEYRING            = 4
KEY_REQKEY_DEFL_USER_SESSION_KEYRING    = 5
KEY_REQKEY_DEFL_GROUP_KEYRING           = 6
KEY_REQKEY_DEFL_REQUESTOR_KEYRING       = 7

struc kexec_segment
{
		.buf:		rd 1;        /* bufor w przestrzeni uzytkownika */
		.bufsz:		rd 1;        /* dlugosc bufora w przestrzeni uzytkownika */
		.mem:		rd 1;        /* fizyczny adres jadra */
		.memsz:		rd 1;        /* dlugosc fizycznego adresu */
}

KEXEC_ON_CRASH          = 0x00000001
KEXEC_PRESERVE_CONTEXT  = 0x00000002

KEXEC_ARCH_DEFAULT = ( 0 shl 16)
KEXEC_ARCH_386     = ( 3 shl 16)
KEXEC_ARCH_X86_64  = (62 shl 16)
KEXEC_ARCH_PPC     = (20 shl 16)
KEXEC_ARCH_PPC64   = (21 shl 16)
KEXEC_ARCH_IA_64   = (50 shl 16)
KEXEC_ARCH_ARM     = (40 shl 16)
KEXEC_ARCH_S390    = (22 shl 16)
KEXEC_ARCH_SH      = (42 shl 16)
KEXEC_ARCH_MIPS_LE = (10 shl 16)
KEXEC_ARCH_MIPS    = ( 8 shl 16)

MSG_WAITFORONE = 0x10000

struc msghdr
{
		.msg_name:		rd 1;       /* opcjonalny adres */
		.msg_namelen:		rd 1;    /* rozmiar adresu */
		.msg_iov:		rd 1;        /* tablica wysylania i zbierania */
		.msg_iovlen:		rd 1;     /* liczba elementow w msg_iov */
		.msg_control:		rd 1;    /* dane pomocnicze */
		.msg_controllen:	rd 1; /* dlugosc bufora danych pomocniczych */
		.msg_flags:		rd 1	;      /* flagi na odebranej
						;		 wiadomosci: MSG_EOR,
						;		 MSG_TRUNC, MSG_CTRUNC,
						;		 MSG_OOB, MSG_ERRQUEUE*/
}

struc mmsghdr
{
	.msg_hdr:	msghdr;  /* Naglowek wiadomosci */
	.msg_len:	rd 1;  /* Liczba otrzymanych bajtow naglowka */
}

CLONE_NEWIPC  = 0x08000000
CLONE_NEWNET  = 0x40000000
CLONE_NEWUTS  = 0x04000000

IPC_CREAT     = 00001000o
IPC_EXCL      = 00002000o
IPC_RMID      = 0
IPC_SET       = 1
IPC_STAT      = 2
IPC_INFO      = 3
IPC_NOWAIT    = 04000o


SHM_HUGETLB   = 04000o
SHM_NORESERVE = 010000o
SHM_RDONLY    = 010000o
SHM_RND       = 020000o
SHM_REMAP     = 040000o
SHM_LOCK      = 11
SHM_UNLOCK    = 12
SHM_STAT      = 13
SHM_INFO      = 14

AF_UNIX       = 1
AF_LOCAL      = 1
AF_INET       = 2
AF_AX25       = 3
AF_IPX        = 4
AF_APPLETALK  = 5
AF_NETROM     = 6
AF_BRIDGE     = 7
AF_ATMPVC     = 8
AF_X25        = 9
AF_INET6      = 10
AF_ROSE       = 11
AF_DECnet     = 12
AF_NETBEUI    = 13
AF_SECURITY   = 14
AF_KEY        = 15
AF_NETLINK    = 16
AF_PACKET     = 17
AF_ASH        = 18
AF_ECONET     = 19
AF_ATMSVC     = 20
AF_SNA        = 22
AF_IRDA       = 23
AF_PPPOX      = 24
AF_WANPIPE    = 25
AF_BLUETOOTH  = 31

SOCK_STREAM    = 1
SOCK_DGRAM     = 2
SOCK_RAW       = 3
SOCK_RDM       = 4
SOCK_SEQPACKET = 5
SOCK_PACKET    = 10
SOCK_NONBLOCK  = 04000o
SOCK_CLOEXEC   = 02000000o

MSG_CONFIRM      = 0x800
MSG_DONTROUTE    = 0x04
MSG_DONTWAIT     = 0x40
MSG_EOR          = 0x80
MSG_MORE         = 0x8000
MSG_NOSIGNAL     = 0x4000
MSG_OOB          = 0x01
MSG_CMSG_CLOEXEC = 0x40000000
MSG_ERRQUEUE     = 0x2000
MSG_PEEK         = 0x02
MSG_TRUNC        = 0x20
MSG_WAITALL      = 0x100

struc sembuf
{
		.sem_num:	rw 1;   /* liczba semaforow */
		.sem_op:	rw 1;             /* operacja na semaforze:
					;	 liczba dodatnia jest dodawana
					;	 zero oznacza czekanie na zero
					;	liczba ujemna jest odejmowana*/
		.sem_flg:	rw 1;            /* flaga operacji:
					;	 IPC_NOWAIT=04000 osemkowo
					;	 lub SEM_UNDO=0x1000 */
}

GETPID   = 11
GETVAL   = 12
GETALL   = 13
GETNCNT  = 14
GETZCNT  = 15
SETVAL   = 16
SETALL   = 17
SEM_STAT = 18
SEM_INFO = 19

struc msgbuf
{
		.mtype:		rd 1;       /* typ wiadomosci, musi byc > 0 */
		.mtext:		rd 1;    /* dane wiadomosci */
}

MSG_EXCEPT  = 020000o
MSG_NOERROR = 010000o
MSG_STAT    = 11
MSG_INFO    = 12


struc ipc_perm
{
		.__key:		rd 1;       /* Klucz podany msgget */
		.uid:		rd 1;         /* Efektywny UID of wlasciciela */
		.gid:		rd 1;         /* Efektywny GID of wlasciciela */
		.cuid:		rd 1;        /* Efektywny UID of tworcy */
		.cgid:		rd 1;        /* Efektywny GID of tworcy */
		.mode:		rw 1;        /* Uprawnienia */
		.__seq:		rw 1;       /* Numer sekwencyjny */
}

struc msqid_ds
{
		.msg_perm:		ipc_perm;     /* Wlasciciel i uprawnienia */
		.msg_stime:		rd 1;    /* Czas ostatniego msgsnd */
		.msg_rtime:		rd 1;    /* Czas ostatniego msgrcv */
		.msg_ctime:		rd 1;    /* Czas ostatniej zmiany */
		.__msg_cbytes:		rd 1; /* Aktualna liczba bajtow w kolejce */
		.msg_qnum:		rd 1;     /* Aktualna liczba wiadomosci w kolejce */
		.msg_qbytes:		rd 1;   /* Maksymalna liczba bajtow dozwolona w kolejce */
		.msg_lspid:		rd 1;    /* PID ostatniego msgsnd */
		.msg_lrpid:		rd 1;    /* PID ostatniego msgrcv */
}

ARCH_SET_FS = 0x1002
ARCH_GET_FS = 0x1003
ARCH_SET_GS = 0x1001
ARCH_GET_GS = 0x1004

MODULE_INIT_IGNORE_MODVERSIONS	= 1
MODULE_INIT_IGNORE_VERMAGIC	= 2

struc sched_attr
{
		.size:			rd 1; /* Rozmiar tej struktury */
		.sched_policy:		rd 1; /* Polityka */
		.sched_flags:		rq 1; /* Flagi = 0 lub SCHED_FLAG_RESET_ON_FORK = 0x40000000 */
		.sched_nice:		rd 1; /* Wartosc priorytetu */
		.sched_priority:	rd 1; /* Statyczny priorytet */
		;/* Pozostale pola sa dla SCHED_DEADLINE */
		.sched_runtime:		rq 1;
		.sched_deadline:	rq 1;
		.sched_period:		rq 1;
}


RENAME_EXCHANGE			= (1 shl 1)
RENAME_NOREPLACE		= (1 shl 0)
RENAME_WHITEOUT			= (1 shl 2)

struc sock_fprog
{
		.len:			rw 1; /* Liczba instrukcji BPF */
		.filter:		rd 1; /* Adres tablicy instrukcji BPF */
}



struc sock_filter
{
		.code:			rw 1
		.jt:			rb 1
		.jf:			rb 1
		.k:			rd 1
}


struc seccomp_data
{
		.nr:			rd 1;  /* Numer funkcji systemowej */
		.arch:			rd 1;  /* wartosc AUDIT_ARCH_* */
		.instruction_pointer:	rq 1;  /* wskaznik instrukcji CPU - IP/EIP/RIP */
		.args:			rq 6;  /* Do 6 parametrow funkcji systemowej */
}

GRND_RANDOM			= 0x0002
GRND_NONBLOCK			= 0x0001

MFD_CLOEXEC			= 0x0001
MFD_ALLOW_SEALING		= 0x0002

BPF_MAP_CREATE			= 0
BPF_MAP_LOOKUP_ELEM		= 1
BPF_MAP_UPDATE_ELEM		= 2
BPF_MAP_DELETE_ELEM		= 3
BPF_MAP_GET_NEXT_KEY		= 4
BPF_PROG_LOAD			= 5

AT_EMPTY_PATH			= 0x1000

MEMBARRIER_CMD_QUERY		= 0
MEMBARRIER_CMD_SHARED		= 1

MLOCK_ONFAULT			= 0x01

RWF_HIPRI			= 0x00000001

FAN_CLASS_PRE_CONTENT		= 0x00000008
FAN_CLASS_CONTENT		= 0x00000004
FAN_CLASS_NOTIF			= 0x00000000
FAN_CLOEXEC			= 0x00000001
FAN_NONBLOCK			= 0x00000002
FAN_UNLIMITED_QUEUE		= 0x00000010
FAN_UNLIMITED_MARKS		= 0x00000020

FAN_MARK_ADD			= 0x00000001
FAN_MARK_REMOVE			= 0x00000002
FAN_MARK_FLUSH			= 0x00000080
FAN_MARK_DONT_FOLLOW		= 0x00000004
FAN_MARK_ONLYDIR		= 0x00000008
FAN_MARK_MOUNT			= 0x00000010
FAN_MARK_IGNORED_MASK		= 0x00000020
FAN_MARK_IGNORED_SURV_MODIFY	= 0x00000040

FAN_ACCESS			= 0x00000001
FAN_MODIFY			= 0x00000002
FAN_CLOSE_WRITE			= 0x00000008
FAN_CLOSE_NOWRITE		= 0x00000010
FAN_OPEN			= 0x00000020
FAN_OPEN_PERM			= 0x00010000
FAN_ACCESS_PERM			= 0x00020000
FAN_ONDIR			= 0x40000000
FAN_EVENT_ON_CHILD		= 0x08000000
FAN_CLOSE			= (FAN_CLOSE_WRITE + FAN_CLOSE_NOWRITE)

struc file_handle
{
		.handle_bytes:			rd 1;   /* rozmiar f_handle */
		.handle_type:			rd 1;   /* typ uchwytu */
		.f_handle:			rb 1;   /* identyfikator pliku */
}

KCMP_FILE			= 0
KCMP_FILES			= 2
KCMP_FS				= 3
KCMP_IO				= 5
KCMP_SIGHAND			= 4
KCMP_SYSVSEM			= 6
KCMP_VM				= 1

KEXEC_FILE_UNLOAD		= 0x00000001
KEXEC_FILE_ON_CRASH		= 0x00000002
KEXEC_FILE_NO_INITRAMFS		= 0x00000004



end if		; __FASM_SYSTEM_LINUX
