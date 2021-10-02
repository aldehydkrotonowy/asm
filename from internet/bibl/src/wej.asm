;;
; Biblioteka Standardowa -
; Procedury pobierajace dane od uzytkownika.
; Wersja Linux: 2004-02-04
; Ostatnia modyfikacja kodu: 2021-02-25
; @author Bogdan 'bogdro' Drozdowski, bogdandr@op.pl (2002-07)
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

global	_we_l
global	_we_lh
global	_we_lz
global	_we_lzh
global	_we_lb
global	_we_lo

global	_we_8
global	_we_8h
global	_we_8z
global	_we_8zh
global	_we_8b
global	_we_8o

global	_we_32
global	_we_32h
global	_we_32z
global	_we_32zh
global	_we_32b
global	_we_32o

global	_we_ld
global	_we_ldh
global	_we_ldz
global	_we_ldzh
global	_we_ldb
global	_we_ldo

global	_we_64
global	_we_64h
global	_we_64z
global	_we_64zh
global	_we_64b
global	_we_64o

global	_we_z
global	_we_c
global	_we_ch

global	_we
global	_we_dl

global	_czysc_klaw

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
extern	_pisz_z
%endif

%if (__DOS > 0) || (__BIOS > 0)
 ; %include	"..\incl\dosbios\nasm\n_const.inc"
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 %if (__COFF == 0)
  segment         biblioteka_wej
 %else
  segment         .text
 %endif
%else
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 %include	"../incl/linuxbsd/nasm/n_system.inc"

 ;*************************************

 section         .data
 znak		db	0

 ;*************************************

 section		.text
%endif

;;
; Pobiera z klawiatury liczbe 16-bitowa bez znaku.
; Makro: we16
; @return AX=wczytana liczba (gdy CF=0), AX=-1 i CF=1, gdy blad.
;;
_we_l:
	pushf
	push	bx
	push	cx
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx		; miejsce na liczbe

.l_petla:
	bibl_call	_we_z	; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.l_juz		; jesli tak, to wychodzimy
	cmp	al, cr
	je	.l_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.l_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.l_petla

	cmp	al, '0'		; jesli nie cyfra, to blad
	jb	.l_blad
	cmp	al, '9'
	ja	.l_blad

	and	al, 0fh		; izolujemy wartosc
	mov	cl, al
	mov	ax, bx

	shl	bx, 1		; zrobimy miejsce na nowa cyfre
	jc	.l_blad

	shl	ax, 1
	jc	.l_blad
	shl	ax, 1
	jc	.l_blad
	shl	ax, 1
	jc	.l_blad

	add	bx, ax		; BX=BX*10 - biezaca liczbe mnozymy przez 10
	jc	.l_blad

	add	bl, cl		; dodajemy cyfre
	adc	bh, 0
	jc	.l_blad		; jesli przekroczony limit, to blad

	jmp	short .l_petla

%if (__DOS > 0) || (__BIOS > 0)
.l_bksp:
	test	si, si
	jz	.l_petla

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	push	dx
	mov	cx, 10
	mov	ax, bx
	xor	dx, dx
	div	cx
	mov	bx, ax
	pop	dx

	jmp	.l_petla
%endif

.l_blad:
	xor	ax, ax

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	pop	bx
	dec	ax		;AX=0FFFFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

.l_juz:
	mov	ax, bx

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury liczbe 16-bitowa szesnastkowa bez znaku.
; Makro: we16h
; @return AX=wczytana liczba (gdy CF=0), AX=-1 i CF=1, gdy blad.
;;
_we_lh:
	pushf
	push	bx
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx

.lh_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.lh_juz		; jesli tak, to wychodzimy
	cmp	al, cr
	je	.lh_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.lh_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.lh_petla

	cmp	al, '0'		; sprawdzamy, czy AL jest w '0'-'9' lub 'A'-'F'
	jb	.lh_blad
	cmp	al, '9'
	ja	.lh_dalej
	and	al, 0fh		; izolujemy wartosc

	jmp	short .lh_ok

.lh_dalej:
	cmp	al, 'A'
	jb	.lh_blad
	cmp	al, 'F'
	ja	.lh_dalej_2
	sub	al, 'A'-10	; izolujemy wartosc
	jmp	short .lh_ok

.lh_dalej_2:
	cmp	al, 'a'
	jb	.lh_blad
	cmp	al, 'f'
	ja	.lh_blad
	sub	al, 'a'-10	; izolujemy wartosc

.lh_ok:
	shl	bx, 1		; robimy miejsce dla nowej cyfry,
				; sprawdzajac, czy miescimy sie w
	jc	.lh_blad	; granicach
	shl	bx, 1
	jc	.lh_blad
	shl	bx, 1
	jc	.lh_blad
	shl	bx, 1
	jc	.lh_blad
	or	bl, al		; dopisujemy nowa cyfre
	jmp	short .lh_petla
%if (__DOS > 0) || (__BIOS > 0)
.lh_bksp:
	test	si, si
	jz	.lh_petla

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	shr	bx, 1
	shr	bx, 1
	shr	bx, 1
	shr	bx, 1
	jmp	.lh_petla
%endif

.lh_blad:
	xor	ax, ax

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	bx
	dec	ax		; AX=0FFFFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

.lh_juz:
	mov	ax, bx

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe 16-bitowa ze znakiem.
; Makro: we16z
; @return AX=wczytana liczba (gdy CF=0), AX=-1 i CF=1, gdy blad.
;;
_we_lz:
	pushf
	push	bx
	push	cx
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif
	xor	bx, bx

.lz_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	xor	cx, cx

	cmp	al, lf		; czy Enter?
	je	.lz_juz		; jesli tak, to wychodzimy
	cmp	al, cr
	je	.lz_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.lz_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.lz_pocz

	cmp	al, '-'
	jne	.lz_dalej1
	inc	ch		; znacznik, ze wpisano minus
	jmp	.lz_ok

%if (__DOS > 0) || (__BIOS > 0)
.lz_bksp:
	test	si, si
	jz	.lz_pocz
	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	test	si, si
	jnz	.lz_nie_pocz

	; jesli SI = 0, to zaczynamy od poczatku
	xor	bx, bx
	xor	cx, cx

	jmp	.lz_pocz

.lz_nie_pocz:
	test	bx, bx
	jnz	.lz_bksp_byly_cyfry

	jmp	short .lz_ok
.lz_bksp_byly_cyfry:
	push	dx
	push	cx
	mov	cx, 10
	mov	ax, bx
	xor	dx, dx
	div	cx
	mov	bx, ax
	pop	cx
	pop	dx
	jmp	short .lz_ok
%endif

.lz_dalej1:
	cmp	al, '+'
	jne	.lz_petla
	jmp	short .lz_ok

.lz_petla:
	cmp	al, '0'		; sprawdzamy, czy AL to cyfra
	jb	.lz_blad
	cmp	al, '9'
	ja	.lz_blad
	and	al, 0fh		; izolujemy wartosc

	mov	cl, al

	mov	ax, bx		; robimy miejsce:
	shl	bx, 1
	jc	.lz_blad

	shl	ax, 1
	jc	.lz_blad
	shl	ax, 1
	jc	.lz_blad
	shl	ax, 1
	jc	.lz_blad
	add	bx, ax		; BX=BX*10 - stara liczbe mnozymy przez 10
	jc	.lz_blad

	add	bl, cl		; dodajemy cyfre
	adc	bh, 0
	jc	.lz_blad	; jesli liczba zbyt duza - blad

.lz_ok:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.lz_juz		; jesli tak, to wychodzimy
	cmp	al, cr
	je	.lz_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.lz_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.lz_ok

	jmp	short .lz_petla

.lz_blad:
	xor	ax, ax

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	dec	ax		; AX=0FFFFh
	pop	bx

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

.lz_juz:
	or	ch, ch		; czy wpisano minus?
	jnz	.lz_minus_juz

	or	bx,bx
	js	.lz_blad	; blad jesli liczba > 32767

	mov	ax, bx

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

.lz_minus_juz:
	cmp	bx, 8000h
	ja	.lz_blad	; blad jesli chcemy liczbe ujemna < -32768

	neg	bx
	mov	ax, bx
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe szesnastkowa 16-bitowa ze znakiem.
; Makro: we16zh
; @return AX=wczytana liczba (gdy CF=0), AX=-1 i CF=1, gdy blad.
;;
_we_lzh:
	pushf
	push	bx
	push	cx
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx

.lzh_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	xor	cx, cx

	cmp	al, lf		; czy Enter?
	je	.lzh_juz
	cmp	al, cr
	je	.lzh_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.lzh_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.lzh_pocz

	cmp	al, '-'
	jne	.lzh_spr_dalej0
	inc	ch		; znacznik, ze wpisano minus
	jmp	.lzh_plus

.lzh_spr_dalej0:
	cmp	al, '+'
	jne	.lzh_petla
	jmp	.lzh_plus

.lzh_petla:			; spr., czy znak jest cyfra hex
	cmp	al, '0'
	jb	.lzh_blad
	cmp	al, '9'
	ja	.lzh_dalej
	and	al,0fh		; izolujemy wartosc

	jmp	short .lzh_ok

.lzh_dalej:
	cmp	al, 'A'
	jb	.lzh_blad
	cmp	al, 'F'
	ja	.lzh_dalej_2
	sub	al, 'A'-10	; izolujemy wartosc

	jmp	short .lzh_ok

.lzh_blad:
	xor	ax, ax

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	pop	bx
	dec	ax		;AX=0FFFFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

%if (__DOS > 0) || (__BIOS > 0)
.lzh_bksp:
	test	si, si
	jz	.lzh_pocz

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	test	si, si
	jnz	.lzh_nie_pocz

	; jesli SI = 0, to zaczynamy od poczatku
	xor	bx, bx
	xor	cx, cx

	jmp	.lzh_pocz

.lzh_nie_pocz:
	test	bx, bx
	jnz	.lzh_bksp_byly_cyfry

	jmp	short .lzh_plus
.lzh_bksp_byly_cyfry:
	shr	bx, 1
	shr	bx, 1
	shr	bx, 1
	shr	bx, 1
	jmp	short .lzh_plus
%endif

.lzh_juz:
	test	ch, ch		; czy wpisano minus?
	jnz	.lzh_minus_juz

	test	bx, bx
	js	.lzh_blad	; blad jesli liczba > 32767

	mov	ax, bx

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

.lzh_dalej_2:
	cmp	al, 'a'
	jb	.lzh_blad
	cmp	al, 'f'
	ja	.lzh_blad
	sub	al, 'a'-10	; izolujemy wartosc

.lzh_ok:
	shl	bx, 1		; miejsce dla nowej cyfry
	jc	.lzh_blad
	shl	bx, 1
	jc	.lzh_blad
	shl	bx, 1
	jc	.lzh_blad
	shl	bx, 1
	jc	.lzh_blad
	or	bl, al		; dopisujemy nowa cyfre

.lzh_plus:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.lzh_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	.lzh_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.lzh_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.lzh_plus

	jmp	.lzh_petla

.lzh_minus_juz:
	cmp	bx, 8000h
	ja	.lzh_blad	; blad jesli liczba < -32768
	neg	bx		; zmiana znaku
	mov	ax, bx

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury 16-bitowa liczbe dwojkowa bez znaku.
; Makro: we16b
; @return AX=wczytana liczba (gdy CF=0), AX=-1 i CF=1, gdy blad.
;;
_we_lb:
	pushf
	push	bx
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx

.lb_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.lb_juz		; jesli tak, to wychodzimy
	cmp	al, cr
	je	.lb_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.lb_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.lb_pocz

	cmp	al, '0'		; AL moze byc tylko 1 lub 0
	jb	.lb_blad
	cmp	al, '1'
	ja	.lb_blad

	and	al, 1		; izolujemy wartosc
	shl	bx, 1		; miejsce dla nowej cyfry
	jc	.lb_blad

	or	bl, al		; dopisujemy cyfre
	jmp	short .lb_pocz
%if (__DOS > 0) || (__BIOS > 0)
.lb_bksp:
	test	si, si
	jz	.lb_pocz

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	shr	bx, 1

	jmp	short .lb_pocz
%endif

.lb_blad:
	xor	ax, ax

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	bx
	dec	ax		; AX=FFFF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

.lb_juz:
	mov	ax, bx

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop 	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury 16-bitowa liczbe osemkowa bez znaku.
; Makro: we16o
; @return AX=wczytana liczba (gdy CF=0), AX=-1 i CF=1, gdy blad.
;;
_we_lo:
	pushf
	push	bx
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx		; miejsce na liczbe

.lo_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.lo_juz		; jesli tak, to wychodzimy
	cmp	al, cr
	je	.lo_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.lo_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.lo_petla

	cmp	al, '0'		; jesli nie cyfra, to blad
	jb	.lo_blad
	cmp	al, '7'
	ja	.lo_blad

	and	al, 0fh		; izolujemy wartosc

	shl	bx, 1		; zrobimy miejsce na nowa cyfre
	jc	.lo_blad

	shl	bx, 1
	jc	.lo_blad

	shl	bx, 1
	jc	.lo_blad
				; BX = BX  * 8

	add	bl, al		; dodajemy cyfre
	adc	bh, 0
	jc	.lo_blad	; jesli przekroczony limit, to blad

	jmp	short .lo_petla
%if (__DOS > 0) || (__BIOS > 0)
.lo_bksp:
	test	si, si
	jz	.lo_petla

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

        shr	bx, 1
        shr	bx, 1
        shr	bx, 1

	jmp	short .lo_petla
%endif

.lo_blad:
	xor	ax, ax

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	bx
	dec	ax		; AX=0FFFFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

.lo_juz:
	mov	ax, bx

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe 8-bitowa bez znaku.
; Makro: we8
; @return AL=wczytana liczba (gdy CF=0), AL=-1 i CF=1, gdy blad.
;;
_we_8:
	pushf
	push	bx
	push	cx
	push	ax
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx

._8_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._8_juz		; jesli tak, to wychodzimy
	cmp	al, cr
	je	._8_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._8_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._8_petla

	cmp	al, '0'		; czy AL to cyfra?
	jb	._8_blad
	cmp	al, '9'
	ja	._8_blad

	and	al, 0fh		; izolujemy wartosc
	mov	cl, al
	mov	al, bl

	shl	bl, 1		; miejsce dla nowej cyfry:
	jc	._8_blad

	shl	al, 1
	jc	._8_blad
	shl	al, 1
	jc	._8_blad
	shl	al, 1
	jc	._8_blad

	add	bl, al		; BL=BL*10
	jc	._8_blad

	add	bl, cl		; dodajemy nowa cyfre
	jc	._8_blad
	jmp	short ._8_petla

%if (__DOS > 0) || (__BIOS > 0)
._8_bksp:
	test	si, si
	jz	._8_petla

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	mov	cl, 10
	xor	bh, bh
	mov	ax, bx
	div	cl
	mov	bx, ax

	jmp	short ._8_petla
%endif

._8_blad:
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	pop	cx
	xor	al, al
	pop	bx
	dec	al		; AL=0FFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

._8_juz:
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	mov	al, bl
	pop	cx
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe 8-bitowa szesnastkowa bez znaku.
; Makro: we8h
; @return AL=wczytana liczba (gdy CF=0), AL=-1 i CF=1, gdy blad.
;;
_we_8h:
	pushf
	push	bx
	push	ax
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx

._8h_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._8h_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._8h_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._8h_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy spacje:
	cmp	al, spc
	je	._8h_petla

	cmp	al, '0'		; spr., czy znak jest cyfra hex
	jb	._8h_blad
	cmp	al, '9'
	ja	._8h_dalej

	and	al, 0fh		; izolujemy wartosc
	jmp	short ._8h_ok

._8h_dalej:
	cmp	al, 'A'
	jb	._8h_blad
	cmp	al, 'F'
	ja	._8h_dalej_2
	sub	al, 'A'-10	; izolujemy wartosc
	jmp	short ._8h_ok

._8h_dalej_2:
	cmp	al, 'a'
	jb	._8h_blad
	cmp	al, 'f'
	ja	._8h_blad
	sub	al, 'a'-10	; izolujemy wartosc

._8h_ok:
	shl	bl, 1		; robimy miejsce dla nowej cyfry
	jc	._8h_blad
	shl	bl, 1
	jc	._8h_blad
	shl	bl, 1
	jc	._8h_blad
	shl	bl, 1
	jc	._8h_blad

	or	bl, al		; dopisujemy nowa cyfre
	jmp	short ._8h_petla
%if (__DOS > 0) || (__BIOS > 0)
._8h_bksp:
	test	si, si
	jz	._8h_petla

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

        shr	bl, 1
        shr	bl, 1
        shr	bl, 1
        shr	bl, 1

	jmp	short ._8h_petla
%endif

._8h_blad:
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	xor	al, al
	pop	bx
	dec	al		;AL=0FFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

._8h_juz:
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	mov	al, bl
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe 8-bitowa ze znakiem.
; Makro: we8z
; @return AL=wczytana liczba (gdy CF=0), AL=-1 i CF=1, gdy blad.
;;
_we_8z:
	pushf
	push	bx
	push	cx
	push	ax
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif
	xor	bx, bx

._8z_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	xor	cx, cx

	cmp	al, lf		; czy Enter?
	je	._8z_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._8z_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._8z_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._8z_pocz

	cmp	al, '-'
	jne	._8z_dalej1
	inc	ch		; znacznik, ze wprowadzono minus
	jmp	._8z_ok

._8z_dalej1:
	cmp	al, '+'
	jne	._8z_petla
	jmp	short ._8z_ok

._8z_petla:
	cmp	al, '0'		; blad, jesli nie cyfra
	jb	._8z_blad
	cmp	al, '9'
	ja	._8z_blad
	and	al, 0fh		; izolujemy wartosc

	mov	cl, al

	mov	al, bl
	shl	bl, 1		; robimy miejsce dla nowej cyfry
	jc	._8z_blad

	shl	al, 1
	jc	._8z_blad
	shl	al, 1
	jc	._8z_blad
	shl	al, 1
	jc	._8z_blad
	add	bl, al		; BL=BL*10
	jc	._8z_blad

	add	bl, cl		; dodajemy nowa cyfre
	jc	._8z_blad

._8z_ok:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._8z_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._8z_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._8z_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._8z_ok

	jmp	short ._8z_petla

._8z_blad:
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	xor	al,al
	pop	cx
	pop	bx
	dec	al		;AL=0FFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

%if (__DOS > 0) || (__BIOS > 0)
._8z_bksp:
	test	si, si
	jz	._8z_pocz

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	test	si, si
	jnz	._8z_nie_pocz

	; jesli SI = 0, to zaczynamy od poczatku
	xor	bx, bx
	xor	cx, cx

	jmp	._8z_pocz

._8z_nie_pocz:
	test	bx, bx
	jnz	._8z_bksp_byly_cyfry

	jmp	._8z_ok
._8z_bksp_byly_cyfry:
	mov	cl, 10
	xor	bh, bh
	mov	ax, bx
	div	cl
	mov	bx, ax

	jmp	._8z_ok
%endif

._8z_minus_juz:
	cmp	bl, 80h
	ja	._8z_blad	; blad, jesli liczba < -128

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	neg	bl
	mov	al, bl
	pop	cx
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

._8z_juz:
	test	ch, ch		; czy wprowadzono minus?
	jnz	._8z_minus_juz

	test	bl, bl
	js	._8z_blad	; blad jesli liczba > 127

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	mov	al, bl
	pop	cx
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury liczbe 8-bitowa szesnastkowa ze znakiem.
; Makro: we8zh
; @return AL=wczytana liczba (gdy CF=0), AL=-1 i CF=1, gdy blad.
;;
_we_8zh:
	pushf
	push	bx
	push	cx
	push	ax
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx

._8zh_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	xor	cx, cx

	cmp	al, lf		; czy Enter?
	je	._8zh_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._8zh_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._8zh_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._8zh_pocz

	cmp	al, '-'
	jne	._8zh_spr_dalej0
	inc	ch		; znacznik, ze wprowadzono minus
	jmp	._8zh_plus

._8zh_spr_dalej0:
	cmp	al, '+'
	jne	._8zh_petla
	jmp	._8zh_plus

._8zh_petla:			; spr., czy znak jest cyfra hex
	cmp	al, '0'
	jb	._8zh_blad
	cmp	al, '9'
	ja	._8zh_dalej
	and	al, 0fh		; izolujemy wartosc
	jmp	short ._8zh_ok

._8zh_dalej:
	cmp	al, 'A'
	jb	._8zh_blad
	cmp	al, 'F'
	ja	._8zh_dalej_2
	sub	al, 'A'-10	; izolujemy wartosc
	jmp	short ._8zh_ok
%if (__DOS > 0) || (__BIOS > 0)
._8zh_bksp:
	test	si, si
	jz	._8zh_pocz

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	test	si, si
	jnz	._8zh_nie_pocz

	; jesli SI = 0, to zaczynamy od poczatku
	xor	bx, bx
	xor	cx, cx

	jmp	._8zh_pocz

._8zh_nie_pocz:
	test	bx, bx
	jnz	._8zh_bksp_byly_cyfry

	jmp	short ._8zh_plus
._8zh_bksp_byly_cyfry:
        shr	bl, 1
        shr	bl, 1
        shr	bl, 1
        shr	bl, 1

	jmp	short ._8zh_plus
%endif

._8zh_blad:
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	xor	al, al
	pop	cx
	pop	bx
	dec	al		; AL=0FFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

._8zh_dalej_2:
	cmp	al, 'a'
	jb	._8zh_blad
	cmp	al, 'f'
	ja	._8zh_blad
	sub	al, 'a'-10	; izolujemy wartosc

._8zh_ok:

	shl	bl, 1		; robimy miejsce dla nowej cyfry
	jc	._8zh_blad
	shl	bl, 1
	jc	._8zh_blad
	shl	bl, 1
	jc	._8zh_blad
	shl	bl, 1		; miejsce na nowa cyfre
	jc	._8zh_blad

	or	bl, al		; dopisz nowa cyfre

._8zh_plus:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._8zh_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._8zh_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._8zh_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._8zh_plus

	jmp	._8zh_petla

._8zh_minus_juz:
	cmp	bl, 80h
	ja	._8zh_blad	; blad jesli liczba < -128
	neg	bl		; zmieniamy znak

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	mov	al, bl
	pop	cx
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

._8zh_juz:
	test	ch, ch		; czy wprowadzono minus?
	jnz	._8zh_minus_juz

	test	bl, bl
	js	._8zh_blad	; blad jesli liczba > 127

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	mov	al, bl
	pop	cx
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe 8-bitowa dwojkowa bez znaku.
; Makro: we8b
; @return AL=wczytana liczba (gdy CF=0), AL=-1 i CF=1, gdy blad.
;;
_we_8b:
	pushf
	push	bx
	push	ax
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx

._8b_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._8b_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._8b_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._8b_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._8b_pocz

	cmp	al, '0'		; musi byc albo 0 albo 1
	jb	._8b_blad
	cmp	al, '1'
	ja	._8b_blad

	and	al, 1		; izolujemy wartosc
	shl	bl, 1		; miejsce dla nowej cyfry
	jc	._8b_blad

	or	bl, al		; dopisujemy nowa cyfre
	jmp	short ._8b_pocz
%if (__DOS > 0) || (__BIOS > 0)
._8b_bksp:
	test	si, si
	jz	._8b_pocz

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

        shr	bl, 1

	jmp	short ._8b_pocz
%endif

._8b_blad:
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	xor	al, al
	pop	bx
	dec	al		; AL=FF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

._8b_juz:
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	mov	al, bl
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe 8-bitowa osemkowa bez znaku.
; Makro: we8o
; @return AL=wczytana liczba (gdy CF=0), AL=-1 i CF=1, gdy blad.
;;
_we_8o:
	pushf
	push	bx
	push	ax
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx

._8o_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._8o_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._8o_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._8o_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._8o_petla

	cmp	al, '0'		; czy AL to cyfra?
	jb	._8o_blad
	cmp	al, '7'
	ja	._8o_blad

	and	al, 0fh		; izolujemy wartosc

	shl	bl, 1		; miejsce dla nowej cyfry:
	jc	._8o_blad

	shl	bl, 1
	jc	._8o_blad

	shl	bl, 1
	jc	._8o_blad
				; BL = BL * 8

	add	bl, al		; dodajemy nowa cyfre
	jc	._8o_blad
	jmp	short ._8o_petla
%if (__DOS > 0) || (__BIOS > 0)
._8o_bksp:
	test	si, si
	jz	._8o_petla

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

        shr	bl, 1
        shr	bl, 1
        shr	bl, 1

	jmp	short ._8o_petla
%endif

._8o_blad:
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	xor	al, al
	pop	bx
	dec	al		; AL=0FFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

._8o_juz:
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	ax
	mov	al, bl
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe 32-bitowa bez znaku.
; Makro: we32
; @return DX:AX=wczytana liczba (gdy CF=0), DX:AX=-1 i CF=1, gdy blad.
;;
_we_32:
	pushf
	push	bx
	push	bp
	push	cx
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	dx, dx
	xor	bx, bx

._32_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._32_bksp
%endif

	cmp	al, lf		; czy Enter?
	jne	._32_dalej1
._32_juz:
				; jesli tak, to wychodzimy
	mov	ax, bx
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	pop	bp
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

._32_dalej1:
	cmp	al, cr
	je	._32_juz
%if (__DOS > 0) || (__BIOS > 0)
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._32_petla

	cmp	al, '0'		; sprawdz, czy cyfra:
	jb	._32_blad
	cmp	al, '9'
	ja	._32_blad

	and	ax, 0fh		;celowo AX, aby wyzerowac AH i izolujemy wartosc

	mov	cx, bx
	mov	bp, dx

	shl	bx, 1		; robimy miejsce dla nowej cyfry
	rcl	dx, 1
	jc	._32_blad
	shl	bx, 1
	rcl	dx, 1
	jc	._32_blad
	shl	bx, 1
	rcl	dx, 1
	jc	._32_blad

	shl	cx, 1
	rcl	bp, 1

	add	bx, cx		;bx=bx*10
	adc	dx, bp		; DX:BX = DX:BX*10
	jc	._32_blad

	add	bx, ax		; dodajemy nowa cyfre
	adc	dx, 0
	jc	._32_blad

	jmp	short ._32_petla

._32_blad:
	xor	ax, ax

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	dec	ax
	pop	bp
	pop	bx
	mov	dx, ax		;DX:AX=FFFF:FFFF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

%if (__DOS > 0) || (__BIOS > 0)
._32_bksp:
	test	si, si
	jz	._32_petla

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	mov	bp, bx
	mov	ax, dx
	xor	dx, dx
	mov	cx, 10
	div	cx		; zachowac reszte
	push	ax
	mov	ax, bp
	div	cx
	pop	dx		; tak, zdejmujemy AX
	mov	bx, ax

	jmp	._32_petla
%endif


;*************************************

;;
; Pobiera z klawiatury liczbe 32-bitowa szesnastkowa bez znaku.
; Makro: we32h
; @return DX:AX=wczytana liczba (gdy CF=0), DX:AX=-1 i CF=1, gdy blad.
;;
_we_32h:
	pushf
	push	bx
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx
	xor	dx, dx

._32h_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._32h_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._32h_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._32h_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._32h_petla

	cmp	al, '0'		; sprawdz, czy cyfra hex
	jb	._32h_blad
	cmp	al, '9'
	ja	._32h_dalej1
	and	al, 0fh		; izloujemy wartosc
	jmp	short ._32h_ok

._32h_dalej1:
	cmp	al, 'A'
	jb	._32h_blad
	cmp	al, 'F'
	ja	._32h_dalej2
	sub	al, 'A'-10	; izolujemy wartosc
	jmp	short ._32h_ok

._32h_dalej2:
	cmp	al, 'a'
	jb	._32h_blad
	cmp	al, 'f'
	ja	._32h_blad
	sub	al, 'a'-10	; izolujemy wartosc

._32h_ok:
	shl	bx, 1
	rcl	dx, 1
	jc	._32h_blad

	shl	bx, 1		; robimy miejsce dla nowej cyfry
				; ( "SHL DX:BX,4" )
	rcl	dx, 1
	jc	._32h_blad

	shl	bx, 1
	rcl	dx, 1
	jc	._32h_blad

	shl	bx, 1
	rcl	dx, 1
	jc	._32h_blad

	or	bl, al		; dopisujemy nowa cyfre
	jmp	short ._32h_petla
%if (__DOS > 0) || (__BIOS > 0)
._32h_bksp:
	test	si, si
	jz	._32h_petla

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	shr	dx, 1
	rcr	bx, 1

	shr	dx, 1
	rcr	bx, 1

	shr	dx, 1
	rcr	bx, 1

	shr	dx, 1
	rcr	bx, 1

	jmp	._32h_petla
%endif

._32h_blad:
	xor	ax, ax
	dec	ax
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	bx
	mov	dx, ax		; DX:AX=FFFF:FFFF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

._32h_juz:
	mov	ax, bx
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury liczbe 32-bitowa ze znakiem.
; Makro: we32z
; @return DX:AX=wczytana liczba (gdy CF=0), DX:AX=-1 i CF=1, gdy blad.
;;
_we_32z:
	pushf
	push	bp
	push	bx
	push	cx
	push	di
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; lizcnik znakow
	xor	si, si
%endif

	xor	dx, dx
	xor	bx, bx

._32z_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	xor	di, di

	cmp	al, lf		; czy Enter?
	je	._32z_juz	; jesli Enter, to wychodzimy
	cmp	al, cr
	je	._32z_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._32z_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._32z_pocz

	cmp	al, '-'
	jne	._32z_dalej1
	inc	di		; znacznik, ze wprowadzono minus
	jmp	._32z_ok

._32z_dalej1:
	cmp	al, '+'
	jne	._32z_petla
	jmp	short ._32z_ok

._32z_petla:			; sprawdzamy, czy cyfra:
	cmp	al, '0'
	jb	._32z_blad
	cmp	al, '9'
	ja	._32z_blad
	and	ax, 0fh		;zeruje AH i izoluje wartosc

	mov	cx, bx
	mov	bp, dx

	shl	bx, 1		; robimy miejsce dla nowej cyfry
	rcl	dx, 1
	jc	._32z_blad
	shl	bx, 1
	rcl	dx, 1
	jc	._32z_blad
	shl	bx, 1
	rcl	dx, 1
	jc	._32z_blad

	shl	cx, 1
	rcl	bp, 1

	add	bx, cx		; bx=bx*10
	adc	dx, bp		; DX:BX = DX:BX*10
	jc	._32z_blad

	add	bx, ax		; dodajemy nowa cyfre
	adc	dx, 0
	jc	._32z_blad

._32z_ok:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._32z_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._32z_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._32z_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._32z_ok

	jmp	short ._32z_petla

._32z_blad:
	xor	ax, ax
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	di
	pop	cx
	dec	ax		;AX=0FFFFh
	pop	bx
	pop	bp
	mov	dx, ax

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

%if (__DOS > 0) || (__BIOS > 0)
._32z_bksp:
	test	si, si
	jz	._32z_pocz
	dec	si

	mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	test	si, si
	jnz	._32z_nie_pocz

	; jesli SI = 0, to zaczynamy od poczatku
	xor	bx, bx
	xor	dx, dx
	xor	di, di

	jmp	._32z_pocz

._32z_nie_pocz:
	mov	ax, bx
	or	ax, dx
	jnz	._32z_bksp_byly_cyfry

	jmp	._32z_ok
._32z_bksp_byly_cyfry:
	mov	bp, bx
	mov	ax, dx
	xor	dx, dx
	mov	cx, 10
	div	cx		; zachowac reszte
	push	ax
	mov	ax, bp
	div	cx
	pop	dx		; tak, zdejmujemy AX
	mov	bx, ax

	jmp	._32z_ok
%endif

._32z_juz:
	test	di, di		; czy wprowadzono minus?
	jnz	._32z_minus_juz

	test	dx, dx
	js	._32z_blad	; blad - liczba za duza

	mov	ax, bx

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	di
	pop	cx
	pop	bx
	pop	bp
	popf
	clc			; zwroc brak bledu
	bibl_ret

._32z_minus_juz:
	cmp	dx, 8000h
	ja	._32z_blad	; blad - liczba za mala
	neg	dx
	neg	bx
	sbb	dx, 0		; zmien znak
	mov	ax, bx

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	di
	pop	cx
	pop	bx
	pop	bp
	popf
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury liczbe 32-bitowa szesnastkowa ze znakiem.
; Makro: we32zh
; @return DX:AX=wczytana liczba (gdy CF=0), DX:AX=-1 i CF=1, gdy blad.
;;
_we_32zh:
	pushf
	push	bx
	push	cx
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	dx, dx
	xor	bx, bx

._32zh_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	xor	cx, cx

	cmp	al, lf		; czy Enter?
	je	._32zh_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._32zh_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._32zh_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._32zh_pocz

	cmp	al, '-'
	jne	._32zh_spr_dalej0
	inc	ch		; znacznik, ze wprowadzono minus
	jmp	._32zh_plus

._32zh_spr_dalej0:
	cmp	al, '+'
	jne	._32zh_petla
	jmp	._32zh_plus

._32zh_petla:			; sprawdzimy, czy cyfra hex:
	cmp	al, '0'
	jb	._32zh_blad
	cmp	al, '9'
	ja	._32zh_dalej
	and	al, 0fh		; izolujemy wartosc
	jmp	short ._32zh_ok

._32zh_dalej:
	cmp	al, 'A'
	jb	._32zh_blad
	cmp	al, 'F'
	ja	._32zh_dalej_2
	sub	al, 'A'-10	; izolujemy wartosc
	jmp	short ._32zh_ok

._32zh_blad:
	xor	ax, ax

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	dec	ax		; AX=0FFFFh
	pop	bx
	mov	dx, ax		; DX:AX = FFFF:FFFF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

%if (__DOS > 0) || (__BIOS > 0)
._32zh_bksp:
	test	si, si
	jz	._32zh_pocz
	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	test	si, si
	jnz	._32zh_nie_pocz

	; jesli SI = 0, to zaczynamy od poczatku
	xor	bx, bx
	xor	dx, dx
	xor	di, di

	jmp	._32zh_pocz

._32zh_nie_pocz:
	mov	ax, bx
	or	ax, dx
	jnz	._32zh_bksp_byly_cyfry

	jmp	short ._32zh_plus
._32zh_bksp_byly_cyfry:
	shr	dx, 1
	rcr	bx, 1

	shr	dx, 1
	rcr	bx, 1

	shr	dx, 1
	rcr	bx, 1

	shr	dx, 1
	rcr	bx, 1

	jmp	._32zh_plus
%endif

._32zh_dalej_2:
	cmp	al, 'a'
	jb	._32zh_blad
	cmp	al, 'f'
	ja	._32zh_blad
	sub	al, 'a'-10	; izolujemy wartosc

._32zh_ok:
	shl	bx, 1		; robimy miejsce dla nowej cyfry
	rcl	dx, 1
	jc	._32zh_blad

	shl	bx, 1
	rcl	dx, 1
	jc	._32zh_blad

	shl	bx, 1
	rcl	dx, 1
	jc	._32zh_blad

	shl	bx, 1
	rcl	dx, 1		; "SHL DX:BX,4"
	jc	._32zh_blad

	or	bl, al		; dopisujemy nowa cyfre

._32zh_plus:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._32zh_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._32zh_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._32zh_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._32zh_plus

	jmp	._32zh_petla


._32zh_minus_juz:
	cmp	dx, 8000h
	ja	._32zh_blad	; blad - zbyt mala liczba
	neg	dx
	neg	bx
	sbb	dx, 0		; zmieniamy znak
	mov	ax, bx

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

._32zh_juz:
	test	ch, ch		; czy wprowadzono minus?
	jnz	._32zh_minus_juz

	test	dx, dx
	js	._32zh_blad	; blad - zbyt duza liczba

	mov	ax, bx

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	cx
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury liczbe 32-bitowa dwojkowa bez znaku.
; Makro: we32b
; @return DX:AX=wczytana liczba (gdy CF=0), DX:AX=-1 i CF=1, gdy blad.
;;
_we_32b:
	pushf
	push	bx
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx
	xor	dx, dx

._32_lb_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._32_lb_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._32_lb_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._32_lb_bksp
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._32_lb_pocz

	cmp	al, '0'		; czy 0 lub 1?
	jb	._32_lb_blad
	cmp	al, '1'
	ja	._32_lb_blad

	and	al, 1		; izolujemy nowa cyfre
	shl	bx, 1		; miejsce dla nowej cyfry:
	rcl	dx, 1		; "SHL DX:BX,1"
	jc	._32_lb_blad	; blad jesli zbyt duza liczba

	or	bl, al		; dopisujemy nowa cyfre
	jmp	short ._32_lb_pocz
%if (__DOS > 0) || (__BIOS > 0)
._32_lb_bksp:
	test	si, si
	jz	._32_lb_pocz

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	shr	dx, 1
	rcr	bx, 1

	jmp	short ._32_lb_pocz
%endif

._32_lb_blad:
	xor	ax, ax
	dec	ax		;AX=FFFF
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	bx
	mov	dx, ax		;DX:AX=FFFF:FFFF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

._32_lb_juz:
	mov	ax, bx
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe 32-bitowa osemkowa bez znaku.
; Makro: we32o
; @return DX:AX=wczytana liczba (gdy CF=0), DX:AX=-1 i CF=1, gdy blad.
;;
_we_32o:
	pushf
	push	bx
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	dx, dx
	xor	bx, bx

._32o_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._32o_bksp
%endif

	cmp	al, lf		; czy Enter?
	jne	._32o_dalej1
				; jesli tak, to wychodzimy
._32o_juz:
	mov	ax, bx
%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	bx
	popf
	clc			; zwroc brak bledu
	bibl_ret

._32o_dalej1:
	cmp	al, cr
	je	._32o_juz
%if (__DOS > 0) || (__BIOS > 0)
	bibl_call	_pisz_z
	inc	si
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._32o_petla

	cmp	al, '0'		; sprawdz, czy cyfra:
	jb	._32o_blad
	cmp	al, '7'
	ja	._32o_blad

	and	ax, 0fh		; celowo AX, aby wyzerowac AH i izolujemy wartosc


	shl	bx, 1		; robimy miejsce dla nowej cyfry
	rcl	dx, 1
	jc	._32o_blad

	shl	bx, 1
	rcl	dx, 1
	jc	._32o_blad

	shl	bx, 1
	rcl	dx, 1
	jc	._32o_blad
				; DX:BX = DX:BX * 8

	add	bx, ax		; dodajemy nowa cyfre
	adc	dx, 0
	jc	._32o_blad

	jmp	short ._32o_petla

._32o_blad:
	xor	ax, ax
	dec	ax

%if (__DOS > 0) || (__BIOS > 0)
	pop	si
%endif
	pop	bx
	mov	dx, ax		;DX:AX=FFFF:FFFF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

%if (__DOS > 0) || (__BIOS > 0)
._32o_bksp:
	test	si, si
	jz	._32o_petla

	dec	si

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	shr	dx, 1
	rcr	bx, 1

	shr	dx, 1
	rcr	bx, 1

	shr	dx, 1
	rcr	bx, 1

	jmp	._32o_petla
%endif


;*************************************

%if (__KOD_16BIT > 0)
 cpu 386
%endif

;;
; Pobiera z klawiatury liczbe 32-bitowa bez znaku.
; Makro: we32e
; @return EAX=wczytana liczba (gdy CF=0), EAX=-1 i CF=1, gdy blad.
;;
_we_ld:
	push_f
	push	rej(bx)
	push	rej(cx)
	push	rej(dx)
%if (__DOS > 0) || (__BIOS > 0)
	push	esi		; licznik znakow
	xor	esi, esi
%endif

	xor	ecx, ecx
	xor	ebx, ebx

.ld_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.ld_juz		; jesli tak, to wychodzimy
	cmp	al, cr
	je	.ld_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.ld_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.ld_petla

	cmp	al, '0'		; czy cyfra?
	jb	.ld_blad
	cmp	al, '9'
	ja	.ld_blad
	and	al, 0fh		; izolujemy wartosc

	mov	cl, al
	mov	eax, ebx

	shl	ebx, 1		; robimy miejsce
	jc	.ld_blad
	shl	eax, 1
	jc	.ld_blad
	shl	eax, 1
	jc	.ld_blad
	shl	eax, 1
	jc	.ld_blad
	add	ebx, eax	; EBX=EBX*10
	jc	.ld_blad

	add	ebx, ecx	; dodajemy cyfre
	jc	.ld_blad
	jmp	short .ld_petla

%if (__DOS > 0) || (__BIOS > 0)
.ld_bksp:
	test	esi, esi
	jz	.ld_petla

	dec	esi

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	mov	ecx, 10
	mov	eax, ebx
	xor	edx, edx
	div	ecx
	mov	ebx, eax

	jmp	short .ld_petla
%endif

.ld_blad:
	xor	eax, eax

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(bx)
	dec	eax 		; EAX=0FFFFFFFFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad
	bibl_ret

.ld_juz:
	mov	eax, ebx

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury liczbe 32-bitowa szesnastkowa bez znaku.
; Makro: we32eh
; @return EAX=wczytana liczba (gdy CF=0), EAX=-1 i CF=1, gdy blad.
;;
_we_ldh:
	push_f
	push	rej(bx)
%if (__DOS > 0) || (__BIOS > 0)
	push	esi		; licznik znakow
	xor	esi, esi
%endif

	xor	ebx, ebx

.ldh_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.ldh_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	.ldh_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.ldh_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.ldh_petla

	cmp	al, '0'		; czy cyfra hex?
	jb	.ldh_blad
	cmp	al, '9'
	ja	.ldh_dalej
	and	al, 0fh		; izolujemy wartosc
	jmp	short .ldh_ok

%if (__DOS > 0) || (__BIOS > 0)
.ldh_bksp:
	test	esi, esi
	jz	.ldh_petla

	dec	esi

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	shr	ebx, 4

	jmp	short .ldh_petla
%endif

.ldh_dalej:			; czy cyfra hex?
	cmp	al, 'A'
	jb	.ldh_blad
	cmp	al, 'F'
	ja	.ldh_dalej_2
	sub	al, 'A'-10	; izolujemy wartosc
	jmp	short .ldh_ok

.ldh_dalej_2:
	cmp	al, 'a'
	jb	.ldh_blad
	cmp	al, 'f'
	ja	.ldh_blad
	sub	al, 'a'-10	; izolujemy wartosc

.ldh_ok:
	shl	ebx, 1		; miejsce na nowa cyfre
	jc	.ldh_blad
	shl	ebx, 1
	jc	.ldh_blad
	shl	ebx, 1
	jc	.ldh_blad
	shl	ebx, 1
	jc	.ldh_blad

	or	bl, al		; dopisujemy nowa cyfre
	jmp	short .ldh_petla

.ldh_blad:
	xor	eax, eax

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(bx)
	dec	eax 		; EAX=0FFFFFFFFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad
	bibl_ret

.ldh_juz:
	mov	eax, ebx

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe 32-bitowa ze znakiem.
; Makro: we32ez
; @return EAX=wczytana liczba (gdy CF=0), EAX=-1 i CF=1, gdy blad.
;;
_we_ldz:
	push_f
	push	rej(bx)
	push	rej(cx)
	push	rej(dx)
	push	rej(di)
%if (__DOS > 0) || (__BIOS > 0)
	push	esi		; licznik znakow
	xor	esi, esi
%endif

	xor	ecx, ecx
	xor	edi, edi
	xor	ebx, ebx

.ldz_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	xor	edi, edi

	cmp	al, lf		; czy Enter?
	je	.ldz_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	.ldz_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.ldz_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.ldz_pocz

	cmp	al, '-'
	jne	.ldz_spr
	inc	edi		; znacznik, ze wprowadzono minus
	jmp	.ldz_ok

.ldz_spr:
	cmp	al, '+'
	jne	.ldz_petla
	jmp	short .ldz_ok

.ldz_petla:
	cmp	al, '0'		; czy cyfra?
	jb	.ldz_blad
	cmp	al, '9'
	ja	.ldz_blad
	and	al, 0fh		; izolujemy wartosc

	mov	cl, al
	mov	eax, ebx

	shl	ebx, 1		; miejsce dla nowej cyfry:
	jc	.ldz_blad
	shl	eax, 1
	jc	.ldz_blad
	shl	eax, 1
	jc	.ldz_blad
	shl	eax, 1
	jc	.ldz_blad
	add	ebx, eax	; EBX=EBX*10
	jc	.ldz_blad

	add	ebx, ecx	; dodajemy nowa cyfre
	jc	.ldz_blad

.ldz_ok:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.ldz_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	.ldz_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.ldz_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.ldz_ok

	jmp	short .ldz_petla
%if (__DOS > 0) || (__BIOS > 0)
.ldz_bksp:
	test	esi, esi
	jz	.ldz_pocz
	dec	esi

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	test	esi, esi
	jnz	.ldz_nie_pocz

	; jesli SI = 0, to zaczynamy od poczatku
	xor	ebx, ebx
	xor	edi, edi

	jmp	.ldz_pocz

.ldz_nie_pocz:
	test	ebx, ebx
	jnz	.ldz_bksp_byly_cyfry

	jmp	.ldz_ok
.ldz_bksp_byly_cyfry:

	mov	ecx, 10
	mov	eax, ebx
	xor	edx, edx
	div	ecx
	mov	ebx, eax

	jmp	.ldz_ok
%endif

.ldz_blad:
	xor	eax, eax

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(di)
	pop	rej(dx)
	dec	eax 		;EAX=0FFFFFFFFh
	pop	rej(cx)
	pop	rej(bx)

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad
	bibl_ret

.ldz_minus_juz:
	cmp	ebx, 80000000h
	ja	.ldz_blad	; blad jesli liczba ujemna za mala
	neg	ebx	 	; zmien znak

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(di)
	pop	rej(dx)
	pop	rej(cx)
	mov	eax, ebx
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret

.ldz_juz:
	test	edi, edi	; czy wprowadzono minus?
	jnz	.ldz_minus_juz

	test	ebx, ebx
	js	.ldz_blad	; blad jesli liczba zbyt duza

	mov	eax, ebx

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(di)
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury liczbe 32-bitowa szesnastkowa ze znakiem.
; Makro: we32ezh
; @return EAX=wczytana liczba (gdy CF=0), EAX=-1 i CF=1, gdy blad.
;;
_we_ldzh:
	push_f
	push	rej(bx)
	push	rej(di)
%if (__DOS > 0) || (__BIOS > 0)
	push	esi		; licznik znakow
	xor	esi, esi
%endif

	xor	ebx, ebx

.ldzh_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	xor	edi, edi

	cmp	al, lf		; czy Enter?
	je	.ldzh_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	.ldzh_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.ldzh_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.ldzh_pocz

	cmp	al, '-'
	jne	.ldzh_spr_dalej0
	inc	edi		; znacznik, ze wprowadzono minus
	jmp	.ldzh_plus

.ldzh_spr_dalej0:
	cmp	al, '+'
	jne	.ldzh_petla
	jmp	.ldzh_plus

.ldzh_petla:			; sprawdzimy, czy cyfra hex:
	cmp	al, '0'
	jb	.ldzh_blad
	cmp	al, '9'
	ja	.ldzh_dalej
	and	al, 0fh		; izolujemy wartosc
	jmp	short .ldzh_ok

.ldzh_dalej:
	cmp	al, 'A'
	jb	.ldzh_blad
	cmp	al, 'F'
	ja	.ldzh_dalej_2
	sub	al, 'A'-10	; izolujemy wartosc
	jmp	short .ldzh_ok

.ldzh_blad:
	xor	eax, eax

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(di)
	dec	eax 		; EAX=0FFFFFFFFh
	pop	rej(bx)

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad
	bibl_ret

%if (__DOS > 0) || (__BIOS > 0)
.ldzh_bksp:
	test	esi, esi
	jz	.ldzh_pocz
	dec	esi

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	test	esi, esi
	jnz	.ldzh_nie_pocz

	; jesli SI = 0, to zaczynamy od poczatku
	xor	ebx, ebx
	xor	edi, edi

	jmp	.ldzh_pocz

.ldzh_nie_pocz:
	test	ebx, ebx
	jnz	.ldzh_bksp_byly_cyfry

	jmp	.ldzh_plus
.ldzh_bksp_byly_cyfry:
	shr	ebx, 4

	jmp	.ldzh_plus
%endif

.ldzh_dalej_2:			; spr., czy cyfra hex - ciag dalszy
	cmp	al, 'a'
	jb	.ldzh_blad
	cmp	al, 'f'
	ja	.ldzh_blad
	sub	al, 'a'-10	; izolujemy wartosc

.ldzh_ok:
	shl	ebx, 1		; robimy miejsce dla nowej cyfry, i sprawdzamy, czy
	jc	.ldzh_blad	; miescimy sie w granicach
	shl	ebx, 1
	jc	.ldzh_blad
	shl	ebx, 1
	jc	.ldzh_blad
	shl	ebx, 1
	jc	.ldzh_blad
	or	bl, al		; dopisujemy nowa cyfre

.ldzh_plus:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.ldzh_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	.ldzh_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.ldzh_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.ldzh_plus

	jmp	.ldzh_petla

.ldzh_minus_juz:
	cmp	ebx, 80000000h
	ja	.ldzh_blad	; blad, jesli liczba ujemna za mala
	neg	ebx 		; zmieniamy znak

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(di)
	mov	eax, ebx
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret

.ldzh_juz:
	test	edi, edi
	jnz	.ldzh_minus_juz	; gdy wprowadzono minus

	test	ebx, ebx
	js	.ldzh_blad	; blad - liczba zbyt duza

	mov	eax, ebx

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(di)
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury liczbe 32-bitowa dwojkowa bez znaku.
; Makro: we32eb
; @return EAX=wczytana liczba (gdy CF=0), EAX=-1 i CF=1, gdy blad.
;;
_we_ldb:
	push_f
	push	rej(bx)
%if (__DOS > 0) || (__BIOS > 0)
	push	esi		; licznik znakow
	xor	esi, esi
%endif

	xor	ebx, ebx

.ldb_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.ldb_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	.ldb_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.ldb_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.ldb_pocz

	cmp	al, '0'		; czy AL to 0 lub 1?
	jb	.ldb_blad
	cmp	al, '1'
	ja	.ldb_blad

	and	al, 1		; izolujemy wartosc
	shl	ebx, 1		; robimy miejsce na nowa cyfre
	jc	.ldb_blad

	or	bl, al		; dopisujemy nowa cyfre
	jmp	short .ldb_pocz
%if (__DOS > 0) || (__BIOS > 0)
.ldb_bksp:
	test	esi, esi
	jz	.ldb_pocz

	dec	esi

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	shr	ebx, 1

	jmp	short .ldb_pocz
%endif

.ldb_blad:
	xor	eax, eax
%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(bx)
	dec	eax		; EAX=FFFFFFFF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad
	bibl_ret

.ldb_juz:
	mov	eax, ebx
%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe 32-bitowa osemkowa bez znaku.
; Makro: we32eo
; @return EAX=wczytana liczba (gdy CF=0), EAX=-1 i CF=1, gdy blad.
;;
_we_ldo:
	push_f
	push	rej(bx)
%if (__DOS > 0) || (__BIOS > 0)
	push	esi		; licznik znakow
	xor	esi, esi
%endif

	xor	ebx,ebx

.ldo_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.ldo_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	.ldo_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	.ldo_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.ldo_petla

	cmp	al, '0'		; czy cyfra?
	jb	.ldo_blad
	cmp	al, '7'
	ja	.ldo_blad
	and	eax, 0fh	; izolujemy wartosc. Celowo zeruje cal EAX.


	shl	ebx, 1		; robimy miejsce
	jc	.ldo_blad

	shl	ebx, 1
	jc	.ldo_blad

	shl	ebx, 1
	jc	.ldo_blad
				; EBX = EBX * 8

	add	ebx, eax	; dodajemy cyfre
	jc	.ldo_blad
	jmp	short .ldo_petla

%if (__DOS > 0) || (__BIOS > 0)
.ldo_bksp:
	test	esi, esi
	jz	.ldo_petla

	dec	esi

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	shr	ebx, 3

	jmp	short .ldo_petla
%endif

.ldo_blad:
	xor	eax, eax

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(bx)
	dec	eax 		; EAX=0FFFFFFFFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad
	bibl_ret

.ldo_juz:
	mov	eax, ebx

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe 64-bitowa bez znaku.
; Makro: we64
; @return EDX:EAX=wczytana liczba (gdy CF=0), EDX:EAX=-1 i CF=1, gdy blad.
;;
_we_64:
	push_f
	push	rej(bp)
	push	rej(bx)
	push	rej(cx)
%if (__DOS > 0) || (__BIOS > 0)
	push	esi		; licznik znakow
	xor	esi, esi
%endif

	xor	edx, edx
	xor	ebx, ebx

._64_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._64_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._64_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._64_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._64_petla

	cmp	al, '0'		; czy cyfra?
	jb	._64_blad
	cmp	al, '9'
	ja	._64_blad

	and	eax, 0fh	; celowo EAX, aby wyzerowac reszte bitow

	mov	ecx, ebx
	mov	ebp, edx

	shl	ebx, 1		; robimy miejsce na nowa cyfre
	rcl	edx, 1
	jc	._64_blad
	shl	ebx, 1
	rcl	edx, 1
	jc	._64_blad
	shl	ebx, 1
	rcl	edx, 1
	jc	._64_blad

	shl	ecx, 1
	rcl	ebp, 1

	add	ebx, ecx	; ebx=ebx*10
	adc	edx, ebp	; EDX:EBX = EDX:EBX*10
	jc	._64_blad

	add	ebx, eax
	adc	edx, 0		; dodajemy nowa cyfre
	jc	._64_blad

	jmp	._64_petla
%if (__DOS > 0) || (__BIOS > 0)
._64_bksp:
	test	esi, esi
	jz	._64_petla

	dec	esi

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	mov	ebp, ebx
	mov	eax, edx
	xor	edx, edx
	mov	ecx, 10
	div	ecx		; zachowac reszte
	push	eax
	mov	eax, ebp
	div	ecx
	pop	edx		; tak, zdejmujemy EAX
	mov	ebx, eax

	jmp	._64_petla
%endif

._64_blad:
	xor	eax, eax

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(cx)
	dec	eax
	pop	rej(bx)
	mov	edx, eax	; EDX:EAX=FFFFFFFF:FFFFFFFF
	pop	rej(bp)

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad
	bibl_ret

._64_juz:
	mov	eax, ebx

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(cx)
	pop	rej(bx)
	pop	rej(bp)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury liczbe 64-bitowa szesnastkowa bez znaku.
; Makro: we64h
; @return EDX:EAX=wczytana liczba (gdy CF=0), EDX:EAX=-1 i CF=1, gdy blad.
;;
_we_64h:
	push_f
	push	rej(bx)
%if (__DOS > 0) || (__BIOS > 0)
	push	esi		; licznik znakow
	xor	esi, esi
%endif

	xor	ebx, ebx
	xor	edx, edx

._64h_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._64h_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._64h_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._64h_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._64h_petla

	cmp	al, '0'		; sprawdzamy, czy cyfra hex:
	jb	._64h_blad
	cmp	al, '9'
	ja	._64h_dalej1

	and	al, 0fh		; izolujemy wartosc
	jmp	short ._64h_ok

._64h_dalej1:
	cmp	al, 'A'
	jb	._64h_blad
	cmp	al, 'F'
	ja	._64h_dalej2

	sub	al, 'A'-10	; izolujemy wartosc
	jmp	short ._64h_ok

._64h_dalej2:
	cmp	al, 'a'
	jb	._64h_blad
	cmp	al, 'f'
	ja	._64h_blad
	sub	al, 'a'-10	; izolujemy wartosc

._64h_ok:
	shl	ebx, 1		; robimy miejsce na nowa cyfre:
	rcl	edx, 1
	jc	._64h_blad

	shl	ebx, 1
	rcl	edx, 1
	jc	._64h_blad

	shl	ebx, 1
	rcl	edx, 1
	jc	._64h_blad

	shl	ebx, 1
	rcl	edx, 1		; "SHL EDX:EBX,4"
	jc	._64h_blad

	or	bl, al		; dopisujemy nowa cyfre
	jmp	short ._64h_petla

%if (__DOS > 0) || (__BIOS > 0)
._64h_bksp:
	test	esi, esi
	jz	._64h_petla

	dec	esi

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	shr	edx, 1
	rcr	ebx, 1

	shr	edx, 1
	rcr	ebx, 1

	shr	edx, 1
	rcr	ebx, 1

	shr	edx, 1
	rcr	ebx, 1

	jmp	._64h_petla
%endif

._64h_blad:
	xor	eax, eax
	dec	eax
%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(bx)
	mov	edx, eax	; EDX:EAX=FFFFFFFF:FFFFFFFF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad
	bibl_ret

._64h_juz:
	mov	eax, ebx
%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury liczbe 64-bitowa ze znakiem.
; Makro: we64z
; @return EDX:EAX=wczytana liczba (gdy CF=0), EDX:EAX=-1 i CF=1, gdy blad.
;;
_we_64z:
	push_f
	push	rej(bp)
	push	rej(bx)
	push	rej(cx)
	push	rej(di)
%if (__DOS > 0) || (__BIOS > 0)
	push	esi		; licznik znakow
	xor	esi, esi
%endif

	xor	edx, edx
	xor	ebx, ebx

._64z_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	xor	edi, edi

	cmp	al, lf		; czy Enter?
	je	._64z_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._64z_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._64z_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._64z_pocz

	cmp	al, '-'
	jne	._64z_dalej1
	inc	edi		; znacznik, ze wprowadzono minus
	jmp	._64z_ok

._64z_dalej1:
	cmp	al, '+'
	jne	._64z_petla
	jmp	short ._64z_ok

._64z_petla:
	cmp	al, '0'		; srp., czy cyfra
	jb	._64z_blad
	cmp	al, '9'
	ja	._64z_blad

	and	eax, 0fh	;zeruje reszte bitow

	mov	ecx, ebx
	mov	ebp, edx

	shl	ebx, 1		; robimy miejsce na nowa cyfre
	rcl	edx, 1
	jc	._64z_blad
	shl	ebx, 1
	rcl	edx, 1
	jc	._64z_blad
	shl	ebx, 1
	rcl	edx, 1
	jc	._64z_blad

	shl	ecx, 1
	rcl	ebp, 1

	add	ebx, ecx	; bx=bx*10
	adc	edx, ebp	; EDX:EBX = EDX:EBX*10
	jc	._64z_blad

	add	ebx, eax	; dodajemy nowa cyfre
	adc	edx, 0
	jc	._64z_blad

._64z_ok:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._64z_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._64z_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._64z_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._64z_ok

	jmp	._64z_petla

._64z_blad:
	xor	eax, eax

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(di)
	pop	rej(cx)
	dec	eax	 	; EAX=0FFFFFFFFh
	pop	rej(bx)
	pop	rej(bp)
	mov	edx, eax	; EDX=EAX=FFFFFFFF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad
	bibl_ret

%if (__DOS > 0) || (__BIOS > 0)
._64z_bksp:
	test	esi, esi
	jz	._64z_pocz
	dec	esi

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	test	esi, esi
	jnz	._64z_nie_pocz

	; jesli SI = 0, to zaczynamy od poczatku
	xor	ebx, ebx
	xor	edx, edx
	xor	edi, edi

	jmp	._64z_pocz

._64z_nie_pocz:

	mov	eax, ebx
	or	eax, edx
	jnz	._64z_bksp_byly_cyfry

	jmp	._64z_ok
._64z_bksp_byly_cyfry:
	mov	ebp, ebx
	mov	eax, edx
	xor	edx, edx
	mov	ecx, 10
	div	ecx		; zachowac reszte
	push	eax
	mov	eax, ebp
	div	ecx
	pop	edx		; tak, zdejmujemy EAX
	mov	ebx, eax

	jmp	._64z_ok
%endif

._64z_minus_juz:
	cmp	edx, 80000000h
	ja	._64z_blad	; blad jesli liczba ujemna za mala

	neg	edx	 	; zmieniamy znak
	neg	ebx
	sbb	edx, 0
	mov	eax, ebx

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(di)
	pop	rej(cx)
	pop	rej(bx)
	pop	rej(bp)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret

._64z_juz:
	test	edi, edi	; czy wprowadzono minus?
	jnz	._64z_minus_juz

	test	edx, edx
	js	._64z_blad	; blad jesli liczba zbyt duza

	mov	eax, ebx

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(di)
	pop	rej(cx)
	pop	rej(bx)
	pop	rej(bp)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury liczbe 64-bitowa szesnastkowa ze znakiem.
; Makro: we64zh
; @return EDX:EAX=wczytana liczba (gdy CF=0), EDX:EAX=-1 i CF=1, gdy blad.
;;
_we_64zh:
	push_f
	push	rej(bx)
	push	rej(cx)
%if (__DOS > 0) || (__BIOS > 0)
	push	esi		; licznik znakow
	xor	esi, esi
%endif

	xor	edx, edx
	xor	ebx, ebx

._64zh_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	xor	cl, cl

	cmp	al, lf		; czy Enter?
	je	._64zh_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._64zh_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._64zh_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._64zh_pocz

	cmp	al, '-'
	jne	._64zh_spr_dalej0
	inc	cl		; znacznik, ze wprowadzono minus
	jmp	._64zh_plus

._64zh_spr_dalej0:
	cmp	al, '+'
	jne	._64zh_petla
	jmp	._64zh_plus

._64zh_petla:
	cmp	al, '0'		; sprawdzimy, czy cyfra hex:
	jb	._64zh_blad
	cmp	al, '9'
	ja	._64zh_dalej
	and	al, 0fh		; izolujemy wartosc
	jmp	short ._64zh_ok

._64zh_dalej:
	cmp	al, 'A'
	jb	._64zh_blad
	cmp	al, 'F'
	ja	._64zh_dalej_2
	sub	al, 'A'-10	; izolujemy wartosc
	jmp	short ._64zh_ok

._64zh_blad:
	xor	eax, eax

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(cx)
	dec	eax 		; EAX=0FFFFFFFFh
	pop	rej(bx)
	mov	edx, eax	; EDX=FFFFFFFF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad
	bibl_ret

%if (__DOS > 0) || (__BIOS > 0)
._64zh_bksp:
	test	esi, esi
	jz	._64zh_pocz
	dec	esi

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	test	esi, esi
	jnz	._64zh_nie_pocz

	; jesli SI = 0, to zaczynamy od poczatku
	xor	ebx, ebx
	xor	edx, edx
	xor	edi, edi

	jmp	._64zh_pocz

._64zh_nie_pocz:

	mov	eax, ebx
	or	eax, edx
	jnz	._64zh_bksp_byly_cyfry

	jmp	._64zh_plus
._64zh_bksp_byly_cyfry:
	shr	edx, 1
	rcr	ebx, 1

	shr	edx, 1
	rcr	ebx, 1

	shr	edx, 1
	rcr	ebx, 1

	shr	edx, 1
	rcr	ebx, 1

	jmp	._64zh_plus
%endif

._64zh_dalej_2:
	cmp	al, 'a'
	jb	._64zh_blad
	cmp	al, 'f'
	ja	._64zh_blad
	sub	al, 'a'-10	; izolujemy wartosc

._64zh_ok:
	shl	ebx, 1		; robimy miejsce dla nowej cyfry:
	rcl	edx, 1
	jc	._64zh_blad

	shl	ebx, 1
	rcl	edx, 1
	jc	._64zh_blad

	shl	ebx, 1
	rcl	edx, 1
	jc	._64zh_blad

	shl	ebx, 1
	rcl	edx, 1		; "SHL EDX:EBX,4"
	jc	._64zh_blad

	or	bl, al		; dopisujemy nowa cyfre

._64zh_plus:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._64zh_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._64zh_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._64zh_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._64zh_plus

	jmp	._64zh_petla

._64zh_minus_juz:
	cmp	edx, 80000000h
	ja	._64zh_blad	; blad, jesli liczba ujemna zbyt mala

	neg	edx 		; zmieniamy znak
	neg	ebx
	sbb	edx, 0
	mov	eax, ebx

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(cx)
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret

._64zh_juz:
	test	cl, cl		; czy wprowadzono minus?
	jnz	._64zh_minus_juz

	test	edx, edx
	js	._64zh_blad	; blad, jesli liczba zbyt duza

	mov	eax, ebx

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(cx)
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury liczbe 64-bitowa dwojkowa bez znaku.
; Makro: we64b
; @return EDX:EAX=wczytana liczba (gdy CF=0), EDX:EAX=-1 i CF=1, gdy blad.
;;
_we_64b:
	push_f
	push	rej(bx)
%if (__DOS > 0) || (__BIOS > 0)
	push	esi		; licznik znakow
	xor	esi, esi
%endif

	xor	ebx, ebx
	xor	edx, edx

._64_lb_pocz:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._64_lb_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._64_lb_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._64_lb_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._64_lb_pocz

	cmp	al, '0'		; czy AL to 0 lub 1?
	jb	._64_lb_blad
	cmp	al, '1'
	ja	._64_lb_blad

	and	al, 1		; izolujemy wartosc
	shl	ebx, 1		; robimy miejsce ( "SHL EDX:EBX, 1" )
	rcl	edx, 1
	jc	._64_lb_blad

	or	bl, al		; dopisujemy nowa cyfre
	jmp	short ._64_lb_pocz

%if (__DOS > 0) || (__BIOS > 0)
._64_lb_bksp:
	test	esi, esi
	jz	._64_lb_pocz

	dec	esi

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	shr	edx, 1
	rcr	ebx, 1

	jmp	short ._64_lb_pocz
%endif

._64_lb_blad:
	xor	eax, eax
	dec	eax	 	; EAX=FFFFFFFF
%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(bx)
	mov	edx, eax	; EDX:EAX=FFFFFFFF:FFFFFFFF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad
	bibl_ret

._64_lb_juz:
	mov	eax, ebx
%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury liczbe 64-bitowa osemkowa bez znaku.
; Makro: we64o
; @return EDX:EAX=wczytana liczba (gdy CF=0), EDX:EAX=-1 i CF=1, gdy blad.
;;
_we_64o:
	push_f
	push	rej(bx)
%if (__DOS > 0) || (__BIOS > 0)
	push	esi		; licznik znakow
	xor	esi, esi
%endif

	xor	edx, edx
	xor	ebx, ebx

._64o_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._64o_juz	; jesli tak, to wychodzimy
	cmp	al, cr
	je	._64o_juz
%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._64o_bksp
	bibl_call	_pisz_z
	inc	esi
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._64o_petla

	cmp	al, '0'		; czy cyfra?
	jb	._64o_blad
	cmp	al, '7'
	ja	._64o_blad

	and	eax, 0fh	; celowo EAX, aby wyzerowac reszte bitow


	shl	ebx, 1		; robimy miejsce na nowa cyfre
	rcl	edx, 1
	jc	._64o_blad
	shl	ebx, 1
	rcl	edx, 1
	jc	._64o_blad
	shl	ebx, 1
	rcl	edx, 1
	jc	._64o_blad

	add	ebx, eax
	adc	edx, 0		; dodajemy nowa cyfre
	jc	._64o_blad

	jmp	._64o_petla
%if (__DOS > 0) || (__BIOS > 0)
._64o_bksp:
	test	esi, esi
	jz	._64o_petla

	dec	esi

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	shr	edx, 1
	rcr	ebx, 1

	shr	edx, 1
	rcr	ebx, 1

	shr	edx, 1
	rcr	ebx, 1

	jmp	short ._64o_petla
%endif

._64o_blad:
	xor	eax, eax

	dec	eax
%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(bx)
	mov	edx, eax	; EDX:EAX=FFFFFFFF:FFFFFFFF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad
	bibl_ret

._64o_juz:
	mov	eax, ebx

%if (__DOS > 0) || (__BIOS > 0)
	pop	esi
%endif
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu
	bibl_ret


;*************************************

;;
; Pobiera z klawiatury znak/bajt.
; Makro: we_z
; @return AL=wczytany znak.
;;
_we_z:

%if (__BIOS > 0)
	pushf
	push	bx
	push	ax

	xor	ah, ah
	int	16h 			; pobierz znak z klawiatury

	pop	bx			; BX = stary AX
	mov	ah, bh
	pop	bx
	popf
	bibl_ret

%elif (__DOS > 0)
	pushf
	push	bx
	push	ax

	mov	ah, 8
	int	21h			; pobierz znak ze stdin

	pop	bx			; BX = stary AX
	mov	ah, bh
	pop	bx
	popf
	bibl_ret

%else
	push	rej(ax)
	push	rej(bx)
	push	rej(cx)
	push	rej(dx)

 %if (__KOD_64BIT > 0)
	mov	rax, sys64_read	; funkcja czytania z pliku
 %else
	mov	eax, sys_read	; funkcja czytania z pliku
 %endif

	mov	ebx, stdin	; standardowe wejscie
	mov	rej(cx), znak	; adres, dokad czytac
	mov	edx, 1		; wczytaj 1 bajt

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

	mov	al, [znak]	; zwracamy przeczytany znak

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
;*************************************

;;
; Pobiera z klawiatury cyfre dziesietna i zwraca jej wartosc.
; Makro: we_c
; @return AL=wartosc wczytanej cyfry (od 0 do 9) i CF=0, lub
;	AL=-1 i CF=1, gdy blad.
;;
_we_c:
	pushf
	push	bx
	push	ax

	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.c_blad		; jesli tak, to blad
	cmp	al, cr		; czy Enter?
	je	.c_blad		; jesli tak, to blad

		; wypisz ten znak
%if (__DOS > 0) || (__BIOS > 0)
	bibl_call	_pisz_z
%endif
	cmp	al, '0'		; czy AL to cyfra?
	jb	.c_blad
	cmp	al, '9'
	ja	.c_blad

	mov	bx, ax
	pop	ax
	mov	al, bl
	and	al, 0fh		; izolujemy wartosc
	pop	bx

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	clc			; zwroc brak bledu
	bibl_ret
.c_blad:
	pop	ax
	pop	bx
	mov	al, 0ffh	; AL = FF

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury cyfre szesnastkowa i zwraca jej wartosc.
; Makro: we_ch
; @return AL=wartosc wczytanej cyfry (od 0 do 15) i CF=0, lub
;	AL=-1 i CF=1, gdy blad.
;;
_we_ch:
	pushf
	push	bx
	push	ax

	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	.ch_blad	; jesli tak, to blad
	cmp	al, cr		; czy Enter?
	je	.ch_blad	; jesli tak, to blad

		; wypisz ten znak
%if (__DOS > 0) || (__BIOS > 0)
	bibl_call	_pisz_z
%endif
	cmp	al, '0'		; sprawdzamy, czy AL to cyfra hex:
	jb	.ch_blad
	cmp	al, '9'
	ja	.ch_dalej
	and	al, 0fh		; izolujemy wartosc
	jmp	short .ch_juz

.ch_dalej:
	cmp	al, 'A'
	jb	.ch_blad
	cmp	al, 'F'
	ja	.ch_dalej2
	sub	al, 'A'-10	; izolujemy wartosc
	jmp	short .ch_juz

.ch_dalej2:
	cmp	al, 'a'
	jb	.ch_blad
	cmp	al, 'f'
	ja	.ch_blad
	sub	al, 'a'-10	; izolujemy wartosc

.ch_juz:
        mov     bx, ax
        pop     ax
        mov     al, bl
        pop     bx

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

        popf
        clc                     ; zwroc brak bledu
	bibl_ret

.ch_blad:
	pop	ax
	pop	bx

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	mov	al, 0ffh	; AL = FF
	stc			; zwroc blad
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury lancuch znakow zakonczony Enterem.
; Lancuch jest umieszczany pod wskazanym adresem i zakanczany bajtem zerowym.
; Makro: we
; @param ES:DI / EDI / RDI - adres bufora, gdzie nalezy umiescic napis.
;;
_we:
	pushf
	push	ax
	push	rej(bx)
	push	rej(di)
	mov	rej(bx), rej(di)	; xBX = poczatek bufora

._we_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._we_juz	; jesli tak, to wychodzimy
	cmp	al, cr		; czy Enter?
	je	._we_juz	; jesli tak, to wychodzimy

%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._we_bksp
	bibl_call	_pisz_z
%endif
				; zachowaj pobrany znak pod ES:EDI i
				; zwieksz EDI o 1
%if (__KOD_16BIT > 0)
	mov	[es:di], al
	inc	di
%else
	mov	[rej(di)], al
	inc	rej(di)
%endif


	jmp	short ._we_petla
%if (__DOS > 0) || (__BIOS > 0)
._we_bksp:
	cmp	rej(di), rej(bx)
	je	._we_petla

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	dec	rej(di)
	jmp	short ._we_petla
%endif

._we_juz:
	mov	al, 0
	stosb
	pop	rej(di)
	pop	rej(bx)
	pop	ax
	popf
	bibl_ret

;*************************************

;;
; Pobiera z klawiatury lancuch znakow zakonczony Enterem, ale ma on miec
;	co najwyzej CX znakow. Lancuch jest umieszczany pod wskazanym
;	adresem i zakanczany bajtem zerowym.
; Makro: we_dl
; @param ES:DI / EDI / RDI - adres bufora, gdzie nalezy umiescic napis.
; @param CX - liczba bajtow do wczytania.
; @return CX - dlugosc wczytanego lancucha (i CF=0) lub CX=-1 i CF=1, gdy
;	przekroczono podana dlugosc.
;;
_we_dl:
	pushf
	push	ax
	push	dx
	push	rej(bx)
	push	rej(di)

	test	cx, cx
	jz	._we_dl_juz	;jesli nie mamy pobierac nic, to wychodzimy

	mov	rej(bx), rej(di)	; BX = poczatek bufora
	mov	dx, cx		; DX = dlugosc

._we_dl_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

	cmp	al, lf		; czy Enter?
	je	._we_dl_juz	; jesli tak, to wychodzimy
	cmp	al, cr		; czy Enter?
	je	._we_dl_juz	; jesli tak, to wychodzimy

%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp
	je	._we_dl_bksp
	bibl_call	_pisz_z
%endif

				; zachowaj pobrany znak pod ES:EDI i
				; zwieksz EDI o 1
%if (__KOD_16BIT > 0)
	mov	[es:di], al
	inc	di
%else
	mov	[rej(di)], al
	inc	rej(di)
%endif

	dec	cx		; zmniejsz ilosc znakow do wprowadzenia
	jns	._we_dl_petla	; pobieraj, dopoki ECX nie jest ujemne

				; ECX < 0. Przekroczono dlugosc. Blad
	xor	cx, cx
	pop	rej(di)
	pop	rej(bx)
	pop	dx
	pop	ax
	dec	cx		; ustawiamy CX=0FFFFh

	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	popf
	stc			; zwroc blad
	bibl_ret

%if (__DOS > 0) || (__BIOS > 0)
._we_dl_bksp:
	cmp	rej(di), rej(bx)
	je	._we_dl_petla

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	dec	rej(di)
	jmp	short ._we_dl_petla
%endif

._we_dl_juz:
	sub	dx, cx		; od dlugosci poczatkowej odejmujemy ilosc
				; znakow, ktore jeszcze mozna bylo wczytac,
				; otrzymujac ilosc wczytanych znakow

	mov	cx, dx		; dlugosc
	pop	rej(di)
	pop	rej(bx)
	pop	dx
	pop	ax
	popf
	clc			; zwroc brak bledu
	bibl_ret

;*************************************

;;
; Czysci bufor klawiatury. Pobiera znaki z klawiatury, az natrafi na
;	Enter lub wystapi blad.
; Makro: czysc_klaw
;;
_czysc_klaw:

	pushf
	push	ax
	push	dx

.petla:
		; pobierz znak z klawiatury
%if (__BIOS > 0)

	mov	ah, 1
	int	16h 			; sprawdz, czy jest znak
	jz	.koniec

%elif (__DOS > 0)

	mov	ah, 6
	mov	dl, 0ffh
	int	21h			; sprawdz, czy jest znak

	jz	.koniec

%else

	; w Linux/BSD zawsze cos znajdziemy, bo wejscie jest buforowane

%endif

	bibl_call	_we_z		; pobierz znak, gdy jest

	cmp	al, lf
	je	.koniec
	cmp	al, cr
	jne	.petla
.koniec:

	pop	dx
	pop	ax
	popf
	bibl_ret
