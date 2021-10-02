; Zalacznik do modulu operacji na lancuchach znakow, skladnia FASM
; 9 procedur

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

if ~defined __FASM_LANCUCHY | defined @f
__FASM_LANCUCHY		= 1
@@:



;===================================


macro		dlugosc
 {

; zwraca w AX dlugosc lancucha znakow ( bez bajtu zerowego ),
; wskazywanego przez [SI] i zakonczonego bajtem zerowym

	if ~ defined _lan_dlugosc | defined @f
		extrn	_lan_dlugosc:dword
		@@:
	end if
	skacz	_lan_dlugosc
 }

;===================================


macro		na_male
 {

; zamienia wszystkie litery na male w lancuchu wskazywanym przez [SI]
; lancuch musi byc zakonczony bajtem zerowym

	if ~ defined _lan_na_male | defined @f
		extrn	_lan_na_male:dword
		@@:
	end if
	skacz	_lan_na_male
 }

;===================================


macro		na_duze
 {

; zamienia wszystkie litery na wielkie w lancuchu wskazywanym przez [SI]
; lancuch musi byc zakonczony bajtem zerowym

	if ~ defined _lan_na_duze | defined @f
		extrn	_lan_na_duze:dword
		@@:
	end if
	skacz	_lan_na_duze
 }

;===================================


macro		porownaj
 {

; porownuje 2 lancuchy znakow pod [SI] i [DI].
; zwraca w AX: -1, 0 lub 1 ( oraz flagi ) gdy lancuch pierwszy jest
; odpowiednio: mniejszy, rowny lub wiekszy niz drugi (ASCII)

	if ~ defined _lan_porownaj | defined @f
		extrn	_lan_porownaj:dword
		@@:
	end if
	skacz	_lan_porownaj
 }

;===================================


macro		porownaj_dl
 {

; porownuje co najwyzej CX znakow z 2 lancuchow znakow pod [SI] i [DI].
; zwraca w AX: -1, 0 lub 1 ( oraz flagi ) gdy lancuch pierwszy jest
; odpowiednio: mniejszy, rowny lub wiekszy niz drugi (ASCII)

	if ~ defined _lan_dl_porownaj | defined @f
		extrn	_lan_dl_porownaj:dword
		@@:
	end if
	skacz	_lan_dl_porownaj
 }

;===================================


macro		zcal
 {

; zcala 2 lancuchy znakow, dopisujac znaki z [DI] do [SI]

	if ~ defined _lan_zcal | defined @f
		extrn	_lan_zcal:dword
		@@:
	end if
	skacz	_lan_zcal
 }

;===================================


macro		zcal_dl
 {

; dopisuje co najwyzej CX znakow z [DI] do [SI]

	if ~ defined _lan_dl_zcal | defined @f
		extrn	_lan_dl_zcal:dword
		@@:
	end if
	skacz	_lan_dl_zcal
 }

;===================================


macro		znajdz
 {

; jesli lancuch znakow spod [DI] znajduje sie w lancuchu znakow
; spod [SI], to w AX zwraca pozycje poczatka lancucha z [DI]
; wzgledem poczatka lancucha z [SI].
; jesli nie, AX = -1.

	if ~ defined _lan_znajdz | defined @f
		extrn	_lan_znajdz:dword
		@@:
	end if
	skacz	_lan_znajdz
 }

;===================================


macro		odwroc
 {

; nadpisuje lancuch pod [SI] tym samym lancuchem wspak

	if ~ defined _lan_odwroc | defined @f
		extrn	_lan_odwroc:dword
		@@:
	end if
	skacz	_lan_odwroc
 }


;===================================


macro		policz
 {

; liczy, ile razy w lancuchu pod [SI] wystepuje znak AL
; wynik zwraca w AX

	if ~ defined _lan_policz | defined @f
		extrn	_lan_policz:dword
		@@:
	end if
	skacz	_lan_policz
 }


;===================================


macro		zamien
 {

; zamienia wszystkie znaki wartosci AH na znak z AL w
; lancuchu znakow spod [SI] zakonczonym bajtem zerowym

	if ~ defined _lan_zamien | defined @f
		extrn	_lan_zamien:dword
		@@:
	end if
	skacz	_lan_zamien

 }


end if		; __FASM_LANCUCHY

