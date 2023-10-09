; Zalacznik do modulu pobierajacego dane od uzytkownika, skladnia FASM

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

if ~defined __FASM_WEJ | defined @f
__FASM_WEJ	= 1
@@:




;===================================

macro		we16
 {

;pobiera liczbe 0-65535, zwraca ja w AX i CF=0
; CF=1 i AX=ffff jesli blad

	if ~ defined _we_l | defined @f
		extrn	_we_l:dword
		@@:
	end if
	skacz	_we_l
 }


;===================================

macro		we16h
 {

;pobiera liczbe heksadecymalna 0-ffff, zwraca ja w AX i CF=0
; AX=ffff i CF=1, jesli blad

	if ~ defined _we_lh | defined @f
		extrn	_we_lh:dword
		@@:
	end if
	skacz	_we_lh
 }


;===================================

macro		we16z
 {

;pobiera liczbe ze znakiem  -32768...32767, zwraca ja w AX i CF=0
; AX=ffff i CF=1, jesli blad

	if ~ defined _we_lz | defined @f
		extrn	_we_lz:dword
		@@:
	end if
	skacz	_we_lz
 }


;===================================

macro		we16zh
 {

;pobiera liczbe heksadecymalna ze znakiem  -8000h...7fff, zwraca ja
; w AX i CF=0
; AX=ffff i CF=1 jesli blad

	if ~ defined _we_lzh | defined @f
		extrn	_we_lzh:dword
		@@:
	end if
	skacz	_we_lzh
 }


;===================================

macro		we16b
 {

;pobiera liczbe binarna 0-1111 1111 1111 1111  i zwraca ja w AX, CF=0
; AX=FFFF i CF=1 jesli blad

	if ~ defined _we_lb | defined @f
		extrn	_we_lb:dword
		@@:
	end if
	skacz	_we_lb
 }

;===================================

macro		we16o
 {

;pobiera liczbe osemkowa i zwraca ja w AX, CF=0
; AX=FFFF i CF=1 jesli blad

	if ~ defined _we_lo | defined @f
		extrn	_we_lo:dword
		@@:
	end if
	skacz	_we_lo
 }

;===================================
;===================================


macro		we8
 {

;pobiera liczbe 0...255 i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

	if ~ defined _we_8 | defined @f
		extrn	_we_8:dword
		@@:
	end if
	skacz	_we_8
 }


;===================================

macro		we8h
 {

;pobiera liczbe 0...FF i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

	if ~ defined _we_8h | defined @f
		extrn	_we_8h:dword
		@@:
	end if
	skacz	_we_8h
 }


;===================================

macro		we8z
 {

;pobiera liczbe -128...127 i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

	if ~ defined _we_8z | defined @f
		extrn	_we_8z:dword
		@@:
	end if
	skacz	_we_8z
 }


;===================================

macro		we8zh
 {

;pobiera liczbe -80h...7f i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

	if ~ defined _we_8zh | defined @f
		extrn	_we_8zh:dword
		@@:
	end if
	skacz	_we_8zh
 }


;===================================

macro		we8b
 {

;pobiera liczbe 0000 0000...1111 1111 i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

	if ~ defined _we_8b | defined @f
		extrn	_we_8b:dword
		@@:
	end if
	skacz	_we_8b
 }

;===================================

macro		we8o
 {

;pobiera liczbe osemkowa i zwraca ja w AL i CF=0
; AL=FF i CF=1 jesli blad

	if ~ defined _we_8o | defined @f
		extrn	_we_8o:dword
		@@:
	end if
	skacz	_we_8o
 }

;===================================
;===================================


macro		we32
 {

;pobiera liczbe 0-4.294.967.296 i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

	if ~ defined _we_32 | defined @f
		extrn	_we_32:dword
		@@:
	end if
	skacz	_we_32
 }


;===================================

macro		we32h
 {

;pobiera liczbe 0-FFFF FFFF i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

	if ~ defined _we_32h | defined @f
		extrn	_we_32h:dword
		@@:
	end if
	skacz	_we_32h
 }


;===================================

macro		we32z
 {

;pobiera liczbe -347.483.648...347.483.647  i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

	if ~ defined _we_32z | defined @f
		extrn	_we_32z:dword
		@@:
	end if
	skacz	_we_32z
 }


;===================================

macro		we32zh
 {

;pobiera liczbe -8000 0000h ... 7fff ffff  i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

	if ~ defined _we_32zh | defined @f
		extrn	_we_32zh:dword
		@@:
	end if
	skacz	_we_32zh
 }


;===================================

macro		we32b
 {

;pobiera liczbe 32-bitowa binarna i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

	if ~ defined _we_32b | defined @f
		extrn	_we_32b:dword
		@@:
	end if
	skacz	_we_32b
 }

;===================================

macro		we32o
 {

;pobiera liczbe 32-bitowa osemkowa i umieszcza w DX:AX, CF=0
; DX:AX=FFFF:FFFF i CF=1 jesli blad

	if ~ defined _we_32o | defined @f
		extrn	_we_32o:dword
		@@:
	end if
	skacz	_we_32o
 }

;===================================
;===================================


macro		we32e
 {

;pobiera liczbe 0-4.294.967.296, zwraca ja w EAX i CF=0
; EAX=ffffffff i CF=1 jesli blad

	if ~ defined _we_ld | defined @f
		extrn	_we_ld:dword
		@@:
	end if
	skacz	_we_ld
 }


;===================================

macro		we32eh
 {

;pobiera liczbe heksadecymalna 0-ffffffff zwraca ja w EAX i CF=0
; EAX=ffffffff i CF=1 jesli blad

	if ~ defined _we_ldh | defined @f
		extrn	_we_ldh:dword
		@@:
	end if
	skacz	_we_ldh
 }


;===================================

macro		we32ez
 {

;pobiera liczbe ze znakiem -347.483.648...347.483.647 zwraca ja
; w EAX i CF=0
; EAX=ffffffff i CF=1 jesli blad

	if ~ defined _we_ldz | defined @f
		extrn	_we_ldz:dword
		@@:
	end if
	skacz	_we_ldz
 }


;===================================

macro		we32ezh
 {

;pobiera liczbe heksadecymalna ze znakiem  -80000000h...7fffffff, zwraca ja
; w EAX i CF=0
; EAX=ffffffff i CF=1 jesli blad

	if ~ defined _we_ldzh | defined @f
		extrn	_we_ldzh:dword
		@@:
	end if
	skacz	_we_ldzh
 }

;===================================

macro		we32eb
 {

;pobiera liczbe binarna 32-bitowa i zwraca ja w EAX, CF=0
; EAX=FFFFFFFF i CF=1 jesli blad

	if ~ defined _we_ldb | defined @f
		extrn	_we_ldb:dword
		@@:
	end if
	skacz	_we_ldb
 }

;===================================

macro		we32eo
 {

;pobiera liczbe osemkowa 32-bitowa i zwraca ja w EAX, CF=0
; EAX=FFFFFFFF i CF=1 jesli blad

	if ~ defined _we_ldo | defined @f
		extrn	_we_ldo:dword
		@@:
	end if
	skacz	_we_ldo
 }

;===================================
;===================================


macro		we64
 {

;pobiera liczbe 64-bitowa i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

	if ~ defined _we_64 | defined @f
		extrn	_we_64:dword
		@@:
	end if
	skacz	_we_64
 }


;===================================

macro		we64h
 {

;pobiera liczbe 64-bitowa heksadecymalna i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

	if ~ defined _we_64h | defined @f
		extrn	_we_64h:dword
		@@:
	end if
	skacz	_we_64h
 }


;===================================

macro		we64z
 {

;pobiera liczbe 64-bitowa ze znakiem i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

	if ~ defined _we_64z | defined @f
		extrn	_we_64z:dword
		@@:
	end if
	skacz	_we_64z
 }


;===================================

macro		we64zh
 {

;pobiera liczbe 64-bitowa heksadecymalna ze znakiem i umieszcza
; w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

	if ~ defined _we_64zh | defined @f
		extrn	_we_64zh:dword
		@@:
	end if
	skacz	_we_64zh
 }


;===================================

macro		we64b
 {

;pobiera liczbe 64-bitowa binarna i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

	if ~ defined _we_64b | defined @f
		extrn	_we_64b:dword
		@@:
	end if
	skacz	_we_64b
 }

;===================================

macro		we64o
 {

;pobiera liczbe 64-bitowa osemkowa i umieszcza w EDX:EAX, CF=0
;EDX:EAX=FFFFFFFF:FFFFFFFF i CF=1 jesli blad

	if ~ defined _we_64o | defined @f
		extrn	_we_64o:dword
		@@:
	end if
	skacz	_we_64o
 }

;===================================
;===================================


macro		we_c
 {

;pobiera cyfre, zwraca jej wartosc (0-9, nie '0'-'9') w AL i CF=0
;aby pobrac '0'-'9', uzyc _we_z
; AL=ff i CF=1 jesli blad

	if ~ defined _we_c | defined @f
		extrn	_we_c:dword
		@@:
	end if
	skacz	_we_c
 }


;===================================

macro		we_z
 {

;pobiera znak/bajt, zwraca go w AL

	if ~ defined _we_z | defined @f
		extrn	_we_z:dword
		@@:
	end if
	skacz	_we_z
 }


;===================================

macro		we_ch
 {

;pobiera "cyfre" heksadecymalna, zwraca ja (0-15, nie '0'-'9' i 'A'-'F')
;w AL i CF=0
; AL=ff i CF=1 jesli blad

	if ~ defined _we_ch | defined @f
		extrn	_we_ch:dword
		@@:
	end if
	skacz	_we_ch
 }


;===================================

macro		we
 {

;pobiera lancuch znakow zakonczony na CR i umieszcza pod ES:DI
;pod koniec, ES:DI wskazuje na lancuch znakow ( bez zmian )

	if ~ defined _we | defined @f
		extrn	_we:dword
		@@:
	end if
	skacz	_we
 }


;===================================

macro		we_dl
 {

;pobiera lancuch znakow o maksymalnej dlugosci CX ( mniejszej, jesli
; wcisnieto Enter ) i umieszcza go pod ES:DI
;CX=dlugosc i CF=0, ES:DI bez zmian
; CX=ffff i CF=1 jesli blad ( przekroczono max. dlugosc )

	if ~ defined _we_dl | defined @f
		extrn	_we_dl:dword
		@@:
	end if
	skacz	_we_dl
 }



end if		; __FASM_WEJ

