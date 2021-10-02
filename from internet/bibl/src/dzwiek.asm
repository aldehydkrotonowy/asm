;;
;  Biblioteka Standardowa -
;  Emisja dzwieku przez glosniczek.
;  Wersja Linux: 2004-02-05
;  Ostatnia modyfikacja kodu: 2021-02-10
;  @author Bogdan 'bogdro' Drozdowski, bogdandr@op.pl (2002-09)
;;


; Copyright (C) 2002-2021 Bogdan 'bogdro' Drozdowski, bogdandr @ op . pl
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

global  _graj_dzwiek

%ifndef __DOS
 %error "Zdefiniuj '__DOS' na 1 albo 0, w zaleznosci od systemu."
%endif

%ifndef __BIOS
 %error "Zdefiniuj '__BIOS' na 1 albo 0, w zaleznosci od systemu."
%endif

%ifndef __LINUX
 %error "Zdefiniuj '__LINUX' na 1 albo 0, w zaleznosci od systemu."
%endif

%ifndef __BSD
 %error "Zdefiniuj '__BSD' na 1 albo 0, w zaleznosci od systemu."
%endif

%if ( (__DOS > 0) || (__BIOS > 0) ) && ( (__LINUX > 0) || (__BSD > 0) )
 %error "Zdefiniuj albo '__DOS' i/lub '__BIOS' na 1, albo '__LINUX' i/lub '__BSD' na 1, nie wszystkie."
%endif

%include "wewnetrz.inc"

%if (__LINUX > 0) || (__BSD > 0)

 KIOCSOUND       equ     0x4B2F

; **************************************

 section         .data

 konsola		db	"/dev/console", 0


 t1 istruc timespec
 t2 istruc timespec
; **************************************

 section		.text

 %include	"../incl/linuxbsd/nasm/n_system.inc"
%else
 %if (__COFF == 0)
  segment         biblioteka_dzwiek
 %else
  segment         .text
 %endif

%endif


;;
; Wytwarza dzwiek w glosniczku. Makro: "graj".
; @param BX = zadana czestotliwosc dzwieku w Hz, co najmniej 19
; @param CX:DX = czas trwania dzwieku w mikrosekundach
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu (BX za maly)
;;
_graj_dzwiek:

%if (__DOS > 0) || (__BIOS > 0)
czasomierz	equ	40h		; numer portu programowalnego
					; czasomierza

klawiatura	equ	60h		; numer portu kontrolera klawiatury

	pushf
	push	ax
	push	dx
	push	si


	cmp	bx, 19			; najnizsza mozliwa czestotliwosc
					; to ok. 18,2 Hz
	jb	._graj_blad


	in	al, klawiatura+1	; port B kontrolera klawiatury
	or  	al, 3			; ustawiamy bity: 0 i 1 - wlaczamy
					; glosnik i bramke od licznika nr. 2
					; czasomierza do glosnika

	out 	klawiatura+1, al



	mov	si, dx			; zachowujemy DX

	mov	dx, 12h
	mov	ax, 34ddh
	div	bx			; AX = 1193181 / czestotliwosc,
					; DX=reszta

	mov	dl, al			; zachowujemy mlodszy bajt dzielnika
					; czestotliwosci



	mov	al, 0b6h

	out	czasomierz+3, al	; wysylamy komende:
					; (bity 7-6) wybieramy licznik nr. 2,
					; (bity 5-4) bedziemy pisac najpierw
					; bity 0-7, potem bity 8-15
					; (bity 3-1) tryb 3: generator fali
					; kwadratowej
					; (bit 0)    licznik binarny 16-bitowy

	mov	al, dl			; odzyskujemy mlodszy bajt
	out	czasomierz+2, al	; port licznika nr. 2 i bity 0-7
					; dzielnika czestotliwosci

	mov	al, ah
	out	czasomierz+2, al	; bity 8-15

	mov	dx,si			; odzyskujemy DX


._graj_pauza:
	mov	ah,86h
	int	15h			; pauza o dlugosci CX:DX mikrosekund

	jnc	._graj_juz
	dec	dx
	sbb	cx, 0			; w razie bledu zmniejszamy CX:DX
	jmp	short ._graj_pauza

._graj_juz:

	in	al, klawiatura+1
	and	al, ~3			; zerujemy bity: 0 i 1 - wylaczamy
					; glosnik i bramke

	out	klawiatura+1, al

	pop	si
	pop	dx
	pop	ax
	popf
	clc				; zwroc brak bledu

	bibl_ret


._graj_blad:
	pop	si
	pop	dx
	pop	ax
	popf
	stc				; zwroc blad

	bibl_ret

%else	; Linux
	push_f
	push	rej(ax)
	push	rej(bx)
	push	rej(cx)
	push	rej(dx)
	push	rej(si)

	cmp     bx, 19	;  najnizsza mozliwa czestotliwosc to ok. 18,2 Hz
	jb      ._graj_blad

	push	rej(cx)
	push	rej(dx)
	push	rej(bx)

%if (__KOD_64BIT > 0)
	mov     rax, sys64_open	; otwieramy konsole do zapisu
%else
	mov     eax, sys_open	; otwieramy konsole do zapisu
%endif
	mov     ebx, konsola
	mov     ecx, O_WRONLY
	;mov     edx, 600q
	mov     edx, 200q
	push	rej(dx)
	push	rej(cx)
	push	rej(bx)
	call	jadro
 %if (__KOD_64BIT > 0)
	add	rsp, 3*8
 %else
	add	esp, 3*4
 %endif

        cmp     rej(ax), 0
        jg      .otw_ok

        mov     rej(ax), 1  ;  jak nie otworzylismy konsoli, piszemy na stdout
.otw_ok:
        mov     rej(bx), rej(ax)	; xBX = uchwyt do pliku
	mov	rej(si), rej(ax)	; xSI = uchwyt do pliku

%if (__KOD_64BIT > 0)
	mov     rax, sys64_ioctl
%else
	mov     eax, sys_ioctl	;  sys_ioctl = 54
%endif
	mov     ecx, KIOCSOUND
	xor     edx, edx	;  wylaczenie ewentualnych dzwiekow
	push	rej(dx)
	push	rej(cx)
	push	rej(bx)
	call	jadro
 %if (__KOD_64BIT > 0)
	add	rsp, 3*8
 %else
	add	esp, 3*4
 %endif

	pop	rej(bx)		; BX = czestotliwosc
	mov	eax, 1234ddh
	xor	edx, edx
	div	ebx		; EAX = 1234DD/EBX - ta liczba idzie do ioctl

	mov     edx, eax
	mov	rej(bx), rej(si)	; xBX = uchwyt do konsoli/stdout
	mov     ecx, KIOCSOUND
%if (__KOD_64BIT > 0)
	mov     rax, sys64_ioctl
%else
	mov     eax, sys_ioctl
%endif
	push	rej(dx)
	push	rej(cx)
	push	rej(bx)
	call	jadro
 %if (__KOD_64BIT > 0)
	add	rsp, 3*8
 %else
	add	esp, 3*4
 %endif

	pop	rej(dx)
	pop	rej(cx)

			;  pauza o dlugosci CX:DX mikrosekund
	mov	eax, ecx
	shl	eax, 16
	mov	ebx, 1000000
	mov	ax, dx		; EAX = CX:DX
	xor	edx, edx
	div     ebx
	mov     [t1+timespec.tv_sec], eax ;  EAX = ilosc sekund

	mov     ebx, 1000
	mov     eax, edx
	mul     ebx
	mov     [t1+timespec.tv_nsec], eax ;  EAX = ilosc nanosekund

%if (__KOD_64BIT > 0)
	mov     rax, sys64_nanosleep
%else
	mov     eax, sys_nanosleep
%endif
	mov     rej(bx), t1
	mov     rej(cx), t2
	push	rej(cx)
	push	rej(bx)
	call	jadro		;  robimy przerwe...
 %if (__KOD_64BIT > 0)
	add	rsp, 2*8
 %else
	add	esp, 2*4
 %endif

%if (__KOD_64BIT > 0)
	mov     rax, sys64_ioctl
%else
	mov     eax, sys_ioctl
%endif
	mov	rej(bx), rej(si)	; EBX = uchwyt do konsoli/stdout
	mov	ecx, KIOCSOUND
	xor	edx, edx	;   wylaczamy dzwiek
	push	rej(dx)
	push	rej(cx)
	push	rej(bx)
	call	jadro
 %if (__KOD_64BIT > 0)
	add	rsp, 3*8
 %else
	add	esp, 3*4
 %endif

	cmp	esi, 2		;  nie zamykamy stdout
	jbe	._graj_koniec

%if (__KOD_64BIT > 0)
        mov	rax, sys64_close
%else
        mov	eax, sys_close  ; sys_close = 6
%endif
	mov	rej(bx), rej(si)	; xBX = uchwyt do konsoli/stdout
        push	rej(si)
        call	jadro
 %if (__KOD_64BIT > 0)
	add	rsp, 1*8
 %else
	add	esp, 1*4
 %endif

._graj_koniec:
	pop	rej(si)
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(bx)
	pop	rej(ax)
	pop_f
	clc		;  zwroc brak bledu

	bibl_ret


._graj_blad:
	pop	rej(si)
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(bx)
	pop	rej(ax)

	pop_f
	stc		;  zwroc blad

	bibl_ret

; dla *BSD:
jadro:
%if (__KOD_64BIT > 0)
	push	rdi
	push	rsi
	push	rdx
	movsx	rax, eax
	movsx	rdi, ebx
	movsx	rsi, ecx
	movsx	rdx, edx
	call	jadro64
	pop	rdx
	pop	rsi
	pop	rdi
	ret
jadro64:
	syscall
%else
	int	80h
%endif
	ret
%endif
