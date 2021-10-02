; Zalacznik do modulu generatorow liczb pseudo-losowych, skladnia FASM

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

if ~defined __FASM_LOSOWE | defined @f
__FASM_LOSOWE		= 1
@@:



;===================================


macro		losuj8
 {

; zwraca liczbe pseudo-losowa 0...255 w AL

	if ~ defined _los_8 | defined @f
		extrn	_los_8:dword
		@@:
	end if
	skacz	_los_8
 }


;===================================

macro		losuj8g
 {

; zwraca liczbe pseudo-losowa z przedzialu BL...CL ( granice bez znaku ) w AL

	if ~ defined _los_8g | defined @f
		extrn	_los_8g:dword
		@@:
	end if
	skacz	_los_8g
 }


;===================================

macro		losuj8zg
 {

; zwraca liczbe pseudo-losowa z przedzialu BL...CL ( granice ze znakiem ) w AL

	if ~ defined _los_8zg | defined @f
		extrn	_los_8zg:dword
		@@:
	end if
	skacz	_los_8zg
 }


;===================================
;===================================


macro		losuj16
 {

; zwraca liczbe pseudo-losowa 0-65535 ( lub -32768...32767 ) w AX

	if ~ defined _los_16 | defined @f
		extrn	_los_16:dword
		@@:
	end if
	skacz	_los_16
 }


;===================================

macro		losuj16g
 {

; zwraca liczbe pseudo-losowa z przedzialu BX...CX ( granice bez znaku ) w AX

	if ~ defined _los_16g | defined @f
		extrn	_los_16g:dword
		@@:
	end if
	skacz	_los_16g
 }


;===================================

macro		losuj16zg
 {

; zwraca liczbe pseudo-losowa z przedzialu BX...CX ( granice ze znakiem ) w AX

	if ~ defined _los_16zg | defined @f
		extrn	_los_16zg:dword
		@@:
	end if
	skacz	_los_16zg
 }


;===================================
;===================================


macro		losuj32
 {

; zwraca liczbe pseudo-losowa 32-bit w DX:AX

	if ~ defined _los_32 | defined @f
		extrn	_los_32:dword
		@@:
	end if
	skacz	_los_32
 }


;===================================

macro		losuj32g
 {

; zwraca liczbe pseudo-losowa z przedzialu BX:SI ... CX:DI
; ( granice bez znaku ) w DX:AX

	if ~ defined _los_32g | defined @f
		extrn	_los_32g:dword
		@@:
	end if
	skacz	_los_32g
 }


;===================================

macro		losuj32zg
 {

; zwraca liczbe pseudo-losowa z przedzialu BX:SI ... CX:DI
; ( granice ze znakiem ) w DX:AX

	if ~ defined _los_32zg | defined @f
		extrn	_los_32zg:dword
		@@:
	end if
	skacz	_los_32zg
 }


;===================================
;===================================

macro		losuj32e
 {

; zwraca liczbe pseudo-losowa 32-bit w EAX

	if ~ defined _los_32e | defined @f
		extrn	_los_32e:dword
		@@:
	end if
	skacz	_los_32e
 }


;===================================

macro		losuj32eg
 {

; zwraca liczbe pseudo-losowa z przedzialu EBX...ECX
; ( granice bez znaku ) w EAX

	if ~ defined _los_32eg | defined @f
		extrn	_los_32eg:dword
		@@:
	end if
	skacz	_los_32eg
 }


;===================================

macro		losuj32ezg
 {

; zwraca liczbe pseudo-losowa z przedzialu EBX...ECX
; ( granice ze znakiem ) w EAX

	if ~ defined _los_32ezg | defined @f
		extrn	_los_32ezg:dword
		@@:
	end if
	skacz	_los_32ezg
 }


;===================================
;===================================


macro		losuj64
 {

; zwraca liczbe pseudo-losowa 64-bit w EDX:EAX

	if ~ defined _los_64 | defined @f
		extrn	_los_64:dword
		@@:
	end if
	skacz	_los_64
 }


;===================================

macro		losuj64g
 {

; zwraca liczbe pseudo-losowa z przedzialu EBX:ESI...ECX:EDI
; ( granice bez znaku ) w EDX:EAX

	if ~ defined _los_64g | defined @f
		extrn	_los_64g:dword
		@@:
	end if
	skacz	_los_64g
 }


;===================================

macro		losuj64zg
 {

; zwraca liczbe pseudo-losowa z przedzialu EBX:ESI...ECX:EDI
; ( granice ze znakiem ) w EDX:EAX

	if ~ defined _los_64zg | defined @f
		extrn	_los_64zg:dword
		@@:
	end if
	skacz	_los_64zg
 }



end if		; __FASM_LOSOWE

