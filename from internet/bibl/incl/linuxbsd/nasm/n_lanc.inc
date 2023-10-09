; Zacznik do modulu operacji na lancuchach znakow, skladnia NASM
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

%ifndef __NASM_LANCUCHY
%define __NASM_LANCUCHY


;===================================


%imacro		dlugosc 0

; zwraca w EAX dlugosc lancucha znakow ( bez bajtu zerowego ),
; wskazywanego przez [ESI] i zakonczonego bajtem zerowym

        %ifndef _lan_dlugosc
                extern  _lan_dlugosc
        %endif

 	call	_lan_dlugosc
		%endm

;===================================


%imacro		na_male 0

; zamienia wszystkie litery na male w lancuchu wskazywanym przez [ESI]
; lancuch musi byc zakonczony bajtem zerowym

        %ifndef _lan_na_male
                extern  _lan_na_male
        %endif

 	call	_lan_na_male
		%endm

;===================================


%imacro		na_duze 0

; zamienia wszystkie litery na wielkie w lancuchu wskazywanym przez [ESI]
; lancuch musi byc zakonczony bajtem zerowym

        %ifndef _lan_na_duze
                extern  _lan_na_duze
        %endif

 	call	_lan_na_duze
		%endm

;===================================


%imacro		porownaj 0

; porownuje 2 lancuchy znakow pod [ESI] i [EDI].
; zwraca w EAX: -1, 0 lub 1 ( oraz flagi ) gdy lancuch pierwszy jest
; odpowiednio: mniejszy, rowny lub wiekszy niz drugi (ASCII)

        %ifndef _lan_porownaj
                extern  _lan_porownaj
        %endif

 	call	_lan_porownaj
		%endm

;===================================


%imacro		porownaj_dl 0

; porownuje co najwyzej ECX znakow z 2 lancuchow znakow pod [ESI] i [EDI].
; zwraca w EAX: -1, 0 lub 1 ( oraz flagi ) gdy lancuch pierwszy jest
; odpowiednio: mniejszy, rowny lub wiekszy niz drugi (ASCII)

        %ifndef _lan_dl_porownaj
                extern  _lan_dl_porownaj
        %endif

 	call	_lan_dl_porownaj
		%endm

;===================================


%imacro		zcal 0

; zcala 2 lancuchy znakow, dopisujac znaki z [EDI] do [ESI]

        %ifndef _lan_zcal
                extern  _lan_zcal
        %endif

 	call	_lan_zcal
		%endm

;===================================


%imacro		zcal_dl 0

; dopisuje co najwyzej ECX znakow z [EDI] do [ESI]

        %ifndef _lan_dl_zcal
                extern  _lan_dl_zcal
        %endif

 	call	_lan_dl_zcal
		%endm

;===================================


%imacro		znajdz 0

; jesli lancuch znakow spod [EDI] znajduje sie w lancuchu znakow
; spod [ESI], to w EAX zwraca pozycje poczatka lancucha z [EDI]
; wzgledem poczatka lancucha z [ESI].
; jesli nie, EAX = -1.

        %ifndef _lan_znajdz
                extern  _lan_znajdz
        %endif

 	call	_lan_znajdz
		%endm

;===================================


%imacro		odwroc 0

; nadpisuje lancuch pod [ESI] tym samym lancuchem wspak

        %ifndef _lan_odwroc
                extern  _lan_odwroc
        %endif

 	call	_lan_odwroc
		%endm


; =================================

%imacro		policz 0

; liczy, ile razy w lancuchu pod [ESI] wystepuje znak AL
; wynik zwraca w EAX

        %ifndef _lan_policz
                extern  _lan_policz
        %endif

 	call	_lan_policz
		%endm

; ================================

%imacro         zamien 0

; zamienia wszystkie znaki wartosci AH na znak z AL w
; lancuchu znakow spod [SI] zakonczonym bajtem zerowym

	%ifndef _lan_zamien
		extern  _lan_zamien
	%endif

	call    _lan_zamien
		%endm


%endif		; __NASM_LANCUCHY

