;Zalacznik do modulu wypisujacego dane
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


extrn	_pisz_l:far
extrn	_pisz_lh:far
extrn	_pisz_lz:far
extrn	_pisz_lzh:far
extrn	_pisz_lb:far
extrn	_pisz_lo:far

extrn	_pisz_8:far
extrn	_pisz_8h:far
extrn	_pisz_8z:far
extrn	_pisz_8zh:far
extrn	_pisz_8b:far
extrn	_pisz_8o:far

extrn	_pisz_32:far
extrn	_pisz_32h:far
extrn	_pisz_32z:far
extrn	_pisz_32zh:far
extrn	_pisz_32b:far
extrn	_pisz_32o:far

extrn	_pisz_ld:far
extrn	_pisz_ldh:far
extrn	_pisz_ldz:far
extrn	_pisz_ldzh:far
extrn	_pisz_ldb:far
extrn	_pisz_ldo:far

extrn	_pisz_64:far
extrn	_pisz_64h:far
extrn	_pisz_64z:far
extrn	_pisz_64zh:far
extrn	_pisz_64b:far
extrn	_pisz_64o:far

extrn	_pisz_z:far
extrn	_pisz_c:far
extrn	_pisz_ch:far

extrn	_pisz:far
extrn	_pisz_wsk:far
extrn	_pisz_wsk32:far
extrn	_pisz_dl:far
extrn	_pisz_dl32:far

;;extrn _cls:proc
extrn	_cls3:far
extrn	_nwln:far


skacz		macro	nazwa
	call	far ptr nazwa
		endm

;===================================

pisz16		macro

;we: AX=liczba bez znaku do wypisania

	skacz	_pisz_l
		endm

;===================================

pisz16h		macro

;we: AX=liczba heksadecymalna do wypisania

	skacz	_pisz_lh
		endm

;===================================

pisz16z		macro

;we: AX=liczba do wypisania ze znakiem

	skacz	_pisz_lz
		endm

;===================================

pisz16zh	macro

;we: AX=liczba heksadecymalna do wypisania ze znakiem

	skacz	_pisz_lzh
		endm

;===================================

pisz16b		macro

;pisze liczbe w AX w postaci dwojkowej

	skacz	_pisz_lb
		endm

;===================================

pisz16o		macro

;pisze liczbe w AX w postaci osemkowej

	skacz	_pisz_lo
		endm


;===================================
;===================================


pisz8		macro

;pisze 8-bitowa liczbe w AL

	skacz	_pisz_8
		endm

;===================================

pisz8h		macro

;pisze 8-bitowa liczbe heksadecymalna w AL

	skacz	_pisz_8h
		endm

;===================================

pisz8z		macro

;pisze 8-bitowa liczbe ze znakiem w AL

	skacz	_pisz_8z
		endm

;===================================

pisz8zh		macro

;pisze 8-bitowa liczbe heksadecymalna ze znakiem w AL

	skacz	_pisz_8zh
		endm

;===================================

pisz8b		macro

;pisze 8-bitowa liczbe dwojkowa w AL

	skacz	_pisz_8b
		endm

;===================================

pisz8o		macro

;pisze 8-bitowa liczbe osemkowa w AL

	skacz	_pisz_8o
		endm


;===================================
;===================================


pisz32		macro

;pisze liczbe w DX:AX

	skacz	_pisz_32
		endm

;===================================

pisz32h		macro

;pisze liczbe w DX:AX szestnastkowo

	skacz	_pisz_32h
		endm

;===================================

pisz32z		macro

;pisze liczbe w DX:AX ze znakiem

	skacz	_pisz_32z
		endm

;===================================

pisz32zh	macro

;pisze liczbe w DX:AX hex ze znakiem

	skacz	_pisz_32zh
		endm

;===================================

pisz32b		macro

;pisze liczbe w DX:AX dwojkowo

	skacz	_pisz_32b
		endm

;===================================

pisz32o		macro

;pisze liczbe w DX:AX osemkowo

	skacz	_pisz_32o
		endm


;===================================
;===================================


pisz32e		macro

;we: EAX=liczba bez znaku do wypisania

	skacz	_pisz_ld
		endm

;===================================

pisz32eh	macro

;we: EAX=liczba szestnastkowa do wypisania

	skacz	_pisz_ldh
		endm

;===================================

pisz32ez	macro

;we: EAX=liczba ze znakiem do wypisania

	skacz	_pisz_ldz
		endm

;===================================

pisz32ezh	macro

;we: EAX=liczba heksadecymalna ze znakiem do wypisania

	skacz	_pisz_ldzh
		endm

;===================================

pisz32eb	macro

;pisze liczbe w EAX w postaci dwojkowej

	skacz	_pisz_ldb
		endm

;===================================

pisz32eo	macro

;pisze liczbe w EAX w postaci osemkowej

	skacz	_pisz_ldo
		endm


;===================================
;===================================



pisz64		macro

;pisze liczbe w EDX:EAX

	skacz	_pisz_64
		endm

;===================================

pisz64h		macro

;pisze liczbe w EDX:EAX szestnastkowo

	skacz	_pisz_64h
		endm

;===================================

pisz64z		macro

;pisze liczbe w EDX:EAX, ze znakiem

	skacz	_pisz_64z
		endm

;===================================

pisz64zh	macro

;pisze liczbe w EDX:EAX hex, ze znakiem

	skacz	_pisz_64zh
		endm

;===================================

pisz64b		macro

;pisze liczbe w EDX:EAX dwojkowo

	skacz	_pisz_64b
		endm

;===================================

pisz64o		macro

;pisze liczbe w EDX:EAX osemkowo

	skacz	_pisz_64o
		endm


;===================================
;===================================



pisz_c		macro

;we: AL=cyfra do wypisania 0...9, nie '0'...'9' ( uzyc _pisz_z )
; CF=1 jesli blad

	skacz	_pisz_c
		endm

;===================================

pisz_z		macro

;we: AL=znak do wypisania

	skacz	_pisz_z
		endm

;===================================

pisz_ch		macro

;we: AL=cyfra heksadecymalna do wypisania 0...15, nie '0'...'f'/'F'
; ( uzyc pisz_z )
; CF=1 jesli blad

	skacz	_pisz_ch
		endm

;===================================

pisz		macro

;we: ciag znakow do wypisania jest w kodzie programu, tuz po odwolaniu
; sie do "pisz" i jest zakonczony na bajt 0

	skacz	_pisz
		endm

;===================================

pisz_dssi	macro

;wypisuje lancuch znakow pod DS:SI, zakonczony na bajt 0

	skacz	_pisz_wsk
		endm

;===================================

pisz_esi	macro

;wypisuje lancuch znakow pod (DS:)ESI, zakonczony na bajt 0

	skacz	_pisz_wsk32
		endm

;===================================

pisz_dl		macro

;wypisuje lancuch znakow pod DS:SI, dlugosci CX

	skacz	_pisz_dl
		endm

;===================================

pisz_dl32	macro

;wypisuje lancuch znakow pod (DS:)ESI, dlugosci ECX

	skacz	_pisz_dl32
		endm

;===================================
;===================================


czysc		macro

;czysci ekran

	skacz	_cls3
		endm

;===================================

nwln		macro

;pisze znak konca linii (Windows)

	skacz	_nwln
		endm


