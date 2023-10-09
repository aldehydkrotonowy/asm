; Zalacznik do modulu pobierajacego liczby ulamkowe w postaci wykladniczej,
; skladnia FASM

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

if ~defined __FASM_FN_WEJ | defined @f
__FASM_CFN_WEJ		= 1
@@:



;===================================

macro		wed32n
 {

; pobiera liczbe ulamkowa pojedynczej precyzji ( 32 bit )
; zwraca ja w ES:[DI] ( bufor musi miec odpowiedni rozmiar:
; co najmniej 4 bajty )
; CF=0 - bez bledu, CF=1 - blad i ES:[DI]=0

	if ~ defined _fn_we_32 | defined @f
		extrn	_fn_we_32:dword
		@@:
	end if
	skacz	_fn_we_32
 }


;===================================

macro		wed64n
 {

; pobiera liczbe ulamkowa podwojnej precyzji ( 64 bit )
; CF=0 - bez bledu, CF=1 - blad i ES:[DI]=0, ( bufor co najmniej 8 bajtow )

	if ~ defined _fn_we_64 | defined @f
		extrn	_fn_we_64:dword
		@@:
	end if
	skacz	_fn_we_64
 }

;===================================

macro		wed80n
 {

; pobiera liczbe ulamkowa rozszerzonej precyzji ( 80 bit )
; CF=0 - bez bledu, CF=1 - blad i ES:[DI]=0, ( bufor co najmniej 10 bajtow )

	if ~ defined _fn_we_80 | defined @f
		extrn	_fn_we_80:dword
		@@:
	end if
	skacz	_fn_we_80
 }



end if		; __FASM_FN_WEJ

