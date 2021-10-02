; Zalacznik do modulu generatorow liczb pseudo-losowych
; 15 procedur

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


extrn	_los_8:far
extrn	_los_8g:far
extrn	_los_8zg:far

extrn	_los_16:far
extrn	_los_16g:far
extrn	_los_16zg:far

extrn	_los_32:far
extrn	_los_32g:far
extrn	_los_32zg:far

extrn	_los_32e:far
extrn	_los_32eg:far
extrn	_los_32ezg:far

extrn	_los_64:far
extrn	_los_64g:far
extrn	_los_64zg:far




skacz		macro	nazwa
	call	far ptr nazwa
		endm

;===================================


losuj8		macro

; zwraca liczbe pseudo-losowa 0...255 w AL

	skacz	_los_8
		endm

;===================================

losuj8g		macro

; zwraca liczbe pseudo-losowa z przedzialu BL...CL ( granice bez znaku ) w AL

	skacz	_los_8g
		endm

;===================================

losuj8zg	macro

; zwraca liczbe pseudo-losowa z przedzialu BL...CL ( granice ze znakiem )w AL

	skacz	_los_8zg
		endm



;===================================
;===================================




losuj16		macro

; zwraca liczbe pseudo-losowa 0-65535 ( lub -32768...32767 ) w AX

	skacz	_los_16
		endm

;===================================

losuj16g	macro

; zwraca liczbe pseudo-losowa z przedzialu BX...CX ( granice bez znaku ) w AX

	skacz	_los_16g
		endm

;===================================

losuj16zg	macro

; zwraca liczbe pseudo-losowa z przedzialu BX...CX ( granice ze znakiem ) w AX

	skacz	_los_16zg
		endm



;===================================
;===================================




losuj32		macro

; zwraca liczbe pseudo-losowa 32-bit w DX:AX

	skacz	_los_32
		endm

;===================================

losuj32g	macro

; zwraca liczbe pseudo-losowa z przedzialu BX:SI ... CX:DI
; ( granice bez znaku ) w DX:AX

	skacz	_los_32g
		endm

;===================================

losuj32zg	macro

; zwraca liczbe pseudo-losowa z przedzialu BX:SI ... CX:DI
; ( granice ze znakiem ) w DX:AX

	skacz	_los_32zg
		endm



;===================================
;===================================



losuj32e	macro

; zwraca liczbe pseudo-losowa 32-bit w EAX

	skacz	_los_32e
		endm

;===================================

losuj32eg	macro

; zwraca liczbe pseudo-losowa z przedzialu EBX...ECX
; ( granice bez znaku ) w EAX

	skacz	_los_32eg
		endm

;===================================

losuj32ezg	macro

; zwraca liczbe pseudo-losowa z przedzialu EBX...ECX
; ( granice ze znakiem ) w EAX

	skacz	_los_32ezg
		endm



;===================================
;===================================




losuj64		macro

; zwraca liczbe pseudo-losowa 64-bit w EDX:EAX

	skacz	_los_64
		endm

;===================================

losuj64g	macro

; zwraca liczbe pseudo-losowa z przedzialu EBX:ESI...ECX:EDI
; ( granice bez znaku ) w EDX:EAX

	skacz	_los_64g
		endm

;===================================

losuj64zg	macro

; zwraca liczbe pseudo-losowa z przedzialu EBX:ESI...ECX:EDI
; ( granice ze znakiem ) w EDX:EAX

	skacz	_los_64zg
		endm

