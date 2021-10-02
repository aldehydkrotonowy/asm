;;
;  Biblioteka Standardowa -
;  Operacje na liczbach BCD.
;  Ostatnia modyfikacja kodu: 2021-02-11
;  @author Bogdan 'bogdro' Drozdowski, bogdandr@op.pl (2008-02)
;;


; Copyright (C) 2008-2021 Bogdan 'bogdro' Drozdowski, bogdandr @ op . pl
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

global _bcd_we8
global _bcd_we16
global _bcd_we32
global _bcd_we32e
global _bcd_we64

global _bcd_pisz8
global _bcd_pisz16
global _bcd_pisz32
global _bcd_pisz32e
global _bcd_pisz64

global _bcd_rbcd_na_sbcd8
global _bcd_sbcd_na_rbcd8
global _bcd_rbcd_na_bin8
global _bcd_sbcd_na_bin8
global _bcd_bin_na_rbcd8
global _bcd_bin_na_sbcd8

global _bcd_rbcd_na_sbcd16
global _bcd_sbcd_na_rbcd16
global _bcd_rbcd_na_bin16
global _bcd_sbcd_na_bin16
global _bcd_bin_na_rbcd16
global _bcd_bin_na_sbcd16

global _bcd_rbcd_na_sbcd32
global _bcd_sbcd_na_rbcd32
global _bcd_rbcd_na_bin32
global _bcd_sbcd_na_bin32
global _bcd_bin_na_rbcd32
global _bcd_bin_na_sbcd32

global _bcd_rbcd_na_sbcd32e
global _bcd_sbcd_na_rbcd32e
global _bcd_rbcd_na_bin32e
global _bcd_sbcd_na_bin32e
global _bcd_bin_na_rbcd32e
global _bcd_bin_na_sbcd32e

global _bcd_rbcd_na_sbcd64
global _bcd_sbcd_na_rbcd64
global _bcd_rbcd_na_bin64
global _bcd_sbcd_na_bin64
global _bcd_bin_na_rbcd64
global _bcd_bin_na_sbcd64



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

extern	_we_z
extern	_czysc_klaw
extern	_pisz_ch

%if (__DOS > 0) || (__BIOS > 0)
extern	_pisz_z
%endif

%if (__DOS > 0) || (__BIOS > 0)
 ; %include	"..\incl\dosbios\nasm\n_const.inc"
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 %if (__COFF == 0)
  segment         biblioteka_bcd
 %else
  segment         .text
 %endif

%else
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 section         .data
%endif

;**************************************

_bcd_bufor:	times	40	db	0

;**************************************

%if (__LINUX > 0) || (__BSD > 0)
section		.text
%endif

; *******************************************************

;;
; Pobiera z klawiatury 8-bitowa spakowana liczbe BCD.
; Makro: we8bcd
; @return AL=wczytana liczba (gdy CF=0), AL=-1 i CF=1, gdy blad.
;;
_bcd_we8:

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
	shl	bl, 1		; robimy miejsce dla nowej cyfry
	jc	._8_blad
	shl	bl, 1
	jc	._8_blad
	shl	bl, 1
	jc	._8_blad
	shl	bl, 1
	jc	._8_blad

	or	bl, al		; dopisujemy nowa cyfre
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

        shr	bl, 1
        shr	bl, 1
        shr	bl, 1
        shr	bl, 1

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


; *******************************************************

;;
; Wyswietla na ekranie podana 8-bitowa spakowana liczbe BCD.
; Makro: pisz8bcd
; @param AL - liczba do wyswietlenia.
;;
_bcd_pisz8:

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


; *******************************************************

;;
; Przerabia podana 8-bitowa niespakowana liczbe BCD na liczbe spakowana.
; Makro: rbcd_sbcd8
; @param AL - liczba do przerobienia.
; @return AL - przerobiona liczba.
;;
_bcd_rbcd_na_sbcd8:

	; niespakowana liczba BCD to liczba 0-9 w bajcie. Nic nie trzeba
	; robic, poza ewentualnym wyzerowaniem gornej polowki AL

	pushf
	and	al, 0fh
	popf

	bibl_ret


; *******************************************************

;;
; Przerabia podana 8-bitowa spakowana liczbe BCD na liczbe niespakowana.
; Makro: sbcd_rbcd8
; @param AL - liczba do przerobienia.
; @return AL - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_sbcd_na_rbcd8:
	push	bx
	pushf

	xor	bx, bx
	cmp	al, 9
	jbe	.zero
	inc	bx
.zero:
	and	al, 0fh
	test	bx, bx
	jnz	.zwroc_cf

	popf
	clc
	jmp	short .koniec

.zwroc_cf:
	popf
	stc
.koniec:
	pop	bx

	bibl_ret


; *******************************************************

;;
; Przerabia podana 8-bitowa niespakowana liczbe BCD na liczbe binarna.
; Makro: rbcd_bin8
; @param AL - liczba do przerobienia.
; @return AL - przerobiona liczba.
;;
_bcd_rbcd_na_bin8:

	pushf
	and	al, 0fh
	popf

	bibl_ret


; *******************************************************

;;
; Przerabia podana 8-bitowa spakowana liczbe BCD na liczbe binarna.
; Makro: sbcd_bin8
; @param AL - liczba do przerobienia.
; @return AL - przerobiona liczba.
;;
_bcd_sbcd_na_bin8:
	pushf
	push	bx

	mov	bl, al		; BL = liczba
	shr	bl, 1
	shr	bl, 1
	shr	bl, 1
	shr	bl, 1		; BL = liczba dziesiatek
	mov	bh, bl
	shl	bh, 1
	shl	bh, 1
	shl	bh, 1
	shl	bl, 1
	add	bl, bh		; BL = BL*10 = cyfra dziesiatek * 10
	and	al, 0fh		; AL = cyfra jednosci
	add	al, bl		; BL = liczba binarnie

	pop	bx
	popf

	bibl_ret


; *******************************************************

;;
; Przerabia podana 8-bitowa liczbe binarna na niespakowana liczbe BCD.
; Makro: bin_rbcd8
; @param AL - liczba do przerobienia.
; @return AL - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_bin_na_rbcd8:
	push	bx
	push	ax
	pushf

	xor	bx, bx
	cmp	al, 9
	jbe	.zero
	inc	bl
	sub	al, 10
.zero:
	mov	bh, 10
	xor	ah, ah
	div	bh
	mov	al, ah	; reszta z dzielenia przez 10

	test	bl, bl
	jnz	.zwroc_cf

	popf
	clc
	jmp	short .koniec

.zwroc_cf:
	popf
	stc
.koniec:
	pop	bx	; BX = stary AX
	mov	ah, bh	; przywrocenie starego AH
	pop	bx

	bibl_ret


; *******************************************************

;;
; Przerabia podana 8-bitowa liczbe binarna na spakowana liczbe BCD.
; Makro: bin_sbcd8
; @param AL - liczba do przerobienia.
; @return AL - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_bin_na_sbcd8:
	push	bx
	push	ax
	pushf

	xor	bx, bx
	cmp	al, 99
	jbe	.zero
	inc	bl
.zero:
	mov	bh, 100
	xor	ah, ah
	div	bh
	mov	al, ah	; AL = reszta z dzielenia przez 100
	mov	bh, 10
	xor	ah, ah
	div	bh
	xchg	al, ah	; reszta z dzielenia przez 10 do AL
	shl	al, 1
	shl	al, 1
	shl	al, 1
	shl	al, 1	; do gornych bitow
	shr	ax, 1
	shr	ax, 1
	shr	ax, 1
	shr	ax, 1	; dolna czesc AH (liczba dziesiatek) do AL

	test	bl, bl
	jnz	.zwroc_cf

	popf
	clc
	jmp	short .koniec

.zwroc_cf:
	popf
	stc
.koniec:
	pop	bx	; BX = stary AX
	mov	ah, bh	; przywrocenie starego AH
	pop	bx

	bibl_ret


; *******************************************************
; *******************************************************


;;
; Pobiera z klawiatury 16-bitowa spakowana liczbe BCD.
; Makro: we16bcd
; @return AX=wczytana liczba (gdy CF=0), AX=-1 i CF=1, gdy blad.
;;
_bcd_we16:

	pushf
	push	bx
	push	cx
%if (__DOS > 0) || (__BIOS > 0)
	push	si		; licznik znakow
	xor	si, si
%endif

	xor	bx, bx		; miejsce na liczbe

.l_petla:
	bibl_call	_we_z		; pobierz znak z klawiatury

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

	shl	bx, 1		; robimy miejsce dla nowej cyfry,
				; sprawdzajac, czy miescimy sie w
	jc	.l_blad		; granicach
	shl	bx, 1
	jc	.l_blad
	shl	bx, 1
	jc	.l_blad
	shl	bx, 1
	jc	.l_blad
	or	bl, al		; dopisujemy nowa cyfre

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

	shr	bx, 1
	shr	bx, 1
	shr	bx, 1
	shr	bx, 1

	jmp	short .l_petla
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


; *******************************************************

;;
; Wyswietla na ekranie podana 16-bitowa spakowana liczbe BCD.
; Makro: pisz16bcd
; @param AX - liczba do wyswietlenia.
;;
_bcd_pisz16:

	pushf
	push	ax
	push	rej(bx)
	push	cx
	push	dx
%if (__KOD_16BIT > 0)
	push	ds
	mov	cx, biblioteka_bcd
	mov	ds, cx
%endif
	push	rej(si)
	xor	rej(si), rej(si)
	xor	rej(bx), rej(bx)

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

	mov 	[_bcd_bufor + rej(si)], bl	; BL = cyfra hex ( kolejne
						; od prawej aby ominac zera )
	inc	rej(si)

	test 	ax, ax
	jnz	._pisz_lh_petla

._pisz_lh_wypis:
	mov 	al, [_bcd_bufor + rej(si) - 1]		; wypisujemy wspak
	bibl_call 	_pisz_ch

	dec	rej(si)
	jnz	._pisz_lh_wypis

	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	dx
	pop	cx
	pop	rej(bx)
	pop	ax
	popf

	bibl_ret

; *******************************************************

;;
; Przerabia podana 16-bitowa niespakowana liczbe BCD na liczbe spakowana.
; Makro: rbcd_sbcd16
; @param AX - liczba do przerobienia.
; @return AX - przerobiona liczba.
;;
_bcd_rbcd_na_sbcd16:

	pushf
	; niespakowana liczba BCD to liczba 0-99 w 2 bajtach.

	; przeniesienie cyfry dziesiatek do gornej polowki AH
	shr	ah, 1
	shr	ah, 1
	shr	ah, 1
	shr	ah, 1

	and	al, 0fh
	or	al, ah
	and	ax, 0ffh

	popf

	bibl_ret


; *******************************************************

;;
; Przerabia podana 16-bitowa spakowana liczbe BCD na liczbe niespakowana.
; Makro: sbcd_rbcd16
; @param AX - liczba do przerobienia.
; @return AX - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_sbcd_na_rbcd16:
	push	bx
	pushf

	xor	bx, bx
	cmp	ax, 99h
	jbe	.zero
	inc	bx
.zero:
	shl	ax, 1
	shl	ax, 1
	shl	ax, 1
	shl	ax, 1
	and	ah, 0fh
	shr	al, 1
	shr	al, 1
	shr	al, 1
	shr	al, 1

	test	bx, bx
	jnz	.zwroc_cf

	popf
	clc
	jmp	short .koniec

.zwroc_cf:
	popf
	stc
.koniec:
	pop	bx

	bibl_ret


; *******************************************************

;;
; Przerabia podana 16-bitowa niespakowana liczbe BCD na liczbe binarna.
; Makro: rbcd_bin16
; @param AX - liczba do przerobienia.
; @return AX - przerobiona liczba.
;;
_bcd_rbcd_na_bin16:
	pushf
	push	bx

	and	ah, 0fh
	; 0-99, AAD = "AL:=(AH*10)+AL && AH:=0"
	mov	bl, ah	; BL = cyfra dziesiatek
	mov	bh, ah
	shl	bl, 1
	shl	bl, 1
	shl	bl, 1
	shl	bh, 1
	add	bl, bh	; BL = cyfra dziesiatek * 10
	and	al, 0fh
	add	al, bl
	xor	ah, ah

	pop	bx
	popf

	bibl_ret


; *******************************************************

;;
; Przerabia podana 16-bitowa spakowana liczbe BCD na liczbe binarna.
; Makro: sbcd_bin16
; @param AX - liczba do przerobienia.
; @return AX - przerobiona liczba.
;;
_bcd_sbcd_na_bin16:
	pushf
	push	bx
	push	cx

	; 0-9999, AAD = "AL:=(AH*10)+AL && AH:=0"
	mov	ch, al	; zachowaj AL

	mov	bl, ah		; BL = liczba setek i tysiecy
	shl	bx, 1
	shl	bx, 1
	shl	bx, 1
	shl	bx, 1
	and	bh, 0fh		; BH = liczba tysiecy, BL = liczba setek << 4
	mov	cl, bh
	shl	cl, 1
	shl	cl, 1
	shl	cl, 1
	shl	bh, 1
	add	bh, cl		; BH *= 10
	shr	bl, 1
	shr	bl, 1
	shr	bl, 1
	shr	bl, 1
	add	bl, bh		; BL = BH*10 + BL = tysiace*10 + setki
	mov	al, bl

	mov	cl, 100
	mul	cl	; AX = AL*100

	mov	bl, ch		; BL = liczba dziesiatek i jednosci
	shl	bx, 1
	shl	bx, 1
	shl	bx, 1
	shl	bx, 1
	and	bh, 0fh		; BH = liczba dziesiatek,
				; BL = liczba jednosci << 4
	mov	cl, bh
	shl	cl, 1
	shl	cl, 1
	shl	cl, 1
	shl	bh, 1
	add	bh, cl		; BH *= 10
	shr	bl, 1
	shr	bl, 1
	shr	bl, 1
	shr	bl, 1
	add	bl, bh		; BL = BH*10 + BL = dziesiatki*10 + jednosci

	add	al, bl
	adc	ah, 0

	pop	cx
	pop	bx
	popf

	bibl_ret


; *******************************************************

;;
; Przerabia podana 16-bitowa liczbe binarna na niespakowana liczbe BCD.
; Makro: bin_rbcd16
; @param AX - liczba do przerobienia.
; @return AX - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_bin_na_rbcd16:
	push	bx
	push	cx
	push	dx
	pushf

	; AAM = "AH:=AL/10 && AL:=AL % 10"

	xor	bx, bx
	cmp	ax, 99
	jbe	.zero
	inc	bl
.zero:
	xor	dx, dx
	mov	cx, 1000
	div	cx
	mov	ax, dx			; AL = reszta
	xor	dx, dx
	mov	cx, 100
	div	cx
	mov	ax, dx
	mov	bh, 10
	div	bh			; AL = liczba dziesiatek

	bibl_call	_bcd_bin_na_rbcd8	; -> AL
	mov	cl, al

	mov	al, ah
	bibl_call	_bcd_bin_na_rbcd8	; -> AL
	mov	ah, cl

	test	bl, bl
	jnz	.zwroc_cf

	popf
	clc
	jmp	short .koniec

.zwroc_cf:
	popf
	stc
.koniec:
	pop	dx
	pop	cx
	pop	bx

	bibl_ret


; *******************************************************

;;
; Przerabia podana 16-bitowa liczbe binarna na spakowana liczbe BCD.
; Makro: bin_sbcd16
; @param AX - liczba do przerobienia.
; @return AX - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_bin_na_sbcd16:
	push	bx
	push	cx
	push	dx
	pushf

	; AAM = "AH:=AL/10 && AL:=AL % 10"

	xor	bx, bx
	cmp	ax, 9999
	jbe	.zero
	inc	bl
.zero:
	xor	dx, dx
	mov	cx, 10000
	div	cx
	mov	ax, dx			; AX = reszta, 0-9999
	mov	bh, 100
	div	bh			; AL = liczba setek
	bibl_call	_bcd_bin_na_sbcd8	; -> AL
	mov	cl, al

	mov	al, ah
	bibl_call	_bcd_bin_na_sbcd8	; -> AL
	mov	ah, cl

	test	bl, bl
	jnz	.zwroc_cf

	popf
	clc
	jmp	short .koniec

.zwroc_cf:
	popf
	stc
.koniec:
	pop	dx
	pop	cx
	pop	bx

	bibl_ret


; *******************************************************
; *******************************************************


;;
; Pobiera z klawiatury 32-bitowa spakowana liczbe BCD.
; Makro: we32bcd
; @return DX:AX=wczytana liczba (gdy CF=0), DX:AX=-1 i CF=1, gdy blad.
;;
_bcd_we32:

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

	shl	bx, 1
	rcl	dx, 1
	jc	._32_blad

	shl	bx, 1		; robimy miejsce dla nowej cyfry
				; ( "SHL DX:BX,4" )
	rcl	dx, 1
	jc	._32_blad

	shl	bx, 1
	rcl	dx, 1
	jc	._32_blad

	shl	bx, 1
	rcl	dx, 1
	jc	._32_blad

	or	bl, al		; dopisujemy nowa cyfre
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

	shr	dx, 1
	rcr	bx, 1

	shr	dx, 1
	rcr	bx, 1

	shr	dx, 1
	rcr	bx, 1

	shr	dx, 1
	rcr	bx, 1

	jmp	._32_petla
%endif


; *******************************************************

;;
; Wyswietla na ekranie podana 32-bitowa spakowana liczbe BCD.
; Makro: pisz32bcd
; @param DX:AX - liczba do wyswietlenia.
;;
_bcd_pisz32:

	push	ax

	mov	ax, dx
	bibl_call	_bcd_pisz16		; wypisujemy starsza czesc

	pop	ax
	bibl_call	_bcd_pisz16		; wypisujemy mlodsza czesc

	bibl_ret

; *******************************************************

;;
; Przerabia podana 32-bitowa niespakowana liczbe BCD na liczbe spakowana.
; Makro: rbcd_sbcd32
; @param DX:AX - liczba do przerobienia.
; @return DX:AX - przerobiona liczba.
;;
_bcd_rbcd_na_sbcd32:
	pushf

	; niespakowana liczba BCD to liczba 0-9999 w 4 bajtach.

	; przeniesienie cyfry dziesiatek do gornej polowki AH
	shl	ah, 1
	shl	ah, 1
	shl	ah, 1
	shl	ah, 1

	; przeniesienie cyfry tysiecy do gornej polowki DH
	shl	dh, 1
	shl	dh, 1
	shl	dh, 1
	shl	dh, 1

	and	al, 0fh
	or	al, ah
	and	dl, 0fh
	or	dl, dh

	mov	ah, dl
	xor	dx, dx
	popf

	bibl_ret


; *******************************************************

;;
; Przerabia podana 32-bitowa spakowana liczbe BCD na liczbe niespakowana.
; Makro: sbcd_rbcd32
; @param DX:AX - liczba do przerobienia.
; @return DX:AX - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_sbcd_na_rbcd32:
	push	bx
	pushf

	mov	bx, 1
	test	dx, dx
	jnz	.zero
	cmp	ax, 9999h
	ja	.zero
	dec	bx
.zero:
	mov	dl, ah
	shl	dx, 1
	shl	dx, 1
	shl	dx, 1
	shl	dx, 1
	and	dh, 0fh
	shr	dl, 1
	shr	dl, 1
	shr	dl, 1
	shr	dl, 1
	shl	ax, 1
	shl	ax, 1
	shl	ax, 1
	shl	ax, 1
	and	ah, 0fh
	shr	al, 1
	shr	al, 1
	shr	al, 1
	shr	al, 1

	test	bx, bx
	jnz	.zwroc_cf

	popf
	clc
	jmp	short .koniec

.zwroc_cf:
	popf
	stc
.koniec:
	pop	bx

	bibl_ret


; *******************************************************

;;
; Przerabia podana 32-bitowa niespakowana liczbe BCD na liczbe binarna.
; Makro: rbcd_bin32
; @param DX:AX - liczba do przerobienia.
; @return DX:AX - przerobiona liczba.
;;
_bcd_rbcd_na_bin32:
	pushf
	push	bx
	push	cx

	; 0-9999
	push	ax
	mov	ax, dx
	bibl_call	_bcd_rbcd_na_bin16	; -> AX
	mov	bx, 100
	mul	bx			; DX:AX = bin(DX) * 10000

	mov	cx, ax
	pop	ax
	bibl_call	_bcd_rbcd_na_bin16	; -> AX
	add	cx, ax
	adc	dx, 0
	mov	ax, cx

	pop	cx
	pop	bx
	popf

	bibl_ret


; *******************************************************

;;
; Przerabia podana 32-bitowa spakowana liczbe BCD na liczbe binarna.
; Makro: sbcd_bin32
; @param DX:AX - liczba do przerobienia.
; @return DX:AX - przerobiona liczba.
;;
_bcd_sbcd_na_bin32:
	pushf
	push	bx
	push	cx

	; 0-9999 9999

	push	ax
	mov	ax, dx
	bibl_call	_bcd_sbcd_na_bin16	; -> AX
	mov	bx, 10000
	mul	bx			; DX:AX = bin(DX) * 10000

	mov	cx, ax
	pop	ax
	bibl_call	_bcd_sbcd_na_bin16	; -> AX
	add	cx, ax
	adc	dx, 0
	mov	ax, cx

	pop	cx
	pop	bx
	popf

	bibl_ret


; *******************************************************

;;
; Przerabia podana 32-bitowa liczbe binarna na niespakowana liczbe BCD.
; Makro: bin_rbcd32
; @param DX:AX - liczba do przerobienia.
; @return DX:AX - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_bin_na_rbcd32:
	push	bx
	push	cx
	pushf

	; AAM = "AH:=AL/10 && AL:=AL % 10"

	mov	bx, 1
	test	dx, dx
	jnz	.nzero
	cmp	ax, 9999
	ja	.nzero
	dec	bl	; liczba sie miesci, gdy DX=0 i AX<9999
.nzero:
	push	ax

	mov	ax, dx
	xor	dx, dx
	mov	cx, 10000
	div	cx
	pop	ax
	mov	cx, 10000
	div	cx
	mov	ax, dx			; AX = reszta
	mov	bh, 100
	div	bh
	push	ax
	xor	ah, ah
	bibl_call	_bcd_bin_na_rbcd16	; -> AX
	mov	dx, ax

	pop	ax
	mov	al, ah
	xor	ah, ah
	bibl_call	_bcd_bin_na_rbcd16	; -> AX

	test	bl, bl
	jnz	.zwroc_cf

	popf
	clc
	jmp	short .koniec

.zwroc_cf:
	popf
	stc
.koniec:
	pop	cx
	pop	bx

	bibl_ret


; *******************************************************

;;
; Przerabia podana 32-bitowa liczbe binarna na spakowana liczbe BCD.
; Makro: bin_sbcd32
; @param DX:AX - liczba do przerobienia.
; @return DX:AX - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_bin_na_sbcd32:
	push	bx
	push	cx
	pushf

	; AAM = "AH:=AL/10 && AL:=AL % 10"
	; 0-9999 9999

	mov	bx, 1
	; 9999 9999 = 0x05F5 E0FF
	cmp	dx, 5F5h
	jna	.spr_eax

.odejmuj:
	; odejmuj po 0x 10 00 az sie bedzie miescilo
	; ( < 0x05F5 E0FF ), aby iloraz w dzieleniu
	; nie byl za duzy

	cmp	dx, 5F5h
	jna	.spr_eax2

.odejmuj2:
	sub	ax, 10000	; odejmuj taka liczbe, aby nie
				; zaklocic mlodszych cyfr
	sbb	dx, 0
	jmp	short .odejmuj

.spr_eax2:
	cmp	ax, 0f0ffh	; celowo o 0x1000 wiecej, by przerwac,
				; gdy liczba jest wieksza od granicznej
	ja	.odejmuj2
	jmp	short .miesci

.spr_eax:
	cmp	ax, 0e0ffh
	ja	.odejmuj

	dec	bl
.miesci:
	push	ax

	mov	ax, dx
	xor	dx, dx
	mov	cx, 10000
	div	cx
	pop	ax		; zaniedbujemy pierwszy wynik, bo wiemy, ze
				; wynik calkowity zmiesci sie w AX po
				; drugim dzieleniu
	; DX bez zmian!
	div	cx		; AX = 4 najstarsze cyfry = pierwszy wynik
	mov	cx, dx		; zachowaj reszte - mlodsza czesc liczby
	bibl_call	_bcd_bin_na_sbcd16	; <-> AX
	mov	dx, ax		; starsza czesc juz przerobiona

	mov	ax, cx		; przerob reszte
	bibl_call	_bcd_bin_na_sbcd16	; <-> AX

	test	bl, bl
	jnz	.zwroc_cf

	popf
	clc
	jmp	short .koniec

.zwroc_cf:
	popf
	stc
.koniec:
	pop	cx
	pop	bx

	bibl_ret

; *******************************************************
; *******************************************************

%if (__KOD_16BIT > 0)
 cpu 386
%endif

;;
; Pobiera z klawiatury 32-bitowa spakowana liczbe BCD.
; Makro: we32ebcd
; @return EAX=wczytana liczba (gdy CF=0), EAX=-1 i CF=1, gdy blad.
;;
_bcd_we32e:

	push_f
	push	rej(bx)
	push	rej(cx)
	push	rej(dx)
%if (__DOS > 0) || (__BIOS > 0)
	push	rej(si)		; licznik znakow
	xor	rej(si), rej(si)
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
	inc	rej(si)
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	.ld_petla

	cmp	al, '0'		; czy cyfra?
	jb	.ld_blad
	cmp	al, '9'
	ja	.ld_blad
	and	al, 0fh		; izolujemy wartosc

	shl	ebx, 1		; miejsce na nowa cyfre
	jc	.ld_blad
	shl	ebx, 1
	jc	.ld_blad
	shl	ebx, 1
	jc	.ld_blad
	shl	ebx, 1
	jc	.ld_blad

	or	bl, al		; dopisujemy nowa cyfre
	jmp	short .ld_petla

%if (__DOS > 0) || (__BIOS > 0)
.ld_bksp:
	test	rej(si), rej(si)
	jz	.ld_petla

	dec	rej(si)

        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, spc
	bibl_call	_pisz_z	; wyswietl znak
        mov	al, bksp
	bibl_call	_pisz_z	; wyswietl znak

	shr	ebx, 4

	jmp	short .ld_petla
%endif

.ld_blad:
	xor	eax, eax

%if (__DOS > 0) || (__BIOS > 0)
	pop	rej(si)
%endif
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(bx)
	dec	eax	 		; EAX=0FFFFFFFFh
	bibl_call	_czysc_klaw	; czyscimy bufor klawiatury

	pop_f
	stc			; zwroc blad

	bibl_ret

.ld_juz:
	mov	eax, ebx

%if (__DOS > 0) || (__BIOS > 0)
	pop	rej(si)
%endif
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(bx)
	pop_f
	clc			; zwroc brak bledu

	bibl_ret


; *******************************************************

;;
; Wyswietla na ekranie podana 32-bitowa spakowana liczbe BCD.
; Makro: pisz32ebcd
; @param EAX - liczba do wyswietlenia.
;;
_bcd_pisz32e:
	push_f
	push	rej(bp)
	push	rej(ax)
	push	rej(bx)
	push	rej(si)
%if (__KOD_16BIT > 0)
	mov	si, biblioteka_bcd
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

	mov	[_bcd_bufor + rej(si)], bl	; w buforze cyfry wspak, aby ominac
					; zera z przodu
	inc 	rej(si)

	test	eax, eax
	jnz	._pisz_ldh_petla

._pisz_ldh_wypis:
	mov	al, [_bcd_bufor + rej(si) - 1]	; wypisujemy wspak
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


; *******************************************************

;;
; Przerabia podana 32-bitowa niespakowana liczbe BCD na liczbe spakowana.
; Makro: rbcd_sbcd32e
; @param EAX - liczba do przerobienia.
; @return EAX - przerobiona liczba.
;;
_bcd_rbcd_na_sbcd32e:
	push_f
	push	rej(bx)

	mov	ebx, eax

	; niespakowana liczba BCD to liczba 0-9999 w 4 bajtach.

	; przeniesienie cyfry dziesiatek do gornej polowki AH
	shl	ah, 1
	shl	ah, 1
	shl	ah, 1
	shl	ah, 1

	and	al, 0fh
	or	al, ah

	shr	ebx, 16

	; przeniesienie cyfry tysiecy do gornej polowki BH
	shl	bh, 1
	shl	bh, 1
	shl	bh, 1
	shl	bh, 1

	and	bl, 0fh
	or	bl, bh	; BL = cyfra tysiecy, cyfra setek
	mov	ah, bl

	and	eax, 0ffffh

	pop	rej(bx)
	pop_f

	bibl_ret


; *******************************************************

;;
; Przerabia podana 32-bitowa spakowana liczbe BCD na liczbe niespakowana.
; Makro: sbcd_rbcd32e
; @param EAX - liczba do przerobienia.
; @return EAX - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_sbcd_na_rbcd32e:
	push	rej(bx)
	push	rej(cx)
	push_f

	xor	ebx, ebx
	cmp	eax, 9999h
	jbe	.zero
	inc	ebx
.zero:
	mov	ecx, eax
	shr	ecx, 4		; cyfry tysiecy i setek w CH,CL
	and	ch, 0fh
	shr	cl, 4

	shl	ax, 4
	and	ah, 0fh
	shr	al, 4
	shl	ecx, 16
	and	eax, 0ffffh
	or	eax, ecx

	test	ebx, ebx
	jnz	.zwroc_cf

	pop_f
	clc
	jmp	short .koniec

.zwroc_cf:
	pop_f
	stc
.koniec:
	pop	rej(cx)
	pop	rej(bx)

	bibl_ret


; *******************************************************

;;
; Przerabia podana 32-bitowa niespakowana liczbe BCD na liczbe binarna.
; Makro: rbcd_bin32e
; @param EAX - liczba do przerobienia.
; @return EAX - przerobiona liczba.
;;
_bcd_rbcd_na_bin32e:
	push_f
	push	rej(bx)
	push	rej(dx)

	; 0-9999

	mov	ebx, eax
	shr	ebx, 16
	mov	dx, bx

	bibl_call	_bcd_rbcd_na_bin32	; <-> DX:AX

	mov	bx, dx
	shl	ebx, 16
	and	eax, 0ffffh
	or	eax, ebx

	pop	rej(dx)
	pop	rej(bx)
	pop_f

	bibl_ret


; *******************************************************

;;
; Przerabia podana 32-bitowa spakowana liczbe BCD na liczbe binarna.
; Makro: sbcd_bin32e
; @param EAX - liczba do przerobienia.
; @return EAX - przerobiona liczba.
;;
_bcd_sbcd_na_bin32e:
	push_f
	push	rej(dx)

	; 0-9999 9999
	mov	edx, eax
	shr	edx, 16

	bibl_call	_bcd_sbcd_na_bin32	; <-> DX:AX

	shl	edx, 16
	and	eax, 0ffffh
	or	eax, edx

	pop	rej(dx)
	pop_f

	bibl_ret


; *******************************************************

;;
; Przerabia podana 32-bitowa liczbe binarna na niespakowana liczbe BCD.
; Makro: bin_rbcd32e
; @param EAX - liczba do przerobienia.
; @return EAX - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_bin_na_rbcd32e:
	push	rej(bx)
	push	rej(cx)
	push	rej(dx)
	push_f

	; AAM = "AH:=AL/10 && AL:=AL % 10"
	mov	bx, 1
	cmp	eax, 9999
	ja	.nzero
	dec	bl
.nzero:
	push	rej(ax)

	xor	dx, dx
	mov	cx, 10000
	div	cx
	mov	ax, dx			; AX = reszta
	mov	bh, 100
	div	bh			; AL = liczba setek
	xor	ah, ah
	bibl_call	_bcd_bin_na_rbcd16	; -> AX
	mov	cx, ax
	shl	ecx, 16

	pop	rej(ax)
	bibl_call	_bcd_bin_na_rbcd16	; -> AX
	and	eax, 0ffffh
	or	eax, ecx

	test	bl, bl
	jnz	.zwroc_cf

	pop_f
	clc
	jmp	short .koniec

.zwroc_cf:
	pop_f
	stc
.koniec:
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(bx)

	bibl_ret


; *******************************************************

;;
; Przerabia podana 32-bitowa liczbe binarna na spakowana liczbe BCD.
; Makro: bin_sbcd32e
; @param EAX - liczba do przerobienia.
; @return EAX - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_bin_na_sbcd32e:
	push	rej(bx)
	push	rej(cx)
	push	rej(dx)
	push_f

	; AAM = "AH:=AL/10 && AL:=AL % 10"

	mov	ebx, 1
	cmp	eax, 99999999
	ja	.nzero
	dec	ebx
.nzero:
	xor	edx, edx
	mov	ecx, 100000000
	div	ecx
	mov	eax, edx		; AX = reszta
	xor	edx, edx
	mov	ecx, 10000
	div	ecx			; EAX = 4 najstarsze cyfry
	bibl_call	_bcd_bin_na_sbcd16	; -> AX
	mov	cx, ax
	shl	ecx, 16

	mov	eax, edx
	bibl_call	_bcd_bin_na_sbcd16	; -> AX
	and	eax, 0ffffh
	or	eax, ecx

	test	ebx, ebx
	jnz	.zwroc_cf

	pop_f
	clc
	jmp	short .koniec

.zwroc_cf:
	pop_f
	stc
.koniec:
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(bx)

	bibl_ret


; *******************************************************
; *******************************************************


;;
; Pobiera z klawiatury 64-bitowa spakowana liczbe BCD.
; Makro: we64bcd
; @return EDX:EAX=wczytana liczba (gdy CF=0), EDX:EAX=-1 i CF=1, gdy blad.
;;
_bcd_we64:

	push_f
	push	rej(bp)
	push	rej(bx)
	push	rej(cx)
%if (__DOS > 0) || (__BIOS > 0)
	push	rej(si)		; licznik znakow
	xor	rej(si), rej(si)
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
	inc	rej(si)
%endif
				; przepuszczamy Spacje:
	cmp	al, spc
	je	._64_petla

	cmp	al, '0'		; czy cyfra?
	jb	._64_blad
	cmp	al, '9'
	ja	._64_blad

	and	eax, 0fh	; celowo EAX, aby wyzerowac reszte bitow

	shl	ebx, 1		; robimy miejsce na nowa cyfre:
	rcl	edx, 1
	jc	._64_blad

	shl	ebx, 1
	rcl	edx, 1
	jc	._64_blad

	shl	ebx, 1
	rcl	edx, 1
	jc	._64_blad

	shl	ebx, 1
	rcl	edx, 1		; "SHL EDX:EBX,4"
	jc	._64_blad

	or	bl, al		; dopisujemy nowa cyfre

	jmp	._64_petla
%if (__DOS > 0) || (__BIOS > 0)
._64_bksp:
	test	rej(si), rej(si)
	jz	._64_petla

	dec	rej(si)

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

	jmp	._64_petla
%endif

._64_blad:
	xor	eax, eax

%if (__DOS > 0) || (__BIOS > 0)
	pop	rej(si)
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
	pop	rej(si)
%endif
	pop	rej(cx)
	pop	rej(bx)
	pop	rej(bp)
	pop_f
	clc			; zwroc brak bledu

	bibl_ret

; *******************************************************

;;
; Wyswietla na ekranie podana 8-bitowa spakowana liczbe BCD.
; Makro: pisz64bcd
; @param EDX:EAX - liczba do wyswietlenia.
;;
_bcd_pisz64:

	push	rej(ax)

	mov	eax, edx
	bibl_call	_bcd_pisz32e		; starsze 32 bity

	pop	rej(ax)
	bibl_call	_bcd_pisz32e		; mlodsze 32 bity

	bibl_ret

; *******************************************************

;;
; Przerabia podana 64-bitowa niespakowana liczbe BCD na liczbe spakowana.
; Makro: rbcd_sbcd64
; @param EDX:EAX - liczba do przerobienia.
; @return EDX:EAX - przerobiona liczba.
;;
_bcd_rbcd_na_sbcd64:

	push_f
	push	rej(bx)

	mov	ebx, eax

	; niespakowana liczba BCD to liczba 0-99999999 w 8 bajtach.

	; przeniesienie cyfry dziesiatek do gornej polowki AH
	shl	ah, 1
	shl	ah, 1
	shl	ah, 1
	shl	ah, 1

	and	al, 0fh
	or	al, ah

	shr	ebx, 16

	; przeniesienie cyfry tysiecy do gornej polowki BH
	shl	bh, 1
	shl	bh, 1
	shl	bh, 1
	shl	bh, 1

	and	bl, 0fh
	or	bl, bh	; BL = cyfra tysiecy, cyfra setek
	mov	ah, bl	; AX = 4 najmlodsze cyfry

	and	eax, 0ffffh

	mov	ebx, edx

	; przeniesienie cyfry dziesiatek do gornej polowki DH
	shl	dh, 1
	shl	dh, 1
	shl	dh, 1
	shl	dh, 1

	and	dl, 0fh
	or	dl, dh

	shr	ebx, 16

	; przeniesienie cyfry tysiecy do gornej polowki BH
	shl	bh, 1
	shl	bh, 1
	shl	bh, 1
	shl	bh, 1

	and	bl, 0fh
	or	bl, bh	; BL = cyfra tysiecy, cyfra setek
	mov	dh, bl	; AX = 4 najmlodsze cyfry

	shl	edx, 16
	or	eax, edx
	xor	edx, edx

	pop	rej(bx)
	pop_f

	bibl_ret


; *******************************************************

;;
; Przerabia podana 64-bitowa spakowana liczbe BCD na liczbe niespakowana.
; Makro: sbcd_rbcd64
; @param EDX:EAX - liczba do przerobienia.
; @return EDX:EAX - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_sbcd_na_rbcd64:
	push	rej(bx)
	push_f

	mov	ebx, 1
	test	edx, edx
	jnz	.nzero
	cmp	eax, 99999999h
	ja	.nzero
	dec	ebx
.nzero:
	mov	edx, eax	; starsza czesc niewazna do wyniku
	shr	edx, 16

	shl	edx, 4
	shr	dx, 4
	shl	edx, 8
	shr	dx, 4
	shr	dl, 4

	and	eax, 0ffffh

	shl	eax, 4
	shr	ax, 4
	shl	eax, 8
	shr	ax, 4
	shr	al, 4

	test	ebx, ebx
	jnz	.zwroc_cf

	pop_f
	clc
	jmp	short .koniec

.zwroc_cf:
	pop_f
	stc
.koniec:
	pop	rej(bx)

	bibl_ret


; *******************************************************

;;
; Przerabia podana 64-bitowa niespakowana liczbe BCD na liczbe binarna.
; Makro: rbcd_bin64
; @param EDX:EAX - liczba do przerobienia.
; @return EDX:EAX - przerobiona liczba.
;;
_bcd_rbcd_na_bin64:
	push_f
	push	rej(bx)
	push	rej(cx)

        ; 0 - 9999 9999

	push	rej(ax)
	mov	eax, edx
	bibl_call	_bcd_rbcd_na_bin32e	; -> EAX
	mov	ebx, 10000
	mul	ebx			; EDX:EAX = bin(EDX) * 10000

	mov	ecx, eax
	pop	rej(ax)
	bibl_call	_bcd_rbcd_na_bin32e	; -> AX
	add	ecx, eax
	adc	edx, 0
	mov	eax, ecx

	pop	rej(cx)
	pop	rej(bx)
	pop_f

	bibl_ret


; *******************************************************

;;
; Przerabia podana 64-bitowa spakowana liczbe BCD na liczbe binarna.
; Makro: sbcd_bin64
; @param EDX:EAX - liczba do przerobienia.
; @return EDX:EAX - przerobiona liczba.
;;
_bcd_sbcd_na_bin64:
	push_f
	push	rej(bx)

        ; 0 - 9999 9999 9999 9999

	push	rej(ax)
	mov	eax, edx
	bibl_call	_bcd_sbcd_na_bin32e	; -> EAX
	mov	ebx, 100000000
	mul	ebx			; EDX:EAX = bin(EDX) * 100000000

	mov	ebx, eax
	pop	rej(ax)
	bibl_call	_bcd_sbcd_na_bin32e	; -> EAX
	add	eax, ebx
	adc	edx, 0

	pop	rej(bx)
	pop_f

	bibl_ret


; *******************************************************

;;
; Przerabia podana 64-bitowa liczbe binarna na niespakowana liczbe BCD.
; Makro: bin_rbcd64
; @param EDX:EAX - liczba do przerobienia.
; @return EDX:EAX - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_bin_na_rbcd64:
	push	rej(bx)
	push	rej(cx)
	push_f

	; AAM = "AH:=AL/10 && AL:=AL % 10"

	mov	ebx, 1
	; 9999 9999 = 0x05F5 E0FF < FFFF FFFF
	cmp	eax, 99999999
	ja	.nzero
	dec	bl
.nzero:
	xor	edx, edx
	mov	ecx, 100000000
	div	ecx
	mov	eax, edx		; AX = reszta
	xor	edx, edx
	mov	ecx, 10000
	div	ecx			; EAX = 4 najstarsze cyfry
	mov	ecx, edx
	bibl_call	_bcd_bin_na_rbcd32e	; <-> EAX
	mov	edx, eax

	mov	eax, ecx		; reszta
	bibl_call	_bcd_bin_na_rbcd32e	; <-> EAX

	test	bl, bl
	jnz	.zwroc_cf

	pop_f
	clc
	jmp	short .koniec

.zwroc_cf:
	pop_f
	stc
.koniec:
	pop	rej(cx)
	pop	rej(bx)

	bibl_ret


; *******************************************************

;;
; Przerabia podana 64-bitowa liczbe binarna na spakowana liczbe BCD.
; Makro: bin_sbcd64
; @param EDX:EAX - liczba do przerobienia.
; @return EDX:EAX - przerobiona liczba.
; @return CF=1 w przypadku przepelnienia (ale wynik zostaje zachowany).
;;
_bcd_bin_na_sbcd64:
	push	rej(bx)
	push	rej(cx)
	push_f

	; AAM = "AH:=AL/10 && AL:=AL % 10"

	mov	ebx, 1
	; 9999 9999 9999 9999 = 0 x 0023 86F2 6FC0 FFFF
	; 0 x 9999 9999 9999 9999 = 1106 8046 4442 2573 0969
	cmp	edx, 2386f2h
	jna	.spr_eax

.odejmuj:
	; odejmuj po 0x 80 00 00 00 az sie bedzie miescilo
	; ( < 0 x 0023 86F2 EFC0 FFFF ), aby iloraz w dzieleniu
	; nie byl za duzy

	cmp	edx, 2386f2h
	jna	.spr_eax2

.odejmuj2:
	sub	eax, 1000000000	; odejmuj taka liczbe, aby nie
				; zaklocic mlodszych cyfr
	sbb	edx, 0
	jmp	short .odejmuj

.spr_eax2:
	cmp	eax, 0efc0ffffh	; celowo o 0x80000000 wiecej, by przerwac,
				; gdy liczba jest wieksza od granicznej
	ja	.odejmuj2
	jmp	short .miesci

.spr_eax:
	cmp	eax, 6fc0ffffh
	ja	.odejmuj

	dec	bl
.miesci:
	push	rej(ax)

	mov	eax, edx
	xor	edx, edx
	mov	ecx, 100000000
	div	ecx
	pop	rej(ax)		; zaniedbujemy pierwszy wynik, bo wiemy, ze
				; wynik calkowity zmiesci sie w EAX po
				; drugim dzieleniu
	; EDX bez zmian!
	div	ecx		; EAX = 8 najstarszych cyfr
				; EAX = pierwszy wynik
	mov	ecx, edx	; zachowaj reszte - mlodsza czesc liczby
	bibl_call	_bcd_bin_na_sbcd32e	; -> EAX
	mov	edx, eax	; starsza czesc juz przerobiona

	mov	eax, ecx	; przerob reszte
	bibl_call	_bcd_bin_na_sbcd32e	; -> EAX

	test	bl, bl
	jnz	.zwroc_cf

	pop_f
	clc
	jmp	short .koniec

.zwroc_cf:
	pop_f
	stc
.koniec:
	pop	rej(cx)
	pop	rej(bx)

	bibl_ret
