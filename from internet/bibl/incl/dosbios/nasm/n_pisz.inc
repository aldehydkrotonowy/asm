;Zalacznik do modulu wypisujacego dane, skladnia NASM

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

%ifndef __NASM_PISZ
%define __NASM_PISZ



;===================================


%imacro		pisz16 0

;we: AX=liczba bez znaku do wypisania

	%ifndef	_pisz_l
		extern	_pisz_l
	%endif

	skacz	_pisz_l
		%endm

;===================================

%imacro		pisz16h 0

;we: AX=liczba heksadecymalna do wypisania

	%ifndef	_pisz_lh
		extern	_pisz_lh
	%endif

	skacz	_pisz_lh
		%endm

;===================================

%imacro		pisz16z 0

;we: AX=liczba do wypisania ze znakiem

	%ifndef	_pisz_lz
		extern	_pisz_lz
	%endif

	skacz	_pisz_lz
		%endm

;===================================

%imacro		pisz16zh 0

;we: AX=liczba heksadecymalna do wypisania ze znakiem

	%ifndef	_pisz_lzh
		extern	_pisz_lzh
	%endif

	skacz	_pisz_lzh
		%endm

;===================================

%imacro		pisz16b	 0

;pisze liczbe w AX w postaci dwojkowej

	%ifndef	_pisz_lb
		extern	_pisz_lb
	%endif

	skacz	_pisz_lb
		%endm

;===================================

%imacro		pisz16o	 0

;pisze liczbe w AX w postaci osemkowej

	%ifndef	_pisz_lo
		extern	_pisz_lo
	%endif

	skacz	_pisz_lo
		%endm


;===================================
;===================================


%imacro		pisz8 0

;pisze 8-bitowa liczbe w AL

	%ifndef	_pisz_8
		extern	_pisz_8
	%endif

	skacz	_pisz_8
		%endm

;===================================

%imacro		pisz8h 0

;pisze 8-bitowa liczbe heksadecymalna w AL

	%ifndef	_pisz_8h
		extern	_pisz_8h
	%endif

	skacz	_pisz_8h
		%endm

;===================================

%imacro		pisz8z 0

;pisze 8-bitowa liczbe ze znakiem w AL

	%ifndef	_pisz_8z
		extern	_pisz_8z
	%endif

	skacz	_pisz_8z
		%endm

;===================================

%imacro		pisz8zh 0

;pisze 8-bitowa liczbe heksadecymalna ze znakiem w AL

	%ifndef	_pisz_8zh
		extern	_pisz_8zh
	%endif

	skacz	_pisz_8zh
		%endm

;===================================

%imacro		pisz8b 0

;pisze 8-bitowa liczbe dwojkowa w AL

	%ifndef	_pisz_8b
		extern	_pisz_8b
	%endif

	skacz	_pisz_8b
		%endm

;===================================

%imacro		pisz8o 0

;pisze 8-bitowa liczbe osemkowa w AL

	%ifndef	_pisz_8o
		extern	_pisz_8o
	%endif

	skacz	_pisz_8o
		%endm

;===================================
;===================================


%imacro		pisz32 0

;pisze liczbe w DX:AX

	%ifndef	_pisz_32
		extern	_pisz_32
	%endif

	skacz	_pisz_32
		%endm

;===================================

%imacro		pisz32h	0

;pisze liczbe w DX:AX szestnastkowo

	%ifndef	_pisz_32h
		extern	_pisz_32h
	%endif

	skacz	_pisz_32h
		%endm

;===================================

%imacro		pisz32z 0

;pisze liczbe w DX:AX ze znakiem

	%ifndef	_pisz_32z
		extern	_pisz_32z
	%endif

	skacz	_pisz_32z
		%endm

;===================================

%imacro		pisz32zh 0

;pisze liczbe w DX:AX hex ze znakiem

	%ifndef	_pisz_32zh
		extern	_pisz_32zh
	%endif

	skacz	_pisz_32zh
		%endm

;===================================

%imacro		pisz32b 0

;pisze liczbe w DX:AX dwojkowo

	%ifndef	_pisz_32b
		extern	_pisz_32b
	%endif

	skacz	_pisz_32b
		%endm

;===================================

%imacro		pisz32o 0

;pisze liczbe w DX:AX osemkowo

	%ifndef	_pisz_32o
		extern	_pisz_32o
	%endif

	skacz	_pisz_32o
		%endm


;===================================
;===================================



%imacro		pisz32e 0

;we: EAX=liczba bez znaku do wypisania

	%ifndef	_pisz_ld
		extern	_pisz_ld
	%endif

	skacz	_pisz_ld
		%endm

;===================================

%imacro		pisz32eh 0

;we: EAX=liczba szestnastkowa do wypisania

	%ifndef	_pisz_ldh
		extern	_pisz_ldh
	%endif

	skacz	_pisz_ldh
		%endm

;===================================

%imacro		pisz32ez 0

;we: EAX=liczba ze znakiem do wypisania

	%ifndef	_pisz_ldz
		extern	_pisz_ldz
	%endif

	skacz	_pisz_ldz
		%endm

;===================================

%imacro		pisz32ezh 0

;we: EAX=liczba heksadecymalna ze znakiem do wypisania

	%ifndef	_pisz_ldzh
		extern	_pisz_ldzh
	%endif

	skacz	_pisz_ldzh
		%endm

;===================================

%imacro		pisz32eb 0

;pisze liczbe w EAX w postaci dwojkowej

	%ifndef	_pisz_ldb
		extern	_pisz_ldb
	%endif

	skacz	_pisz_ldb
		%endm

;===================================

%imacro		pisz32eo 0

;pisze liczbe w EAX w postaci osemkowej

	%ifndef	_pisz_ldo
		extern	_pisz_ldo
	%endif

	skacz	_pisz_ldo
		%endm


;===================================
;===================================


%imacro		pisz64 0

;pisze liczbe w EDX:EAX

	%ifndef	_pisz_64
		extern	_pisz_64
	%endif

	skacz	_pisz_64
		%endm

;===================================

%imacro		pisz64h 0

;pisze liczbe w EDX:EAX szestnastkowo

	%ifndef	_pisz_64h
		extern	_pisz_64h
	%endif

	skacz	_pisz_64h
		%endm

;===================================

%imacro		pisz64z 0

;pisze liczbe w EDX:EAX, ze znakiem

	%ifndef	_pisz_64z
		extern	_pisz_64z
	%endif

	skacz	_pisz_64z
		%endm

;===================================

%imacro		pisz64zh 0

;pisze liczbe w EDX:EAX hex, ze znakiem

	%ifndef	_pisz_64zh
		extern	_pisz_64zh
	%endif

	skacz	_pisz_64zh
		%endm

;===================================

%imacro		pisz64b 0

;pisze liczbe w EDX:EAX dwojkowo

	%ifndef	_pisz_64b
		extern	_pisz_64b
	%endif

	skacz	_pisz_64b
		%endm

;===================================

%imacro		pisz64o 0

;pisze liczbe w EDX:EAX osemkowo

	%ifndef	_pisz_64o
		extern	_pisz_64o
	%endif

	skacz	_pisz_64o
		%endm


;===================================
;===================================


%imacro		pisz_c 0

;we: AL=cyfra do wypisania 0...9, nie '0'...'9' ( uzyc _pisz_z )
; CF=1 jesli blad

	%ifndef	_pisz_c
		extern	_pisz_c
	%endif

	skacz	_pisz_c
		%endm

;===================================

%imacro		pisz_z 0

;we: AL=znak do wypisania

	%ifndef	_pisz_z
		extern	_pisz_z
	%endif

	skacz	_pisz_z
		%endm

;===================================

%imacro		pisz_ch 0

;we: AL=cyfra heksadecymalna do wypisania 0...15, nie '0'...'f'/'F'
; ( uzyc pisz_z )
; CF=1 jesli blad

	%ifndef	_pisz_ch
		extern	_pisz_ch
	%endif

	skacz	_pisz_ch
		%endm

;===================================

%imacro		pisz 0

;we: ciag znakow do wypisania jest w kodzie programu, tuz po odwolaniu
; sie do "pisz" i jest zakonczony na bajt 0

	%ifndef	_pisz
		extern	_pisz
	%endif

	skacz	_pisz
		%endm

;===================================

%imacro		pisz_dssi 0

;wypisuje lancuch znakow pod DS:SI, zakonczony na bajt 0

	%ifndef	_pisz_wsk
		extern	_pisz_wsk
	%endif

	skacz	_pisz_wsk
		%endm

;===================================

%imacro		pisz_esi 0

;wypisuje lancuch znakow pod (DS:)ESI, zakonczony na bajt 0

	%ifndef	_pisz_wsk32
		extern	_pisz_wsk32
	%endif

	skacz	_pisz_wsk32
		%endm

;===================================

%imacro		pisz_dl 0

;wypisuje lancuch znakow pod DS:SI, dlugosci CX

	%ifndef	_pisz_dl
		extern	_pisz_dl
	%endif

	skacz	_pisz_dl
		%endm

;===================================

%imacro		pisz_dl32 0

;wypisuje lancuch znakow pod (DS:)ESI, dlugosci ECX

	%ifndef	_pisz_dl32
		extern	_pisz_dl32
	%endif

	skacz	_pisz_dl32
		%endm

;===================================
;===================================

%imacro		czysc 0

;czysci ekran

	%ifndef	_cls3
		extern	_cls3
	%endif

	skacz	_cls3
		%endm

;===================================

%imacro		nwln 0

;pisze znak konca linii (Windows)

	%ifndef	_nwln
		extern	_nwln
	%endif

	skacz	_nwln
		%endm


%endif		; __NASM_PISZ

