;;
; Biblioteka Standardowa -
; Procedury wypisujace dane.
; Wersja Linux: 2004-02-04
; Ostatnia modyfikacja kodu: 2021-02-24
; @author Bogdan 'bogdro' Drozdowski, bogdandr@op.pl (2002-07).
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

global	_pisz_l
global	_pisz_lh
global	_pisz_lz
global	_pisz_lzh
global	_pisz_lb
global	_pisz_lo

global	_pisz_8
global	_pisz_8h
global	_pisz_8z
global	_pisz_8zh
global	_pisz_8b
global	_pisz_8o

global	_pisz_32
global	_pisz_32h
global	_pisz_32z
global	_pisz_32zh
global	_pisz_32b
global	_pisz_32o

global	_pisz_ld
global	_pisz_ldh
global	_pisz_ldz
global	_pisz_ldzh
global	_pisz_ldb
global	_pisz_ldo

global	_pisz_64
global	_pisz_64h
global	_pisz_64z
global	_pisz_64zh
global	_pisz_64b
global	_pisz_64o

global	_pisz_z
global	_pisz_c
global	_pisz_ch

global	_pisz
global	_pisz_wsk
global	_pisz_wsk32
global	_pisz_dl
global	_pisz_dl32

global	_cls3
global	_nwln
global	_pozycja

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
  segment         biblioteka_pisz
 %else
  segment         .text
 %endif
%else
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 %include	"../incl/linuxbsd/nasm/n_system.inc"
 section         .data
%endif

;**************************************

_pisz_bufor	times	40	db	0

;**************************************

%if (__LINUX > 0) || (__BSD > 0)
section		.text
%endif

;;
; Wyswietla na ekranie podana liczbe 16-bitowa bez znaku.
; Makro: pisz16
; @param AX - liczba do wyswietlenia.
;;
_pisz_l:
	pushf
	push	bx
	push	dx
	push	cx
	push	ax
%if (__KOD_16BIT > 0)
	push	ds
	mov	cx, biblioteka_pisz
	mov	ds, cx
%endif
	push	rej(si)
	xor	rej(si), rej(si)
	mov	cx, 10

._pisz_l_petla:				; wpisujemy do bufora reszty z
					; dzielenia liczby przez 10,
	xor	dx, dx			; czyli cyfry wspak
	div	cx
	or	dl, '0'
	mov	[_pisz_bufor + rej(si)], dl
	inc	rej(si)
	test	ax, ax			; dopoki liczba jest rozna od 0
	jnz	._pisz_l_petla

._pisz_l_wypis:
	mov	al, [_pisz_bufor + rej(si) - 1]
	bibl_call	_pisz_z

	dec	rej(si)
	jnz	._pisz_l_wypis

	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	ax
	pop	cx
	pop	dx
	pop	bx
	popf

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 16-bitowa bez znaku szesnastkowo.
; Makro: pisz16h
; @param AX - liczba do wyswietlenia szesnastkowo.
;;
_pisz_lh:
	pushf
	push	ax
	push	bx
	push	cx
	push	dx
%if (__KOD_16BIT > 0)
	push	ds
	mov	cx, biblioteka_pisz
	mov	ds, cx
%endif
	push	rej(si)
	xor	rej(si), rej(si)
	xor	bx, bx

._pisz_lh_petla:				; 4 mlodsze bity wyjda do BL
	shr	ax, 1
	rcr	bl, 1
	shr	ax, 1
	rcr	bl, 1
	shr	ax, 1
	rcr	bl, 1
	shr	ax, 1
	rcr	bl, 1

%if (__DOS > 0) || (__BIOS > 0)
	shr	bl, 1
	shr	bl, 1
	shr	bl, 1
	shr	bl, 1
%else
	shr	bl, 4
%endif

	mov 	[_pisz_bufor + rej(si)], bl	; BL = cyfra hex ( kolejne
						; od prawej aby ominac zera )
	inc	rej(si)

	test 	ax, ax
	jnz	._pisz_lh_petla

._pisz_lh_wypis:
	mov 	al, [_pisz_bufor + rej(si) - 1]	; wypisujemy wspak
	bibl_call 	_pisz_ch

	dec	rej(si)
	jnz	._pisz_lh_wypis

	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	popf

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 16-bitowa ze znakiem.
; Makro: pisz16z
; @param AX - liczba do wyswietlenia.
;;
_pisz_lz:
	pushf
	push	ax
	push	bx

	mov	bx, ax
	test	ax, ax
	js	._lz_ze_znakiem		; ujemna? - wypisz minus i liczba

	bibl_call	_pisz_l			; wypisz tylko liczbe

	jmp 	short ._lz_koniec
._lz_ze_znakiem:
	mov	al, '-'
	bibl_call	_pisz_z

	xor	ax, ax
	sub	ax, bx			; zmieniamy znak liczby

	bibl_call	_pisz_l

._lz_koniec:
	pop	bx
	pop	ax
	popf

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podana liczbe 16-bitowa ze znakiem szesnastkowo.
; Makro: pisz16zh
; @param AX - liczba do wyswietlenia.
;;
_pisz_lzh:
	pushf
	push	ax
	push	bx

	mov 	bx, ax
	test	ax, ax
	js	._lzh_ze_znakiem	; ujemna? - wypisz minus i liczbe

	bibl_call	_pisz_lh		; wypisz tylko liczbe

	jmp	short ._lzh_koniec
._lzh_ze_znakiem:
	mov	al, '-'
	bibl_call	_pisz_z

	xor	ax, ax
	sub	ax, bx			; zmieniamy znak liczby

	bibl_call	_pisz_lh

._lzh_koniec:
	pop	bx
	pop	ax
	popf

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podana liczbe 16-bitowa bez znaku dwojkowo.
; Makro: pisz16b
; @param AX - liczba do wyswietlenia.
;;
_pisz_lb:
	pushf
	push	ax
	push	bx
	push	cx
%if (__KOD_16BIT > 0)
	push	ds
	mov	cx, biblioteka_pisz
	mov	ds, cx
%endif
	push	rej(si)
	xor	rej(si), rej(si)

	mov	bx, ax
	mov	al, '0'			; AL = '0'
.lb_petla:
	shl	bx, 1		; kolejne bity z lewej strony dodajemy do AL
	adc	ax, 0
	mov	[_pisz_bufor + rej(si)], al
	inc	rej(si)
	and	ax, byte '0'		; zerujemy AL

	cmp	rej(si), 16
	jb	.lb_petla		; do ostatniego, 16. bitu

	mov	cx, 16
	mov	rej(si), _pisz_bufor

	bibl_call	_pisz_dl32

	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	cx
	pop	bx
	pop	ax
	popf
	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podana liczbe 16-bitowa bez znaku osemkowo.
; Makro: pisz16o
; @param AX - liczba do wyswietlenia.
;;
_pisz_lo:
	pushf
	push	ax
	push	dx
%if (__KOD_16BIT > 0)
	push	ds
	mov	dx, biblioteka_pisz
	mov	ds, dx
%endif
	push	rej(si)
	xor	rej(si), rej(si)

._pisz_lo_petla:			; wpisujemy do bufora reszty z
					; dzielenia liczby przez 8,
	mov	dx, ax
	and	dl, 7			; DL = AX % 8
	or	dl, '0'
%if (__DOS > 0) || (__BIOS > 0)
					; AX = AX / 8
	shr	ax, 1
	shr	ax, 1
	shr	ax, 1
%else
	shr	ax, 3			; AX = AX / 8
%endif

	mov	[_pisz_bufor + rej(si)], dl
	inc	rej(si)

	test	ax, ax			; dopoki liczba jest rozna od 0
	jnz	._pisz_lo_petla

._pisz_lo_wypis:
	mov	al, [_pisz_bufor + rej(si) - 1]
	bibl_call	_pisz_z

	dec	rej(si)
	jnz	._pisz_lo_wypis

	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	dx
	pop	ax
	popf

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podana liczbe 8-bitowa bez znaku.
; Makro: pisz8
; @param AL - liczba do wyswietlenia.
;;
_pisz_8:
	pushf
	push	ax
	push	cx
%if (__KOD_16BIT > 0)
	push	ds
	mov	cx, biblioteka_pisz
	mov	ds, cx
%endif
	push	rej(si)
	xor	rej(si), rej(si)

	mov	cx, 10
	xor	ah, ah

._pisz_8_petla:
	div	cl
	or	ah, '0'
	mov	[_pisz_bufor + rej(si)],ah	; do bufora ida reszty z
						; dzielenia przez 10
	inc	rej(si)
	xor	ah, ah
	test	al, al
	jnz	._pisz_8_petla

._pisz_8_wypis:
	mov	al, [_pisz_bufor + rej(si) - 1]	; wypisujemy wspak
	bibl_call	_pisz_z

	dec	rej(si)
	jnz	._pisz_8_wypis

	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	cx
	pop	ax
	popf
	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 8-bitowa bez znaku szesnastkowo.
; Makro: pisz8h
; @param AL - liczba do wyswietlenia.
;;
_pisz_8h:
	pushf
	push	ax
	push	bx

	mov	bh, al
%if (__DOS > 0) || (__BIOS > 0)
					; BH=starsze 4 bity
	shr	bh, 1
	shr	bh, 1
	shr	bh, 1
	shr	bh, 1
%else
	shr	bh, 4			; BH=starsze 4 bity
%endif

	mov	bl, al
	test	bh, bh
	jz	._pisz_8h_dalej		; pomijamy wypisywanie 0 z przodu
	mov	al, bh
	bibl_call	_pisz_ch

._pisz_8h_dalej:
	and	bl, 0fh			; BL=mlodsze 4 bity
	mov	al, bl
	bibl_call	_pisz_ch

	pop	bx
	pop	ax
	popf

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 8-bitowa ze znakiem.
; Makro: pisz8z
; @param AL - liczba do wyswietlenia.
;;
_pisz_8z:
	pushf

	test 	al, al
	js	._8z_znak		; jesli ujemna, wypisz minus
	bibl_call	_pisz_8

	jmp 	short ._8z_koniec

._8z_znak:
	push	bx
	push	ax

	neg	al			; zmieniamy znak
	mov	bl, al

	mov	al, '-'
	bibl_call	_pisz_z

	mov	al,bl
	bibl_call	_pisz_8

	pop	ax
	pop	bx

._8z_koniec:
	popf
	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 8-bitowa ze znakiem szesnastkowo.
; Makro: pisz8zh
; @param AL - liczba do wyswietlenia.
;;
_pisz_8zh:
	pushf

	test	al, al
	js	._8zh_znak		; jesli ujemna, wypisz minus
	bibl_call	_pisz_8h

	jmp	short ._8zh_koniec

._8zh_znak:
	push	bx
	push	ax

	neg	al			; zmieniamy znak
	mov	bl, al

	mov	al, '-'
	bibl_call	_pisz_z

	mov	al, bl
	bibl_call	_pisz_8h

	pop	ax
	pop	bx

._8zh_koniec:
	popf

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 8-bitowa bez znaku dwojkowo.
; Makro: pisz8b
; @param AL - liczba do wyswietlenia.
;;
_pisz_8b:
	pushf
	push	ax
	push	bx
	push	cx
%if (__KOD_16BIT > 0)
	push	ds
	mov	cx, biblioteka_pisz
	mov	ds, cx
%endif
	push	rej(si)
	xor	rej(si), rej(si)

	mov	bx, ax
	mov	al, '0'

._8b_petla:
	shl	bl,1			; bity wychodzace z lewej dodajemy do AL
	adc	al,0

	mov	[_pisz_bufor + rej(si)], al

	and	al,'0'			; zerujemy AL
	inc	rej(si)
	cmp	rej(si), 8
	jb	._8b_petla		; do ostatniego, 8. bitu

	mov	rej(si), _pisz_bufor
	mov	cx, 8
%if (__DOS > 0) || (__BIOS > 0)
	bibl_call	_pisz_dl
%else
	bibl_call	_pisz_dl32
%endif

	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	cx
	pop	bx
	pop	ax
	popf

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podana liczbe 8-bitowa bez znaku osemkowo.
; Makro: pisz8o
; @param AL - liczba do wyswietlenia.
;;
_pisz_8o:
	pushf
	push	ax
	push	rej(si)
%if (__KOD_16BIT > 0)
	push	ds
	mov	si, biblioteka_pisz
	mov	ds, si
%endif
	xor	rej(si), rej(si)

._pisz_8o_petla:
	mov	ah, al
	and	ah, 7				; AH = AL % 8
%if (__DOS > 0) || (__BIOS > 0)
						; AL = AL / 8
	shr	al, 1
	shr	al, 1
	shr	al, 1
%else
	shr	al, 3				; AL = AL / 8
%endif
	or	ah, '0'
	mov	[_pisz_bufor + rej(si)], ah	; do bufora ida reszty z
						; dzielenia przez 8
	inc	rej(si)
	test	al, al
	jnz	._pisz_8o_petla

._pisz_8o_wypis:
	mov	al, [_pisz_bufor + rej(si) - 1]	; wypisujemy wspak
	bibl_call	_pisz_z

	dec	rej(si)
	jnz	._pisz_8o_wypis

%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(si)
	pop	ax
	popf
	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 32-bitowa bez znaku.
; Makro: pisz32
; @param DX:AX - liczba do wyswietlenia.
;;
_pisz_32:
	pushf
	push	bp
	push	ax
	push	bx
	push	cx
	push	dx
%if (__KOD_16BIT > 0)
	push	ds
	mov	cx, biblioteka_pisz
	mov	ds, cx
%endif
	push	rej(si)
	xor	rej(si), rej(si)

	mov	cx, 10

._32_petla:
	mov	bp, ax
	mov	ax, dx
	xor	dx, dx
	div	cx
	mov	bx, ax		;starsza czesc ilorazu
	mov	ax, bp		;mlodsza czesc dzielnej
	div	cx
				;dx=reszta
	mov	[_pisz_bufor + rej(si)], dl	; do bufora ida reszty z
						; dzielenia przez 10
	inc	rej(si)
	mov	dx, bx
				;dx:ax = iloraz
	or 	bx, ax		;jesli iloraz = 0, to juz koniec
	jnz	._32_petla

; wypisujemy:

._pisz_32_petla:
	mov	al, [_pisz_bufor + rej(si) - 1]	; wypisujemy wspak
	or	al,'0'
	bibl_call	_pisz_z

	dec	rej(si)
	jnz	._pisz_32_petla

	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	pop	bp
	popf

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 32-bitowa bez znaku szesnastkowo.
; Makro: pisz32h
; @param DX:AX - liczba do wyswietlenia.
;;
_pisz_32h:
	push	ax

	mov	ax, dx
	bibl_call	_pisz_lh		; wypisujemy starsza czesc

	mov	al, ':'
	bibl_call	_pisz_z

	pop	ax
	bibl_call	_pisz_lh		; wypisujemy mlodsza czesc

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 32-bitowa ze znakiem.
; Makro: pisz32z
; @param DX:AX - liczba do wyswietlenia.
;;
_pisz_32z:
	pushf

	test	dx, dx
	js	._32z_jest_znak		; czy ujemna?

	bibl_call	_pisz_32		; nie? wypisz tylko liczbe

	jmp	short ._32z_koniec

._32z_jest_znak:
	push	ax

	mov	al, '-'
	bibl_call	_pisz_z

	pop	ax
	push	ax
	push	dx

	neg	dx
	neg	ax
	sbb	dx, 0			; odwroc znak

	bibl_call	_pisz_32		; wypisz liczbe

	pop	dx
	pop	ax

._32z_koniec:

	popf
	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 32-bitowa ze znakiem szesnastkowo.
; Makro: pisz32zh
; @param DX:AX - liczba do wyswietlenia.
;;
_pisz_32zh:
	pushf

	test 	dx, dx
	js	._32zh_jest_znak		; czy ujemna?

	bibl_call	_pisz_32h

	jmp	short ._32zh_koniec		; wypisz tylko liczbe i wyjdz

._32zh_jest_znak:
	push	ax

	mov	al, '-'
	bibl_call	_pisz_z

	pop	ax
	push	ax
	push	dx

	neg	dx
	neg	ax
	sbb	dx, 0			; odwroc znak

	bibl_call	_pisz_32h		; wypisz liczbe

	pop	dx
	pop	ax

._32zh_koniec:
	popf
	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 32-bitowa bez znaku dwojkowo.
; Makro: pisz32b
; @param DX:AX - liczba do wyswietlenia.
;;
_pisz_32b:
	push	ax

	mov	ax, dx
	bibl_call	_pisz_lb		; starsza czesc dwojkowo

	mov	al, ':'
	bibl_call	_pisz_z

	pop	ax
	bibl_call	_pisz_lb		; mlodsza czesc dwojkowo

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podana liczbe 32-bitowa bez znaku osemkowo.
; Makro: pisz32o
; @param DX:AX - liczba do wyswietlenia.
;;
_pisz_32o:
	pushf
	push	ax
	push	cx
	push	dx
%if (__KOD_16BIT > 0)
	push	ds
	mov	cx, biblioteka_pisz
	mov	ds, cx
%endif
	push	rej(si)
	xor	rej(si), rej(si)

._32o_petla:
	mov	cx, ax
	and	cl, 7		; CL = AL % 8
	or	cl, '0'

				; dzielenie DX:AX przez 8
	shr	dx, 1
	rcr	ax, 1
	shr	dx, 1
	rcr	ax, 1
	shr	dx, 1
	rcr	ax, 1

	mov	[_pisz_bufor + rej(si)], cl	; do bufora ida reszty z
						; dzielenia przez 8
	inc	rej(si)
				; dx:ax = iloraz
	test 	ax, ax		; jesli iloraz = 0, to juz koniec
	jnz	._32o_petla

	test 	dx, dx
	jnz	._32o_petla

; wypisujemy:

._pisz_32o_petla:
	mov	al, [_pisz_bufor + rej(si) - 1]	; wypisujemy wspak
	or	al,'0'
	bibl_call	_pisz_z

	dec	rej(si)
	jnz	._pisz_32o_petla

	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	dx
	pop	cx
	pop	ax
	popf

	bibl_ret

;**************************************

%if (__KOD_16BIT > 0)
 cpu 386
%endif

;;
; Wyswietla na ekranie podana liczbe 32-bitowa bez znaku.
; Makro: pisz32e
; @param EAX - liczba do wyswietlenia.
;;
_pisz_ld:
	push_f
	push	rej(cx)
	push	rej(dx)
	push	rej(ax)
	push	rej(si)
%if (__KOD_16BIT > 0)
	push	ds
	mov	cx, biblioteka_pisz
	mov	ds, cx
%endif
	xor	rej(si), rej(si)
	mov	ecx, 10

._pisz_ld_petla:
	xor	edx, edx
	div	ecx

	or	dl, '0'
		; do bufora ida reszty z
		; dzielenia przez 10,
		; czyli cyfry wspak
	mov	[_pisz_bufor + rej(si)], dl
	inc	rej(si)
	test	eax, eax
	jnz	._pisz_ld_petla

._pisz_ld_wypis:
	mov	al, [_pisz_bufor + rej(si) - 1]	; wypisujemy reszty wspak
	bibl_call	_pisz_z
	dec	rej(si)
	jnz	._pisz_ld_wypis

%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(si)
	pop	rej(ax)
	pop	rej(dx)
	pop	rej(cx)
	pop_f

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 32-bitowa bez znaku szesnastkowo.
; Makro: pisz32eh
; @param EAX - liczba do wyswietlenia.
;;
_pisz_ldh:
	push_f
	push	rej(bp)
	push	rej(ax)
	push	rej(bx)
	push	rej(si)
%if (__KOD_16BIT > 0)
	push	ds
	mov	si, biblioteka_pisz
	mov	ds, si
%endif
	xor	rej(si), rej(si)
	xor	ebx, ebx

._pisz_ldh_petla:			; kolejne bity od prawej ida do BL
	shr	eax,1
	rcr	bl, 1
	shr	eax,1
	rcr	bl, 1
	shr	eax,1
	rcr	bl, 1
	shr	eax,1
	rcr	bl, 1
	shr	bl, 4

	; w buforze cyfry wspak, aby ominac
	; zera z przodu
	mov	[_pisz_bufor + rej(si)], bl
	inc 	rej(si)
	test	eax, eax
	jnz	._pisz_ldh_petla

._pisz_ldh_wypis:
	mov	al, [_pisz_bufor + rej(si) - 1]	; wypisujemy wspak
	bibl_call	_pisz_ch
	dec 	rej(si)
	jnz	._pisz_ldh_wypis

%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(si)
	pop	rej(bx)
	pop	rej(ax)
	pop	rej(bp)
	pop_f

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 32-bitowa ze znakiem.
; Makro: pisz32ez
; @param EAX - liczba do wyswietlenia.
;;
_pisz_ldz:
	push_f
	push	rej(ax)
	push	rej(bx)

	mov	ebx, eax
	test	ebx, ebx
	js	._ldz_ze_znakiem	; czy ujemna?

	bibl_call	_pisz_ld		; nie? wypisz tyko liczbe

	jmp	short ._ldz_koniec

._ldz_ze_znakiem:
	mov	al, '-'
	bibl_call	_pisz_z

	xor	eax, eax
	sub	eax, ebx		; zmien znak

	bibl_call	_pisz_ld		; wypisz liczbe

._ldz_koniec:
	pop	rej(bx)
	pop	rej(ax)
	pop_f

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podana liczbe 32-bitowa ze znakiem szesnastkowo.
; Makro: pisz32ezh
; @param EAX - liczba do wyswietlenia.
;;
_pisz_ldzh:
	push_f
	push	rej(ax)
	push	rej(bx)

	mov	ebx, eax
	test	ebx, ebx
	js	._ldzh_ze_znakiem	; czy ujemna?

	bibl_call	_pisz_ldh		; nie? wypisz tyko liczbe

	jmp	short ._ldzh_koniec

._ldzh_ze_znakiem:
	mov	al, '-'
	bibl_call	_pisz_z

	xor	eax, eax
	sub	eax, ebx		; zmien znak

	bibl_call	_pisz_ldh		; wypisz liczbe

._ldzh_koniec:
	pop	rej(bx)
	pop	rej(ax)
	pop_f

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podana liczbe 32-bitowa bez znaku dwojkowo.
; Makro: pisz32eb
; @param EAX - liczba do wyswietlenia.
;;
_pisz_ldb:
	push_f
	push	rej(ax)
	push	rej(bx)
	push	rej(cx)
	push	rej(si)
%if (__KOD_16BIT > 0)
	push	ds
	mov	cx, biblioteka_pisz
	mov	ds, cx
%endif
	mov	ebx, eax
	mov	al, '0'
	xor	rej(si), rej(si)

.ldb_petla:
	shl	ebx, 1			; kolejne bity od lewej dodajemy do AL
	adc	eax, 0

	mov	[_pisz_bufor + rej(si)], al
	inc	rej(si)
	and 	eax, '0'
	cmp	rej(si), 32		; az do ostatniego, 32. bitu
	jb	.ldb_petla

	mov	ecx, 32
	mov	rej(si), _pisz_bufor
	bibl_call	_pisz_dl32

%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(si)
	pop	rej(cx)
	pop	rej(bx)
	pop	rej(ax)
	pop_f

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podana liczbe 32-bitowa bez znaku osemkowo.
; Makro: pisz32eo
; @param EAX - liczba do wyswietlenia.
;;
_pisz_ldo:
	push_f
	push	rej(dx)
	push	rej(ax)
	push	rej(si)

	xor	rej(si), rej(si)
%if (__KOD_16BIT > 0)
	push	ds
	mov	dx, biblioteka_pisz
	mov	ds, dx
%endif

._pisz_ldo_petla:
	mov	edx, eax
	and	dl, 7				; DL = EAX % 8
	shr	eax, 3				; EAX = EAX / 8

	or	dl, '0'
	; do bufora ida reszty z
	; dzielenia przez 8,
	; czyli cyfry wspak
	mov	[_pisz_bufor + rej(si)], dl
	inc	rej(si)
	test	eax, eax
	jnz	._pisz_ldo_petla

._pisz_ldo_wypis:
	mov	al, [_pisz_bufor + rej(si) - 1]	; wypisujemy reszty wspak
	bibl_call	_pisz_z
	dec	rej(si)
	jnz	._pisz_ldo_wypis

%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(si)
	pop	rej(ax)
	pop	rej(dx)
	pop_f

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 64-bitowa bez znaku.
; Makro: pisz64
; @param EDX:EAX - liczba do wyswietlenia.
;;
_pisz_64:
	push_f
	push	rej(bp)
	push	rej(ax)
	push	rej(bx)
	push	rej(cx)
	push	rej(dx)
	push	rej(si)
%if (__KOD_16BIT > 0)
	push	ds
	mov	cx, biblioteka_pisz
	mov	ds, cx
%endif
	mov	ecx, 10
	xor	rej(si), rej(si)
._64_petla:
	mov	ebp, eax
	mov	eax, edx
	xor	edx, edx
	div	ecx
	mov	ebx, eax		;starsza czesc ilorazu
	mov	eax, ebp		;mlodsza czesc dzielnej
	div	ecx

	or	dl, '0'
					; edx=reszta
	; do bufora ida reszty z dzielenia
	; przez 10, czyli cyfry wspak
	mov	[_pisz_bufor + rej(si)],dl
	inc	rej(si)
	mov	edx, ebx
					; edx:eax = iloraz
	or	ebx, eax		; jesli iloraz = 0, to juz koniec
	jnz	._64_petla

;wypisujemy:

._pisz_64_petla:
	mov 	al, [_pisz_bufor + rej(si) - 1]	; wypisujemy wspak
	bibl_call	_pisz_z
	dec	rej(si)
	jnz	._pisz_64_petla

%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(si)
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(bx)
	pop	rej(ax)
	pop	rej(bp)
	pop_f

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 64-bitowa bez znaku szesnastkowo.
; Makro: pisz64h
; @param EDX:EAX - liczba do wyswietlenia.
;;
_pisz_64h:
	push	rej(ax)

	mov	eax, edx
	bibl_call	_pisz_ldh		; starsze 32 bity

	mov	al, ':'
	bibl_call	_pisz_z

	pop	rej(ax)
	bibl_call	_pisz_ldh		; mlodsze 32 bity

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 64-bitowa ze znakiem.
; Makro: pisz64z
; @param EDX:EAX - liczba do wyswietlenia.
;;
_pisz_64z:
	push_f

	test	edx, edx
	js	._64z_jest_znak		; czy ujemna?

	bibl_call	_pisz_64		; nie? wypisz tylko liczbe

	jmp	short ._64z_koniec

._64z_jest_znak:
	push	rej(ax)

	mov	al, '-'
	bibl_call	_pisz_z			; wypisz minus

	pop	rej(ax)
	push	rej(ax)
	push	rej(dx)

	neg	edx
	neg	eax
	sbb	edx, 0			; zmien znak

	bibl_call	_pisz_64		; wypisz liczbe

	pop	rej(dx)
	pop	rej(ax)

._64z_koniec:
	pop_f

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podana liczbe 64-bitowa ze znakiem szesnastkowo.
; Makro: pisz64zh
; @param EDX:EAX - liczba do wyswietlenia.
;;
_pisz_64zh:
	push_f

	test	edx, edx
	js	._64zh_jest_znak	; czy ujemna?

	bibl_call	_pisz_64h		; nie? wypisz tylko liczbe

	jmp	short ._64zh_koniec

._64zh_jest_znak:
	push	rej(ax)

	mov	al, '-'
	bibl_call	_pisz_z			; wypisz minus

	pop	rej(ax)
	push	rej(ax)
	push	rej(dx)

	neg	edx
	neg	eax
	sbb	edx, 0			; zmien znak

	bibl_call	_pisz_64h		; wypisz liczbe

	pop	rej(dx)
	pop	rej(ax)

._64zh_koniec:
	pop_f

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podana liczbe 64-bitowa bez znaku dwojkowo.
; Makro: pisz64b
; @param EDX:EAX - liczba do wyswietlenia.
;;
_pisz_64b:
	push	rej(ax)

	mov	eax, edx

	bibl_call	_pisz_ldb		; wypisz starsza czesc

	mov	al, ':'
	bibl_call	_pisz_z

	pop	rej(ax)
	bibl_call	_pisz_ldb		; wypisz mlodsza czesc

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podana liczbe 64-bitowa bez znaku osemkowo.
; Makro: pisz64o
; @param EDX:EAX - liczba do wyswietlenia.
;;
_pisz_64o:
	push_f
	push	rej(ax)
	push	rej(cx)
	push	rej(dx)
	push	rej(si)
%if (__KOD_16BIT > 0)
	push	ds
	mov	cx, biblioteka_pisz
	mov	ds, cx
%endif

	xor	rej(si), rej(si)

._64o_petla:
	mov	ecx, eax
	and	cl, 7			; CL = EAX % 8

					; dzielenie EDX:EAX przez 8:
	shr	edx, 1
	rcr	eax, 1
	shr	edx, 1
	rcr	eax, 1
	shr	edx, 1
	rcr	eax, 1
	or	cl, '0'
					; edx=reszta
	; do bufora ida reszty z dzielenia
	; przez 8, czyli cyfry wspak
	mov	[_pisz_bufor + rej(si)],cl
	inc	rej(si)
					; edx:eax = iloraz
	test	eax, eax		; jesli iloraz = 0, to juz koniec
	jnz	._64o_petla

	test	edx, edx
	jnz	._64o_petla

;wypisujemy:

._pisz_64o_petla:
	mov 	al, [_pisz_bufor + rej(si) - 1]	; wypisujemy wspak
	bibl_call	_pisz_z
	dec	rej(si)
	jnz	._pisz_64o_petla

%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(si)
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(ax)
	pop_f

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podany znak.
; Makro: pisz_z
; @param AL - znak do wyswietlenia.
;;
_pisz_z:

%if (__BIOS > 0)
	push	ax
	push	bp

	mov	ah, 0eh
	int	10h

	pop	bp
	pop	ax
	bibl_ret

%elif (__DOS > 0)
	push	dx
        push    ax
        mov     ah, 2
	mov	dl, al
        int     21h
        pop     ax
	pop	dx

	bibl_ret

%else
	push_f
	push	rej(ax)
	push	rej(bx)
	push	rej(cx)
	push	rej(dx)
	mov	[_pisz_bufor+39], al
 %if (__KOD_64BIT > 0)
	mov	rax, sys64_write
 %else
	mov	eax, sys_write		; funkcja zapisu do pliku
 %endif

	mov	ebx, stdout		; kierujemy na standardowe wyjscie
	lea	rej(cx), [_pisz_bufor+39]
	mov	edx, 1

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
	pop	rej(bx)
	pop	rej(ax)
	pop_f

	bibl_ret

; dla *BSD:
jadro:
 %if (__KOD_64BIT > 0)
	push	rdi
	push	rsi
	push	rdx
	movsx	rax, eax
	movsx	rdi, ebx
	mov	rsi, rcx
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
;**************************************

;;
; Wyswietla na ekranie podana cyfre (od 0 do 9).
; Makro: pisz_c
; @param AL - cyfra do wyswietlenia (wartosc, nie kod ASCII).
; @return flaga CF=0, gdy podano prawidlowa cyfre, CF=1 w przypadku bledu
;;
_pisz_c:
	push_f
	cmp	al, 9
	ja	._blad_c

	push	ax
	or	al, '0'			; czyli ADD AL,'0'
	bibl_call	_pisz_z			; wyswietl cyfre

	pop	ax
	pop_f
	clc
	bibl_ret

._blad_c:
	pop_f
	stc

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podana cyfre szesnastkowo (od 0 do 15).
; Makro: pisz_ch
; @param AL - cyfra do wyswietlenia (wartosc od 0 do 15, nie kod ASCII).
; @return flaga CF=0, gdy podano prawidlowa cyfre hex, CF=1 w przypadku bledu
;;
_pisz_ch:
	push	ax
	push_f

	cmp	al, 9		; 0-9 czy 10-15?
	ja	._ch_hex
	or	al,'0'
	jmp	short ._ch_pz

._ch_hex:
	cmp	al, 15
	ja	._blad_ch
	add	al, 'A'-10	; z 10-15 na 'A'-'F'


._ch_pz:
	bibl_call	_pisz_z		; wypisz znak wynikowy

	pop_f
	clc
	jmp	short ._ch_ok

._blad_ch:
	pop_f
	stc
._ch_ok:
	pop	ax

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie ciag znakow. Ciag znakow do wyswietlenia znajduje sie
;	w kodzie programu, tuz za uruchomieniem tej procedury - tak, jakby
;	byl dalszymi instrukcjami. Musi byc zakonczony na bajt zerowy.
; Makro: pisz
;;
_pisz:
	push	rej(bp)
	mov	rej(bp), rej(sp)
	push_f
	push	rej(si)
	push	rej(ax)

%if (__KOD_16BIT > 0)

        push	ds

        mov     ds, [bp+4]
        mov     si, [bp+2]              ; DS:SI = adres powrotny, czyli
                                        ; poczatek lancucha znakow
%else
 %if (__KOD_64BIT > 0)


;	lea	rbp, [rsp+8+8]		; FIXME
	mov	rsi, [rbp+8]		; RSI = adres powrotny, czyli
					; poczatek lancucha znakow
 %else


	mov	esi, [ebp+4]		; ESI = adres powrotny, czyli
					; poczatek lancucha znakow
 %endif
%endif

._pisz_petla:
        mov	al, [rej(si)]		; ladujemy kolejny znak
	test	al, al
	jz	._pisz_koniec		; jesli bajt zerowy, to wychodzimy

	bibl_call	_pisz_z		; wypisz wczytany znak

	inc	rej(si)
	jmp	short ._pisz_petla

._pisz_koniec:
%if (__KOD_16BIT > 0)
        pop     ds

%endif
	inc	rej(si)			; pomijamy bajt 0
	pop	rej(ax)

%if (__KOD_16BIT > 0)
        mov     [bp+2], si              ; ustawiamy adres powrotny na po
                                        ; bajcie zerowym
%else
 %if (__KOD_64BIT > 0)
	mov	[rbp+8],rsi		; ustawiamy adres powrotny na po
					; bajcie zerowym
 %else
	mov	[ebp+4],esi		; ustawiamy adres powrotny na po
					; bajcie zerowym
 %endif

%endif
	pop	rej(si)
	pop_f
	pop	rej(bp)

	bibl_ret


;**************************************

;;
; Wyswietla na ekranie podany ciag znakow.
; Makro: pisz_dssi
; @param DS:SI - adres lancucha znakow, zakonczonego bajtem zerowym.
;;
_pisz_wsk:
	push_f
	push	ax
	push	rej(si)

	cld

._pwsk_petla:
	lodsb			; wczytuj bajt
	test	al, al		; dopoki znak wczytany jest rozny od 0
	jz	._pwsk_juz

	bibl_call	_pisz_z		; wypisz ten znak

	jmp	short ._pwsk_petla

._pwsk_juz:

	pop	rej(si)
	pop	ax
	pop_f

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie podany ciag znakow.
; Makro: pisz_esi
; @param DS:ESI - adres lancucha znakow, zakonczonego bajtem zerowym.
;;
_pisz_wsk32:
	push_f
	push	ax
	push	rej(si)

._pwsk32_petla:
	mov	al, [esi]		; wczytuj bajt
	test	al, al			; dopoki znak wczytany jest rozny od 0
	jz	._pwsk32_juz

	bibl_call	_pisz_z			; wypisz ten znak

	inc	rej(si)
	jmp	short ._pwsk32_petla

._pwsk32_juz:

	pop	rej(si)
	pop	ax
	pop_f
	bibl_ret


;**************************************

;;
; Wyswietla na ekranie fragment podanego ciagu znakow.
; Makro: pisz_dl
; @param DS:SI / ESI / RSI - adres lancucha znakow, zakonczonego bajtem zerowym.
; @param CX - ilosc znakow do wyswietlenia.
;;
_pisz_dl:
	push_f
	push	ax
	push	cx
	push	rej(si)

	test	cx, cx
	jz	.dl_koniec
	cld

.dl_petla:
	lodsb			; wczytuj znak

	bibl_call	_pisz_z

	dec	cx		; dopoki CX rozny od 0
	jnz	.dl_petla

.dl_koniec:
	pop	rej(si)
	pop	cx
	pop	ax
	pop_f

	bibl_ret

;**************************************

;;
; Wyswietla na ekranie fragment podanego ciagu znakow.
; Makro: pisz_dl32
; @param DS:SI / ESI / RSI - adres lancucha znakow, zakonczonego bajtem zerowym.
; @param CX - ilosc znakow do wyswietlenia.
;;
_pisz_dl32:
	push_f
	push	ax
	push	cx
	push	rej(si)

	test	cx, cx
	jz	.dl32_koniec

.dl32_petla:
	mov	al, [rej(si)]		; wczytuj znak
	inc	rej(si)

	bibl_call	_pisz_z

	dec	cx			; dopoki ECX rozny od 0
	jnz	.dl32_petla

.dl32_koniec:

	pop	rej(si)
	pop	cx
	pop	ax
	pop_f

	bibl_ret

;**************************************

;;
; Czysci ekran.
; Makro: czysc
;;
_cls3:
%if (__DOS > 0) || (__BIOS > 0)
        push_f
        push    ax
        push    bx

        mov     ah, 0fh
        int     10h                     ; pobierz biezacy tryb (AL), niszczy BH
        xor     ah, ah
        int     10h                     ; ponowne wejscie czysci ekran

        pop     bx
        pop     ax
        pop_f

%else
	push	rej(ax)
	push	rej(cx)
	push	rej(si)

	mov	byte	[_pisz_bufor  ], ESCP
	mov	byte	[_pisz_bufor+1], '['
	mov	byte	[_pisz_bufor+2], '2'
	mov	byte	[_pisz_bufor+3], 'J'

	mov	rej(si), _pisz_bufor
	mov	ecx, 4
	bibl_call	_pisz_dl32

	xor	eax, eax
	bibl_call	_pozycja

	pop	rej(si)
	pop	rej(cx)
	pop	rej(ax)

%endif
	bibl_ret


;**************************************

;;
; Wyswietla sekwencje przejscia do nowej linii.
;;
_nwln:
	push	ax

%if (__DOS > 0) || (__BIOS > 0)
	mov	al, cr
	bibl_call	_pisz_z
%endif
	mov	al, lf
	bibl_call	_pisz_z

	pop	ax
	bibl_ret


;**************************************

;;
; Ustawia kursor na danej pozycji.
; @param AL - wiersz
; @param AH - kolumna
;;
_pozycja:
%if (__DOS > 0) || (__BIOS > 0)
	push	ax
	push	dx

	mov	dh, al
	mov	dl, ah
	mov	ah, 2
	int	10h

	pop	dx
	pop	ax

%else
	; poczatek sekwencji kontrolnej terminala ESC,"[ww;kkH"
	mov	byte [_pisz_bufor  ], ESCP
	mov	byte [_pisz_bufor+1], '['
	mov	byte [_pisz_bufor+4], ';'
	mov	byte [_pisz_bufor+7], 'H'

	push_f
	push	rej(ax)
	push	rej(cx)
	push	rej(dx)
	push	rej(si)

	mov	dh, 10
	push	rej(ax)
	shr	eax, 8
	and	eax, 0FFh		; AX = kolumna znaku
	div	dh
	or	eax, "00"
	mov	[_pisz_bufor+5], ax

	pop	rej(ax)
	and	eax, 0FFh		; AX = wiersz znaku
	div	dh
	or	eax, "00"
	mov	[_pisz_bufor+2], ax

	mov	esi, _pisz_bufor
	mov	ecx, 8
	bibl_call	_pisz_dl32

	pop	rej(si)
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(ax)
	pop_f

%endif

	bibl_ret
