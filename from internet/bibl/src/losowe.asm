;;
; Biblioteka Standardowa -
; Generatory liczb pseudolosowych.
; Wersja NASM: 2003-11-30
; Wersja Linux: 2004-02-06
; Ostatnia modyfikacja kodu: 2021-02-25
; @author Bogdan 'bogdro' Drozdowski, bogdandr@op.pl (2002-08)
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

global	_los_8
global	_los_8g
global	_los_8zg

global	_los_16
global	_los_16g
global	_los_16zg

global	_los_32
global	_los_32g
global	_los_32zg

global	_los_32e
global	_los_32eg
global	_los_32ezg

global	_los_64
global	_los_64g
global	_los_64zg

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

%if (__DOS > 0) || (__BIOS > 0)

 ; %include	"..\incl\dosbios\nasm\n_const.inc"
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 %if (__COFF == 0)
  segment         biblioteka_los
 %else
  segment         .text
 %endif
%else

 %include	"../incl/linuxbsd/nasm/n_const.inc"
 %include	"../incl/linuxbsd/nasm/n_system.inc"
 section         .data
%endif

; **************************************

nasionko	dd	24136857h
czy_nasionko	db	falsz		;czy uzywac istniejacego nasionka?

; **************************************

%if (__DOS > 0) || (__BIOS > 0)
_los_ustaw_seed:
	push	ax
	push	dx

 %if (__COFF == 0)
	push	es

	xor	dx, dx
	mov	es, dx
	mov	ax, [es:46ch]		; 40h:6ch = liczba taktow zegara od
					; polnocy ( 32bit )
	mov	dx, [es:46eh]

	pop	es
 %else
	push	cx

	mov	ah, 2ch
	int	21h			; pobierz czas systemowy. Zwraca:
					; CX=GG:MM, DX=SS:CC (setne sekundy)
	mov	ax, cx

	pop	cx
 %endif
	xor	ax, dx
	mov	word [nasionko], dx
	mov	word [nasionko+2], ax

	pop	dx
	pop	ax
	bibl_ret

%else
section		.text

_los_ustaw_seed:
	push	rej(ax)
	push	rej(bx)
	push	rej(cx)

	mov	eax, sys_time
	xor	ebx, ebx
	push	rej(bx)
	call	jadro
 %if (__KOD_64BIT > 0)
	add	rsp, 1*8
 %else
	add	esp, 1*4
 %endif
	mov	[nasionko], eax

	pop	rej(cx)
	pop	rej(bx)
	pop	rej(ax)
	bibl_ret

; dla *BSD:
jadro:
%if (__KOD_64BIT > 0)
	push	rdi
	push	rsi
	push	rdx
	mov	rax, sys64_time
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

; **************************************

;;
; Zwraca liczbe pseudo-losowa 0...255.
; Makro: losuj8
; @return AL - liczba pseudolosowa
;;
_los_8:
	pushf
	push	dx
	push	ax
%if (__KOD_16BIT > 0)
	push	ds
	push	es
%endif

	xor	dx, dx

%if (__KOD_16BIT > 0)
	mov	ax, biblioteka_los
	mov	ds, ax
%endif

	cmp	byte [czy_nasionko], prawda
	je	._8_dalej

	bibl_call	_los_ustaw_seed

	mov	byte [czy_nasionko], prawda

._8_dalej:

	mov	ax, [nasionko]
	mov	dx, [nasionko+2]
	xor	ax, 2345h
	or	dx, 9876h

	mul	dx

	or	ax, dx
	xor	dx, ax

	mov	[nasionko],ax
	mov	[nasionko+2],dx

	xor	al, ah
	or	al, dl
	xor	al, dh

%if (__KOD_16BIT > 0)
	pop	es
	pop	ds
%endif

	mov	dl, al
	pop	ax
	mov	al, dl
	pop	dx
	popf

	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa z przedzialu BL...CL (granice bez znaku).
; Makro: losuj8g
; @param BL - dolna granica przedzialu
; @param CL - gorna granica przedzialu
; @return AL - liczba pseudolosowa
;;
_los_8g:
	pushf
	push	bx
	push	cx

	cmp	bl, cl
	jne	._8g_spr
	mov	al, bl
	jmp	short ._8g_koniec

._8g_spr:
	jb	._8g_ok
	xchg	bl, cl

._8g_ok:
	bibl_call	_los_8

	cmp	al, bl
	jb	._8g_ok
	cmp	al, cl
	ja	._8g_ok

._8g_koniec:

	pop	cx
	pop	bx
	popf

	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa z przedzialu BL...CL (granice ze znakiem).
; Makro: losuj8zg
; @param BL - dolna granica przedzialu
; @param CL - gorna granica przedzialu
; @return AL - liczba pseudolosowa
;;
_los_8zg:
	pushf
	push	bx
	push	cx

	cmp	bl, cl
	jne	._8zg_spr
	mov	al, bl
	jmp	short ._8zg_koniec

._8zg_spr:
	jl	._8zg_ok
	xchg	bl, cl
._8zg_ok:
	bibl_call	_los_8

	cmp	al, bl
	jl	._8zg_ok
	cmp	al, cl
	jg	._8zg_ok

._8zg_koniec:

	pop	cx
	pop	bx
	popf

	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa 0-65535 (lub -32768...32767).
; Makro: losuj16
; @return AX - liczba pseudolosowa
;;
_los_16:
	pushf
	push	dx
%if (__KOD_16BIT > 0)
	push	ds
	push	es

	mov	ax, biblioteka_los
	mov	ds, ax
%endif

	xor	dx, dx

	cmp	byte [czy_nasionko], prawda
	je	._16_dalej

	bibl_call	_los_ustaw_seed

	mov	byte [czy_nasionko], prawda

._16_dalej:

	mov	ax, [nasionko]
	mov	dx, [nasionko+2]
	xor	ax, 2233h
	ror	dx, 1
	sbb	ax, dx
	or	dx, 1414h

	mul	dx

	or	ax, dx
	and	dx, ax
	rol	ax, 1

	mov	[nasionko], ax
	mov	[nasionko+2], dx

	sbb	dx, ax
	sbb	ax, dx
	xor	ax, dx

%if (__KOD_16BIT > 0)
	pop	es
	pop	ds
%endif

	pop	dx
	popf

	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa z przedzialu BX...CX (granice bez znaku).
; Makro: losuj16g
; @param BX - dolna granica przedzialu
; @param CX - gorna granica przedzialu
; @return AX - liczba pseudolosowa
;;
_los_16g:
	pushf
	push	bx
	push	cx

	cmp	bx, cx
	jne	._16g_spr
	mov	ax, bx
	jmp	short ._16g_koniec

._16g_spr:
	jb	._16g_ok
	xchg	bx, cx
._16g_ok:

	bibl_call	_los_16

	cmp	ax, bx
	jb	._16g_ok
	cmp	ax, cx
	ja	._16g_ok

._16g_koniec:

	pop	cx
	pop	bx
	popf

	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa z przedzialu BX...CX (granice ze znakiem).
; Makro: losuj16zg
; @param BX - dolna granica przedzialu
; @param CX - gorna granica przedzialu
; @return AX - liczba pseudolosowa
;;
_los_16zg:
	pushf
	push	bx
	push	cx

	cmp	bx, cx
	jne	._16zg_spr
	mov	ax, bx
	jmp	short ._16zg_koniec

._16zg_spr:
	jl	._16zg_ok
	xchg	bx, cx

._16zg_ok:

	bibl_call	_los_16

	cmp	ax, bx
	jl	._16zg_ok
	cmp	ax, cx
	jg	._16zg_ok

._16zg_koniec:

	pop	cx
	pop	bx
	popf

	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa 32-bit.
; Makro: losuj32
; @return DX:AX - liczba pseudolosowa
;;
_los_32:
	pushf
%if (__KOD_16BIT > 0)
	push	ds
	push	es

	mov	ax, biblioteka_los
	mov	ds, ax
%endif

	cmp	byte [czy_nasionko], prawda
	je	._32_dalej

	bibl_call	_los_ustaw_seed

	mov	ax, [nasionko]
	mov	dx, [nasionko+2]
	xor	ax, 8877h
	or	dx, 4455h
	mov	[nasionko], ax
	mov	[nasionko+2], dx

	mov	byte [czy_nasionko], prawda

._32_dalej:

	mov	ax, [nasionko]
	mov	dx, [nasionko+2]

	xor	ax, 2a8fh
	or	dx, 313h
%if (__DOS > 0) || (__BIOS > 0)
	rol	ax, 1
	rol	ax, 1
	rol	ax, 1
	rol	ax, 1
	rol	ax, 1
	rol	ax, 1
%else
	rol	ax, 6
%endif
	sub	ax, dx
%if (__DOS > 0) || (__BIOS > 0)
	ror	dx, 1
	ror	dx, 1
	ror	dx, 1
%else
	ror	dx, 3
%endif
	xor	ax, dx
	sub	dx, ax

	mul	dx

	or	ax, dx
	rol	ax, 1
	xor	dx, ax
	rcr	dx, 1

	mov	[nasionko], ax
	mov	[nasionko+2], dx

	ror	dx, 1

	adc	dx, ax
	xor	ax, dx
	sub	ax, dx

%if (__KOD_16BIT > 0)
	pop	es
	pop	ds
%endif

	popf

	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa z przedzialu BX:SI...CX:DI (granice bez znaku).
; Makro: losuj32g
; @param BX:SI - dolna granica przedzialu
; @param CX:DI - gorna granica przedzialu
; @return DX:AX - liczba pseudolosowa
;;
_los_32g:
	pushf
	push	bx
	push	cx
	push	di
	push	si


	cmp	bx, cx
	jne	._32g_spr
	cmp	si, di
	jne	._32g_spr2

	mov	ax, si
	mov	dx, bx
	jmp	short ._32g_koniec

._32g_spr:
	jb	._32g_ok1
	xchg	bx, cx			;jesli jestesmy tu, to przejdziemy
					; tez przez nastepne

	cmp	si, di
._32g_spr2:
	jb	._32g_ok1
	xchg	si, di

._32g_ok1:

	bibl_call	_los_32

	cmp	dx, bx
	je	._32g_spr_granice
	jb	._32g_ok1

	cmp	dx, cx
	je	._32g_spr_granice2
	ja	._32g_ok1

	jmp	short ._32g_koniec		;tutaj BX:SI < DX:AX < CX:DI

._32g_spr_granice:
	cmp	ax, si
	jb	._32g_ok1
	jmp	short ._32g_koniec

._32g_spr_granice2:
	cmp	ax, di
	ja	._32g_ok1


._32g_koniec:

	pop	si
	pop	di
	pop	cx
	pop	bx
	popf

	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa z przedzialu BX:SI...CX:DI (granice ze znakiem).
; Makro: losuj32zg
; @param BX:SI - dolna granica przedzialu
; @param CX:DI - gorna granica przedzialu
; @return DX:AX - liczba pseudolosowa
;;
_los_32zg:
	pushf
	push	bx
	push	cx
	push	di
	push	si


	cmp	bx, cx
	jne	._32zg_spr
	cmp	si, di
	jne	._32zg_spr2

	mov	ax, si
	mov	dx, bx
	jmp	short ._32zg_koniec

._32zg_spr:
	jl	._32zg_ok1
	xchg	bx, cx			; jesli jestesmy tu, to przejdziemy
					; tez przez nastepne

	cmp	si, di
._32zg_spr2:
	jl	._32zg_ok1
	xchg	si, di

._32zg_ok1:

	bibl_call	_los_32

	cmp	dx, bx
	je	._32zg_spr_granice
	jl	._32zg_ok1

	cmp	dx, cx
	je	._32zg_spr_granice2
	jg	._32zg_ok1

	jmp	short ._32zg_koniec		;tutaj BX:SI < DX:AX < CX:DI

._32zg_spr_granice:
	cmp	ax, si
	jl	._32zg_ok1
	jmp	short ._32zg_koniec

._32zg_spr_granice2:
	cmp	ax, di
	jg	._32zg_ok1


._32zg_koniec:

	pop	si
	pop	di
	pop	cx
	pop	bx
	popf

	bibl_ret


; **************************************

%if (__KOD_16BIT > 0)
 cpu 386
%endif

;;
; Zwraca liczbe pseudo-losowa 32-bit.
; Makro: losuj32e
; @return EAX - liczba pseudolosowa
;;
_los_32e:
	push_f
	push	rej(dx)
%if (__KOD_16BIT > 0)
	push	ds
	push	es
%endif

	xor	edx, edx

%if (__KOD_16BIT > 0)
	mov	ax, biblioteka_los
	mov	ds, ax
%endif

	cmp	byte [czy_nasionko], prawda
	je	._32e_dalej

	bibl_call	_los_ustaw_seed

	mov	eax, [nasionko]
	xor	eax, 99775533h
	mov	edx, eax
	rol	edx, 7

	mov	[nasionko], eax
	mov	byte [czy_nasionko], prawda

._32e_dalej:

	mov	eax, [nasionko]

	xor	eax, 871bf532h
	ror	eax, 5
	or	edx, 1a9a3b5bh
	add	eax, 1ba5c7ah
	ror	edx, 9
	and	eax, edx
	sbb	eax, edx
	rol	eax, 13
	and	edx, 5b6d14ch
	xor	eax, 6a42d0cfh

	mul	edx

	or	eax, edx
	ror	edx, 5
	xor	edx, eax
	rol	eax, 7

	mov	[nasionko], eax

	sbb	edx, eax
	xor	eax, edx
;	sub	eax, edx

%if (__KOD_16BIT > 0)
	pop	es
	pop	ds
%endif

	pop	rej(dx)
	pop_f

	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa z przedzialu EBX...ECX (granice bez znaku).
; Makro: losuj32eg
; @param EBX - dolna granica przedzialu
; @param ECX - gorna granica przedzialu
; @return EAX - liczba pseudolosowa
;;
_los_32eg:
	push_f
	push	rej(bx)
	push	rej(cx)

	cmp	ebx, ecx
	jne	._32eg_spr
	mov	eax, ebx
	jmp	short ._32eg_koniec

._32eg_spr:
	jb	._32eg_ok
	xchg	ebx, ecx

._32eg_ok:

	bibl_call	_los_32e

	cmp	eax, ebx
	jb	._32eg_ok
	cmp	eax, ecx
	ja	._32eg_ok

._32eg_koniec:

	pop	rej(cx)
	pop	rej(bx)
	pop_f

	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa z przedzialu EBX...ECX (granice ze znakiem).
; Makro: losuj32ezg
; @param EBX - dolna granica przedzialu
; @param ECX - gorna granica przedzialu
; @return EAX - liczba pseudolosowa
;;
_los_32ezg:
	push_f
	push	rej(bx)
	push	rej(cx)

	cmp	ebx, ecx
	jne	._32ezg_spr
	mov	eax, ebx
	jmp	short ._32ezg_koniec

._32ezg_spr:
	jl	._32ezg_ok
	xchg	ebx, ecx

._32ezg_ok:

	bibl_call	_los_32e

	cmp	eax, ebx
	jl	._32ezg_ok
	cmp	eax, ecx
	jg	._32ezg_ok

._32ezg_koniec:

	pop	rej(cx)
	pop	rej(bx)
	pop_f

	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa 64-bit.
; Makro: losuj64
; @return EDX:EAX - liczba pseudolosowa
;;
_los_64:
	push_f
%if (__KOD_16BIT > 0)
	push	ds
	push	es
%endif

	xor	edx, edx

%if (__KOD_16BIT > 0)
	mov	ax, biblioteka_los
	mov	ds, ax
%endif

	cmp	byte [czy_nasionko], prawda
	je	._64_dalej

	bibl_call	_los_ustaw_seed

	mov	eax, [nasionko]
	xor	eax, 0bd578421h
	mov	edx, eax
	rol	edx, 15

	mov	[nasionko], eax
	mov	byte [czy_nasionko], prawda

._64_dalej:

	mov	eax, [nasionko]
	xor	eax, 5a6d771ch
	ror	edx, 17
	rcl	eax, 6
	xor	edx, 7ab2c13fh
	and	eax, 69bc71eah

	and	eax, edx
	add	eax, 4ab129ch
	rol	eax, 11
	and	edx, 3a91d05bh
	sub	eax, edx

	mul	edx

;	and	eax, edx
	ror	edx, 9
	xor	edx, eax
	rol	eax, 4

	mov	[nasionko], eax

	sbb	eax, edx
	xor	eax, edx
	sub	eax, edx

%if (__KOD_16BIT > 0)
	pop	es
	pop	ds
%endif

	pop_f
	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa 64-bit z przedzialu EBX:ESI...ECX:EDI
;	(granice bez znaku).
; Makro: losuj64g
; @param EBX:ESI - dolna granica przedzialu
; @param ECX:EDI - gorna granica przedzialu
; @return EDX:EAX - liczba pseudolosowa
;;
_los_64g:
	push_f
	push	rej(bx)
	push	rej(cx)
	push	rej(di)
	push	rej(si)


	cmp	ebx, ecx
	jne	._64g_spr
	cmp	esi, edi
	jne	._64g_spr2

	mov	eax, esi
	mov	edx, ebx
	jmp	short ._64g_koniec

._64g_spr:
	jb	._64g_ok1
	xchg	ebx, ecx
	cmp	esi, edi

._64g_spr2:
	jb	._64g_ok1
	xchg	esi, edi

._64g_ok1:

	bibl_call	_los_64

	cmp	edx, ebx
	je	._64g_spr_granice
	jb	._64g_ok1

	cmp	edx, ecx
	je	._64g_spr_granice2
	ja	._64g_ok1

	jmp	short ._64g_koniec

._64g_spr_granice:
	cmp	eax, esi
	jb	._64g_ok1
	jmp	short ._64g_koniec

._64g_spr_granice2:
	cmp	eax, edi
	ja	._64g_ok1


._64g_koniec:

	pop	rej(si)
	pop	rej(di)
	pop	rej(cx)
	pop	rej(bx)
	pop_f

	bibl_ret


; **************************************

;;
; Zwraca liczbe pseudo-losowa 64-bit z przedzialu EBX:ESI...ECX:EDI
;	(granice ze znakiem).
; Makro: losuj64zg
; @param EBX:ESI - dolna granica przedzialu
; @param ECX:EDI - gorna granica przedzialu
; @return EDX:EAX - liczba pseudolosowa
;;
_los_64zg:
	push_f
	push	rej(bx)
	push	rej(cx)
	push	rej(di)
	push	rej(si)


	cmp	ebx, ecx
	jne	._64zg_spr
	cmp	esi, edi
	jne	._64zg_spr2

	mov	eax, esi
	mov	edx, ebx
	jmp	short ._64zg_koniec

._64zg_spr:
	jl	._64zg_ok1
	xchg	ebx, ecx
	cmp	esi, edi

._64zg_spr2:
	jl	._64zg_ok1
	xchg	esi, edi

._64zg_ok1:

	bibl_call	_los_64

	cmp	edx, ebx
	je	._64zg_spr_granice
	jl	._64zg_ok1

	cmp	edx, ecx
	je	._64zg_spr_granice2
	jg	._64zg_ok1

	jmp	short ._64zg_koniec

._64zg_spr_granice:
	cmp	eax, esi
	jl	._64zg_ok1
	jmp	short ._64zg_koniec

._64zg_spr_granice2:
	cmp	eax, edi
	jg	._64zg_ok1


._64zg_koniec:

	pop	rej(si)
	pop	rej(di)
	pop	rej(cx)
	pop	rej(bx)
	pop_f

	bibl_ret
