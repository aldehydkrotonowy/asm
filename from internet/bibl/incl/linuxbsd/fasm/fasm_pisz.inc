; Zalacznik do modulu wypisujacego dane, skladnia FASM
; 40 procedur

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

if ~defined __FASM_PISZ | defined @f
__FASM_PISZ	= 1
@@:



;===================================

macro		pisz16
 {

;we: AX=liczba bez znaku do wypisania

	if ~ defined _pisz_l | defined @f
		extrn	_pisz_l
		@@:
	end if
	call	_pisz_l
 }


;===================================

macro		pisz16h
 {

;we: AX=liczba heksadecymalna do wypisania

	if ~ defined _pisz_lh | defined @f
		extrn	_pisz_lh
		@@:
	end if
	call	_pisz_lh
 }


;===================================

macro		pisz16z
 {

;we: AX=liczba do wypisania ze znakiem

	if ~ defined _pisz_lz | defined @f
		extrn	_pisz_lz
		@@:
	end if
	call	_pisz_lz
 }


;===================================

macro		pisz16zh
 {

;we: AX=liczba heksadecymalna do wypisania ze znakiem

	if ~ defined _pisz_lzh | defined @f
		extrn	_pisz_lzh
		@@:
	end if
	call	_pisz_lzh
 }


;===================================

macro		pisz16b
 {

;pisze liczbe w AX w postaci dwojkowej

	if ~ defined _pisz_lb | defined @f
		extrn	_pisz_lb
		@@:
	end if
	call	_pisz_lb
 }


;===================================

macro		pisz16o
 {

;pisze liczbe w AX w postaci osemkowej

	if ~ defined _pisz_lo | defined @f
		extrn	_pisz_lo
		@@:
	end if
	call	_pisz_lo
 }


;===================================
;===================================


macro		pisz8
 {

;pisze 8-bitowa liczbe w AL

	if ~ defined _pisz_8 | defined @f
		extrn	_pisz_8
		@@:
	end if
	call	_pisz_8
 }


;===================================

macro		pisz8h
 {

;pisze 8-bitowa liczbe heksadecymalna w AL

	if ~ defined _pisz_8h | defined @f
		extrn	_pisz_8h
		@@:
	end if
	call	_pisz_8h
 }


;===================================

macro		pisz8z
 {

;pisze 8-bitowa liczbe ze znakiem w AL

	if ~ defined _pisz_8z | defined @f
		extrn	_pisz_8z
		@@:
	end if
	call	_pisz_8z
 }


;===================================

macro		pisz8zh
 {

;pisze 8-bitowa liczbe heksadecymalna ze znakiem w AL

	if ~ defined _pisz_8zh | defined @f
		extrn	_pisz_8zh
		@@:
	end if
	call	_pisz_8zh
 }


;===================================

macro		pisz8b
 {

;pisze 8-bitowa liczbe dwojkowa w AL

	if ~ defined _pisz_8b | defined @f
		extrn	_pisz_8b
		@@:
	end if
	call	_pisz_8b
 }


;===================================

macro		pisz8o
 {

;pisze 8-bitowa liczbe osemkowa w AL

	if ~ defined _pisz_8o | defined @f
		extrn	_pisz_8o
		@@:
	end if
	call	_pisz_8o
 }

;===================================
;===================================


macro		pisz32
 {

;pisze liczbe z DX:AX

	if ~ defined _pisz_32 | defined @f
		extrn	_pisz_32
		@@:
	end if
	call	_pisz_32
 }


;===================================

macro		pisz32h
 {

;pisze liczbe z DX:AX szestnastkowo

	if ~ defined _pisz_32h | defined @f
		extrn	_pisz_32h
		@@:
	end if
	call	_pisz_32h
 }


;===================================

macro		pisz32z
 {

;pisze liczbe z DX:AX ze znakiem

	if ~ defined _pisz_32z | defined @f
		extrn	_pisz_32z
		@@:
	end if
	call	_pisz_32z
 }


;===================================

macro		pisz32zh
 {

;pisze liczbe z DX:AX hex ze znakiem

	if ~ defined _pisz_32zh | defined @f
		extrn	_pisz_32zh
		@@:
	end if
	call	_pisz_32zh
 }


;===================================

macro		pisz32b
 {

;pisze liczbe z DX:AX dwojkowo

	if ~ defined _pisz_32b | defined @f
		extrn	_pisz_32b
		@@:
	end if
	call	_pisz_32b
 }


;===================================

macro		pisz32o
 {

;pisze liczbe z DX:AX osemkowo

	if ~ defined _pisz_32o | defined @f
		extrn	_pisz_32o
		@@:
	end if
	call	_pisz_32o
 }

;===================================
;===================================


macro		pisz32e
 {

;we: EAX=liczba bez znaku do wypisania

	if ~ defined _pisz_ld | defined @f
		extrn	_pisz_ld
		@@:
	end if
	call	_pisz_ld
 }


;===================================

macro		pisz32eh
 {

;we: EAX=liczba szestnastkowa do wypisania

	if ~ defined _pisz_ldh | defined @f
		extrn	_pisz_ldh
		@@:
	end if
	call	_pisz_ldh
 }


;===================================

macro		pisz32ez
 {

;we: EAX=liczba ze znakiem do wypisania

	if ~ defined _pisz_ldz | defined @f
		extrn	_pisz_ldz
		@@:
	end if
	call	_pisz_ldz
 }


;===================================

macro		pisz32ezh
 {

;we: EAX=liczba heksadecymalna ze znakiem do wypisania

	if ~ defined _pisz_ldzh | defined @f
		extrn	_pisz_ldzh
		@@:
	end if
	call	_pisz_ldzh
 }


;===================================

macro		pisz32eb
 {

;pisze liczbe z EAX w postaci dwojkowej

	if ~ defined _pisz_ldb | defined @f
		extrn	_pisz_ldb
		@@:
	end if
	call	_pisz_ldb
 }


;===================================

macro		pisz32eo
 {

;pisze liczbe z EAX w postaci osemkowej

	if ~ defined _pisz_ldo | defined @f
		extrn	_pisz_ldo
		@@:
	end if
	call	_pisz_ldo
 }

;===================================
;===================================



macro		pisz64
 {

;pisze liczbe z EDX:EAX

	if ~ defined _pisz_64 | defined @f
		extrn	_pisz_64
		@@:
	end if
	call	_pisz_64
 }


;===================================

macro		pisz64h
 {

;pisze liczbe z EDX:EAX szestnastkowo

	if ~ defined _pisz_64h | defined @f
		extrn	_pisz_64h
		@@:
	end if
	call	_pisz_64h
 }


;===================================

macro		pisz64z
 {

;pisze liczbe z EDX:EAX, ze znakiem

	if ~ defined _pisz_64z | defined @f
		extrn	_pisz_64z
		@@:
	end if
	call	_pisz_64z
 }


;===================================

macro		pisz64zh
 {

;pisze liczbe z EDX:EAX hex, ze znakiem

	if ~ defined _pisz_64zh | defined @f
		extrn	_pisz_64zh
		@@:
	end if
	call	_pisz_64zh
 }


;===================================

macro		pisz64b
 {

;pisze liczbe z EDX:EAX dwojkowo

	if ~ defined _pisz_64b | defined @f
		extrn	_pisz_64b
		@@:
	end if
	call	_pisz_64b
 }


;===================================

macro		pisz64o
 {

;pisze liczbe z EDX:EAX osemkowo

	if ~ defined _pisz_64o | defined @f
		extrn	_pisz_64o
		@@:
	end if
	call	_pisz_64o
 }

;===================================
;===================================



macro		pisz_c
 {

; we: AL=cyfra do wypisania 0...9, nie '0'...'9' ( uzyc _pisz_z )
; wy: CF=1 jesli blad

	if ~ defined _pisz_c | defined @f
		extrn	_pisz_c
		@@:
	end if
	call	_pisz_c
 }


;===================================

macro		pisz_z
 {

;we: AL=znak do wypisania

	if ~ defined _pisz_z | defined @f
		extrn	_pisz_z
		@@:
	end if
	call	_pisz_z
 }


;===================================

macro		pisz_ch
 {

; we: AL=cyfra heksadecymalna do wypisania 0...15, nie '0'...'f'/'F'
; ( wtedy uzyc pisz_z )
; wy: CF=1 jesli blad

	if ~ defined _pisz_ch | defined @f
		extrn	_pisz_ch
		@@:
	end if
	call	_pisz_ch
 }


;===================================

macro		pisz
 {

;we: ciag znakow do wypisania jest w kodzie programu, tuz po
; odwolaniu sie do "pisz" i jest zakonczony na bajt 0

	if ~ defined _pisz | defined @f
		extrn	_pisz
		@@:
	end if
	call	_pisz
 }


;===================================

macro		pisz_dssi
 {

;wypisuje lancuch znakow pod DS:SI, zakonczony na bajt 0

	if ~ defined _pisz_wsk32 | defined @f
		extrn	_pisz_wsk32
		@@:
	end if
;;;	call	_pisz_wsk
	call	_pisz_wsk32
 }


;===================================

macro		pisz_esi
 {

;wypisuje lancuch znakow pod (DS:)ESI, zakonczony na bajt 0

	if ~ defined _pisz_wsk32 | defined @f
		extrn	_pisz_wsk32
		@@:
	end if
	call	_pisz_wsk32
 }


;===================================

macro		pisz_dl
 {

;wypisuje lancuch znakow pod DS:SI, dlugosci CX

	if ~ defined _pisz_dl32 | defined @f
		extrn	_pisz_dl32
		@@:
	end if
;;;	call	_pisz_dl
	call	_pisz_dl32
 }


;===================================

macro		pisz_dl32
 {

;wypisuje lancuch znakow pod (DS:)ESI, dlugosci ECX

	if ~ defined _pisz_dl32 | defined @f
		extrn	_pisz_dl32
		@@:
	end if
	call	_pisz_dl32
 }


;===================================
;===================================


macro		czysc
 {

;czysci ekran

	if ~ defined _cls3 | defined @f
		extrn	_cls3
		@@:
	end if
	call	_cls3
 }


;===================================

macro		nwln
 {

;pisze znak konca linii (Linux)

	if ~ defined _nwln | defined @f
		extrn	_nwln
		@@:
	end if
	call	_nwln
 }


;===================================

macro		pozycja
{

;ustawia kursor na danej pozycji:
; AL = wiersz
; AH = kolumna

	if ~ defined _pozycja | defined @f
		extrn	_pozycja
		@@:
	end if
	call	_pozycja
}



end if		; __FASM_PISZ

