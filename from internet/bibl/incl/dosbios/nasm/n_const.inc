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
; stale, skladnia NASM
;=====================================================

%ifndef __NASM_CONST
%define __NASM_CONST



;----------------------------------------
; null, prawda, falsz
;----------------------------------------


%idefine	NULL	0

%idefine	falsz	0
%idefine	prawda	1

%idefine	false	0
%idefine	true	1


;----------------------------------------
; niektore uzywane znaki
;----------------------------------------


%idefine	BEL	7	; dzwonek
%idefine	BKSP	8	; back space
%idefine	TAB	9	; tabulator
%idefine	LF	10	; line feed
%idefine	EOL	10	; nowa linia: DOS,Windows (10,13) / Linux (10)
%idefine	CR	13	; Enter / powrot karetki / carriage return
%idefine	EOF	1ah	; end-of-file, rzadko juz stosowane
%idefine	ESCP	1bh	; Escape
%idefine	SPC	32	; Spacja


;=====================================================
; makra
;=====================================================


%imacro		wyjscie 0-1 0

	mov ax, (4ch << 8) | (%1 & 0ffh)
	int 21h

		%endm


;***********************************************


%imacro		cdde 0

; umieszcza podwojne slowo z DX:AX w EAX

	push dx
	push ax
	pop eax

;;	push ax
;;	mov ax,dx
;;	shl eax,16
;;	pop ax

		%endm

;***********************************************


%imacro		cedd 0

; umieszcza podwojne slowo z EAX w DX:AX

	push eax
	pop ax
	pop dx

;;	push ax
;;	shr eax,16
;;	mov dx,ax
;;	pop ax

		%endm

;***********************************************

%imacro		fcmova	2
	fcmovnbe %1, %2
	%endm

%imacro		fcmovae	2
	fcmovnb %1, %2
	%endm

%imacro		fcmovna	2
	fcmovbe	%1, %2
	%endm

%imacro		fcmovnae	2
	fcmovb	%1, %2
	%endm

%imacro		fcmovz	2
	fcmove	%1, %2
	%endm

%imacro		fcmovnz	2
	fcmovne	%1, %2
	%endm


;=====================================================
; kolory
;=====================================================

%idefine	czarny		0
%idefine	nieb		1
%idefine	niebieski	nieb
%idefine	ziel		2
%idefine	zielony		ziel
%idefine	cyan		3
%idefine	czer		4
%idefine	czerwony	czer
%idefine	magn		5
%idefine	magneta		magn
%idefine	braz		6
%idefine	brazowy		braz
%idefine	j_szary		7
%idefine	jasny_szary	j_szary


%idefine	c_szary		8
%idefine	ciemny_szary	c_szary

%idefine	j_nieb		9
%idefine	jasny_nieb	j_nieb
%idefine	j_niebieski	j_nieb
%idefine	jasny_niebieski	j_nieb

%idefine	j_ziel		10
%idefine	jasny_ziel	j_ziel
%idefine	j_zielony	j_ziel
%idefine	jasny_zielony	j_ziel

%idefine	j_cyan		11
%idefine	jasny_cyan	j_cyan

%idefine	j_czer		12
%idefine	jasny_czer	j_czer
%idefine	j_czerwony	j_czer
%idefine	jasny_czerwony	j_czer

%idefine	j_magn		13
%idefine	jasny_magn	j_magn
%idefine	j_magneta	j_magn
%idefine	jasny_magneta	j_magn

%idefine	zolty		14

%idefine	bialy		15


%endif		; __NASM_CONST

