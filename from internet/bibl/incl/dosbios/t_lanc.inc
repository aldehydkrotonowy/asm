; Zalacznik do modulu operacji na lancuchach znakow
; 11 procedur

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


extrn	_lan_dlugosc:far
extrn	_lan_na_male:far
extrn	_lan_na_duze:far
extrn	_lan_porownaj:far
extrn	_lan_dl_porownaj:far

extrn	_lan_zcal:far
extrn	_lan_dl_zcal:far
extrn	_lan_znajdz:far
extrn	_lan_odwroc:far
extrn	_lan_policz:far

extrn	_lan_zamien:far




skacz		macro	nazwa
	call	far ptr nazwa
		endm

;===================================


dlugosc		macro

; zwraca w AX dlugosc lancucha znakow ( bez bajtu zerowego ),
; wskazywanego przez [SI] i zakonczonego bajtem zerowym

	skacz	_lan_dlugosc
		endm

;===================================


na_male		macro

; zamienia wszystkie litery na male w lancuchu wskazywanym przez [SI]
; lancuch musi byc zakonczony bajtem zerowym

	skacz	_lan_na_male
		endm

;===================================


na_duze		macro

; zamienia wszystkie litery na wielkie w lancuchu wskazywanym przez [SI]
; lancuch musi byc zakonczony bajtem zerowym

	skacz	_lan_na_duze
		endm

;===================================


porownaj	macro

; porownuje 2 lancuchy znakow pod [SI] i [DI].
; zwraca w AX: -1, 0 lub 1 ( oraz flagi ) gdy lancuch pierwszy jest
; odpowiednio: mniejszy, rowny lub wiekszy niz drugi (ASCII)

	skacz	_lan_porownaj
		endm

;===================================


porownaj_dl	macro

; porownuje co najwyzej CX znakow z 2 lancuchow znakow pod [SI] i [DI].
; zwraca w AX: -1, 0 lub 1 ( oraz flagi ) gdy lancuch pierwszy jest
; odpowiednio: mniejszy, rowny lub wiekszy niz drugi (ASCII)

	skacz	_lan_dl_porownaj
		endm

;===================================


zcal		macro

; zcala 2 lancuchy znakow, dopisujac znaki z [DI] do [SI]

	skacz	_lan_zcal
		endm

;===================================


zcal_dl		macro

; dopisuje co najwyzej CX znakow z [DI] do [SI]

	skacz	_lan_dl_zcal
		endm

;===================================


znajdz		macro

; jesli lancuch znakow spod [DI] znajduje sie w lancuchu znakow
; spod [SI], to w AX zwraca pozycje poczatka lancucha z [DI]
; wzgledem poczatka lancucha z [SI].
; jesli nie, AX = -1.

	skacz	_lan_znajdz
		endm

;===================================


odwroc		macro

; nadpisuje lancuch pod [SI] tym samym lancuchem wspak

	skacz	_lan_odwroc
		endm

;===================================


policz		macro

; liczy, ile razy w lancuchu pod [SI] wystepuje znak AL
; wynik zwraca w AX

	skacz	_lan_policz
		endm

;===================================


zamien		macro

; zamienia wszystkie znaki wartosci AH na znak z AL w
; lancuchu znakow spod [SI] zakonczonym bajtem zerowym


	skacz	_lan_zamien
		endm


