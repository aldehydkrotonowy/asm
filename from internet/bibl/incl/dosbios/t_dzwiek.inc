; Zalacznik do modulu emisji dzwieku przez glosniczek
; 1 procedura

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


;=================================
; Muzyczna skala dzwieku (Hz):
;=================================

		;_sqrt12_2	equ	1.05946309435929526456182529494634

dzw_c1		equ	264
dzw_c1@		equ	280			;(dzw_c1 * _sqrt12_2)

dzw_d1		equ	dzw_c1 * 9/8		; 297
dzw_d1@		equ	315			;(dzw_d1 * _sqrt12_2)

dzw_e1		equ	dzw_c1 * 5/4		; 330

dzw_f1		equ	dzw_c1 * 4/3		; 352
dzw_f1@		equ	373			;(dzw_f1 * _sqrt12_2)

dzw_g1		equ	dzw_c1 * 3/2		; 396
dzw_g1@		equ	420			;(dzw_g1 * _sqrt12_2)

dzw_a1		equ	dzw_c1 * 5/3		; 440
dzw_a1@		equ	466			;(dzw_a1 * _sqrt12_2)

dzw_h1		equ	dzw_c1 * 15/8		; 495

dzw_c2		equ	dzw_c1 * 2		; 528


;=================================
; Fizyczna skala dzwieku (Hz):
;=================================

dzw_c1_f	equ	256
dzw_c1@_f	equ	271			;(dzw_c1_f * _sqrt12_2)

dzw_d1_f	equ	dzw_c1_f * 9/8		; 288
dzw_d1@_f	equ	305			;(dzw_d1_f * _sqrt12_2)

dzw_e1_f	equ	dzw_c1_f * 5/4		; 320

dzw_f1_f	equ	dzw_c1_f * 4/3		; 341
dzw_f1@_f	equ	362			;(dzw_f1_f * _sqrt12_2)

dzw_g1_f	equ	dzw_c1_f * 3/2		; 384
dzw_g1@_f	equ	407			;(dzw_g1_f * _sqrt12_2)

dzw_a1_f	equ	dzw_c1_f * 5/3		; 427
dzw_a1@_f	equ	452			;(dzw_a1_f * _sqrt12_2)

dzw_h1_f	equ	dzw_c1_f * 15/8		; 480

dzw_c2_f	equ	dzw_c1_f * 2		; 512

;=================================
; Makro:
;=================================

extrn	_graj_dzwiek:far

graj		macro

; wejscie:	BX = zadana czestotliwosc dzwieku w Hz, co najmniej 19
;		CX:DX = czas trwania dzwieku w mikrosekundach
;
; wyjscie:	CF = 0 - wykonane bez bledow
;		CF = 1 - blad: BX za maly

	call	far ptr _graj_dzwiek
		endm

