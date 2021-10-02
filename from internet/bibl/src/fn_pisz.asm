;;
; Biblioteka Standardowa -
; Procedury wypisujace liczby w postaci ulamka dziesietnego,
; w postaci wykladniczej.
; Procedury wymagaja koprocesora.
; Wersja Linux: 2004-02-04
; Ostatnia modyfikacja kodu: 2021-02-24
; @author Bogdan 'bogdro' Drozdowski, bogdandr@op.pl (2003-02)
;;


; Copyright (C) 2003-2021 Bogdan 'bogdro' Drozdowski, bogdandr @ op . pl
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

global	_pisz_pjpn
global	_pisz_pdpn
global	_pisz_rpn

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

extern	_pisz_lz 			; do wypisywania wykladnikow
extern	_koprocesor
extern	_pisz_z

%if (__DOS > 0) || (__BIOS > 0)
 ; %include	"..\incl\dosbios\nasm\n_const.inc"
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 %if (__COFF == 0)
  segment         biblioteka_fn_wy
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

; **************************************

%if (__LINUX > 0) || (__BSD > 0)
section		.text
%endif

;;
; Wypisuje na ekranie liczbe ulamkowa o pojedynczej precyzji
; (32 bit), znajdujaca sie pod adresem ES:DI / EDI / RDI,
; w postaci wykladniczej.
; Makro: piszd32n.
; Precyzja - do 6 miejsc po przecinku.
; @param [ES:DI] / [EDI] / [RDI] - liczba do wypisania.
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu
;;
_pisz_pjpn:
	push	cx
	mov	cl, 32

_pisz_pjpn_start:
	push_f
	push	ax
%if (__KOD_16BIT > 0)
	push	ds

	mov	ax, biblioteka_fn_wy
	mov	ds, ax
%endif
	fsave	[stan_fpu]

	bibl_call	_koprocesor	; sprawdzimy, czy jest koprocesor

	test	ax, ax
	jnz	._pjpn_dalej

	frstor	[stan_fpu]

%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	ax
	pop_f
	stc
	pop	cx

	bibl_ret

._pjpn_zero:

	mov	al, '0'
	bibl_call	_pisz_z
	mov	al, ','
	bibl_call	_pisz_z
	mov	al, '0'
	bibl_call	_pisz_z
	mov	al, 'e'
	bibl_call	_pisz_z
	mov	al, '0'
	bibl_call	_pisz_z

	jmp	._pjpn_koniec

._pjpn_dalej:
					; AX i flagi juz na stosie
	push	dx

	xor	dx, dx

	mov	word [liczba], 10

	finit

	fnstcw	[status]
	or	word [status],(0ch << 8)	; zaokraglanie: obcinaj
						; ( bity 10 i 11 =1 )
	fldcw	[status]

	fild	word [liczba]		; ladujemy liczbe calkowita 10
					; st(0)=10


; =============================================================
					; ladujemy liczbe do wypisania:


	cmp	cl, 64
	ja	._czyt80
	jb	._czyt32


; fdivp:  st(1) := st(1) / st(0),   pop st(0)
; fdiv st(0), st(i)   : st(0) := st(0) / st(i)
; fcom - porownuje st(0) i st(1)

					; st:
%if (__KOD_16BIT > 0)
	fld	qword [es:di]		; liczba, 10
%else
	fld	qword [rej(di)]		; liczba, 10
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


; =============================================================

._czyt_juz:				; st: liczba, 10


	ftst
	fstsw	[status]
	mov	ax, [status]

	and	ah, 01000101b		; zachowujemy C3, C2 i C0
					; ( C1 jest niewazny )
	jz	._pjpn_ok		; st(0) > 0?

	cmp	ah, 01000101b		; zla liczba?
	jne	._pjpn_spr_dalej0
	jmp	._pjpn_blad

._pjpn_spr_dalej0:

	cmp	ah, 01000000b		; st(0)=0?
	je	._pjpn_zero

	cmp	ah, 1			; czy st(0) < 0? , na wszelki wypadek
	je	._pjpn_spr_dalej2
	jmp	._pjpn_blad

._pjpn_spr_dalej2:

					; tutaj st(0) jest ujemne
	mov	al, '-'
	bibl_call	_pisz_z			; wypisujemy minus

	fchs				; zmieniamy znak st(0)


; =============================================================

._pjpn_ok:
					; st: liczba, 10
	fcom	st1
	fstsw	[status]
	mov	ax, [status]

	and	ah, 01000101b		; zachowujemy C3, C2 i C0
					; ( C1 jest niewazny )
					; 000: st(0) > st(1), 001: < ,
					; 100 =, 111 blad
	jz	.dziel10
	cmp	ah, 01000000b
	je	.dziel10		; gdy st(0) >= 10, to dzielimy przez 10

	cmp	ah, 1			; gdy st(0) < 10, to sprawdz,
					; czy < 1 czy > 1.
	je	._pjpn_spr_dalej3
	jmp	._pjpn_blad

._pjpn_spr_dalej3:

	fld1				; 1, liczba, 10
	fcomp	st1			; liczba, 10
	fstsw	[status]
	mov	ax, [status]

	and	ah, 01000101b		; zachowujemy C3, C2 i C0
					; ( C1 jest niewazny )
					; 000: st(0) > st(1), 001: < ,
					; 100 =, 111 blad

	jz	.mnoz10			; gdy  1 > liczba

	cmp	ah,1			; gdy  1 < liczba < 10
	je	.pisz_liczbe
	cmp	ah, 01000000b		; gdy liczba = 1
	je	.pisz_liczbe

	jmp	._pjpn_blad

.dziel10:
					; st: liczba, 10
					; liczba > 10. Dzielimy przez 10
					; dopoki liczba > 10.
	fdiv	st0, st1
	inc	dx			; zwiekszamy wykladnik

	fcom	st1
	fstsw	[status]
	mov	ax, [status]

	and	ah, 01000101b		; zachowujemy C3, C2 i C0
					; ( C1 jest niewazny )
					; 000: st(0) > st(1), 001: < ,
					; 100 =, 111 blad
	jz	.dziel10
	cmp	ah, 01000000b
	je	.dziel10		; gdy st(0) >= 10, to dzielimy przez 10

	jmp	short .pisz_liczbe

.mnoz10:
					; st: liczba, 10
					; liczba < 1. Mnozymy przez 10
					; dopoki liczba < 1.

	fmul	st0, st1
	dec	dx			; zmniejszamy wykladnik

	fld1				; 1, liczba, 10
	fcomp	st1
	fstsw	[status]
	mov	ax, [status]

	and	ah, 01000101b		; zachowujemy C3, C2 i C0
					; ( C1 jest niewazny )
					; 000: st(0) > st(1), 001: < ,
					; 100 =, 111 blad

	jz	.mnoz10			; gdy 1 > liczba, to mnozymy przez 10


; =============================================================


.pisz_liczbe:

	fist	word [liczba]		; st: liczba, 10
	mov	al, byte [liczba]

	or	al, '0'
	bibl_call	_pisz_z			; piszemy cyfre (czesc calkowita)

	fild	word [liczba]		; st: czesc calk, liczba, 10
	fsubp	st1, st0
					; st: liczba-cz.calk.=czesc ulamkowa,10

	mov	al, ','
	bibl_call	_pisz_z			; piszemy przecinek

	xor	ch, ch			; zerujemy licznik wypisanych cyfr

._pjpn_pisz32:

	fmul	st0, st1		; st: czesc ulamk. * 10, 10

	fist	word [liczba]		; cyfra ( cz.ul*10 ) do [liczba],
					; potem do AL

	mov	al, [liczba]

	or	al, '0'			; piszemy czesc calkowita ( 1 cyfre )
	bibl_call	_pisz_z

	inc	ch			; licznik wypisanych cyfr

	fild	word [liczba]		; st: czesc calk., liczba, 10
	fsubp	st1, st0		; st(1):=st(1)-st(0);
					; st: czesc ulamkowa, 10

	ftst				; spr., czy st(0) juz =0
	fstsw	[status]
	mov	ax, [status]
	sahf
	jz	._pjpn_pisz_wykl	; st(0)=0 - koniec, wypisac wykladnik

	cmp	ch, 80
	je	._pjpn_pisz_wykl	; aby nie wypisywalo w nieskonczonosc

	jmp	short ._pjpn_pisz32


; =============================================================


._pjpn_blad:

	frstor	[stan_fpu]		; przywroc stan FPU

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

._pjpn_koniec:

	frstor	[stan_fpu]		; przywroc stan FPU

	pop	dx
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	ax
	pop_f
	clc				; zwroc brak bledu

	pop	cx

	bibl_ret

; =============================================================

._pjpn_pisz_wykl:
	mov	al, 'e'
	bibl_call	_pisz_z			; piszemy 'e'

	mov	ax, dx
	bibl_call	_pisz_lz	; piszemy wykladnik

	jmp	short ._pjpn_koniec



; **************************************


;;
; Wypisuje na ekranie liczbe ulamkowa o pojedynczej precyzji
; (64 bit), znajdujaca sie pod adresem ES:DI / EDI / RDI,
; w postaci wykladniczej.
; Makro: piszd64n.
; Precyzja - do 14 miejsc po przecinku.
; @param [ES:DI] / [EDI] / [RDI] - liczba do wypisania.
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu
;;
_pisz_pdpn:
	push	cx
	mov	cl, 64
	jmp	_pisz_pjpn_start



; **************************************

;;
; Wypisuje na ekranie liczbe ulamkowa o rozszerzonej precyzji
; (80 bit), znajdujaca sie pod adresem ES:DI / EDI / RDI,
; w postaci wykladniczej.
; Makro: piszd80n.
; Precyzja - do 17 miejsc po przecinku.
; @param [ES:DI] / [EDI] / [RDI] - liczba do wypisania.
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu
;;
_pisz_rpn:
	push	cx
	mov	cl, 80
	jmp	_pisz_pjpn_start
