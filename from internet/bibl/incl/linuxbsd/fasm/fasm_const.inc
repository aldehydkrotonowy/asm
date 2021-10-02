;=====================================================
; stale, skladnia FASM
;=====================================================

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

if ~defined __FASM_CONST | defined @f
__FASM_CONST	= 1
@@:


;--------------------------
; null, prawda, falsz
;--------------------------

null		=	0
NULL		equ	null

falsz		=	0
FALSZ		equ	falsz

false		=	0
FALSE		equ	false

prawda		=	1
PRAWDA		equ	prawda

true		=	1
TRUE		equ	true


;--------------------------
; niektore uzywane znaki
;--------------------------

bel		=	7       ; dzwonek
BEL		equ	bel

bksp		=	8       ; back space
BKSP		equ	bksp

tab		=	9       ; tabulator
TAB		equ	tab

lf		equ	10      ; line feed
LF		equ	lf

eol		=	10      ; nowa linia: DOS,Windows (10,13) / Linux (10)
EOL		equ	eol

cr		=	13      ; Enter / powrot karetki / carriage return
CR		equ	cr

eof		=	1ah     ; end-of-file, rzadko juz stosowane
EOF		equ	eof

escp		=	1bh     ; Escape
ESCP		equ	escp

spc		=	32      ; Spacja
SPC		equ	spc


;--------------------------
; slowa kluczowe
;--------------------------

byp	equ	byte
wp	equ	word
dwp	equ	dword
pp	equ	pword
fp	equ	fword
qp	equ	qword
tp	equ	tbyte
dqp	equ	dqword


;=====================================================
; makra
;=====================================================

macro	wyjscie	kod
 {
	if kod eq
		xor	ebx, ebx
	else
		mov	ebx, kod
	end if
		mov	eax, 1
		int	80h
 }

macro	wyjscie64	kod
 {
	if kod eq
		xor	rdi, rdi
	else
		mov	rdi, kod
	end if
		mov	rax, 60
		syscall
 }

;***********************************************

macro	cdde
 {

	; umieszcza podwojne slowo z DX:AX w EAX

	push dx
	push ax
	pop eax

;;      push    ax
;;      mov     ax, dx
;;      shl     eax, 16
;;      pop     ax

 }

;***********************************************

macro	cedd
 {

	; umieszcza podwojne slowo z EAX w DX:AX

	push eax
	pop ax
	pop dx

;;      push    ax
;;      shr     eax, 16
;;      mov     dx, ax
;;      pop     ax

 }


;=====================================================
; kolory
;=====================================================

czarny		=	0
CZARNY		equ	czarny

nieb		=	1
NIEB		equ	nieb

ziel		=	2
ZIEL		equ	ziel

cyan		=	3
CYAN		equ	cyan

czer		=	4
CZER		equ	czer

magn		=	5
MAGN		equ	magn

braz		=	6
BRAZ		equ	braz

j_szary		=	7
J_SZARY		equ	j_szary


c_szary		= 	8
C_SZARY		equ	c_szary

j_nieb		=	9
J_NIEB		equ	j_nieb

j_ziel		=	10
J_ZIEL		equ	j_ziel

j_cyan		=	11
J_CYAN		equ	j_cyan

j_czer		=	12
J_CZER		equ	j_czer

j_magn		=	13
J_MAGN		equ	j_magn

zolty		=	14
ZOLTY		equ	zolty

bialy		=	15
BIALY		equ	bialy


end if		; __FASM_CONST

