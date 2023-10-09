; Zalacznik do modulu pobierajacego dane od uzytkownika, skladnia NASM
; 36 procedur

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

%ifndef __NASM_WEJ
%define __NASM_WEJ



;===================================

%imacro		we16 0

;pobiera liczbe 0-65535, zwraca ja w AX i CF=0
; CF=1 i AX=ffff jesli blad

        %ifndef _we_l
                extern  _we_l
        %endif

	call	_we_l
		%endm

;===================================

%imacro		we16h 0

;pobiera liczbe heksadecymalna 0-ffff, zwraca ja w AX i CF=0
; AX=ffff i CF=1, jesli blad

        %ifndef _we_lh
                extern  _we_lh
        %endif

	call	_we_lh
		%endm

;===================================

%imacro		we16z 0

;pobiera liczbe ze znakiem  -32768...32767, zwraca ja w AX i CF=0
; AX=ffff i CF=1, jesli blad

        %ifndef _we_lz
                extern  _we_lz
        %endif

	call	_we_lz
		%endm

;===================================

%imacro		we16zh 0

;pobiera liczbe heksadecymalna ze znakiem  -8000h...7fff, zwraca ja w AX i CF=0
; AX=ffff i CF=1 jesli blad

        %ifndef _we_lzh
                extern  _we_lzh
        %endif

	call	_we_lzh
		%endm

;===================================

%imacro		we16b 0

;pobiera liczbe binarna 0-1111 1111 1111 1111  i zwraca ja w AX, CF=0
; AX=FFFF i CF=1 jesli blad

        %ifndef _we_lb
                extern  _we_lb
        %endif

	call	_we_lb
		%endm

;===================================

%imacro		we16o 0

;pobiera liczbe osemkowa i zwraca ja w AX, CF=0
; AX=FFFF i CF=1 jesli blad

        %ifndef _we_lo
                extern  _we_lo
        %endif

	call	_we_lo
		%endm

;===================================
;===================================

%imacro		we8 0

;pobiera liczbe 0...255 i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

        %ifndef _we_8
                extern  _we_8
        %endif

	call	_we_8
		%endm

;===================================

%imacro		we8h 0

;pobiera liczbe 0...FF i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

        %ifndef _we_8h
                extern  _we_8h
        %endif

	call	_we_8h
		%endm

;===================================

%imacro		we8z 0

;pobiera liczbe -128...127 i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

        %ifndef _we_8z
                extern  _we_8z
        %endif

	call	_we_8z
		%endm

;===================================

%imacro		we8zh 0

;pobiera liczbe -80h...7f i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

        %ifndef _we_8zh
                extern  _we_8zh
        %endif

	call	_we_8zh
		%endm

;===================================

%imacro		we8b 0

;pobiera liczbe 0000 0000...1111 1111 i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

        %ifndef _we_8b
                extern  _we_8b
        %endif

	call	_we_8b
		%endm

;===================================

%imacro		we8o 0

;pobiera liczbe osemkowa i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

        %ifndef _we_8o
                extern  _we_8o
        %endif

	call	_we_8o
		%endm

;===================================
;===================================


%imacro		we32 0

;pobiera liczbe 0-4.294.967.296 i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

        %ifndef _we_32
                extern  _we_32
        %endif

	call	_we_32
		%endm

;===================================

%imacro		we32h 0

;pobiera liczbe 0-FFFF FFFF i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

        %ifndef _we_32h
                extern  _we_32h
        %endif

	call	_we_32h
		%endm

;===================================

%imacro		we32z 0

;pobiera liczbe -347.483.648...347.483.647  i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

        %ifndef _we_32z
                extern  _we_32z
        %endif

	call	_we_32z
		%endm

;===================================

%imacro		we32zh 0

;pobiera liczbe -8000 0000h ... 7fff ffff  i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

        %ifndef _we_32zh
                extern  _we_32zh
        %endif

	call	_we_32zh
		%endm

;===================================

%imacro		we32b 0

;pobiera liczbe 32-bitowa binarna i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

        %ifndef _we_32b
                extern  _we_32b
        %endif

	call	_we_32b
		%endm

;===================================

%imacro		we32o 0

;pobiera liczbe 32-bitowa osemkowa i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

        %ifndef _we_32o
                extern  _we_32o
        %endif

	call	_we_32o
		%endm


;===================================
;===================================


%imacro		we32e 0

;pobiera liczbe 0-4.294.967.295, zwraca ja w EAX i CF=0
; EAX=ffffffff i CF=1 jesli blad

        %ifndef _we_ld
                extern  _we_ld
        %endif

	call	_we_ld
		%endm

;===================================

%imacro		we32eh 0

;pobiera liczbe heksadecymalna 0-ffffffff zwraca ja w EAX i CF=0
; EAX=ffffffff i CF=1 jesli blad

        %ifndef _we_ldh
                extern  _we_ldh
        %endif

	call	_we_ldh
		%endm

;===================================

%imacro		we32ez 0

;pobiera liczbe ze znakiem -347.483.648...347.483.647 zwraca ja w EAX i CF=0
; EAX=ffffffff i CF=1 jesli blad

        %ifndef _we_ldz
                extern  _we_ldz
        %endif

	call	_we_ldz
		%endm

;===================================

%imacro		we32ezh 0

;pobiera liczbe heksadecymalne ze znakiem  -80000000h...7fffffff, zwraca ja
; w EAX i CF=0
; EAX=ffffffff i CF=1 jesli blad

        %ifndef _we_ldzh
                extern  _we_ldzh
        %endif

	call	_we_ldzh
		%endm

;===================================

%imacro		we32eb 0

;pobiera liczbe binarna 32-bitowa i zwraca ja w EAX, CF=0
; EAX=FFFFFFFF i CF=1 jesli blad

        %ifndef _we_ldb
                extern  _we_ldb
        %endif

	call	_we_ldb
		%endm

;===================================

%imacro		we32eo 0

;pobiera liczbe osemkowa 32-bitowa i zwraca ja w EAX, CF=0
; EAX=FFFFFFFF i CF=1 jesli blad

        %ifndef _we_ldo
                extern  _we_ldo
        %endif

	call	_we_ldo
		%endm


;===================================
;===================================


%imacro		we64 0

;pobiera liczbe 64-bitowa i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

        %ifndef _we_64
                extern  _we_64
        %endif

	call	_we_64
		%endm

;===================================

%imacro		we64h 0

;pobiera liczbe 64-bitowa heksadecymalna i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

        %ifndef _we_64h
                extern  _we_64h
        %endif

	call	_we_64h
		%endm

;===================================

%imacro		we64z 0

;pobiera liczbe 64-bitowa ze znakiem i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

        %ifndef _we_64z
                extern  _we_64z
        %endif

	call	_we_64z
		%endm

;===================================

%imacro		we64zh 0

;pobiera liczbe 64-bitowa heksadecymalna ze znakiem i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

        %ifndef _we_64zh
                extern  _we_64zh
        %endif

	call	_we_64zh
		%endm

;===================================

%imacro		we64b 0

;pobiera liczbe 64-bitowa binarna i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

        %ifndef _we_64b
                extern  _we_64b
        %endif

	call	_we_64b
		%endm

;===================================

%imacro		we64o 0

;pobiera liczbe 64-bitowa osemkowa i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

        %ifndef _we_64o
                extern  _we_64o
        %endif

	call	_we_64o
		%endm

;===================================
;===================================


%imacro		we_c 0

;pobiera cyfre, zwraca jej wartosc (0-9, nie '0'-'9') w AL i CF=0
;aby pobrac '0'-'9', uzyc _we_z
; AL=ff i CF=1 jesli blad

        %ifndef _we_c
                extern  _we_c
        %endif

	call	_we_c
		%endm

;===================================

%imacro		we_z 0

;pobiera znak/bajt, zwraca go w AL

        %ifndef _we_z
                extern  _we_z
        %endif

	call	_we_z
		%endm

;===================================

%imacro		we_ch 0

;pobiera "cyfre" heksadecymalna, zwraca jej wartosc
; (0-15, nie '0'-'9' i 'a'/'A'-'f'/'F')
;w AL i CF=0
; AL=FF i CF=1 jesli blad

        %ifndef _we_ch
                extern  _we_ch
        %endif

	call	_we_ch
		%endm

;===================================

%imacro		we 0

;pobiera lancuch znakow zakonczony Enterem i umieszcza pod EDI
;pod koniec, EDI wskazuje na lancuch znakow ( bez zmian )

        %ifndef _we
                extern  _we
        %endif

	call	_we
		%endm

;===================================

%imacro		we_dl 0

;pobiera lancuch znakow o maksymalnej dlugosci ECX ( mniejszej, jesli
; wcisnieto Enter )
;i umieszcza go pod EDI
;ECX=dlugosc i CF=0, EDI bez zmian
; ECX=FFFFFFFF i CF=1 jesli blad ( przekroczono max. dlugosc )

        %ifndef _we_dl
                extern  _we_dl
        %endif

	call	_we_dl
		%endm

;===================================

%imacro		czysc_klaw 0

; czysci bufor klawiatury pobierajac z niego znaki az trafi na
; Line Feed ( 10 ) lub wystapi blad

        %ifndef _czysc_klaw
                extern  _czysc_klaw
        %endif

	call	_czysc_klaw
		%endm



%endif		; __NASM_WEJ

