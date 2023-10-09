; Zalacznik do modulu operacji na liczbach BCD, skladnia NASM
; 40 procedur

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

%ifndef __NASM_BCD
%define __NASM_BCD


;===================================

%imacro		we8bcd 0

; Pobiera spakowana liczbe BCD i zwraca ja w AL. AL=-1 i CF=1, gdy blad

        %ifndef _bcd_we8
                extern  _bcd_we8
        %endif

	skacz	_bcd_we8
		%endm

;===================================

%imacro		pisz8bcd 0

; Wyswietla spakowana liczbe BCD podana w AL.

        %ifndef _bcd_pisz8
                extern  _bcd_pisz8
        %endif

	skacz	_bcd_pisz8
		%endm

;===================================

%imacro		rbcd_na_sbcd8 0

; Przerabia niespakowana liczbe BCD podana w AL na postac spakowana.
; Wynik zwraca w AL.

        %ifndef _bcd_rbcd_na_sbcd8
                extern  _bcd_rbcd_na_sbcd8
        %endif

	skacz	_bcd_rbcd_na_sbcd8
		%endm

;===================================

%imacro		sbcd_na_rbcd8 0

; Przerabia spakowana liczbe BCD podana w AL na postac niespakowana.
; Wynik zwraca w AL. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_sbcd_na_rbcd8
                extern  _bcd_sbcd_na_rbcd8
        %endif

	skacz	_bcd_sbcd_na_rbcd8
		%endm

;===================================

%imacro		rbcd_na_bin8 0

; Przerabia niespakowana liczbe BCD podana w AL na postac binarna.
; Wynik zwraca w AL.

        %ifndef _bcd_rbcd_na_bin8
                extern  _bcd_rbcd_na_bin8
        %endif

	skacz	_bcd_rbcd_na_bin8
		%endm

;===================================

%imacro		sbcd_na_bin8 0

; Przerabia spakowana liczbe BCD podana w AL na postac binarna.
; Wynik zwraca w AL.

        %ifndef _bcd_sbcd_na_bin8
                extern  _bcd_sbcd_na_bin8
        %endif

	skacz	_bcd_sbcd_na_bin8
		%endm

;===================================

%imacro		bin_na_rbcd8 0

; Przerabia liczbe binarna podana w AL na niespakowana liczbe BCD.
; Wynik zwraca w AL. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_bin_na_rbcd8
                extern  _bcd_bin_na_rbcd8
        %endif

	skacz	_bcd_bin_na_rbcd8
		%endm

;===================================

%imacro		bin_na_sbcd8 0

; Przerabia liczbe binarna podana w AL na spakowana liczbe BCD.
; Wynik zwraca w AL. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_bin_na_sbcd8
                extern  _bcd_bin_na_sbcd8
        %endif

	skacz	_bcd_bin_na_sbcd8
		%endm

;===================================
;===================================

%imacro		we16bcd 0

; Pobiera spakowana liczbe BCD i zwraca ja w AX. AX=-1 i CF=1, gdy blad

        %ifndef _bcd_we16
                extern  _bcd_we16
        %endif

	skacz	_bcd_we16
		%endm

;===================================

%imacro		pisz16bcd 0

; Wyswietla spakowana liczbe BCD podana w AX.

        %ifndef _bcd_pisz16
                extern  _bcd_pisz16
        %endif

	skacz	_bcd_pisz16
		%endm

;===================================

%imacro		rbcd_na_sbcd16 0

; Przerabia niespakowana liczbe BCD podana w AX na postac spakowana.
; Wynik zwraca w AX.

        %ifndef _bcd_rbcd_na_sbcd16
                extern  _bcd_rbcd_na_sbcd16
        %endif

	skacz	_bcd_rbcd_na_sbcd16
		%endm

;===================================

%imacro		sbcd_na_rbcd16 0

; Przerabia spakowana liczbe BCD podana w AX na postac niespakowana.
; Wynik zwraca w AX. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_sbcd_na_rbcd16
                extern  _bcd_sbcd_na_rbcd16
        %endif

	skacz	_bcd_sbcd_na_rbcd16
		%endm

;===================================

%imacro		rbcd_na_bin16 0

; Przerabia niespakowana liczbe BCD podana w AX na postac binarna.
; Wynik zwraca w AX.

        %ifndef _bcd_rbcd_na_bin16
                extern  _bcd_rbcd_na_bin16
        %endif

	skacz	_bcd_rbcd_na_bin16
		%endm

;===================================

%imacro		sbcd_na_bin16 0

; Przerabia spakowana liczbe BCD podana w AX na postac binarna.
; Wynik zwraca w AX.

        %ifndef _bcd_sbcd_na_bin16
                extern  _bcd_sbcd_na_bin16
        %endif

	skacz	_bcd_sbcd_na_bin16
		%endm

;===================================

%imacro		bin_na_rbcd16 0

; Przerabia liczbe binarna podana w AX na niespakowana liczbe BCD.
; Wynik zwraca w AX. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_bin_na_rbcd16
                extern  _bcd_bin_na_rbcd16
        %endif

	skacz	_bcd_bin_na_rbcd16
		%endm

;===================================

%imacro		bin_na_sbcd16 0

; Przerabia liczbe binarna podana w AX na spakowana liczbe BCD.
; Wynik zwraca w AX. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_bin_na_sbcd16
                extern  _bcd_bin_na_sbcd16
        %endif

	skacz	_bcd_bin_na_sbcd16
		%endm

;===================================
;===================================

%imacro		we32bcd 0

; Pobiera spakowana liczbe BCD i zwraca ja w DX:AX. DX:AX=-1 i CF=1, gdy blad

        %ifndef _bcd_we32
                extern  _bcd_we32
        %endif

	skacz	_bcd_we32
		%endm

;===================================

%imacro		pisz32bcd 0

; Wyswietla spakowana liczbe BCD podana w DX:AX.

        %ifndef _bcd_pisz32
                extern  _bcd_pisz32
        %endif

	skacz	_bcd_pisz32
		%endm

;===================================

%imacro		rbcd_na_sbcd32 0

; Przerabia niespakowana liczbe BCD podana w DX:AX na postac spakowana.
; Wynik zwraca w DX:AX.

        %ifndef _bcd_rbcd_na_sbcd32
                extern  _bcd_rbcd_na_sbcd32
        %endif

	skacz	_bcd_rbcd_na_sbcd32
		%endm

;===================================

%imacro		sbcd_na_rbcd32 0

; Przerabia spakowana liczbe BCD podana w DX:AX na postac niespakowana.
; Wynik zwraca w DX:AX. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_sbcd_na_rbcd32
                extern  _bcd_sbcd_na_rbcd32
        %endif

	skacz	_bcd_sbcd_na_rbcd32
		%endm

;===================================

%imacro		rbcd_na_bin32 0

; Przerabia niespakowana liczbe BCD podana w DX:AX na postac binarna.
; Wynik zwraca w DX:AX.

        %ifndef _bcd_rbcd_na_bin32
                extern  _bcd_rbcd_na_bin32
        %endif

	skacz	_bcd_rbcd_na_bin32
		%endm

;===================================

%imacro		sbcd_na_bin32 0

; Przerabia spakowana liczbe BCD podana w DX:AX na postac binarna.
; Wynik zwraca w DX:AX.

        %ifndef _bcd_sbcd_na_bin32
                extern  _bcd_sbcd_na_bin32
        %endif

	skacz	_bcd_sbcd_na_bin32
		%endm

;===================================

%imacro		bin_na_rbcd32 0

; Przerabia liczbe binarna podana w DX:AX na niespakowana liczbe BCD.
; Wynik zwraca w DX:AX. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_bin_na_rbcd32
                extern  _bcd_bin_na_rbcd32
        %endif

	skacz	_bcd_bin_na_rbcd32
		%endm

;===================================

%imacro		bin_na_sbcd32 0

; Przerabia liczbe binarna podana w DX:AX na spakowana liczbe BCD.
; Wynik zwraca w DX:AX. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_bin_na_sbcd32
                extern  _bcd_bin_na_sbcd32
        %endif

	skacz	_bcd_bin_na_sbcd32
		%endm

;===================================
;===================================

%imacro		we32ebcd 0

; Pobiera spakowana liczbe BCD i zwraca ja w EAX. EAX=-1 i CF=1, gdy blad

        %ifndef _bcd_we32e
                extern  _bcd_we32e
        %endif

	skacz	_bcd_we32e
		%endm

;===================================

%imacro		pisz32ebcd 0

; Wyswietla spakowana liczbe BCD podana w EAX.

        %ifndef _bcd_pisz32e
                extern  _bcd_pisz32e
        %endif

	skacz	_bcd_pisz32e
		%endm

;===================================

%imacro		rbcd_na_sbcd32e 0

; Przerabia niespakowana liczbe BCD podana w EAX na postac spakowana.
; Wynik zwraca w EAX.

        %ifndef _bcd_rbcd_na_sbcd32e
                extern  _bcd_rbcd_na_sbcd32e
        %endif

	skacz	_bcd_rbcd_na_sbcd32e
		%endm

;===================================

%imacro		sbcd_na_rbcd32e 0

; Przerabia spakowana liczbe BCD podana w EAX na postac niespakowana.
; Wynik zwraca w EAX. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_sbcd_na_rbcd32e
                extern  _bcd_sbcd_na_rbcd32e
        %endif

	skacz	_bcd_sbcd_na_rbcd32e
		%endm

;===================================

%imacro		rbcd_na_bin32e 0

; Przerabia niespakowana liczbe BCD podana w EAX na postac binarna.
; Wynik zwraca w EAX.

        %ifndef _bcd_rbcd_na_bin32e
                extern  _bcd_rbcd_na_bin32e
        %endif

	skacz	_bcd_rbcd_na_bin32e
		%endm

;===================================

%imacro		sbcd_na_bin32e 0

; Przerabia spakowana liczbe BCD podana w EAX na postac binarna.
; Wynik zwraca w EAX.

        %ifndef _bcd_sbcd_na_bin32e
                extern  _bcd_sbcd_na_bin32e
        %endif

	skacz	_bcd_sbcd_na_bin32e
		%endm

;===================================

%imacro		bin_na_rbcd32e 0

; Przerabia liczbe binarna podana w EAX na niespakowana liczbe BCD.
; Wynik zwraca w EAX. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_bin_na_rbcd32e
                extern  _bcd_bin_na_rbcd32e
        %endif

	skacz	_bcd_bin_na_rbcd32e
		%endm

;===================================

%imacro		bin_na_sbcd32e 0

; Przerabia liczbe binarna podana w EAX na spakowana liczbe BCD.
; Wynik zwraca w EAX. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_bin_na_sbcd32e
                extern  _bcd_bin_na_sbcd32e
        %endif

	skacz	_bcd_bin_na_sbcd32e
		%endm

;===================================
;===================================

%imacro		we64bcd 0

; Pobiera spakowana liczbe BCD i zwraca ja w EDX:EAX.
; EDX:EAX=-1 i CF=1, gdy blad

        %ifndef _bcd_we64
                extern  _bcd_we64
        %endif

	skacz	_bcd_we64
		%endm

;===================================

%imacro		pisz64bcd 0

; Wyswietla spakowana liczbe BCD podana w EDX:EAX.

        %ifndef _bcd_pisz64
                extern  _bcd_pisz64
        %endif

	skacz	_bcd_pisz64
		%endm

;===================================

%imacro		rbcd_na_sbcd64 0

; Przerabia niespakowana liczbe BCD podana w EDX:EAX na postac spakowana.
; Wynik zwraca w EDX:EAX.

        %ifndef _bcd_rbcd_na_sbcd64
                extern  _bcd_rbcd_na_sbcd64
        %endif

	skacz	_bcd_rbcd_na_sbcd64
		%endm

;===================================

%imacro		sbcd_na_rbcd64 0

; Przerabia spakowana liczbe BCD podana w EDX:EAX na postac niespakowana.
; Wynik zwraca w EDX:EAX. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_sbcd_na_rbcd64
                extern  _bcd_sbcd_na_rbcd64
        %endif

	skacz	_bcd_sbcd_na_rbcd64
		%endm

;===================================

%imacro		rbcd_na_bin64 0

; Przerabia niespakowana liczbe BCD podana w EDX:EAX na postac binarna.
; Wynik zwraca w EDX:EAX.

        %ifndef _bcd_rbcd_na_bin64
                extern  _bcd_rbcd_na_bin64
        %endif

	skacz	_bcd_rbcd_na_bin64
		%endm

;===================================

%imacro		sbcd_na_bin64 0

; Przerabia spakowana liczbe BCD podana w EDX:EAX na postac binarna.
; Wynik zwraca w EDX:EAX.

        %ifndef _bcd_sbcd_na_bin64
                extern  _bcd_sbcd_na_bin64
        %endif

	skacz	_bcd_sbcd_na_bin64
		%endm

;===================================

%imacro		bin_na_rbcd64 0

; Przerabia liczbe binarna podana w EDX:EAX na niespakowana liczbe BCD.
; Wynik zwraca w EDX:EAX. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_bin_na_rbcd64
                extern  _bcd_bin_na_rbcd64
        %endif

	skacz	_bcd_bin_na_rbcd64
		%endm

;===================================

%imacro		bin_na_sbcd64 0

; Przerabia liczbe binarna podana w EDX:EAX na spakowana liczbe BCD.
; Wynik zwraca w EDX:EAX. CF=1 w przypadku przepelnienia.

        %ifndef _bcd_bin_na_sbcd64
                extern  _bcd_bin_na_sbcd64
        %endif

	skacz	_bcd_bin_na_sbcd64
		%endm

;===================================
;===================================


%endif		; __NASM_BCD
