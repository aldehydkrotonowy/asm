; Zalacznik do modulu pobierajacego dane od uzytkownika
; 30 procedur

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


extrn	_we_l:far
extrn	_we_lh:far
extrn	_we_lz:far
extrn	_we_lzh:far
extrn	_we_lb:far
extrn	_we_lo:far

extrn	_we_8:far
extrn	_we_8h:far
extrn	_we_8z:far
extrn	_we_8zh:far
extrn	_we_8b:far
extrn	_we_8o:far

extrn	_we_32:far
extrn	_we_32h:far
extrn	_we_32z:far
extrn	_we_32zh:far
extrn	_we_32b:far
extrn	_we_32o:far

extrn	_we_ld:far
extrn	_we_ldh:far
extrn	_we_ldz:far
extrn	_we_ldzh:far
extrn	_we_ldb:far
extrn	_we_ldo:far

extrn	_we_64:far
extrn	_we_64h:far
extrn	_we_64z:far
extrn	_we_64zh:far
extrn	_we_64b:far
extrn	_we_64o:far

extrn	_we_z:far
extrn	_we_c:far
extrn	_we_ch:far

extrn	_we:far
extrn	_we_dl:far


skacz		macro	nazwa
	call	far ptr nazwa
		endm

;===================================

we16		macro

;pobiera liczbe 0-65535, zwraca ja w AX i CF=0
; CF=1 i AX=ffff jesli blad

	skacz	_we_l
		endm

;===================================

we16h		macro

;pobiera liczbe heksadecymalna 0-ffff, zwraca ja w AX i CF=0
; AX=ffff i CF=1, jesli blad

	skacz	_we_lh
		endm

;===================================

we16z		macro

;pobiera liczbe ze znakiem  -32768...32767, zwraca ja w AX i CF=0
; AX=ffff i CF=1, jesli blad

	skacz	_we_lz
		endm

;===================================

we16zh		macro

;pobiera liczbe heksadecymalna ze znakiem  -8000h...7fff, zwraca ja
; w AX i CF=0
; AX=ffff i CF=1 jesli blad

	skacz	_we_lzh
		endm

;===================================

we16b		macro

;pobiera liczbe binarna 0-1111 1111 1111 1111  i zwraca ja w AX, CF=0
; AX=FFFF i CF=1 jesli blad

	skacz	_we_lb
		endm

;===================================

we16o		macro

;pobiera liczbe osemkowa  i zwraca ja w AX, CF=0
; AX=FFFF i CF=1 jesli blad

	skacz	_we_lo
		endm


;===================================
;===================================


we8		macro

;pobiera liczbe 0...255 i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

	skacz	_we_8
		endm

;===================================

we8h		macro

;pobiera liczbe 0...FF i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

	skacz	_we_8h
		endm

;===================================

we8z		macro

;pobiera liczbe -128...127 i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

	skacz	_we_8z
		endm

;===================================

we8zh		macro

;pobiera liczbe -80h...7f i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

	skacz	_we_8zh
		endm

;===================================

we8b		macro

;pobiera liczbe 0000 0000...1111 1111 i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

	skacz	_we_8b
		endm

;===================================

we8o		macro

;pobiera liczbe osemkowa i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

	skacz	_we_8o
		endm


;===================================
;===================================


we32		macro

;pobiera liczbe 0-4.294.967.296 i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

	skacz	_we_32
		endm

;===================================

we32h		macro

;pobiera liczbe 0-FFFF FFFF i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

	skacz	_we_32h
		endm

;===================================

we32z		macro

;pobiera liczbe -347.483.648...347.483.647  i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

	skacz	_we_32z
		endm

;===================================

we32zh		macro

;pobiera liczbe -8000 0000h ... 7fff ffff  i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

	skacz	_we_32zh
		endm

;===================================

we32b		macro

;pobiera liczbe 32-bitowa binarna i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

	skacz	_we_32b
		endm

;===================================

we32o		macro

;pobiera liczbe 32-bitowa osemkowa i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

	skacz	_we_32o
		endm


;===================================
;===================================


we32e		macro

;pobiera liczbe 0-4.294.967.296, zwraca ja w EAX i CF=0
; EAX=ffffffff i CF=1 jesli blad

	skacz	_we_ld
		endm

;===================================

we32eh		macro

;pobiera liczbe heksadecymalna 0-ffffffff zwraca ja w EAX i CF=0
; EAX=ffffffff i CF=1 jesli blad

	skacz	_we_ldh
		endm

;===================================

we32ez		macro

;pobiera liczbe ze znakiem -347.483.648...347.483.647 zwraca ja
; w EAX i CF=0
; EAX=ffffffff i CF=1 jesli blad

	skacz	_we_ldz
		endm

;===================================

we32ezh		macro

;pobiera liczbe heksadecymalna ze znakiem  -80000000h...7fffffff, zwraca ja
; w EAX i CF=0
; EAX=ffffffff i CF=1 jesli blad

	skacz	_we_ldzh
		endm

;===================================

we32eb		macro

;pobiera liczbe binarna 32-bitowa i zwraca ja w EAX, CF=0
; EAX=FFFFFFFF i CF=1 jesli blad

	skacz	_we_ldb
		endm

;===================================

we32eo		macro

;pobiera liczbe osemkowa 32-bitowa i zwraca ja w EAX, CF=0
; EAX=FFFFFFFF i CF=1 jesli blad

	skacz	_we_ldo
		endm


;===================================
;===================================


we64		macro

;pobiera liczbe 64-bitowa i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

	skacz	_we_64
		endm

;===================================

we64h		macro

;pobiera liczbe 64-bitowa heksadecymalna i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

	skacz	_we_64h
		endm

;===================================

we64z		macro

;pobiera liczbe 64-bitowa ze znakiem i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

	skacz	_we_64z
		endm

;===================================

we64zh		macro

;pobiera liczbe 64-bitowa heksadecymalna ze znakiem i umieszcza
; w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

	skacz	_we_64zh
		endm

;===================================

we64b		macro

;pobiera liczbe 64-bitowa binarna i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

	skacz	_we_64b
		endm

;===================================

we64o		macro

;pobiera liczbe 64-bitowa osemkowa i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

	skacz	_we_64o
		endm


;===================================
;===================================


we_c		macro

;pobiera cyfre, zwraca jej wartosc (0-9, nie '0'-'9') w AL i CF=0
;aby pobrac '0'-'9', uzyc _we_z
; AL=ff i CF=1 jesli blad

	skacz	_we_c
		endm

;===================================

we_z		macro

;pobiera znak/bajt, zwraca go w AL

	skacz	_we_z
		endm

;===================================

we_ch		macro

;pobiera "cyfre" heksadecymalna, zwraca ja (0-15, nie '0'-'9' i 'A'-'F')
;w AL i CF=0
; AL=ff i CF=1 jesli blad

	skacz	_we_ch
		endm

;===================================

we		macro

;pobiera lancuch znakow zakonczony na CR ( Enter ) i umieszcza pod ES:DI
;pod koniec, ES:DI wskazuje na lancuch znakow ( bez zmian )
;lancuch konczy sie bajtem zerowym

	skacz	_we
		endm

;===================================

we_dl		macro

;pobiera lancuch znakow o maksymalnej dlugosci CX ( mniejszej, jesli
; wcisnieto Enter ) i umieszcza go pod ES:DI
;CX=dlugosc i CF=0, ES:DI bez zmian
; CX=ffff i CF=1 jesli blad ( przekroczono max. dlugosc )

	skacz	_we_dl
		endm

