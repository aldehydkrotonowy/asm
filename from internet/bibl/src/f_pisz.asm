;;
; Biblioteka Standardowa -
; Procedury wypisujace liczby w postaci ulamka dziesietnego.
; Procedury wymagaja koprocesora.
; Wersja Linux: 2004-02-04
; Ostatnia modyfikacja kodu: 2021-02-24
; @author Bogdan 'bogdro' Drozdowski, bogdandr@op.pl (2002-09)
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

global	_pisz_pjp
global	_pisz_pdp
global	_pisz_rp

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

extern	_koprocesor
extern	_pisz_z

%if (__DOS > 0) || (__BIOS > 0)
 ; %include	"..\incl\dosbios\nasm\n_const.inc"
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 %if (__COFF == 0)
  segment         biblioteka_f_pisz
 %else
  segment         .text
 %endif
%else
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 section         .data
%endif

; **************************************

liczba		dw	10
status		dw	0
stan_fpu	times	108	db	0
cyfry		times	5000	db	0

; **************************************

%if (__LINUX > 0) || (__BSD > 0)
section		.text
%endif

;;
; Wypisuje na ekranie liczbe ulamkowa o pojedynczej precyzji
; (32 bit), znajdujaca sie pod adresem ES:DI / EDI / RDI.
; Makro: piszd32.
; Precyzja - do 6 miejsc po przecinku.
; @param [ES:DI] / [EDI] / [RDI] - liczba do wypisania.
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu
;;
_pisz_pjp:
	push	cx
	mov	cl, 32

_pisz_pjp_start:
	push_f
	push	ax
%if (__KOD_16BIT > 0)
	push	ds
	mov	ax, biblioteka_f_pisz
	mov	ds, ax
%endif

	fsave	[stan_fpu]

	bibl_call	_koprocesor	; sprawdzimy, czy jest koprocesor

	test	ax, ax
	jnz	._pjp_dalej

	frstor [stan_fpu]

%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	ax
	pop_f
	stc
	pop	cx

	bibl_ret

._pjp_zero:
	mov	al, '0'
	bibl_call	_pisz_z
	mov	al, ','
	bibl_call	_pisz_z
	mov	al, '0'
	bibl_call	_pisz_z

	jmp	._pjp_koniec

._pjp_dalej:
					;AX i flagi juz na stosie
	push	dx
	push	rej(si)
	xor	rej(si), rej(si)

	mov	word [liczba], 10

	finit

	fnstcw	[status]
	or	word [status],(0ch << 8)	;zaokraglanie: obcinaj
	fldcw	[status]


; =============================================================

					; ladujemy liczbe do wypisania:
	cmp	cl, 64
	ja	._czyt80
	jb	._czyt32

%if (__KOD_16BIT > 0)
	fld	qword [es:di]		; liczba, 10
%else
	fld	qword [rej(di)]
%endif
	jmp	short ._czyt_juz

._czyt32:
%if (__KOD_16BIT > 0)
	fld	dword [es:di]		; liczba, 10
%else
	fld	dword [rej(di)]		; liczba, 10
%endif
	jmp	short ._czyt_juz
._czyt80:
%if (__KOD_16BIT > 0)
	fld	tword [es:di]		; liczba, 10
%else
	fld	tword [rej(di)]		; liczba, 10
%endif

._czyt_juz:				; st: liczba

	ftst
	fstsw	[status]
	mov	ax, [status]

	and	ah, 01000101b		; zachowujemy C3, C2 i C0
					; ( C1 jest niewazny )
	jz	._pjp_ok		; st(0) > 0?

	cmp	ah, 01000101b		; zla liczba?
	jne	._pjp_l_ok
	jmp	._pjp_blad

._pjp_l_ok:

	cmp	ah, 01000000b		; st(0)=0?
	je	._pjp_zero

	cmp	ah, 1			; na wszelki wypadek
	jne	._pjp_blad
					; tutaj st(0) jest ujemne
	fchs
	mov	al, '-'
	bibl_call	_pisz_z


; =============================================================

._pjp_ok:

	fild	word [liczba]		; ladujemy liczbe calkowita 10
					; st: 10, liczba

					; 10, liczba
	fld	st1			; liczba, 10, liczba
	frndint				; [liczba], 10, liczba
	fsub	st2, st0		; [liczba], 10, cz.ulamk

.dziel10:
					; st: [liczba], 10, cz.ulamk

	fxch	st1			; 10, [liczba], cz.ul.
	fld	st1			; [liczba], 10, [liczba], cz.ul.

	fprem			; mod([liczba],10), 10, [liczba], cz.ulamk
	fistp	word [cyfry + rej(si)]	; 10, [liczba], cz.ulamk
	fxch	st1			; [liczba], 10, cz.ul.
	fdiv	st0, st1
	frndint				; [[liczba]/10], 10, cz.ul.
	inc	rej(si)

	ftst
	fstsw	[status]
	mov	ax, [status]
	sahf
	jnz	.dziel10


	fstp	st0			; 10, cz.ulamk
	fxch	st1			; cz.ulamk, 10

	xor	ch, ch

._pjp_wypisuj:				; wypisujemy czesc calkowita
	test	rej(si), rej(si)
	jz	._pjp_wypisuj_koniec

	dec	rej(si)
	mov	al, [cyfry + rej(si)]
	or	al, '0'
	bibl_call	_pisz_z

	inc	ch
	cmp	ch, 80
	jbe	short ._pjp_wypisuj

._pjp_wypisuj_koniec:

	mov	al, ','
	bibl_call	_pisz_z

	xor	ch, ch

._pjp_pisz32:				; cz.ulamk, 10

	fmul	st0, st1		; st: czesc ulamk. * 10, 10

	fist	word [liczba]		; cyfra ( cz.ul*10 ) do [liczba],
					; potem do AL

	fstsw	[status]
	mov	ax, [status]

	and	al, 18h			;spr., czy over-/under-flow
	jnz	._pjp_blad


	mov	al, [liczba]

	or	al, '0'			;piszemy czesc calkowita (1 cyfre)
	bibl_call	_pisz_z

	inc	ch			; licznik cyfr

	fild	word [liczba]		; st: czesc calk., liczba, 10
	fsubp	st1, st0		; st(1):=st(1)-st(0);
					; st: czesc ulamkowa, 10

	ftst				; spr., czy st(0) juz =0
	fstsw	[status]
	mov	ax, [status]
	sahf
	jz	._pjp_koniec

	cmp	ch, 80
	je	._pjp_koniec		; aby nie wypisywalo w nieskonczonosc

	jmp	short ._pjp_pisz32

; =============================================================

._pjp_blad:
					; st: liczba, 10

	frstor	[stan_fpu]		; przywroc stan FPU

	pop	rej(si)
	pop	dx
%if (__KOD_16BIT > 0)
	pop	ds
%endif

	pop	ax
	pop_f
	stc				; zwroc blad

	pop	cx

	bibl_ret

; =============================================================

._pjp_koniec:
					; st: czesc ulamk., 10

	frstor	[stan_fpu]		; przywroc stan FPU

	pop	rej(si)
	pop	dx
%if (__KOD_16BIT > 0)
	pop	ds
%endif

	pop	ax
	pop_f
	clc				; zwroc brak bledu

	pop	cx

	bibl_ret


; **************************************

;;
; Wypisuje na ekranie liczbe ulamkowa o podwojnej precyzji
; (64 bit), znajdujaca sie pod adresem ES:DI / EDI / RDI.
; Makro: piszd64.
; Precyzja - do 14 miejsc po przecinku.
; @param [ES:DI] / [EDI] / [RDI] - liczba do wypisania.
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu
;;
_pisz_pdp:
	push	cx
	mov	cl, 64
	jmp	_pisz_pjp_start



; **************************************

;;
; Wypisuje na ekranie liczbe ulamkowa o rozszerzonej precyzji
; (380bit), znajdujaca sie pod adresem ES:DI / EDI / RDI.
; Makro: piszd80.
; Precyzja - do 17 miejsc po przecinku.
; @param [ES:DI] / [EDI] / [RDI] - liczba do wypisania.
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu
;;
_pisz_rp:
	push	cx
	mov	cl, 80
	jmp	_pisz_pjp_start
