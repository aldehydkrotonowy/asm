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


st0	EQU		<st(0)>
st1	EQU		<st(1)>
st2	EQU		<st(2)>
st3	EQU		<st(3)>
st4	EQU		<st(4)>
st5	EQU		<st(5)>
st6	EQU		<st(6)>
st7	EQU		<st(7)>

;=====================================================
; Dla uzytkownikow Netwide Assemblera ( NASM'a ) :
;=====================================================

				; tutaj niestety po etykietach trzeba
				; wstawiac dwukropki, np. 'abcd: resb 10'
resb	MACRO	ilosc
	db	&ilosc&	dup (?)
	ENDM

resw	MACRO	ilosc
	dw	&ilosc&	dup (?)
	ENDM

resd	MACRO	ilosc
	dd	&ilosc&	dup (?)
	ENDM

resq	MACRO	ilosc
	dq	&ilosc&	dup (?)
	ENDM

rest	MACRO	ilosc
	dt	&ilosc&	dup (?)
	ENDM




extern		equ	<extrn>

CPU	macro	arch
	IFDEF IDEAL
		P&arch&
	ELSE
		.&arch&
	ENDIF
	ENDM


COMMENT #
!%error		equ	<'ERR'>
!%if		equ	<'IF'>
!%elseif	equ	<'ELSEIF'>
!%else		equ	<'ELSE'>
!%endif		equ	<'ENDIF'>
!=!=		equ	<'EQ'>
!!!=		equ	<'NE'>
!>!=		equ	<'GE'>
!>		equ	<'GT'>
!<!=		equ	<'LE'>
!<		equ	<'LT'>
!%!%		equ	<'MOD'>

!%rep		equ	<'REPT'>

!%arg		equ	<'arg'>
!%local		equ	<'local'>


!|		equ	<'OR'>
!&		equ	<'AND'>
!^		equ	<'XOR'>
!<!<		equ	<'SHL'>
!>!>		equ	<'SHR'>
!/!/		equ	<'/'>
!%		equ	<'MOD'>
!%!%		equ	<'MOD'>
!~		equ	<'NOT'>

!%define		macro	symbol, wartosc
	&symbol&	equ	&wartosc&
	endm

!%substr	equ	<'substr'>


				; mozliwe, ze po etykietach trzeba
				; wstawiac dwukropki, np. 'abcd: times 10 db 1'
				; lub nawet 'abcd: times 10, db, 1'
TIMES	macro	ile, typ, wartosc
	&typ& &ile& dup(&wartosc&)
	ENDM

#


;=====================================================
; Dla uzytkownikow Flat Assemblera ( FASM'a ) :
;=====================================================

repeat		equ	<REPT>

format		macro	typ
	ERR "Dyrektywa 'format' nie jest obslugiwana"
		endm

heap		macro	wielkosc
	ERR "Dyrektywa 'heap' nie jest obslugiwana"
		endm

entry		macro	miejsce
	ERR "Dyrektywa 'entry' nie jest obslugiwana"
		endm

section		macro	typ
	ERR "Dyrektywa 'section' nie jest obslugiwana"
		endm


				; tutaj niestety po etykietach trzeba
				; wstawiac dwukropki, np. 'abcd: rb 10'
rb	MACRO	ilosc
	db	&ilosc&	dup (?)
	ENDM

rw	MACRO	ilosc
	dw	&ilosc&	dup (?)
	ENDM

rd	MACRO	ilosc
	dd	&ilosc&	dup (?)
	ENDM

rq	MACRO	ilosc
	dq	&ilosc&	dup (?)
	ENDM

rt	MACRO	ilosc
	dt	&ilosc&	dup (?)
	ENDM

