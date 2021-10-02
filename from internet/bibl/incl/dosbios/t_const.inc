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

;=====================================================
; stale, skladnia TASM
;=====================================================


byp	equ	<byte ptr>
wp	equ	<word ptr>
dwp	equ	<dword ptr>
pp	equ	<pword ptr>
qp	equ	<qword ptr>
tp	equ	<tbyte ptr>



;--------------------------
; null, prawda, falsz
;--------------------------

NULL		equ	0
falsz		equ	0
false		equ	0
prawda		equ	1
true		equ	1

;--------------------------
; niektore uzywane znaki
;--------------------------

bel		equ	7	; dzwonek

bksp		equ	8	; back space

tab		equ	9	; tabulator

lf		equ	10	; line feed

eol		equ	10	; nowa linia: DOS,Windows (10,13) / Linux (10)

cr		equ	13	; Enter / powrot karetki / carrige return

eof		equ	1ah	; end-of-file, rzadko juz stosowane

escp		equ	1bh	; Escape

spc		equ	32	; Spacja



;=====================================================
; makra
;=====================================================

wyjscie		macro	kod

ifnb <kod>
	mov ax,( 4ch shl 8 ) or ( kod and 0ffh )
else
	mov ax,4c00h
endif
	int 21h
		endm

;***********************************************

cdde		macro

; umieszcza powojne slowo z DX:AX w EAX

	push dx
	push ax
;;	mov ax,dx
;;	shl eax,16
	pop eax
		endm

;***********************************************

cedd		macro

; umieszcza powojne slowo z EAX w DX:AX

	push eax
;;	shr eax,16
;;	mov dx,ax
	pop ax
	pop dx
		endm



;=====================================================
; kolory
;=====================================================

czarny		equ	0
nieb		equ	1
ziel		equ	2
cyan		equ	3
czer		equ	4
magn		equ	5
braz		equ	6
j_szary		equ	7

c_szary		equ 	8
j_nieb		equ	9
j_ziel		equ	10
j_cyan		equ	11
j_czer		equ	12
j_magn		equ	13
zolty		equ	14
bialy		equ	15

