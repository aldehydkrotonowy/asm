; Zalacznik do modulu operacji na liczbach BCD, skladnia FASM
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

if ~defined __FASM_BCD | defined @f
__FASM_BCD	= 1
@@:

;===================================

macro		we8bcd
 {
; Pobiera spakowana liczbe BCD i zwraca ja w AL. AL=-1 i CF=1, gdy blad

        if ~ defined _bcd_we8 | defined @f
                extrn  _bcd_we8
		@@:
        end if

	call	_bcd_we8
 }

;===================================

macro		pisz8bcd
 {
; Wyswietla spakowana liczbe BCD podana w AL.

        if ~ defined _bcd_pisz8 | defined @f
                extrn  _bcd_pisz8
		@@:
        end if

	call	_bcd_pisz8
 }

;===================================

macro		rbcd_na_sbcd8
 {
; Przerabia niespakowana liczbe BCD podana w AL na postac spakowana.
; Wynik zwraca w AL.

        if ~ defined _bcd_rbcd_na_sbcd8 | defined @f
                extrn  _bcd_rbcd_na_sbcd8
		@@:
        end if

	call	_bcd_rbcd_na_sbcd8
 }

;===================================

macro		sbcd_na_rbcd8
 {
; Przerabia spakowana liczbe BCD podana w AL na postac niespakowana.
; Wynik zwraca w AL. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_sbcd_na_rbcd8 | defined @f
                extrn  _bcd_sbcd_na_rbcd8
		@@:
        end if

	call	_bcd_sbcd_na_rbcd8
 }

;===================================

macro		rbcd_na_bin8
 {
; Przerabia niespakowana liczbe BCD podana w AL na postac binarna.
; Wynik zwraca w AL.

        if ~ defined _bcd_rbcd_na_bin8 | defined @f
                extrn  _bcd_rbcd_na_bin8
		@@:
        end if

	call	_bcd_rbcd_na_bin8
 }

;===================================

macro		sbcd_na_bin8
 {
; Przerabia spakowana liczbe BCD podana w AL na postac binarna.
; Wynik zwraca w AL.

        if ~ defined _bcd_sbcd_na_bin8 | defined @f
                extrn  _bcd_sbcd_na_bin8
		@@:
        end if

	call	_bcd_sbcd_na_bin8
 }

;===================================

macro		bin_na_rbcd8
 {
; Przerabia liczbe binarna podana w AL na niespakowana liczbe BCD.
; Wynik zwraca w AL. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_bin_na_rbcd8 | defined @f
                extrn  _bcd_bin_na_rbcd8
		@@:
        end if

	call	_bcd_bin_na_rbcd8
 }

;===================================

macro		bin_na_sbcd8
 {
; Przerabia liczbe binarna podana w AL na spakowana liczbe BCD.
; Wynik zwraca w AL. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_bin_na_sbcd8 | defined @f
                extrn  _bcd_bin_na_sbcd8
		@@:
        end if

	call	_bcd_bin_na_sbcd8
 }

;===================================
;===================================

macro		we16bcd
 {
; Pobiera spakowana liczbe BCD i zwraca ja w AX. AX=-1 i CF=1, gdy blad

        if ~ defined _bcd_we16 | defined @f
                extrn  _bcd_we16
		@@:
        end if

	call	_bcd_we16
 }

;===================================

macro		pisz16bcd
 {
; Wyswietla spakowana liczbe BCD podana w AX.

        if ~ defined _bcd_pisz16 | defined @f
                extrn  _bcd_pisz16
		@@:
        end if

	call	_bcd_pisz16
 }

;===================================

macro		rbcd_na_sbcd16
 {
; Przerabia niespakowana liczbe BCD podana w AX na postac spakowana.
; Wynik zwraca w AX.

        if ~ defined _bcd_rbcd_na_sbcd16 | defined @f
                extrn  _bcd_rbcd_na_sbcd16
		@@:
        end if

	call	_bcd_rbcd_na_sbcd16
 }

;===================================

macro		sbcd_na_rbcd16
 {
; Przerabia spakowana liczbe BCD podana w AX na postac niespakowana.
; Wynik zwraca w AX. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_sbcd_na_rbcd16 | defined @f
                extrn  _bcd_sbcd_na_rbcd16
		@@:
        end if

	call	_bcd_sbcd_na_rbcd16
 }

;===================================

macro		rbcd_na_bin16
 {
; Przerabia niespakowana liczbe BCD podana w AX na postac binarna.
; Wynik zwraca w AX.

        if ~ defined _bcd_rbcd_na_bin16 | defined @f
                extrn  _bcd_rbcd_na_bin16
		@@:
        end if

	call	_bcd_rbcd_na_bin16
 }

;===================================

macro		sbcd_na_bin16
 {
; Przerabia spakowana liczbe BCD podana w AX na postac binarna.
; Wynik zwraca w AX.

        if ~ defined _bcd_sbcd_na_bin16 | defined @f
                extrn  _bcd_sbcd_na_bin16
		@@:
        end if

	call	_bcd_sbcd_na_bin16
 }

;===================================

macro		bin_na_rbcd16
 {
; Przerabia liczbe binarna podana w AX na niespakowana liczbe BCD.
; Wynik zwraca w AX. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_bin_na_rbcd16 | defined @f
                extrn  _bcd_bin_na_rbcd16
		@@:
        end if

	call	_bcd_bin_na_rbcd16
 }

;===================================

macro		bin_na_sbcd16
 {
; Przerabia liczbe binarna podana w AX na spakowana liczbe BCD.
; Wynik zwraca w AX. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_bin_na_sbcd16 | defined @f
                extrn  _bcd_bin_na_sbcd16
		@@:
        end if

	call	_bcd_bin_na_sbcd16
 }

;===================================
;===================================

macro		we32bcd
 {
; Pobiera spakowana liczbe BCD i zwraca ja w DX:AX. DX:AX=-1 i CF=1, gdy blad

        if ~ defined _bcd_we32 | defined @f
                extrn  _bcd_we32
		@@:
        end if

	call	_bcd_we32
 }

;===================================

macro		pisz32bcd
 {
; Wyswietla spakowana liczbe BCD podana w DX:AX.

        if ~ defined _bcd_pisz32 | defined @f
                extrn  _bcd_pisz32
		@@:
        end if

	call	_bcd_pisz32
 }

;===================================

macro		rbcd_na_sbcd32
 {
; Przerabia niespakowana liczbe BCD podana w DX:AX na postac spakowana.
; Wynik zwraca w DX:AX.

        if ~ defined _bcd_rbcd_na_sbcd32 | defined @f
                extrn  _bcd_rbcd_na_sbcd32
		@@:
        end if

	call	_bcd_rbcd_na_sbcd32
 }

;===================================

macro		sbcd_na_rbcd32
 {
; Przerabia spakowana liczbe BCD podana w DX:AX na postac niespakowana.
; Wynik zwraca w DX:AX. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_sbcd_na_rbcd32 | defined @f
                extrn  _bcd_sbcd_na_rbcd32
		@@:
        end if

	call	_bcd_sbcd_na_rbcd32
 }

;===================================

macro		rbcd_na_bin32
 {
; Przerabia niespakowana liczbe BCD podana w DX:AX na postac binarna.
; Wynik zwraca w DX:AX.

        if ~ defined _bcd_rbcd_na_bin32 | defined @f
                extrn  _bcd_rbcd_na_bin32
		@@:
        end if

	call	_bcd_rbcd_na_bin32
 }

;===================================

macro		sbcd_na_bin32
 {
; Przerabia spakowana liczbe BCD podana w DX:AX na postac binarna.
; Wynik zwraca w DX:AX.

        if ~ defined _bcd_sbcd_na_bin32 | defined @f
                extrn  _bcd_sbcd_na_bin32
		@@:
        end if

	call	_bcd_sbcd_na_bin32
 }

;===================================

macro		bin_na_rbcd32
 {
; Przerabia liczbe binarna podana w DX:AX na niespakowana liczbe BCD.
; Wynik zwraca w DX:AX. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_bin_na_rbcd32 | defined @f
                extrn  _bcd_bin_na_rbcd32
		@@:
        end if

	call	_bcd_bin_na_rbcd32
 }

;===================================

macro		bin_na_sbcd32
 {
; Przerabia liczbe binarna podana w DX:AX na spakowana liczbe BCD.
; Wynik zwraca w DX:AX. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_bin_na_sbcd32 | defined @f
                extrn  _bcd_bin_na_sbcd32
		@@:
        end if

	call	_bcd_bin_na_sbcd32
 }

;===================================
;===================================

macro		we32ebcd
 {
; Pobiera spakowana liczbe BCD i zwraca ja w EAX. EAX=-1 i CF=1, gdy blad

        if ~ defined _bcd_we32e | defined @f
                extrn  _bcd_we32e
		@@:
        end if

	call	_bcd_we32e
 }

;===================================

macro		pisz32ebcd
 {
; Wyswietla spakowana liczbe BCD podana w EAX.

        if ~ defined _bcd_pisz32e | defined @f
                extrn  _bcd_pisz32e
		@@:
        end if

	call	_bcd_pisz32e
 }

;===================================

macro		rbcd_na_sbcd32e
 {
; Przerabia niespakowana liczbe BCD podana w EAX na postac spakowana.
; Wynik zwraca w EAX.

        if ~ defined _bcd_rbcd_na_sbcd32e | defined @f
                extrn  _bcd_rbcd_na_sbcd32e
		@@:
        end if

	call	_bcd_rbcd_na_sbcd32e
 }

;===================================

macro		sbcd_na_rbcd32e
 {
; Przerabia spakowana liczbe BCD podana w EAX na postac niespakowana.
; Wynik zwraca w EAX. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_sbcd_na_rbcd32e | defined @f
                extrn  _bcd_sbcd_na_rbcd32e
		@@:
        end if

	call	_bcd_sbcd_na_rbcd32e
 }

;===================================

macro		rbcd_na_bin32e
 {
; Przerabia niespakowana liczbe BCD podana w EAX na postac binarna.
; Wynik zwraca w EAX.

        if ~ defined _bcd_rbcd_na_bin32e | defined @f
                extrn  _bcd_rbcd_na_bin32e
		@@:
        end if

	call	_bcd_rbcd_na_bin32e
 }

;===================================

macro		sbcd_na_bin32e
 {
; Przerabia spakowana liczbe BCD podana w EAX na postac binarna.
; Wynik zwraca w EAX.

        if ~ defined _bcd_sbcd_na_bin32e | defined @f
                extrn  _bcd_sbcd_na_bin32e
		@@:
        end if

	call	_bcd_sbcd_na_bin32e
 }

;===================================

macro		bin_na_rbcd32e
 {
; Przerabia liczbe binarna podana w EAX na niespakowana liczbe BCD.
; Wynik zwraca w EAX. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_bin_na_rbcd32e | defined @f
                extrn  _bcd_bin_na_rbcd32e
		@@:
        end if

	call	_bcd_bin_na_rbcd32e
 }

;===================================

macro		bin_na_sbcd32e
 {
; Przerabia liczbe binarna podana w EAX na spakowana liczbe BCD.
; Wynik zwraca w EAX. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_bin_na_sbcd32e | defined @f
                extrn  _bcd_bin_na_sbcd32e
		@@:
        end if

	call	_bcd_bin_na_sbcd32e
 }

;===================================
;===================================

macro		we64bcd
 {
; Pobiera spakowana liczbe BCD i zwraca ja w EDX:EAX.
; EDX:EAX=-1 i CF=1, gdy blad

        if ~ defined _bcd_we64 | defined @f
                extrn  _bcd_we64
		@@:
        end if

	call	_bcd_we64
 }

;===================================

macro		pisz64bcd
 {
; Wyswietla spakowana liczbe BCD podana w EDX:EAX.

        if ~ defined _bcd_pisz64 | defined @f
                extrn  _bcd_pisz64
		@@:
        end if

	call	_bcd_pisz64
 }

;===================================

macro		rbcd_na_sbcd64
 {
; Przerabia niespakowana liczbe BCD podana w EDX:EAX na postac spakowana.
; Wynik zwraca w EDX:EAX.

        if ~ defined _bcd_rbcd_na_sbcd64 | defined @f
                extrn  _bcd_rbcd_na_sbcd64
		@@:
        end if

	call	_bcd_rbcd_na_sbcd64
 }

;===================================

macro		sbcd_na_rbcd64
 {
; Przerabia spakowana liczbe BCD podana w EDX:EAX na postac niespakowana.
; Wynik zwraca w EDX:EAX. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_sbcd_na_rbcd64 | defined @f
                extrn  _bcd_sbcd_na_rbcd64
		@@:
        end if

	call	_bcd_sbcd_na_rbcd64
 }

;===================================

macro		rbcd_na_bin64
 {
; Przerabia niespakowana liczbe BCD podana w EDX:EAX na postac binarna.
; Wynik zwraca w EDX:EAX.

        if ~ defined _bcd_rbcd_na_bin64 | defined @f
                extrn  _bcd_rbcd_na_bin64
		@@:
        end if

	call	_bcd_rbcd_na_bin64
 }

;===================================

macro		sbcd_na_bin64
 {
; Przerabia spakowana liczbe BCD podana w EDX:EAX na postac binarna.
; Wynik zwraca w EDX:EAX.

        if ~ defined _bcd_sbcd_na_bin64 | defined @f
                extrn  _bcd_sbcd_na_bin64
		@@:
        end if

	call	_bcd_sbcd_na_bin64
 }

;===================================

macro		bin_na_rbcd64
 {
; Przerabia liczbe binarna podana w EDX:EAX na niespakowana liczbe BCD.
; Wynik zwraca w EDX:EAX. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_bin_na_rbcd64 | defined @f
                extrn  _bcd_bin_na_rbcd64
		@@:
        end if

	call	_bcd_bin_na_rbcd64
 }

;===================================

macro		bin_na_sbcd64
 {
; Przerabia liczbe binarna podana w EDX:EAX na spakowana liczbe BCD.
; Wynik zwraca w EDX:EAX. CF=1 w przypadku przepelnienia.

        if ~ defined _bcd_bin_na_sbcd64 | defined @f
                extrn  _bcd_bin_na_sbcd64
		@@:
        end if

	call	_bcd_bin_na_sbcd64
 }

;===================================
;===================================


end if		; __FASM_BCD
