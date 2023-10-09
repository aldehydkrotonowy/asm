; Zalacznik do modulu operacji na liczbach BCD, skladnia TASM
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


extrn _bcd_we8:far
extrn _bcd_we16:far
extrn _bcd_we32:far
extrn _bcd_we32e:far
extrn _bcd_we64:far

extrn _bcd_pisz8:far
extrn _bcd_pisz16:far
extrn _bcd_pisz32:far
extrn _bcd_pisz32e:far
extrn _bcd_pisz64:far

extrn _bcd_rbcd_na_sbcd8:far
extrn _bcd_sbcd_na_rbcd8:far
extrn _bcd_rbcd_na_bin8:far
extrn _bcd_sbcd_na_bin8:far
extrn _bcd_bin_na_rbcd8:far
extrn _bcd_bin_na_sbcd8:far

extrn _bcd_rbcd_na_sbcd16:far
extrn _bcd_sbcd_na_rbcd16:far
extrn _bcd_rbcd_na_bin16:far
extrn _bcd_sbcd_na_bin16:far
extrn _bcd_bin_na_rbcd16:far
extrn _bcd_bin_na_sbcd16:far

extrn _bcd_rbcd_na_sbcd32:far
extrn _bcd_sbcd_na_rbcd32:far
extrn _bcd_rbcd_na_bin32:far
extrn _bcd_sbcd_na_bin32:far
extrn _bcd_bin_na_rbcd32:far
extrn _bcd_bin_na_sbcd32:far

extrn _bcd_rbcd_na_sbcd32e:far
extrn _bcd_sbcd_na_rbcd32e:far
extrn _bcd_rbcd_na_bin32e:far
extrn _bcd_sbcd_na_bin32e:far
extrn _bcd_bin_na_rbcd32e:far
extrn _bcd_bin_na_sbcd32e:far

extrn _bcd_rbcd_na_sbcd64:far
extrn _bcd_sbcd_na_rbcd64:far
extrn _bcd_rbcd_na_bin64:far
extrn _bcd_sbcd_na_bin64:far
extrn _bcd_bin_na_rbcd64:far
extrn _bcd_bin_na_sbcd64:far


skacz		macro	nazwa
	call	far ptr nazwa
		endm

;===================================

we8bcd		macro

; Pobiera spakowana liczbe BCD i zwraca ja w AL. AL=-1 i CF=1, gdy blad

	skacz	_bcd_we8
endm

;===================================

pisz8bcd		macro

; Wyswietla spakowana liczbe BCD podana w AL.

	skacz	_bcd_pisz8
endm

;===================================

rbcd_na_sbcd8		macro

; Przerabia niespakowana liczbe BCD podana w AL na postac spakowana.
; Wynik zwraca w AL.

	skacz	_bcd_rbcd_na_sbcd8
endm

;===================================

sbcd_na_rbcd8		macro

; Przerabia spakowana liczbe BCD podana w AL na postac niespakowana.
; Wynik zwraca w AL. CF=1 w przypadku przepelnienia.

	skacz	_bcd_sbcd_na_rbcd8
endm

;===================================

rbcd_na_bin8		macro

; Przerabia niespakowana liczbe BCD podana w AL na postac binarna.
; Wynik zwraca w AL.

	skacz	_bcd_rbcd_na_bin8
endm

;===================================

sbcd_na_bin8		macro

; Przerabia spakowana liczbe BCD podana w AL na postac binarna.
; Wynik zwraca w AL.

	skacz	_bcd_sbcd_na_bin8
endm

;===================================

bin_na_rbcd8		macro

; Przerabia liczbe binarna podana w AL na niespakowana liczbe BCD.
; Wynik zwraca w AL. CF=1 w przypadku przepelnienia.

	skacz	_bcd_bin_na_rbcd8
endm

;===================================

bin_na_sbcd8		macro

; Przerabia liczbe binarna podana w AL na spakowana liczbe BCD.
; Wynik zwraca w AL. CF=1 w przypadku przepelnienia.

	skacz	_bcd_bin_na_sbcd8
endm

;===================================
;===================================

we16bcd		macro

; Pobiera spakowana liczbe BCD i zwraca ja w AX. AX=-1 i CF=1, gdy blad

	skacz	_bcd_we16
endm

;===================================

pisz16bcd		macro

; Wyswietla spakowana liczbe BCD podana w AX.

	skacz	_bcd_pisz16
endm

;===================================

rbcd_na_sbcd16		macro

; Przerabia niespakowana liczbe BCD podana w AX na postac spakowana.
; Wynik zwraca w AX.

	skacz	_bcd_rbcd_na_sbcd16
endm

;===================================

sbcd_na_rbcd16		macro

; Przerabia spakowana liczbe BCD podana w AX na postac niespakowana.
; Wynik zwraca w AX. CF=1 w przypadku przepelnienia.

	skacz	_bcd_sbcd_na_rbcd16
endm

;===================================

rbcd_na_bin16		macro

; Przerabia niespakowana liczbe BCD podana w AX na postac binarna.
; Wynik zwraca w AX.

	skacz	_bcd_rbcd_na_bin16
endm

;===================================

sbcd_na_bin16		macro

; Przerabia spakowana liczbe BCD podana w AX na postac binarna.
; Wynik zwraca w AX.

	skacz	_bcd_sbcd_na_bin16
endm

;===================================

bin_na_rbcd16		macro

; Przerabia liczbe binarna podana w AX na niespakowana liczbe BCD.
; Wynik zwraca w AX. CF=1 w przypadku przepelnienia.

	skacz	_bcd_bin_na_rbcd16
endm

;===================================

bin_na_sbcd16		macro

; Przerabia liczbe binarna podana w AX na spakowana liczbe BCD.
; Wynik zwraca w AX. CF=1 w przypadku przepelnienia.

	skacz	_bcd_bin_na_sbcd16
endm

;===================================
;===================================

we32bcd		macro

; Pobiera spakowana liczbe BCD i zwraca ja w DX:AX. DX:AX=-1 i CF=1, gdy blad

	skacz	_bcd_we32
endm

;===================================

pisz32bcd		macro

; Wyswietla spakowana liczbe BCD podana w DX:AX.

	skacz	_bcd_pisz32
endm

;===================================

rbcd_na_sbcd32		macro

; Przerabia niespakowana liczbe BCD podana w DX:AX na postac spakowana.
; Wynik zwraca w DX:AX.

	skacz	_bcd_rbcd_na_sbcd32
endm

;===================================

sbcd_na_rbcd32		macro

; Przerabia spakowana liczbe BCD podana w DX:AX na postac niespakowana.
; Wynik zwraca w DX:AX. CF=1 w przypadku przepelnienia.

	skacz	_bcd_sbcd_na_rbcd32
endm

;===================================

rbcd_na_bin32		macro

; Przerabia niespakowana liczbe BCD podana w DX:AX na postac binarna.
; Wynik zwraca w DX:AX.

	skacz	_bcd_rbcd_na_bin32
endm

;===================================

sbcd_na_bin32		macro

; Przerabia spakowana liczbe BCD podana w DX:AX na postac binarna.
; Wynik zwraca w DX:AX.

	skacz	_bcd_sbcd_na_bin32
endm

;===================================

bin_na_rbcd32		macro

; Przerabia liczbe binarna podana w DX:AX na niespakowana liczbe BCD.
; Wynik zwraca w DX:AX. CF=1 w przypadku przepelnienia.

	skacz	_bcd_bin_na_rbcd32
endm

;===================================

bin_na_sbcd32		macro

; Przerabia liczbe binarna podana w DX:AX na spakowana liczbe BCD.
; Wynik zwraca w DX:AX. CF=1 w przypadku przepelnienia.

	skacz	_bcd_bin_na_sbcd32
endm

;===================================
;===================================

we32ebcd		macro

; Pobiera spakowana liczbe BCD i zwraca ja w EAX. EAX=-1 i CF=1, gdy blad

	skacz	_bcd_we32e
endm

;===================================

pisz32ebcd		macro

; Wyswietla spakowana liczbe BCD podana w EAX.

	skacz	_bcd_pisz32e
endm

;===================================

rbcd_na_sbcd32e		macro

; Przerabia niespakowana liczbe BCD podana w EAX na postac spakowana.
; Wynik zwraca w EAX.

	skacz	_bcd_rbcd_na_sbcd32e
endm

;===================================

sbcd_na_rbcd32e		macro

; Przerabia spakowana liczbe BCD podana w EAX na postac niespakowana.
; Wynik zwraca w EAX. CF=1 w przypadku przepelnienia.

	skacz	_bcd_sbcd_na_rbcd32e
endm

;===================================

rbcd_na_bin32e		macro

; Przerabia niespakowana liczbe BCD podana w EAX na postac binarna.
; Wynik zwraca w EAX.

	skacz	_bcd_rbcd_na_bin32e
endm

;===================================

sbcd_na_bin32e		macro

; Przerabia spakowana liczbe BCD podana w EAX na postac binarna.
; Wynik zwraca w EAX.

	skacz	_bcd_sbcd_na_bin32e
endm

;===================================

bin_na_rbcd32e		macro

; Przerabia liczbe binarna podana w EAX na niespakowana liczbe BCD.
; Wynik zwraca w EAX. CF=1 w przypadku przepelnienia.

	skacz	_bcd_bin_na_rbcd32e
endm

;===================================

bin_na_sbcd32e		macro

; Przerabia liczbe binarna podana w EAX na spakowana liczbe BCD.
; Wynik zwraca w EAX. CF=1 w przypadku przepelnienia.

	skacz	_bcd_bin_na_sbcd32e
endm

;===================================
;===================================

we64bcd		macro

; Pobiera spakowana liczbe BCD i zwraca ja w EDX:EAX.
; EDX:EAX=-1 i CF=1, gdy blad

	skacz	_bcd_we64
endm

;===================================

pisz64bcd		macro

; Wyswietla spakowana liczbe BCD podana w EDX:EAX.

	skacz	_bcd_pisz64
endm

;===================================

rbcd_na_sbcd64		macro

; Przerabia niespakowana liczbe BCD podana w EDX:EAX na postac spakowana.
; Wynik zwraca w EDX:EAX.

	skacz	_bcd_rbcd_na_sbcd64
endm

;===================================

sbcd_na_rbcd64		macro

; Przerabia spakowana liczbe BCD podana w EDX:EAX na postac niespakowana.
; Wynik zwraca w EDX:EAX. CF=1 w przypadku przepelnienia.

	skacz	_bcd_sbcd_na_rbcd64
endm

;===================================

rbcd_na_bin64		macro

; Przerabia niespakowana liczbe BCD podana w EDX:EAX na postac binarna.
; Wynik zwraca w EDX:EAX.

	skacz	_bcd_rbcd_na_bin64
endm

;===================================

sbcd_na_bin64		macro

; Przerabia spakowana liczbe BCD podana w EDX:EAX na postac binarna.
; Wynik zwraca w EDX:EAX.

	skacz	_bcd_sbcd_na_bin64
endm

;===================================

bin_na_rbcd64		macro

; Przerabia liczbe binarna podana w EDX:EAX na niespakowana liczbe BCD.
; Wynik zwraca w EDX:EAX. CF=1 w przypadku przepelnienia.

	skacz	_bcd_bin_na_rbcd64
endm

;===================================

bin_na_sbcd64		macro

; Przerabia liczbe binarna podana w EDX:EAX na spakowana liczbe BCD.
; Wynik zwraca w EDX:EAX. CF=1 w przypadku przepelnienia.

	skacz	_bcd_bin_na_sbcd64
endm

;===================================
;===================================
