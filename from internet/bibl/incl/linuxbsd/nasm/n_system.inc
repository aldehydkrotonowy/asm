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

%ifndef __NASM_SYSTEM_LINUX
%define __NASM_SYSTEM_LINUX

%define	        EPERM		 1	; Operacja niedozwolona
%define	        ENOENT		 2	; Nie ma takiego pliku/katalogu
%define	        ESRCH		 3	; Nie ma takiego procesu
%define	        EINTR		 4	; Przerwana funkcja systemowa
%define	        EIO		 5	; Blad I/O
%define	        ENXIO		 6	; Nie ma takiego urzadzenia/adresu
%define	        E2BIG		 7	; Za dluga lista argumentow
%define	        ENOEXEC		 8	; Blad formatu wykonywalnego
%define	        EBADF		 9	; Zly numer pliku
%define	        ECHILD		10	; Nie ma procesow potomnych
%define	        EAGAIN		11	; Sprobuj jeszcze raz
%define	        ENOMEM		12	; Brak pamieci
%define	        EACCES		13	; Odmowa dostepu
%define		EACCESS		EACCES
%define	        EFAULT		14	; Zly adres
%define	        ENOTBLK		15	; Wymagane jest urzadzenie blokowe
%define	        EBUSY		16	; Urzadzenie/zasob zajety
%define	        EEXIST		17	; Plik istnieje
%define	        EXDEV		18	; Cross-device link
%define	        ENODEV		19	; Nie ma takiego urzadzenia
%define	        ENOTDIR		20	; To nie jest katalog
%define	        EISDIR		21	; To jest katalog
%define	        EINVAL		22	; Nieprawidlowy argument
%define	        ENFILE		23	; Przepelnienie tablicy plikow
%define	        EMFILE		24	; Za duzo otwartych plikow
%define	        ENOTTY		25	; Nie jest terminalem
%define	        ETXTBSY		26	; Plik testowy zajety
%define	        EFBIG		27	; Plik za duzy
%define	        ENOSPC		28	; Brak miejsca na urzadzeniu
%define	        ESPIPE		29	; Nieprawidlowe przejscie w pliku (Illegal seek)
%define	        EROFS		30	; System plikow tylko do odczytu
%define	        EMLINK		31	; Za duzo linkow
%define	        EPIPE		32	; Zly potok (Broken pipe)
%define	        EDOM		33	; Argument poza dziedzina funkcji mat.
%define	        ERANGE		34	; Wyniku nie da sie przedstawic
%define	        EDEADLK		35	; Resource deadlock would occur
%define	        ENAMETOOLONG	36	; Zbyt dluga nazwa pliku
%define	        ENOLCK		37	; No record locks available
%define	        ENOSYS		38	; Funkcja nie zaimplementowana
%define	        ENOTEMPTY	39	; Katalog nie jest pusty
%define	        ELOOP		40	; Zbyt duzo linkow symbolicznych
%define	        EWOULDBLOCK	EAGAIN	; Wstrzymaloby dzialanie programu
%define	        ENOMSG		42	; Nie ma wiadomosci zadanego typu
%define	        EIDRM		43	; Identyfikator zostal usuniety
%define	        ECHRNG		44	; Numer kanalu spoza zasiegu
%define	        EL2NSYNC	45	; Level 2 not synchronized
%define	        EL3HLT		46	; Level 3 halted
%define	        EL3RST		47	; Level 3 reset
%define	        ELNRNG		48	; Link number out of range
%define	        EUNATCH		49	; Niepodlaczony sterownik protokolu
%define	        ENOCSI		50	; No CSI structure available
%define	        EL2HLT		51	; Level 2 halted
%define	        EBADE		52	; Invalid exchange
%define	        EBADR		53	; Nieprawidlowy deskryptor zadania
%define	        EXFULL		54	; Exchange full
%define	        ENOANO		55	; No anode
%define	        EBADRQC		56	; Nieprawidlowy kod zadania
%define	        EBADSLT		57	; Invalid slot
%define	        EDEADLOCK	EDEADLK
%define	        EBFONT		59	; Bad font file format
%define	        ENOSTR		60	; Device not a stream
%define	        ENODATA		61	; Nie ma danych
%define	        ETIME		62	; Przekroczony limit czasu
%define	        ENOSR		63	; Out of streams resources
%define	        ENONET		64	; Machine is not on the network
%define	        ENOPKG		65	; Package not installed
%define	        EREMOTE		66	; Obiekt jest zdalny
%define	        ENOLINK		67	; Link has been severed
%define	        EADV		68	; Advertise error
%define	        ESRMNT		69	; Srmount error
%define	        ECOMM		70	; Blad komunikacji przy wysylaniu
%define	        EPROTO		71	; Blad protokolu
%define	        EMULTIHOP	72	; Multihop attempted
%define	        EDOTDOT		73	; RFS specific error
%define	        EBADMSG		74	; Not a data message
%define	        EOVERFLOW	75	; Wartosc za duza dla okreslonego typu
%define	        ENOTUNIQ	76	; Nazwa nie jest unikalna w sieci
%define	        EBADFD		77	; Deskryptor pliku w zlym stanie
%define	        EREMCHG		78	; Zmiana adresu zdalnego
%define	        ELIBACC		79	; Nie mozna sie dostac do wymaganej bibl.
%define	        ELIBBAD		80	; Accessing a corrupted shared library
%define	        ELIBSCN		81	; .lib section in a.out corrupted
%define	        ELIBMAX		82	; Attempting to link in too many shared libraries
%define	        ELIBEXEC	83	; Cannot exec a shared library directly
%define	        EILSEQ		84	; Nieprawidlowa sekwencja bajtow
%define	        ERESTART	85	; Interrupted system call should be restarted
%define	        ESTRPIPE	86	; Streams pipe error
%define	        EUSERS		87	; Za duzo uzytkownikow
%define	        ENOTSOCK	88	; Socket operation on non-socket
%define	        EDESTADDRREQ	89	; Wymagany adres docelowy
%define	        EMSGSIZE	90	; Message too long
%define	        EPROTOTYPE	91	; Protocol wrong type for socket
%define	        ENOPROTOOPT	92	; Protokol niedostepny
%define	        EPROTONOSUPPORT	93	; Protokol nieobslugiwany
%define	        ESOCKTNOSUPPORT	94	; Socket type not supported
%define	        EOPNOTSUPP	95	; Operation not supported on transport endpoint
%define	        EPFNOSUPPORT	96	; Protocol family not supported
%define	        EAFNOSUPPORT	97	; Address family not supported by protocol
%define	        EADDRINUSE	98	; Adres juz jest uzywany
%define	        EADDRNOTAVAIL	99	; Nie moge przydzielic zadanego adresu
%define	        ENETDOWN	100	; Siec nie dziala
%define	        ENETUNREACH	101	; Siec jest niedostepna
%define	        ENETRESET	102	; Network dropped connection because of reset
%define	        ECONNABORTED	103	; Software caused connection abort
%define	        ECONNRESET	104	; Connection reset by peer
%define	        ENOBUFS		105	; No buffer space available
%define	        EISCONN		106	; Transport endpoint is already connected
%define	        ENOTCONN	107	; Transport endpoint is not connected
%define	        ESHUTDOWN	108	; Cannot send after transport endpoint shutdown
%define	        ETOOMANYREFS	109	; Too many references: cannot splice
%define	        ETIMEDOUT	110	; Przekroczony limit czasu polaczenia
%define	        ECONNREFUSED	111	; Odmowa polaczenia
%define	        EHOSTDOWN	112	; Host is down
%define	        EHOSTUNREACH	113	; Nie ma drogi do hosta
%define	        EALREADY	114	; Operacja juz trwa
%define	        EINPROGRESS	115	; Operation now in progress
%define	        ESTALE		116	; Stale NFS file handle
%define	        EUCLEAN		117	; Structure needs cleaning
%define	        ENOTNAM		118	; Not a XENIX named type file
%define	        ENAVAIL		119	; No XENIX semaphores available
%define	        EISNAM		120	; Is a named type file
%define	        EREMOTEIO	121	; Blad zdalnego I/O
%define	        EDQUOT		122	; Przekroczony limit dyskowy Quota

%define	        ENOMEDIUM	123	; Brak nosnika
%define	        EMEDIUMTYPE	124	; Zly typ nosnika

%define		ECANCELED	125	; Zrezygnowano z operacji
%define		ENOKEY		126	; Required key not available
%define		EKEYEXPIRED	127	; Key has expired
%define		EKEYREVOKED	128	; Key has been revoked
%define		EKEYREJECTED	129	; Key was rejected by service

%define		EOWNERDEAD	130	; Owner died
%define		ENOTRECOVERABLE	131	; Stan nieodnawialny

%define 	ERESTARTSYS	512
%define 	ERESTARTNOINTR	513
%define 	ERESTARTNOHAND	514	; restart if no handler..
%define 	ENOIOCTLCMD	515	; No ioctl command
%define 	ERESTART_RESTARTBLOCK 516 ; restart by calling sys_restart_syscall

; Zdefiniowane dla protokolu NFSv3
%define 	EBADHANDLE	521	; Illegal NFS file handle
%define 	ENOTSYNC	522	; Update synchronization mismatch
%define 	EBADCOOKIE	523	; Cookie is stale
%define 	ENOTSUPP	524	; Operation is not supported
%define 	ETOOSMALL	525	; Buffer or request is too small
%define 	ESERVERFAULT	526	; An untranslatable error occurred
%define 	EBADTYPE	527	; Type not supported by server
%define 	EJUKEBOX	528	; Request initiated, but will not complete before timeout
%define 	EIOCBQUEUED	529	; iocb queued, will get completion event
%define 	EIOCBRETRY	530	; iocb queued, will trigger a retry

%define 	EWOULDBLOCKIO	530	; Would block due to block-IO

;=====================================================
; stale systemowe
;=====================================================

%define         O_ACCMODE       0003o
%define         O_RDONLY        00o
%define         O_WRONLY        01o
%define         O_RDWR          02o
%define         O_CREAT         0100o
%define         O_EXCL          0200o
%define         O_NOCTTY        0400o
%define         O_TRUNC         01000o
%define         O_APPEND        02000o
%define         O_NONBLOCK      04000o
%define         O_NDELAY        O_NONBLOCK
%define         O_SYNC          010000o  ;  specyficzne dla ext2 i urzadzen blokowych
%define         FASYNC          020000o  ;  fcntl, dla zgodnosci z BSD
%define         O_DIRECT        040000o  ;  podpowiedz bezposredniego dostepu do dysku
%define         O_LARGEFILE     0100000o
%define         O_DIRECTORY     0200000o   ; musi byc katalogiem
%define         O_NOFOLLOW      0400000o   ; nie podazaj za linkami



%define         S_ISUID         04000o  ; ustaw ID uzytkownika przy wykonywaniu (suid)
%define         S_ISGID         02000o  ; ustaw ID grupy przy wykonywaniu (sgid)
%define         S_ISVTX         01000o  ; "sticky bit" - usuwac moze tylko wlasciciel
%define         S_IRUSR         00400o  ; czytanie przez wlascicela (S_IREAD)
%define         S_IWUSR         00200o  ; zapis przez wlascicela (S_IWRITE)
%define         S_IXUSR         00100o  ; wykonyw./przeszuk. przez wlascicela (S_IEXEC)
%define         S_IRGRP         00040o  ; czytanie przez grupe
%define         S_IWGRP         00020o  ; zapis przez grupe
%define         S_IXGRP         00010o  ; wykonywanie/przeszukiwanie przez grupe
%define         S_IROTH         00004o  ; czytanie przez innych (R_OK)
%define         S_IWOTH         00002o  ; zapis przez innych (W_OK)
%define         S_IXOTH         00001o  ; wykonywanie/przeszukiwanie przez innych (X_OK)

%define         S_IRWXU		( S_IRUSR | S_IWUSR | S_IXUSR )
%define         S_IRWXG         ( S_IRGRP | S_IWGRP | S_IXGRP )
%define         S_IRWXO         ( S_IROTH | S_IWOTH | S_IXOTH )

%define         S_IRWXUGO       ( S_IRWXU | S_IRWXG | S_IRWXO )
%define         S_IALLUGO       ( S_ISUID | S_ISGID | S_ISVTX | S_IRWXUGO )
%define         S_IRUGO         ( S_IRUSR | S_IRGRP | S_IROTH )
%define         S_IWUGO         ( S_IWUSR | S_IWGRP | S_IWOTH )
%define         S_IXUGO         ( S_IXUSR | S_IXGRP | S_IXOTH )



%define         MS_MGC_MSK      0C0EDh ; in m.s. 16-bit; 'magic', niezbedne przed 2.4?
%define         MS_RDONLY       1      ; Zamountuj tylko do odczytu
%define         MS_NOSUID       2      ; Ignoruj bity suid i sgid
%define         MS_NODEV        4      ; Zabron dostepu do specjalnych plikow/urzadzen
%define         MS_NOEXEC       8      ; Zabron wykonywania programow
%define         MS_SYNCHRONOUS  16     ; Zapisy sa synchronizowane natychmiast
%define         MS_REMOUNT      32     ; Zmien flagi zamontowanego systemu plikow
%define         MS_MANDLOCK     64     ; Pozwol na nakazane blokady na systemie plikow?
%define         MS_NOATIME      1024   ; Nie zmieniaj czasow dostepu
%define         MS_NODIRATIME   2048   ; Nie zmieniaj czasow dostepu do katalogow
%define         MS_BIND         4096
%define         MS_REC          16384
%define         MS_VERBOSE      32768
%define         MS_ACTIVE       (1<<30)
%define         MS_NOUSER       (1<<31)


%define         SEEK_SET	0
%define         SEKK_CUR	1
%define         SEEK_END	2


%define         PTRACE_PEEKTEXT		0
%define         PTRACE_PEEKDATA		1
%define         PTRACE_PEEKUSR		2
%define         PTRACE_POKETEXT		3
%define         PTRACE_POKEDATA		4
%define         PTRACE_POKEUSR		5
%define         PTRACE_TRACEME		6
%define         PTRACE_CONT		7
%define         PTRACE_KILL		8
%define         PTRACE_SINGLESTEP	9
%define         PTRACE_GETREGS		12
%define         PTRACE_SETREGS		13
%define         PTRACE_GETFPREGS	14
%define         PTRACE_SETFPREGS	15
%define         PTRACE_ATTACH		16
%define         PTRACE_DETACH		17
%define         PTRACE_GETFPXREGS	18
%define         PTRACE_SETFPXREGS	19
%define         PTRACE_SETOPTIONS	21
%define         PTRACE_SYSCALL		24

%define         F_DUPFD		0
%define         F_GETFD		1
%define         F_SETFD		2
%define         F_GETFL		3
%define         F_SETFL		4
%define         F_GETLK		5
%define         F_SETLK		6
%define         F_SETLKW	7
%define         F_SETOWN	8
%define         F_GETOWN	9


; podstawowe deskryptory plikow

%idefine	stdin		0
%idefine	stdout		1
%idefine	stderr		2



;=====================================================
; numery funkcji systemowych Linuksa, skladnia NASM
;=====================================================


%idefine	sys_setup		0
%idefine	sys_exit		1
%idefine	sys_fork		2
%idefine	sys_read		3
%idefine	sys_write		4
%idefine	sys_open		5
%idefine	sys_close		6
%idefine	sys_waitpid		7
%idefine	sys_creat		8
%idefine	sys_link		9
%idefine	sys_unlink		10
%idefine	sys_execve		11
%idefine	sys_chdir		12
%idefine	sys_time		13
%idefine	sys_mknod		14
%idefine	sys_chmod		15
%idefine	sys_lchown		16
%idefine	sys_break		17
%idefine	sys_oldstat		18
%idefine	sys_stat		sys_oldstat
%idefine	sys_lseek		19
%idefine	sys_getpid		20
%idefine	sys_mount		21
%idefine	sys_umount		22
%idefine	sys_oldumount		sys_umount
%idefine	sys_setuid		23
%idefine	sys_getuid		24
%idefine	sys_stime		25
%idefine	sys_ptrace		26
%idefine	sys_alarm		27
%idefine	sys_oldfstat		28
%idefine	sys_fstat		sys_oldfstat
%idefine	sys_pause		29
%idefine	sys_utime		30
%idefine	sys_stty		31
%idefine	sys_gtty		32
%idefine	sys_access		33
%idefine	sys_nice		34
%idefine	sys_ftime		35
%idefine	sys_sync		36
%idefine	sys_kill		37
%idefine	sys_rename		38
%idefine	sys_mkdir		39
%idefine	sys_rmdir		40
%idefine	sys_dup			41
%idefine	sys_pipe		42
%idefine	sys_times		43
%idefine	sys_prof		44
%idefine	sys_brk			45
%idefine	sys_setgid		46
%idefine	sys_getgid		47
%idefine	sys_signal		48
%idefine	sys_geteuid		49


%idefine	sys_getegid		50
%idefine	sys_acct		51
%idefine	sys_umount2		52		; 2.2+
%idefine	sys_lock		53
%idefine	sys_ioctl		54
%idefine	sys_fcntl		55
%idefine	sys_mpx			56
%idefine	sys_setpgid		57
%idefine	sys_ulimit		58
%idefine	sys_oldolduname		59
%idefine	sys_umask		60
%idefine	sys_chroot		61
%idefine	sys_ustat		62
%idefine	sys_dup2		63
%idefine	sys_getppid		64
%idefine	sys_getpgrp		65
%idefine	sys_setsid		66
%idefine	sys_sigaction		67
%idefine	sys_sgetmask		68
%idefine	sys_ssetmask		69
%idefine	sys_setreuid		70
%idefine	sys_setregid		71
%idefine	sys_sigsuspend		72
%idefine	sys_sigpending		73
%idefine	sys_sethostname		74
%idefine	sys_setrlimit		75
%idefine	sys_getrlimit		76
%idefine	sys_getrusage		77
%idefine	sys_gettimeofday	78
%idefine	sys_settimeofday	79
%idefine	sys_getgroups		80
%idefine	sys_setgroups		81
%idefine	sys_select		82
%idefine	sys_symlink		83
%idefine	sys_oldlstat		84
%idefine	sys_lstat		sys_oldlstat
%idefine	sys_readlink		85
%idefine	sys_uselib		86
%idefine	sys_swapon		87
%idefine	sys_reboot		88
%idefine	sys_readdir		89
%idefine	sys_mmap		90
%idefine	sys_munmap		91
%idefine	sys_truncate		92
%idefine	sys_ftruncate		93
%idefine	sys_fchmod		94
%idefine	sys_fchown		95
%idefine	sys_getpriority		96
%idefine	sys_setpriority		97
%idefine	sys_profil		98
%idefine	sys_statfs		99


%idefine	sys_fstatfs		100
%idefine	sys_ioperm		101
%idefine	sys_socketcall		102
%idefine	sys_syslog		103
%idefine	sys_setitimer		104
%idefine	sys_getitimer		105
%idefine	sys_stat		106
%idefine	sys_newstat		sys_stat
%idefine	sys_lstat		107
%idefine	sys_newlstat		sys_lstat
%idefine	sys_fstat		108
%idefine	sys_newfstat		sys_fstat
%idefine	sys_olduname		109
%idefine	sys_iopl		110
%idefine	sys_vhangup		111
%idefine	sys_idle		112
%idefine	sys_vm86old		113
%idefine	sys_wait4		114
%idefine	sys_swapoff		115
%idefine	sys_sysinfo		116
%idefine	sys_ipc			117
%idefine	sys_fsync		118
%idefine	sys_sigreturn		119
%idefine	sys_clone		120
%idefine	sys_setdomainname	121
%idefine	sys_uname		122
%idefine	sys_newuname		sys_uname
%idefine	sys_modify_ldt		123
%idefine	sys_adjtimex		124
%idefine	sys_mprotect		125
%idefine	sys_sigprocmask		126
%idefine	sys_create_module	127
%idefine	sys_init_module		128
%idefine	sys_delete_module	129
%idefine	sys_get_kernel_syms	130
%idefine	sys_quotactl		131
%idefine	sys_getpgid		132
%idefine	sys_fchdir		133
%idefine	sys_bdfulsh		134
%idefine	sys_sysfs		135
%idefine	sys_personality		136
%idefine	sys_afs_syscall		137
%idefine	sys_setfsuid		138
%idefine	sys_setfsgid		139
%idefine	sys__llseek		140
%idefine	sys_llseek		sys__llseek
%idefine	sys_getdents		141
%idefine	sys_newselect		142
%idefine	sys_flock		143
%idefine	sys_msync		144
%idefine	sys_readv		145
%idefine	sys_writev		146
%idefine	sys_getsid		147
%idefine	sys_fdatasync		148
%idefine	sys__sysctl		149
%idefine	sys_sysctl		sys__sysctl


%idefine	sys_mlock		150
%idefine	sys_munlock		151
%idefine	sys_mlockall		152
%idefine	sys_munlockall		153
%idefine	sys_sched_setparam	154
%idefine	sys_sched_getparam	155
%idefine	sys_sched_setscheduler	156
%idefine	sys_sched_getscheduler	157
%idefine	sys_sched_yield		158
%idefine	sys_sched_get_priority_max	159
%idefine	sys_sched_get_priority_min	160
%idefine	sys_sched_rr_get_interval	161
%idefine	sys_nanosleep		162
%idefine	sys_mremap		163
%idefine	sys_setresuid		164		; 2.2+
%idefine	sys_getresuid		165		; 2.2+
%idefine	sys_vm86		166
%idefine	sys_query_module	167		; 2.2+
%idefine	sys_poll		168		; 2.2+
%idefine	sys_nfsservctl		169		; 2.2+
%idefine	sys_setresgid		170		; 2.2+
%idefine	sys_getresgid		171		; 2.2+
%idefine	sys_prctl		172		; 2.2+
%idefine	sys_rt_sigreturn	173		; 2.2+
%idefine	sys_rt_sigaction	174		; 2.2+
%idefine	sys_rt_sigprocmask	175		; 2.2+
%idefine	sys_rt_sigpending	176		; 2.2+
%idefine	sys_rt_sigtimedwait	177		; 2.2+
%idefine	sys_rt_sigqueueinfo	178		; 2.2+
%idefine	sys_rt_sigsuspend	179		; 2.2+
%idefine	sys_pread		180		; 2.2+
%idefine	sys_pwrite		181		; 2.2+
%idefine	sys_chown		182		; 2.2+
%idefine	sys_getcwd		183		; 2.2+
%idefine	sys_capget		184		; 2.2+
%idefine	sys_capset		185		; 2.2+
%idefine	sys_sigaltstack		186		; 2.2+
%idefine	sys_sendfile		187		; 2.2+
%idefine	sys_getpmsg		188		; 2.2+
%idefine	sys_putpmsg		189		; 2.2+
%idefine	sys_vfork		190		; 2.2+

; 2.4.2

%idefine	sys_getrlimit		191
%idefine	sys_mmap2		192
%idefine	sys_truncate64		193
%idefine	sys_ftruncate64		194
%idefine	sys_stat64		195
%idefine	sys_lstat64		196
%idefine	sys_fstat64		197

; 2.4.18

%idefine	sys_lchown32		198
%idefine	sys_getuid32		199
%idefine	sys_getgid32		200
%idefine	sys_geteuid32		201
%idefine	sys_getegid32		202
%idefine	sys_setreuid32		203
%idefine	sys_setregid32		204
%idefine	sys_getgroups32		205
%idefine	sys_setgroups32		206
%idefine	sys_fchown32		207
%idefine	sys_setresuid32		208
%idefine	sys_getresuid32		209
%idefine	sys_setresgid32		210
%idefine	sys_getresgid32		211
%idefine	sys_chown32		212
%idefine	sys_setuid32		213
%idefine	sys_setgid32		214
%idefine	sys_setfsuid32		215
%idefine	sys_setfsgid		216
%idefine	sys_pivot_root		217
%idefine	sys_mincore		218
%idefine	sys_madvise		219
%idefine	sys_madvise1		sys_madvise
%idefine	sys_getdents64		220
%idefine	sys_fcntl64		221

%idefine	sys_security		223
%idefine	sys_gettid		224
%idefine	sys_readahead		225
%idefine	sys_setxattr		226
%idefine	sys_lsetxattr		227
%idefine	sys_fsetxattr		228
%idefine	sys_getxattr		229
%idefine	sys_lgetxattr		230
%idefine	sys_fgetxattr		231
%idefine	sys_listxattr		232
%idefine	sys_llistxattr		233
%idefine	sys_flistxattr		234
%idefine	sys_removexattr		235
%idefine	sys_lremovexattr	236
%idefine	sys_fremovexattr	237

; 2.4.19

%idefine	sys_tkill		238
%idefine	sys_sendfile64		239
%idefine	sys_futex		240
%idefine	sys_sched_setaffinity	241
%idefine	sys_sched_getaffinity	242

; 2.4.20

%idefine	sys_set_thread_area	243
%idefine	sys_get_thread_area	244
%idefine	sys_io_setup		245
%idefine	sys_io_destroy		246
%idefine	sys_io_getevents	247
%idefine	sys_io_submit		248
%idefine	sys_io_cancel		249
%idefine	sys_alloc_hugepages	250
%idefine	sys_free_hugepages	251
%idefine	sys_exit_group		252

; 2.6

%idefine	sys_lookup_dcookie	253
%idefine	sys_epoll_create	254
%idefine	sys_epoll_ctl		255
%idefine	sys_epoll_wait		256
%idefine	sys_remap_file_pages	257
%idefine	sys_set_tid_address	258
%idefine	sys_timer_create	259
%idefine	sys_timer_settime	260
%idefine	sys_timer_gettime	261
%idefine	sys_timer_getoverrun	262
%idefine	sys_timer_delete	263
%idefine	sys_clock_settime	264
%idefine	sys_clock_gettime	265
%idefine	sys_clock_getres	266
%idefine	sys_clock_nanosleep	267
%idefine	sys_statfs64		268
%idefine	sys_fstatfs64		269
%idefine	sys_tgkill		270
%idefine	sys_utimes		271
%idefine 	sys_fadvise64_64	272
%idefine 	sys_vserver		273
%idefine 	sys_mbind		274
%idefine 	sys_get_mempolicy	275
%idefine 	sys_set_mempolicy	276
%idefine 	sys_mq_open 		277
%idefine 	sys_mq_unlink		(sys_mq_open+1)
%idefine 	sys_mq_timedsend	(sys_mq_open+2)
%idefine 	sys_mq_timedreceive	(sys_mq_open+3)
%idefine 	sys_mq_notify		(sys_mq_open+4)
%idefine 	sys_mq_getsetattr	(sys_mq_open+5)
%idefine 	sys_sys_kexec_load	283
%idefine 	sys_waitid		284
; %idefine 	sys_sys_setaltroot	285
%idefine 	sys_add_key		286
%idefine 	sys_request_key		287
%idefine 	sys_keyctl		288
%idefine 	sys_ioprio_set		289
%idefine 	sys_ioprio_get		290
%idefine 	sys_inotify_init	291
%idefine 	sys_inotify_add_watch	292
%idefine 	sys_inotify_rm_watch	293
%idefine 	sys_migrate_pages	294
%idefine 	sys_openat		295
%idefine 	sys_mkdirat		296
%idefine 	sys_mknodat		297
%idefine 	sys_fchownat		298
%idefine 	sys_futimesat		299
%idefine 	sys_fstatat64		300
%idefine 	sys_unlinkat		301
%idefine 	sys_renameat		302
%idefine 	sys_linkat		303
%idefine 	sys_symlinkat		304
%idefine 	sys_readlinkat		305
%idefine 	sys_fchmodat		306
%idefine 	sys_faccessat		307
%idefine 	sys_pselect6		308
%idefine 	sys_ppoll		309
%idefine 	sys_unshare		310
%idefine	sys_set_robust_list	311
%idefine	sys_get_robust_list	312
%idefine	sys_splice		313
%idefine	sys_sync_file_range	314
%idefine	sys_tee			315
%idefine	sys_vmsplice		316
%idefine	sys_move_pages		317
%idefine	sys_getcpu		318
%idefine	sys_epoll_pwait		319
%idefine	sys_utimensat		320
%idefine	sys_signalfd		321
%idefine	sys_timerfd_create	322
%idefine	sys_eventfd		323
%idefine	sys_fallocate		324
%idefine	sys_timerfd_settime	325
%idefine	sys_timerfd_gettime	326
%idefine	sys_signalfd4		327
%idefine	sys_eventfd2		328
%idefine	sys_epoll_create1	329
%idefine	sys_dup3		330
%idefine	sys_pipe2		331
%idefine	sys_inotify_init1	332
%idefine	sys_preadv		333
%idefine	sys_pwritev		334
%idefine	sys_rt_tgsigqueueinfo	335
%idefine	sys_perf_event_open	336
%idefine	sys_recvmmsg		337
%idefine	sys_fanotify_init	338
%idefine	sys_fanotify_mark	339
%idefine	sys_prlimit64		340
%idefine	sys_name_to_handle_at	341
%idefine	sys_open_by_handle_at	342
%idefine	sys_clock_adjtime	343
%idefine	sys_syncfs		344
%idefine	sys_sendmmsg		345
%idefine	sys_setns		346
%idefine	sys_process_vm_readv	347
%idefine	sys_process_vm_writev	348
%idefine	sys_kcmp		349

; 4.6.5

%idefine	sys_finit_module	350
%idefine	sys_sched_setattr	351
%idefine	sys_sched_getattr	352
%idefine	sys_renameat2		353
%idefine	sys_seccomp		354
%idefine	sys_getrandom		355
%idefine	sys_memfd_create	356
%idefine	sys_bpf			357
%idefine	sys_execveat		358
%idefine	sys_socket		359
%idefine	sys_socketpair		360
%idefine	sys_bind		361
%idefine	sys_connect		362
%idefine	sys_listen		363
%idefine	sys_accept4		364
%idefine	sys_getsockopt		365
%idefine	sys_setsockopt		366
%idefine	sys_getsockname		367
%idefine	sys_getpeername		368
%idefine	sys_sendto		369
%idefine	sys_sendmsg		370
%idefine	sys_recvfrom		371
%idefine	sys_recvmsg		372
%idefine	sys_shutdown		373
%idefine	sys_userfaultfd		374
%idefine	sys_membarrier		375
%idefine	sys_mlock2		376
%idefine	sys_copy_file_range	377
%idefine	sys_preadv2		378
%idefine	sys_pwritev2		379

;=====================================================
; numery funkcji systemowych Linuksa x86-64, skladnia NASM
;=====================================================

%idefine	sys64_read			0
%idefine	sys64_write			1
%idefine	sys64_open			2
%idefine	sys64_close			3
%idefine	sys64_stat			4
%idefine	sys64_fstat			5
%idefine	sys64_lstat			6
%idefine	sys64_poll			7
%idefine	sys64_lseek			8
%idefine	sys64_mmap			9
%idefine	sys64_mprotect			10
%idefine	sys64_munmap			11
%idefine	sys64_brk			12
%idefine	sys64_rt_sigaction		13
%idefine	sys64_rt_sigprocmask		14
%idefine	sys64_rt_sigreturn		15
%idefine	sys64_ioctl			16
%idefine	sys64_pread64			17
%idefine	sys64_pwrite64			18
%idefine	sys64_readv			19
%idefine	sys64_writev			20
%idefine	sys64_access			21
%idefine	sys64_pipe			22
%idefine	sys64_select			23
%idefine	sys64_sched_yield		24
%idefine	sys64_mremap			25
%idefine	sys64_msync			26
%idefine	sys64_mincore			27
%idefine	sys64_madvise1			28
%idefine	sys64_shmget			29
%idefine	sys64_shmat			30
%idefine	sys64_shmctl			31
%idefine	sys64_dup			32
%idefine	sys64_dup2			33
%idefine	sys64_pause			34
%idefine	sys64_nanosleep			35
%idefine	sys64_getitimer			36
%idefine	sys64_alarm			37
%idefine	sys64_setitimer			38
%idefine	sys64_getpid			39
%idefine	sys64_sendfile64		40
%idefine	sys64_socket			41
%idefine	sys64_connect			42
%idefine	sys64_accept			43
%idefine	sys64_sendto			44
%idefine	sys64_recvfrom			45
%idefine	sys64_sendmsg			46
%idefine	sys64_recvmsg			47
%idefine	sys64_shutdown			48
%idefine	sys64_bind			49
%idefine	sys64_listen			50
%idefine	sys64_getsockname		51
%idefine	sys64_getpeername		52
%idefine	sys64_socketpair		53
%idefine	sys64_setsockopt		54
%idefine	sys64_getsockopt		55
%idefine	sys64_clone			56
%idefine	sys64_fork			57
%idefine	sys64_vfork			58
%idefine	sys64_execve			59
%idefine	sys64_exit			60
%idefine	sys64_wait4			61
%idefine	sys64_kill			62
%idefine	sys64_uname			63
%idefine	sys64_semget			64
%idefine	sys64_semop			65
%idefine	sys64_semctl			66
%idefine	sys64_shmdt			67
%idefine	sys64_msgget			68
%idefine	sys64_msgsnd			69
%idefine	sys64_msgrcv			70
%idefine	sys64_msgctl			71
%idefine	sys64_fcntl			72
%idefine	sys64_flock			73
%idefine	sys64_fsync			74
%idefine	sys64_fdatasync			75
%idefine	sys64_truncate			76
%idefine	sys64_ftruncate			77
%idefine	sys64_getdents			78
%idefine	sys64_getcwd			79
%idefine	sys64_chdir			80
%idefine	sys64_fchdir			81
%idefine	sys64_rename			82
%idefine	sys64_mkdir			83
%idefine	sys64_rmdir			84
%idefine	sys64_creat			85
%idefine	sys64_link			86
%idefine	sys64_unlink			87
%idefine	sys64_symlink			88
%idefine	sys64_readlink			89
%idefine	sys64_chmod			90
%idefine	sys64_fchmod			91
%idefine	sys64_chown			92
%idefine	sys64_fchown			93
%idefine	sys64_lchown			94
%idefine	sys64_umask			95
%idefine	sys64_gettimeofday		96
%idefine	sys64_getrlimit			97
%idefine	sys64_getrusage			98
%idefine	sys64_sysinfo			99
%idefine	sys64_times			100
%idefine	sys64_ptrace			101
%idefine	sys64_getuid			102
%idefine	sys64_syslog			103
%idefine	sys64_getgid			104
%idefine	sys64_setuid			105
%idefine	sys64_setgid			106
%idefine	sys64_geteuid			107
%idefine	sys64_getegid			108
%idefine	sys64_setpgid			109
%idefine	sys64_getppid			110
%idefine	sys64_getpgrp			111
%idefine	sys64_setsid			112
%idefine	sys64_setreuid			113
%idefine	sys64_setregid			114
%idefine	sys64_getgroups			115
%idefine	sys64_setgroups			116
%idefine	sys64_setresuid			117
%idefine	sys64_getresuid			118
%idefine	sys64_setresgid			119
%idefine	sys64_getresgid			120
%idefine	sys64_getpgid			121
%idefine	sys64_setfsuid			122
%idefine	sys64_setfsgid			123
%idefine	sys64_getsid			124
%idefine	sys64_capget			125
%idefine	sys64_capset			126
%idefine	sys64_rt_sigpending		127
%idefine	sys64_rt_sigtimedwait		128
%idefine	sys64_rt_sigqueueinfo		129
%idefine	sys64_rt_sigsuspend		130
%idefine	sys64_sigaltstack		131
%idefine	sys64_utime			132
%idefine	sys64_mknod			133
%idefine	sys64_uselib			134
%idefine	sys64_personality		135
%idefine	sys64_ustat			136
%idefine	sys64_statfs			137
%idefine	sys64_fstatfs			138
%idefine	sys64_sysfs			139
%idefine	sys64_getpriority		140
%idefine	sys64_setpriority		141
%idefine	sys64_sched_setparam		142
%idefine	sys64_sched_getparam		143
%idefine	sys64_sched_setsheduler		144
%idefine	sys64_sched_getsheduler		145
%idefine	sys64_sched_get_priority_max	146
%idefine	sys64_sched_get_priority_min	147
%idefine	sys64_sched_rr_get_interval	148
%idefine	sys64_mlock			149
%idefine	sys64_munlock			150
%idefine	sys64_mlockall			151
%idefine	sys64_munlockall		152
%idefine	sys64_vhangup			153
%idefine	sys64_modify_ldt		154
%idefine	sys64_pivot_root		155
%idefine	sys64_sysctl			156
%idefine	sys64_prctl			157
%idefine	sys64_arch_prctl		158
%idefine	sys64_adjtimex			159
%idefine	sys64_setrlimit			160
%idefine	sys64_chroot			161
%idefine	sys64_sync			162
%idefine	sys64_acct			163
%idefine	sys64_settimeofday		164
%idefine	sys64_mount			165
%idefine	sys64_umount2			166
%idefine	sys64_swapon			167
%idefine	sys64_swapoff			168
%idefine	sys64_reboot			169
%idefine	sys64_sethostname		170
%idefine	sys64_setdomainname		171
%idefine	sys64_iopl			172
%idefine	sys64_ioperm			173
%idefine	sys64_create_module		174
%idefine	sys64_init_module		175
%idefine	sys64_delete_module		176
%idefine	sys64_get_kernel_syms		177
%idefine	sys64_query_module		178
%idefine	sys64_quotactl			179
%idefine	sys64_nfsservctl		180
%idefine	sys64_getpmsg			181
%idefine	sys64_putpmsg			182
%idefine	sys64_afs_syscall		183
%idefine	sys64_tuxcall			184
%idefine	sys64_security			185
%idefine	sys64_gettid			186
%idefine	sys64_readahead			187
%idefine	sys64_setxattr			188
%idefine	sys64_lsetxattr			189
%idefine	sys64_fsetxattr			190
%idefine	sys64_getxattr			191
%idefine	sys64_lgetxattr			192
%idefine	sys64_fgetxattr			193
%idefine	sys64_listxattr			194
%idefine	sys64_llistxattr		195
%idefine	sys64_flistxattr		196
%idefine	sys64_removexattr		197
%idefine	sys64_lremovexattr		198
%idefine	sys64_fremovexattr		199
%idefine	sys64_tkill			200
%idefine	sys64_time			201
%idefine	sys64_futex			202
%idefine	sys64_sched_setaffinity		203
%idefine	sys64_sched_getaffinity		204
%idefine	sys64_set_thread_area		205
%idefine	sys64_io_setup			206
%idefine	sys64_io_destroy		207
%idefine	sys64_io_getevents		208
%idefine	sys64_io_submit			209
%idefine	sys64_io_cancel			210
%idefine	sys64_get_thread_area		211
%idefine	sys64_lookup_dcookie		212
%idefine	sys64_epoll_create		213
%idefine	sys64_epoll_ctl_old		214
%idefine	sys64_epoll_wait_old		215
%idefine	sys64_remap_file_pages		216
%idefine	sys64_getdents64		217
%idefine	sys64_set_tid_address		218
%idefine	sys64_restart_syscall		219
%idefine	sys64_semtimedop		220
%idefine	sys64_fadvise64_64		221
%idefine	sys64_timer_create		222
%idefine	sys64_timer_settime		223
%idefine	sys64_timer_gettime		224
%idefine	sys64_timer_getoverrun		225
%idefine	sys64_timer_delete		226
%idefine	sys64_clock_settime		227
%idefine	sys64_clock_gettime		228
%idefine	sys64_clock_getres		229
%idefine	sys64_clock_nanosleep		230
%idefine	sys64_exit_group		231
%idefine	sys64_epoll_wait		232
%idefine	sys64_epoll_ctl			233
%idefine	sys64_tgkill			234
%idefine	sys64_utimes			235
%idefine	sys64_vserver			236
%idefine	sys64_mbind			237
%idefine	sys64_set_mempolicy		238
%idefine	sys64_get_mempolicy		239
%idefine	sys64_mq_open			240
%idefine	sys64_mq_unlink			241
%idefine	sys64_mq_timedsend		242
%idefine	sys64_mq_timederceive		243
%idefine	sys64_mq_notify			244
%idefine	sys64_mq_getsetattr		245
%idefine	sys64_kexec_load		246
%idefine	sys64_waitid			247
%idefine	sys64_add_key			248
%idefine	sys64_request_key		249
%idefine	sys64_keyctl			250
%idefine	sys64_ioprio_set		251
%idefine	sys64_ioprio_get		252
%idefine	sys64_inotify_init		253
%idefine	sys64_inotify_add_watch		254
%idefine	sys64_inotify_rm_watch		255
%idefine	sys64_migrate_pages		256
%idefine	sys64_openat			257
%idefine	sys64_mkdirat			258
%idefine	sys64_mknodat			259
%idefine	sys64_fchownat			260
%idefine	sys64_futimesat			261
%idefine	sys64_fstatat64			262
%idefine	sys64_ulinkat			263
%idefine	sys64_renameat			264
%idefine	sys64_linkat			265
%idefine	sys64_symlinkat			266
%idefine	sys64_readlinkat		267
%idefine	sys64_fchmodat			268
%idefine	sys64_faccessat			269
%idefine	sys64_pselect6			270
%idefine	sys64_ppoll			271
%idefine	sys64_unshare			272
%idefine	sys64_set_robust_list		273
%idefine	sys64_get_robust_list		274
%idefine	sys64_splice			275
%idefine	sys64_tee			276
%idefine	sys64_sync_file_range		277
%idefine	sys64_vmsplice			278
%idefine	sys64_move_pages		279
%idefine	sys64_utimensat			280
%idefine	sys64_epoll_pwait		281
%idefine	sys64_signalfd			282
%idefine	sys64_timerfd_create		283
%idefine	sys64_eventfd			284
%idefine	sys64_fallocate			285
%idefine	sys64_timerfd_settime		286
%idefine	sys64_timerfd_gettime		287
%idefine	sys64_paccept			288
%idefine	sys64_signalfd4			289
%idefine	sys64_eventfd2			290
%idefine	sys64_epoll_create1		291
%idefine	sys64_dup3			292
%idefine	sys64_pipe2			293
%idefine	sys64_inotify_init1		294
%idefine	sys64_preadv			295
%idefine	sys64_pwritev			296
%idefine	sys64_rt_tgsigqueueinfo		297
%idefine	sys64_perf_counter_open		298
%idefine	sys64_recvmmsg			299
%idefine	sys64_fanotify_init		300
%idefine	sys64_fanotify_mark		301
%idefine	sys64_prlimit64			302
%idefine	sys64_name_to_handle_at		303
%idefine	sys64_open_by_handle_at		304
%idefine	sys64_clock_adjtime		305
%idefine	sys64_syncfs			306
%idefine	sys64_sendmmsg			307
%idefine	sys64_setns			308
%idefine	sys64_getcpu			309
%idefine	sys64_process_vm_readv		310
%idefine	sys64_process_vm_writev		311
%idefine	sys64_kcmp			312

; 4.6.5

%idefine	sys64_finit_module		313
%idefine	sys64_sched_setattr		314
%idefine	sys64_sched_getattr		315
%idefine	sys64_renameat2			316
%idefine	sys64_seccomp			317
%idefine	sys64_getrandom			318
%idefine	sys64_memfd_create		319
%idefine	sys64_kexec_file_load		320
%idefine	sys64_bpf			321
%idefine	sys64_execveat			322
%idefine	sys64_userfaultfd		323
%idefine	sys64_membarrier		324
%idefine	sys64_mlock2			325
%idefine	sys64_copy_file_range		326
%idefine	sys64_preadv2			327
%idefine	sys64_pwritev2			328


struc pt_regs
		._ebx:         resd 1
		._ecx:         resd 1
		._edx:         resd 1
		._esi:         resd 1
		._edi:         resd 1
		._ebp:         resd 1
		._eax:         resd 1
		._xds:         resw 1
		._xes:         resw 1
		.orig_eax:     resd 1
		._eip:         resd 1
		._xcs:         resw 1
		._eflags:      resd 1
		._esp:         resd 1
		._xss:         resw 1
endstruc

struc tms
	    	.tms_utime:     resd 1
		.tms_stime:     resd 1
		.tms_cutime:    resd 1
	    	.tms_cstime:    resd 1
endstruc

struc flock
 		.l_type:        resw 1
		.l_whence:      resw 1
		.l_start:       resd 1
		.l_len:         resd 1
		.l_pid:         resd 1
endstruc

%define		RLIMIT_CPU		0
%define		RLIMIT_FSIZE		1
%define		RLIMIT_DATA		2
%define		RLIMIT_STACK		3
%define		RLIMIT_CORE		4
%define		RLIMIT_RSS		5
%define		RLIMIT_NPROC		6
%define		RLIMIT_NOFILE		7
%define		RLIMIT_OFILE		RLIMIT_NOFILE
%define		RLIMIT_MEMLOCK		8
%define		RLIMIT_AS		9
%define		RLIMIT_LOCKS		10
%define		RLIMIT_SIGPENDING	11
%define		RLIMIT_MSGQUEUE		12
%define		RLIMIT_NICE		13
%define		RLIMIT_RTPRIO		14

struc rlimit
	    	.rlim_cur:      resd 1
	    	.rlim_max:      resd 1
endstruc


struc timeval
 	    	.tv_sec:        resd 1
	    	.tv_usec:       resd 1
endstruc

struc sigaction
	    	.sa_handler:	resd 1; procedura obslugi sygnalu
	    	.sa_flags:	resd 1;
	    	.sa_restorer:	resd 1;	// procedura przywracajaca ???
	    	.sa_mask:	resd 2;		// maska utrzymywana dla rozszerzalnosci
endstruc
%define 	_NSIG		64
%define 	_NSIG_BPW	32
%define 	_NSIG_WORDS	(_NSIG/_NSIG_BPW)

struc sigset_t
	    	.sig:		resd _NSIG_WORDS;
endstruc

%define         RUSAGE_SELF	0
%define         RUSAGE_CHILDREN	(-1)
%define         RUSAGE_BOTH	(-2)

struc	rusage
	    	.ru_utime:      resb timeval_size
	    	.ru_stime:      resb timeval_size
	    	.ru_maxrss:     resd 1
	    	.ru_ixrss:      resd 1
	    	.ru_idrss:      resd 1
	    	.ru_isrss:      resd 1
	    	.ru_minflt:     resd 1
	    	.ru_majflt:     resd 1
	    	.ru_nswap:      resd 1
	    	.ru_inblock:    resd 1
	    	.ru_oublock:    resd 1
	    	.ru_msgsnd:     resd 1
	    	.ru_msgrcv:     resd 1
	    	.ru_nsignals:   resd 1
	    	.ru_nvcsw:      resd 1
	    	.ru_nivcsw:     resd 1
endstruc


struc timezone
	        .tz_minuteswest:        resd 1
		.tz_dsttime:            resd 1
endstruc

%define         UL_GETFSIZE     1
%define         UL_SETFSIZE     2
%define         __UL_GETMAXBRK  3
%define         __UL_GETOPENMAX 4

struc utimbuf
                .actime:        resd 1
                .modtime:       resd 1
endstruc

struc timeb
                .time:          resd 1
                .millitm:       resw 1
                .timezone:      resw 1
                .dstflag:       resw 1
endstruc

struc ustat
		.f_tfree:	resd 1;	/* calkowita liczba wolnych blokow */
		.f_tinode:	resd 1;	/* liczba wolnych wezlow i-node */
		.f_fname:	resb 6;	/* nazwa systemu plikow (nieuzywane) */
		.f_fpack:	resb 6;	/* nazwa paczki(?) systemu plikow (nieuzywane) */
endstruc

%define         SWAP_FLAG_PREFER        0x8000
%define         SWAP_FLAG_PRIO_MASK     0x7fff
%define         SWAP_FLAG_PRIO_SHIFT    0

%define         LINUX_REBOOT_CMD_RESTART        0x01234567
%define         LINUX_REBOOT_CMD_HALT           0xCDEF0123
%define         LINUX_REBOOT_CMD_CAD_ON         0x89ABCDEF
%define         LINUX_REBOOT_CMD_CAD_OFF        0x00000000
%define         LINUX_REBOOT_CMD_POWER_OFF      0x4321FEDC
%define         LINUX_REBOOT_CMD_RESTART2       0xA1B2C3D4

struc dirent
                .d_ino:         resd 1
                .d_off:         resd 1
                .d_reclen:      resw 1
                .d_name:        resb 256
endstruc

%define         PROT_READ       1
%define         PROT_WRITE      2
%define         PROT_EXEC       4
%define         PROT_NONE       0

%define         MAP_FIXED       0x10
%define         MAP_GROWSDOWN   0x0100
%define         MAP_DENYWRITE   0x0800
%define         MAP_EXECUTABLE  0x1000
%define         MAP_LOCKED      0x2000
%define         MAP_NORESERVE   0x4000
%define		MAP_NONBLOCK	0x10000
%define         MAP_FILE        0
%define         MAP_ANONYMOUS   0x20
%define         MAP_ANON        MAP_ANONYMOUS

%define         MAP_SHARED      0x01
%define         MAP_PRIVATE     0x02


%define         PRIO_PROCESS    0
%define         PRIO_PGRP       1
%define         PRIO_USER       2

struc fsid_t
	        .__val:         resd 2
endstruc

struc statfs
                .f_type:        resd 1
                .f_bsize:       resd 1
                .f_blocks:      resd 1
                .f_bfree:       resd 1
                .f_bavail:      resd 1
                .f_files:       resd 1
                .f_ffree:       resd 1
                .f_fsid:	resd 2
                .f_namelen:     resd 1
                .f_spare:       resd 6
endstruc

%define         AFFS_SUPER_MAGIC        0xADFF
%define         EXT_SUPER_MAGIC         0x137D
%define         EXT2_OLD_SUPER_MAGIC    0xEF51
%define         EXT2_SUPER_MAGIC        0xEF53
%define         HPFS_SUPER_MAGIC        0xF995E849
%define         ISOFS_SUPER_MAGIC       0x9660
%define         MINIX_SUPER_MAGIC       0x137F
%define         MINIX_SUPER_MAGIC2      0x138F
%define         MINIX2_SUPER_MAGIC      0x2468
%define         MINIX2_SUPER_MAGIC2     0x2478
%define         MSDOS_SUPER_MAGIC       0x4d44
%define         NCP_SUPER_MAGIC         0x564c
%define         NFS_SUPER_MAGIC         0x6969
%define         PROC_SUPER_MAGIC        0x9fa0
%define         SMB_SUPER_MAGIC         0x517B
%define         XENIX_SUPER_MAGIC       0x012FF7B4
%define         SYSV4_SUPER_MAGIC       0x012FF7B5
%define         SYSV2_SUPER_MAGIC       0x012FF7B6
%define         COH_SUPER_MAGIC         0x012FF7B7
%define         UFS_MAGIC               0x00011954
%define         _XIAFS_SUPER_MAGIC      0x012FD16D


%define         ITIMER_REAL     0
%define         ITIMER_VIRTUAL  1
%define         ITIMER_PROF     2

struc itimerval
                .it_interval:   resb timeval_size
                .it_value:      resb timeval_size
endstruc

struc stat
                  .st_dev:      resw 1
                  .st_ino:      resd 1
                  .st_mode:     resw 1
                  .st_nlink:    resw 1
                  .st_uid:      resw 1
                  .st_gid:      resw 1
                  .st_rdev:     resw 1
                  .st_size:     resd 1
                  .st_blksize:  resd 1
                  .st_blocks:   resd 1
                  .st_atime:    resd 1
                  .st_mtime:    resd 1
                  .st_ctime:    resd 1
endstruc


%define         S_IFMT          0170000o
%define         S_IFSOCK        0140000o
%define         S_IFLNK         0120000o
%define         S_IFREG         0100000o
%define         S_IFBLK         0060000o
%define         S_IFDIR         0040000o
%define         S_IFCHR         0020000o
%define         S_IFIFO         0010000o


struc vm86_regs
                ._ebx:          resd 1
                ._ecx:          resd 1
                ._edx:          resd 1
                ._esi:          resd 1
                ._edi:          resd 1
                ._ebp:          resd 1
                ._eax:          resd 1
                .__null_ds:     resd 1
                .__null_es:     resd 1
                .__null_fs:     resd 1
                .__null_gs:     resd 1
                .orig_eax:      resd 1
                ._eip:          resd 1
                ._cs:           resw 1
	        .__csh:         resw 1
                ._eflags:       resd 1
                ._esp:          resd 1
                ._ss:           resw 1
	        .__ssh:         resw 1

                ._es:           resw 1
	        .__esh:         resw 1
                ._ds:           resw 1
	        .__dsh:         resw 1
                ._fs:           resw 1
	        .__fsh:         resw 1
                ._gs:           resw 1
	        .__gsh:         resw 1
endstruc

struc revectored_struct
                .__map:         resd 8
endstruc


struc vm86_struct
                .regs:                  resb vm86_regs_size
                .flags:                 resd 1
                .screen_bitmap:         resd 1
                .cpu_type:              resd 1
                .int_revectored:        resb revectored_struct_size
                .int21_revectored:      resb revectored_struct_size
endstruc



%define         WNOHANG         1
%define         WUNTRACED       2
%define		WCONTINUED	8
%define		WSTOPPED	2
%define		WEXITED		4
%define		WNOWAIT		0x01000000
%define		__WNOTHREAD     0x20000000
%define         __WALL          0x40000000
%define         __WCLONE        0x80000000

struc sysinfo
                .uptime:        resd 1
                .loads:         resd 3
                .totalram:      resd 1
                .freeram:       resd 1
                .sharedram:     resd 1
                .bufferram:     resd 1
                .totalswap:     resd 1
                .freeswap:      resd 1
                .procs:         resw 1
                .totalhigh:     resd 1
                .freehigh:      resd 1
                .mem_unit:      resd 1
		._f:            resb 8  ; dopelnienie?
endstruc

%define         CSIGNAL         0x000000ff
%define         CLONE_VM        0x00000100
%define         CLONE_FS        0x00000200
%define         CLONE_FILES     0x00000400
%define         CLONE_SIGHAND   0x00000800
%define         CLONE_PID       0x00001000
%define         CLONE_PTRACE    0x00002000
%define         CLONE_VFORK     0x00004000
%define         CLONE_PARENT    0x00008000
%define         CLONE_THREAD    0x00010000
%define         CLONE_NEWNS     0x00020000
%define         CLONE_SIGNAL    (CLONE_SIGHAND | CLONE_THREAD)

%define _UTSNAME_LENGTH 65

struc utsname
                .sysname:       resb _UTSNAME_LENGTH
                .nodename:      resb _UTSNAME_LENGTH
                .release:       resb _UTSNAME_LENGTH
                .version:       resb _UTSNAME_LENGTH
                .machine:       resb _UTSNAME_LENGTH
                .domainname:    resb _UTSNAME_LENGTH
endstruc

struc timex
                .modes:         resd 1
                .offset:        resd 1
                .frequency:     resd 1
                .maxerror:      resd 1
                .esterror:      resd 1
                .status:        resd 1
                .constant:      resd 1
                .precision:     resd 1
                .tolerance:     resd 1
                .time:          resb timeval_size
                .tick:          resd 1
endstruc


%define         ADJ_OFFSET              0x0001
%define         ADJ_FREQUENCY           0x0002
%define         ADJ_MAXERROR            0x0004
%define         ADJ_ESTERROR            0x0008
%define         ADJ_STATUS              0x0010
%define         ADJ_TIMECONST           0x0020
%define         ADJ_TICK                0x4000
%define         ADJ_OFFSET_SINGLESHOT   0x8001

%define         TIME_OK         0
%define         TIME_INS        1
%define         TIME_DEL        2
%define         TIME_OOP        3
%define         TIME_WAIT       4
%define         TIME_BAD        5

%define         SIG_BLOCK       0
%define         SIG_UNBLOCK     1
%define         SIG_SETMASK     2


struc kernel_sym
                .value:         resd 1
                .name:          resb 60
endstruc

%define         Q_QUOTAON       0x0100  ; 0x800002
%define         Q_QUOTAOFF      0x0200  ; 0x800003
%define         Q_GETQUOTA      0x0300  ; 0x800007
%define         Q_SETQUOTA      0x0400  ; 0x800008
%define         Q_SETUSE        0x0500
%define         Q_SYNC          0x0600  ; 0x800001
%define         Q_SETQLIM       0x0700
%define         Q_GETSTATS      0x0800
%define         Q_GETINFO       0x800005
%define         Q_SETINFO       0x800006
;%define         Q_SETGRACE      0x800002
;%define         Q_SETFLAGS      0x800002

struc mem_dqblk
                .dqb_bhardlimit:        resd 1
                .dqb_bsoftlimit:        resd 1
                .dqb_curspace:          resq 1
                .dqb_ihardlimit:        resd 1
                .dqb_isoftlimit:        resd 1
                .dqb_curinodes:         resd 1
                .dqb_btime:             resd 1
                .dqb_itime:             resd 1
endstruc


struc dqstats
                .lookups:               resd 1
                .drops:                 resd 1
                .reads:                 resd 1
                .writes:                resd 1
                .cache_hits:            resd 1
                .allocated_dquots:      resd 1
                .free_dquots:           resd 1
                .syncs:                 resd 1
endstruc

%define         LOCK_SH         1
%define         LOCK_EX         2
%define		LOCK_NB		4
%define         LOCK_UN         8

struc timespec
                .tv_sec:	resd 1
                .tv_nsec:	resd 1
endstruc

%define		MS_ASYNC	1
%define		MS_INVALIDATE	2
%define		MS_SYNC		4

struc iovec
		.iov_base:		resd 1
		.iov_len:		resd 1
endstruc

struc __sysctl_args
		.name:			resd 1
		.nlen:			resd 1
		.oldval:		resd 1
		.oldlenp:		resd 1
		.newval:		resd 1
		.newlen:		resd 1
endstruc

%define		MCL_CURRENT	1
%define		MCL_FUTURE	2

struc sched_param
		.__sched_priority:	resd 1
endstruc

%define		SCHED_OTHER	0
%define		SCHED_FIFO	1
%define		SCHED_RR	2

%define		MREMAP_MAYMOVE	1
%define		MREMAP_FIXED	2

%define		VM86_PLUS_INSTALL_CHECK		0
%define		VM86_ENTER			1
%define		VM86_ENTER_NO_BYPASS		2
%define		VM86_REQUEST_IRQ		3
%define		VM86_FREE_IRQ			4
%define		VM86_GET_IRQ_BITS		5
%define		VM86_GET_AND_RESET_IRQ		6

%define		QM_MODULES	1
%define		QM_DEPS		2
%define		QM_REFS		3
%define		QM_SYMBOLS	4
%define		QM_INFO		5

struc module_symbol
		.value:		resd 1
		.name:		resd 1;	/* adres lancucha znakow od poczatku bufora */
endstruc

struc module_info
		.address:	resd 1;	/* adres modulu */
		.size:		resd 1;	/* zajmowana pamiec */
		.flags:		resd 1;	/* stan: MOD_RUNNING,  MOD_AUTOCLEAN, ... */
endstruc

struc pollfd
		.fd:		resd 1;	/* deskryptor otwartego pliku */
		.events:	resw 1;	/* maska zdarzen (patrz nizej) do monitorowania */
		.revents:	resw 1;	/* powrotna maska zdarzen (patrz nizej) znalezionych */
endstruc

%define		POLLIN		0x0001
%define		POLLRDNORM	0x0040
%define		POLLRDBAND	0x0080
%define		POLLNORM	POLLRDNORM
%define		POLLPRI		0x0002
%define		POLLOUT		0x0004
%define		POLLWRNORM	POLLOUT
%define		POLLWRBAND	0x0100
%define		POLLERR		0x0008
%define		POLLHUP		0x0010
%define		POLLNVAL	0x0020

%define		NFSCTL_SVC		0
%define		NFSCTL_ADDCLIENT	1
%define		NFSCTL_DELCLIENT	2
%define		NFSCTL_EXPORT		3
%define		NFSCTL_UNEXPORT		4
%define		NFSCTL_UGIDUPDATE	5
%define		NFSCTL_GETFH		6
%define		NFSCTL_GETFD		7
%define		NFSCTL_GETFS		8
%define		NFSCTL_FODROP		50
%define		NFSCTL_STOPFODROP	51
%define		NFSCTL_FOLOCKS		52
%define		NFSCTL_FOGRACE		53
%define		NFSCTL_FOSERV		54

%define		PR_SET_PDEATHSIG	1
%define		PR_GET_PDEATHSIG	2
%define		PR_GET_DUMPABLE		3
%define		PR_SET_DUMPABLE		4
%define		PR_GET_UNALIGN		5
%define		PR_SET_UNALIGN		6
%define		PR_GET_KEEPCAPS		7
%define		PR_SET_KEEPCAPS		8
%define		PR_GET_FPEMU		9
%define		PR_SET_FPEMU		10
%define		PR_GET_FPEXC		11
%define		PR_SET_FPEXC		12
%define		PR_GET_TIMING		13
%define		PR_SET_TIMING		14

struc __user_cap_header_struct

		.version:	resd 1
		.pid:		resd 1
endstruc

struc __user_cap_data_struct

	        .effective:	resd 1
	        .permitted:	resd 1
	        .inheritable:	resd 1
endstruc

struc sigaltstack

		.ss_sp:		resd 1;		// int (dword)
		.ss_flags:	resd 1;		// int (dword), SS_ONSTACK or SS_DISABLE
		.ss_size:	resd 1;		// int (dword)
endstruc

%define		STAT64_HAS_BROKEN_ST_INO	1

struc stat64

		.st_dev:	resw 1
		.__pad0:	resb 10

		.__st_ino:	resd 1

		.st_mode:	resd 1
		.st_nlink:	resd 1

		.st_uid:	resd 1
		.st_gid:	resd 1

		.st_rdev:	resw 1
		.__pad3:	resb 10

		.st_size:	resq 1
		.st_blksize:	resd 1

		.st_blocks:	resd 1;	/* Number 512-byte blocks allocated. */
		.__pad4:	resd 1;		/* future possible st_blocks high bits */

		.st_atime:	resd 1
		.__pad5:	resd 1

		.st_mtime:	resd 1
		.__pad6:	resd 1

		.st_ctime:	resd 1
		.__pad7:	resd 1;		/* will be high 32 bits of ctime someday */

		.st_ino:	resq 1
endstruc

%define		MADV_NORMAL		0
%define		MADV_RANDOM		1
%define		MADV_SEQUENTIAL		2
%define		MADV_WILLNEED		3
%define		MADV_DONTNEED		4

%define		SIGHUP		1
%define		SIGINT		2
%define		SIGQUIT		3
%define		SIGILL		4
%define		SIGTRAP		5
%define		SIGABRT		6
%define		SIGIOT		6	; tak, tez
%define		SIGBUS		7
%define		SIGFPE		8
%define		SIGKILL		9
%define		SIGUSR1		10
%define		SIGSEGV		11
%define		SIGUSR2		12
%define		SIGPIPE		13
%define		SIGALRM		14
%define		SIGTERM		15
%define		SIGSTKFLT	16
%define		SIGCHLD		17
%define		SIGCLD		SIGCHLD
%define		SIGCONT		18
%define		SIGSTOP		19
%define		SIGTSTP		20
%define		SIGTTIN		21
%define		SIGTTOU		22
%define		SIGURG		23
%define		SIGXCPU		24
%define		SIGXFSZ		25
%define		SIGVTALRM	26
%define		SIGPROF		27
%define		SIGWINCH	28
%define		SIGPOLL		29
%define		SIGIO		SIGPOLL
%define		SIGPWR		30
%define		SIGSYS		31
%define		SIGUNUSED	31	; tak, tez

%define		FUTEX_WAIT	0
%define		FUTEX_WAKE	1
%define		FUTEX_FD	2

struc io_event

		.data:		resq 1;		/* pole danych */
		.obj:		resq 1;		/* skad przyszlo zdarzenie */
		.res:		resq 1;		/* kod wynikowy zdarzenia */
		.res2:		resq 1;		/* wynik drugorzedny */
endstruc

struc iocb

		.aio_data:		resq 1
		.aio_key:		resd 1
		.aio_reserved1:		resd 1

		.aio_lio_opcode:	resw 1
		.aio_reqprio:		resw 1
		.aio_fildes:		resd 1

		.aio_buf:		resq 1
		.aio_nbytes:		resq 1
		.aio_offset:		resq 1

		.aio_reserved2:		resq 1
		.aio_reserved3:		resq 1
endstruc

%define		EPOLL_CTL_ADD	1
%define		EPOLL_CTL_DEL	2
%define		EPOLL_CTL_MOD	3

%define		CLOCK_REALTIME			0
%define		CLOCK_MONOTONIC			1
%define		CLOCK_PROCESS_CPUTIME_ID	2
%define		CLOCK_THREAD_CPUTIME_ID		3

%define		MPOL_DEFAULT	0
%define		MPOL_PREFERRED	1
%define		MPOL_BIND	2
%define		MPOL_INTERLEAVE	3

%define		MPOL_MF_STRICT		1
%define		MPOL_MF_MOVE		2
%define		MPOL_MF_MOVE_ALL	4

struc mq_attr

		.mq_flags:	resd 1;     /* Flagi: 0 lub O_NONBLOCK */
		.mq_maxmsg:	resd 1;     /* Max. liczba wiadomosci w kolejce */
		.mq_msgsize:	resd 1;     /* Max. rozmiar wiadomosci w bajtach */
		.mq_curmsgs:	resd 1;     /* Liczba wiadomosci aktualnie w kolejce */
endstruc

%define		IN_ACCESS	 0x00000001
%define		IN_MODIFY	 0x00000002
%define		IN_ATTRIB	 0x00000004
%define		IN_CLOSE_WRITE	 0x00000008
%define		IN_CLOSE_NOWRITE 0x00000010
%define		IN_OPEN		 0x00000020
%define		IN_MOVED_FROM	 0x00000040
%define		IN_MOVED_TO	 0x00000080
%define		IN_CREATE	 0x00000100
%define		IN_DELETE	 0x00000200
%define		IN_DELETE_SELF	 0x00000400
%define		IN_MOVE_SELF	 0x00000800
%define		IN_UNMOUNT	 0x00002000
%define		IN_Q_OVERFLOW	 0x00004000
%define		IN_IGNORED	 0x00008000
%define		IN_ONLYDIR	 0x01000000
%define		IN_DONT_FOLLOW	 0x02000000
%define		IN_MASK_ADD	 0x20000000
%define		IN_ISDIR	 0x40000000
%define		IN_ONESHOT	 0x80000000

%define		SIG_DFL		0
%define		SIG_IGN		1

%define		TIMER_ABSTIME	1
%define		MPOL_F_ADDR	2

%define		AT_SYMLINK_NOFOLLOW	0x100
%define		AT_REMOVEDIR		0x200
%define		AT_EACCESS		0x200
%define		AT_FDCWD		-100

%define		FALLOC_FL_KEEP_SIZE	1

%define		IOPRIO_WHO_PROCESS	0
%define		IOPRIO_WHO_PGRP		1
%define		IOPRIO_WHO_USER		2

%define		SYNC_FILE_RANGE_WAIT_BEFORE	1
%define		SYNC_FILE_RANGE_WRITE		2
%define		SYNC_FILE_RANGE_WAIT_AFTER	4

%define		SIG_BLOCK	0
%define		SIG_UNBLOCK	1
%define		SIG_SETMASK	2

%define		POSIX_FADV_NORMAL	0
%define		POSIX_FADV_RANDOM	1
%define		POSIX_FADV_SEQUENTIAL	2
%define		POSIX_FADV_WILLNEED	3
%define         POSIX_FADV_DONTNEED	4
%define		POSIX_FADV_NOREUSE	5

%define		SPLICE_F_MOVE		1
%define		SPLICE_F_NONBLOCK	2
%define		SPLICE_F_MORE		4
%define		SPLICE_F_GIFT		8

struc getcpu_cache

		.blob:		resd 32

endstruc

struc epoll_event

		.events:	resd 1;  /* zdarzenia Epoll */
		.data:		resq 1;  /* Zmienna danych uzytkownika */

endstruc

%define		TFD_NONBLOCK		4000o
%define		TFD_CLOEXEC		2000000o
%define		TFD_TIMER_ABSTIME	1

struc itimerspec

		.it_interval:	resb timespec_size
		.it_value:	resb timespec_size

endstruc

%define		SFD_NONBLOCK		4000o
%define		SFD_CLOEXEC		2000000o

%define		EFD_NONBLOCK		4000o
%define		EFD_CLOEXEC		2000000o

%define		EPOLL_CLOEXEC		2000000o

%define		O_CLOEXEC		2000000o

%define		IN_NONBLOCK		4000o
%define		IN_CLOEXEC		2000000o

struc robust_list
	        .next:		resd 1
endstruc

struc robust_list_head

		.list:			resb robust_list_size
		.futex_offset:		resd 1
		.list_op_pending:	resd 1

endstruc

%idefine KEYCTL_GET_KEYRING_ID           0
%idefine KEYCTL_JOIN_SESSION_KEYRING     1
%idefine KEYCTL_UPDATE                   2
%idefine KEYCTL_REVOKE                   3
%idefine KEYCTL_CHOWN                    4
%idefine KEYCTL_SETPERM                  5
%idefine KEYCTL_DESCRIBE                 6
%idefine KEYCTL_CLEAR                    7
%idefine KEYCTL_LINK                     8
%idefine KEYCTL_UNLINK                   9
%idefine KEYCTL_SEARCH                   10
%idefine KEYCTL_READ                     11
%idefine KEYCTL_INSTANTIATE              12
%idefine KEYCTL_NEGATE                   13
%idefine KEYCTL_SET_REQKEY_KEYRING       14
%idefine KEYCTL_SET_TIMEOUT              15
%idefine KEYCTL_ASSUME_AUTHORITY         16
%idefine KEYCTL_GET_SECURITY             17

;/* special process keyring shortcut IDs */
%idefine KEY_SPEC_THREAD_KEYRING         -1
%idefine KEY_SPEC_PROCESS_KEYRING        -2
%idefine KEY_SPEC_SESSION_KEYRING        -3
%idefine KEY_SPEC_USER_KEYRING           -4
%idefine KEY_SPEC_USER_SESSION_KEYRING   -5
%idefine KEY_SPEC_GROUP_KEYRING          -6
%idefine KEY_SPEC_REQKEY_AUTH_KEY        -7
%idefine KEY_SPEC_REQUESTOR_KEYRING      -8

;/* request-key default keyrings */
%idefine KEY_REQKEY_DEFL_NO_CHANGE               -1
%idefine KEY_REQKEY_DEFL_DEFAULT                 0
%idefine KEY_REQKEY_DEFL_THREAD_KEYRING          1
%idefine KEY_REQKEY_DEFL_PROCESS_KEYRING         2
%idefine KEY_REQKEY_DEFL_SESSION_KEYRING         3
%idefine KEY_REQKEY_DEFL_USER_KEYRING            4
%idefine KEY_REQKEY_DEFL_USER_SESSION_KEYRING    5
%idefine KEY_REQKEY_DEFL_GROUP_KEYRING           6
%idefine KEY_REQKEY_DEFL_REQUESTOR_KEYRING       7

struc kexec_segment

		.buf:		resd 1;        /* bufor w przestrzeni uzytkownika */
		.bufsz:		resd 1;        /* dlugosc bufora w przestrzeni uzytkownika */
		.mem:		resd 1;        /* fizyczny adres jadra */
		.memsz:		resd 1;        /* dlugosc fizycznego adresu */

endstruc

%idefine KEXEC_ON_CRASH          0x00000001
%idefine KEXEC_PRESERVE_CONTEXT  0x00000002

%idefine KEXEC_ARCH_DEFAULT ( 0 << 16)
%idefine KEXEC_ARCH_386     ( 3 << 16)
%idefine KEXEC_ARCH_X86_64  (62 << 16)
%idefine KEXEC_ARCH_PPC     (20 << 16)
%idefine KEXEC_ARCH_PPC64   (21 << 16)
%idefine KEXEC_ARCH_IA_64   (50 << 16)
%idefine KEXEC_ARCH_ARM     (40 << 16)
%idefine KEXEC_ARCH_S390    (22 << 16)
%idefine KEXEC_ARCH_SH      (42 << 16)
%idefine KEXEC_ARCH_MIPS_LE (10 << 16)
%idefine KEXEC_ARCH_MIPS    ( 8 << 16)

%idefine MSG_WAITFORONE 0x10000

struc msghdr

		.msg_name:		resd 1;       /* opcjonalny adres */
		.msg_namelen:		resd 1;    /* rozmiar adresu */
		.msg_iov:		resd 1;        /* tablica wysylania i zbierania */
		.msg_iovlen:		resd 1;     /* liczba elementow w msg_iov */
		.msg_control:		resd 1;    /* dane pomocnicze */
		.msg_controllen:	resd 1; /* dlugosc bufora danych pomocniczych */
		.msg_flags:		resd 1	;      /* flagi na odebranej
						;		 wiadomosci: MSG_EOR,
						;		 MSG_TRUNC, MSG_CTRUNC,
						;		 MSG_OOB, MSG_ERRQUEUE*/
endstruc

struc mmsghdr

		.msg_hdr:	resb msghdr_size;  /* Naglowek wiadomosci */
		.msg_len:	resd 1;  /* Liczba otrzymanych bajtow naglowka */

endstruc

%idefine CLONE_NEWIPC 0x08000000
%idefine CLONE_NEWNET 0x40000000
%idefine CLONE_NEWUTS 0x04000000

%idefine IPC_CREAT     00001000o
%idefine IPC_EXCL      00002000o
%idefine IPC_RMID      0
%idefine IPC_SET       1
%idefine IPC_STAT      2
%idefine IPC_INFO      3
%idefine IPC_NOWAIT    04000o


%idefine SHM_HUGETLB   04000o
%idefine SHM_NORESERVE 010000o
%idefine SHM_RDONLY    010000o
%idefine SHM_RND       020000o
%idefine SHM_REMAP     040000o
%idefine SHM_LOCK      11
%idefine SHM_UNLOCK    12
%idefine SHM_STAT      13
%idefine SHM_INFO      14

%idefine AF_UNIX       1
%idefine AF_LOCAL      1
%idefine AF_INET       2
%idefine AF_AX25       3
%idefine AF_IPX        4
%idefine AF_APPLETALK  5
%idefine AF_NETROM     6
%idefine AF_BRIDGE     7
%idefine AF_ATMPVC     8
%idefine AF_X25        9
%idefine AF_INET6      10
%idefine AF_ROSE       11
%idefine AF_DECnet     12
%idefine AF_NETBEUI    13
%idefine AF_SECURITY   14
%idefine AF_KEY        15
%idefine AF_NETLINK    16
%idefine AF_PACKET     17
%idefine AF_ASH        18
%idefine AF_ECONET     19
%idefine AF_ATMSVC     20
%idefine AF_SNA        22
%idefine AF_IRDA       23
%idefine AF_PPPOX      24
%idefine AF_WANPIPE    25
%idefine AF_BLUETOOTH  31

%idefine SOCK_STREAM    1
%idefine SOCK_DGRAM     2
%idefine SOCK_RAW       3
%idefine SOCK_RDM       4
%idefine SOCK_SEQPACKET 5
%idefine SOCK_PACKET    10
%idefine SOCK_NONBLOCK  04000o
%idefine SOCK_CLOEXEC   02000000o

%idefine MSG_CONFIRM      0x800
%idefine MSG_DONTROUTE    0x04
%idefine MSG_DONTWAIT     0x40
%idefine MSG_EOR          0x80
%idefine MSG_MORE         0x8000
%idefine MSG_NOSIGNAL     0x4000
%idefine MSG_OOB          0x01
%idefine MSG_CMSG_CLOEXEC 0x40000000
%idefine MSG_ERRQUEUE     0x2000
%idefine MSG_PEEK         0x02
%idefine MSG_TRUNC        0x20
%idefine MSG_WAITALL      0x100

struc sembuf

		.sem_num:	resw 1;   /* liczba semaforow */
		.sem_op:	resw 1;             /* operacja na semaforze:
					;	 liczba dodatnia jest dodawana
					;	 zero oznacza czekanie na zero
					;	liczba ujemna jest odejmowana*/
		.sem_flg:	resw 1;            /* flaga operacji:
					;	 IPC_NOWAIT=04000 osemkowo
					;	 lub SEM_UNDO=0x1000 */
endstruc

%idefine GETPID   11
%idefine GETVAL   12
%idefine GETALL   13
%idefine GETNCNT  14
%idefine GETZCNT  15
%idefine SETVAL   16
%idefine SETALL   17
%idefine SEM_STAT 18
%idefine SEM_INFO 19

struc msgbuf

		.mtype:		resd 1;       /* typ wiadomosci, musi byc > 0 */
		.mtext:		resd 1;    /* dane wiadomosci */

endstruc

%idefine MSG_EXCEPT  020000o
%idefine MSG_NOERROR 010000o
%idefine MSG_STAT    11
%idefine MSG_INFO    12


struc ipc_perm

		.__key:		resd 1;       /* Klucz podany msgget */
		.uid:		resd 1;         /* Efektywny UID of wlasciciela */
		.gid:		resd 1;         /* Efektywny GID of wlasciciela */
		.cuid:		resd 1;        /* Efektywny UID of tworcy */
		.cgid:		resd 1;        /* Efektywny GID of tworcy */
		.mode:		resw 1;        /* Uprawnienia */
		.__seq:		resw 1;       /* Numer sekwencyjny */

endstruc

struc msqid_ds

		.msg_perm:		resb ipc_perm_size;     /* Wlasciciel i uprawnienia */
		.msg_stime:		resd 1;    /* Czas ostatniego msgsnd */
		.msg_rtime:		resd 1;    /* Czas ostatniego msgrcv */
		.msg_ctime:		resd 1;    /* Czas ostatniej zmiany */
		.__msg_cbytes:		resd 1; /* Aktualna liczba bajtow w kolejce */
		.msg_qnum:		resd 1;     /* Aktualna liczba wiadomosci w kolejce */
		.msg_qbytes:		resd 1;   /* Maksymalna liczba bajtow dozwolona w kolejce */
		.msg_lspid:		resd 1;    /* PID ostatniego msgsnd */
		.msg_lrpid:		resd 1;    /* PID ostatniego msgrcv */

endstruc

%idefine ARCH_SET_FS 0x1002
%idefine ARCH_GET_FS 0x1003
%idefine ARCH_SET_GS 0x1001
%idefine ARCH_GET_GS 0x1004

%idefine MODULE_INIT_IGNORE_MODVERSIONS	1
%idefine MODULE_INIT_IGNORE_VERMAGIC	2

struc sched_attr

		.size:			resd 1; /* Rozmiar tej struktury */
		.sched_policy:		resd 1; /* Polityka */
		.sched_flags:		resq 1; /* Flagi = 0 lub SCHED_FLAG_RESET_ON_FORK = 0x40000000 */
		.sched_nice:		resd 1; /* Wartosc priorytetu */
		.sched_priority:	resd 1; /* Statyczny priorytet */
		;/* Pozostale pola sa dla SCHED_DEADLINE */
		.sched_runtime:		resq 1;
		.sched_deadline:	resq 1;
		.sched_period:		resq 1;

endstruc

%idefine RENAME_EXCHANGE	(1 << 1)
%idefine RENAME_NOREPLACE	(1 << 0)
%idefine RENAME_WHITEOUT	(1 << 2)

struc sock_fprog

		.len:			resw 1; /* Liczba instrukcji BPF */
		.filter:		resd 1; /* Adres tablicy instrukcji BPF */

endstruc


struc sock_filter

		.code:			resw 1
		.jt:			resb 1
		.jf:			resb 1
		.k:			resd 1

endstruc

struc seccomp_data

		.nr:			resd 1;  /* Numer funkcji systemowej */
		.arch:			resd 1;  /* wartosc AUDIT_ARCH_* */
		.instruction_pointer:	resq 1;  /* wskaznik instrukcji CPU - IP/EIP/RIP */
		.args:			resq 6;  /* Do 6 parametrow funkcji systemowej */

endstruc

%idefine GRND_RANDOM			0x0002
%idefine GRND_NONBLOCK			0x0001

%idefine MFD_CLOEXEC			0x0001
%idefine MFD_ALLOW_SEALING		0x0002

%idefine BPF_MAP_CREATE			0
%idefine BPF_MAP_LOOKUP_ELEM		1
%idefine BPF_MAP_UPDATE_ELEM		2
%idefine BPF_MAP_DELETE_ELEM		3
%idefine BPF_MAP_GET_NEXT_KEY		4
%idefine BPF_PROG_LOAD			5

%idefine AT_EMPTY_PATH			0x1000

%idefine MEMBARRIER_CMD_QUERY		0
%idefine MEMBARRIER_CMD_SHARED		1

%idefine MLOCK_ONFAULT			0x01

%idefine RWF_HIPRI			0x00000001

%idefine FAN_CLASS_PRE_CONTENT		0x00000008
%idefine FAN_CLASS_CONTENT		0x00000004
%idefine FAN_CLASS_NOTIF		0x00000000
%idefine FAN_CLOEXEC			0x00000001
%idefine FAN_NONBLOCK			0x00000002
%idefine FAN_UNLIMITED_QUEUE		0x00000010
%idefine FAN_UNLIMITED_MARKS		0x00000020

%idefine FAN_MARK_ADD			0x00000001
%idefine FAN_MARK_REMOVE		0x00000002
%idefine FAN_MARK_FLUSH			0x00000080
%idefine FAN_MARK_DONT_FOLLOW		0x00000004
%idefine FAN_MARK_ONLYDIR		0x00000008
%idefine FAN_MARK_MOUNT			0x00000010
%idefine FAN_MARK_IGNORED_MASK		0x00000020
%idefine FAN_MARK_IGNORED_SURV_MODIFY	0x00000040

%idefine FAN_ACCESS			0x00000001
%idefine FAN_MODIFY			0x00000002
%idefine FAN_CLOSE_WRITE		0x00000008
%idefine FAN_CLOSE_NOWRITE		0x00000010
%idefine FAN_OPEN			0x00000020
%idefine FAN_OPEN_PERM			0x00010000
%idefine FAN_ACCESS_PERM		0x00020000
%idefine FAN_ONDIR			0x40000000
%idefine FAN_EVENT_ON_CHILD		0x08000000
%idefine FAN_CLOSE			(FAN_CLOSE_WRITE + FAN_CLOSE_NOWRITE)

struc file_handle

		.handle_bytes:			resd 1;   /* rozmiar f_handle */
		.handle_type:			resd 1;   /* typ uchwytu */
		.f_handle:			resb 1;   /* identyfikator pliku */

endstruc

%idefine KCMP_FILE			0
%idefine KCMP_FILES			2
%idefine KCMP_FS			3
%idefine KCMP_IO			5
%idefine KCMP_SIGHAND			4
%idefine KCMP_SYSVSEM			6
%idefine KCMP_VM			1

%idefine KEXEC_FILE_UNLOAD		0x00000001
%idefine KEXEC_FILE_ON_CRASH		0x00000002
%idefine KEXEC_FILE_NO_INITRAMFS	0x00000004


%endif		; __NASM_SYSTEM_LINUX
