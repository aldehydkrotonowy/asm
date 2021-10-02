; Zalacznik do modulu generatorow liczb pseudo-losowych, skladnia NASM

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

%ifndef __NASM_LOSOWE
%define __NASM_LOSOWE



;===================================

%imacro		losuj8 0

; zwraca liczbe pseudo-losowa 0...255 w AL

	%ifndef	_los_8
		extern	_los_8
	%endif

	skacz	_los_8
		%endm

;===================================

%imacro		losuj8g 0

; zwraca liczbe pseudo-losowa z przedzialu BL...CL ( granice bez znaku ) w AL

	%ifndef	_los_8g
		extern	_los_8g
	%endif

	skacz	_los_8g
		%endm

;===================================

%imacro		losuj8zg 0

; zwraca liczbe pseudo-losowa z przedzialu BL...CL ( granice ze znakiem ) w AL

	%ifndef	_los_8zg
		extern	_los_8zg
	%endif

	skacz	_los_8zg
		%endm

;===================================
;===================================


%imacro		losuj16 0

; zwraca liczbe pseudo-losowa 0-65535 ( lub -32768...32767 ) w AX

	%ifndef	_los_16
		extern	_los_16
	%endif

	skacz	_los_16
		%endm

;===================================

%imacro		losuj16g 0

; zwraca liczbe pseudo-losowa z przedzialu BX...CX ( granice bez znaku ) w AX

	%ifndef	_los_16g
		extern	_los_16g
	%endif

	skacz	_los_16g
		%endm

;===================================

%imacro		losuj16zg 0

; zwraca liczbe pseudo-losowa z przedzialu BX...CX ( granice ze znakiem ) w AX

	%ifndef	_los_16zg
		extern	_los_16zg
	%endif

	skacz	_los_16zg
		%endm

;===================================
;===================================


%imacro		losuj32 0

; zwraca liczbe pseudo-losowa 32-bit w DX:AX

	%ifndef	_los_32
		extern	_los_32
	%endif

	skacz	_los_32
		%endm

;===================================

%imacro		losuj32g 0

; zwraca liczbe pseudo-losowa z przedzialu BX:SI ... CX:DI
; ( granice bez znaku ) w DX:AX

	%ifndef	_los_32g
		extern	_los_32g
	%endif

	skacz	_los_32g
		%endm

;===================================

%imacro		losuj32zg 0

; zwraca liczbe pseudo-losowa z przedzialu BX:SI ... CX:DI
; ( granice ze znakiem ) w DX:AX

	%ifndef	_los_32zg
		extern	_los_32zg
	%endif

	skacz	_los_32zg
		%endm

;===================================
;===================================

%imacro		losuj32e 0

; zwraca liczbe pseudo-losowa 32-bit w EAX

	%ifndef	_los_32e
		extern	_los_32e
	%endif

	skacz	_los_32e
		%endm

;===================================

%imacro		losuj32eg 0

; zwraca liczbe pseudo-losowa z przedzialu EBX...ECX
; ( granice bez znaku ) w EAX

	%ifndef	_los_32eg
		extern	_los_32eg
	%endif

	skacz	_los_32eg
		%endm

;===================================

%imacro		losuj32ezg 0

; zwraca liczbe pseudo-losowa z przedzialu EBX...ECX
; ( granice ze znakiem ) w EAX

	%ifndef	_los_32ezg
		extern	_los_32ezg
	%endif

	skacz	_los_32ezg
		%endm

;===================================
;===================================


%imacro		losuj64 0

; zwraca liczbe pseudo-losowa 64-bit w EDX:EAX

	%ifndef	_los_64
		extern	_los_64
	%endif

	skacz	_los_64
		%endm

;===================================

%imacro		losuj64g 0

; zwraca liczbe pseudo-losowa z przedzialu EBX:ESI...ECX:EDI
; ( granice bez znaku ) w EDX:EAX

	%ifndef	_los_64g
		extern	_los_64g
	%endif

	skacz	_los_64g
		%endm

;===================================

%imacro		losuj64zg 0

; zwraca liczbe pseudo-losowa z przedzialu EBX:ESI...ECX:EDI
; ( granice ze znakiem ) w EDX:EAX

	%ifndef	_los_64zg
		extern	_los_64zg
	%endif

	skacz	_los_64zg
		%endm


%endif		; __NASM_LOSOWE

