; Zalacznik do modulu operacji na lancuchach znakow, skladnia FASM
; 10 procedur

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

; zwraca w EAX dlugosc lancucha znakow ( bez bajtu zerowego ),
; wskazywanego przez [ESI] i zakonczonego bajtem zerowym

	if ~ defined _lan_dlugosc | defined @f
		extrn	_lan_dlugosc
		@@:
	end if
	call	_lan_dlugosc
 }

;===================================


macro		na_male
 {

; zamienia wszystkie litery na male w lancuchu wskazywanym przez [ESI]
; lancuch musi byc zakonczony bajtem zerowym

	if ~ defined _lan_na_male | defined @f
		extrn	_lan_na_male
		@@:
	end if
	call	_lan_na_male
 }

;===================================


macro		na_duze
 {

; zamienia wszystkie litery na wielkie w lancuchu wskazywanym przez [ESI]
; lancuch musi byc zakonczony bajtem zerowym

	if ~ defined _lan_na_duze | defined @f
		extrn	_lan_na_duze
		@@:
	end if
	call	_lan_na_duze
 }

;===================================


macro		porownaj
 {

; porownuje 2 lancuchy znakow pod [ESI] i [EDI].
; zwraca w EAX: -1, 0 lub 1 ( oraz flagi ) gdy lancuch pierwszy jest
; odpowiednio: mniejszy, rowny lub wiekszy niz drugi (ASCII)

	if ~ defined _lan_porownaj | defined @f
		extrn	_lan_porownaj
		@@:
	end if
	call	_lan_porownaj
 }

;===================================


macro		porownaj_dl
 {

; porownuje co najwyzej ECX znakow z 2 lancuchow znakow pod [ESI] i [EDI].
; zwraca w EAX: -1, 0 lub 1 ( oraz flagi ) gdy lancuch pierwszy jest
; odpowiednio: mniejszy, rowny lub wiekszy niz drugi (ASCII)

	if ~ defined _lan_dl_porownaj | defined @f
		extrn	_lan_dl_porownaj
		@@:
	end if
	call	_lan_dl_porownaj
 }

;===================================


macro		zcal
 {

; zcala 2 lancuchy znakow, dopisujac znaki z [EDI] do [ESI]

	if ~ defined _lan_zcal | defined @f
		extrn	_lan_zcal
		@@:
	end if
	call	_lan_zcal
 }

;===================================


macro		zcal_dl
 {

; dopisuje co najwyzej ECX znakow z [EDI] do [ESI]

	if ~ defined _lan_dl_zcal | defined @f
		extrn	_lan_dl_zcal
		@@:
	end if
	call	_lan_dl_zcal
 }

;===================================


macro		znajdz
 {

; jesli lancuch znakow spod [EDI] znajduje sie w lancuchu znakow
; spod [ESI], to w EAX zwraca pozycje poczatka lancucha z [EDI]
; wzgledem poczatka lancucha z [ESI].
; jesli nie, EAX = -1.

	if ~ defined _lan_znajdz | defined @f
		extrn	_lan_znajdz
		@@:
	end if
	call	_lan_znajdz
 }

;===================================


macro		odwroc
 {

; nadpisuje lancuch pod [ESI] tym samym lancuchem wspak

	if ~ defined _lan_odwroc | defined @f
		extrn	_lan_odwroc
		@@:
	end if
	call	_lan_odwroc
 }

; ==================================

macro		policz
 {

; liczy, ile razy w lancuchu pod [ESI] wystepuje znak AL
; wynik zwraca w EAX

	if ~ defined _lan_policz | defined @f
		extrn	_lan_policz
		@@:
	end if
	call	_lan_policz
 }

; ==================================

macro           zamien
 {

; zamienia wszystkie znaki wartosci AH na znak z AL w
; lancuchu znakow spod [SI] zakonczonym bajtem zerowym

	if ~ defined _lan_zamien | defined @f
		extrn	_lan_zamien
		@@:
	end if
	call	_lan_zamien

 }

end if		; __FASM_LANCUCHY

