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
; Dla uzytkownikow Turbo Assemblera ( TASM'a ) :
;=====================================================

if ~defined __2_FASM_ | defined @f
__2_FASM	= 1
@@:



;--------------------------
; modele pamieci
;--------------------------

macro	.model typ { }

;tiny		equ
;small		equ
;medium		equ
;compact	equ
;large		equ
;huge		equ

;--------------------------
; slowa kluczowe
;--------------------------

offset	equ
OFFSET	equ	offset		; UWAGA. Kazdy offset jest 32-bitowy
ptr	equ
PTR	equ	ptr



;----------------------------------------
; instrukcje
;----------------------------------------


macro		fadd
 {
	faddp	st1,st0
 }

macro		fsub
 {
	fsubp	st1,st0
 }

macro		fmul
 {
	fmulp	st1,st0
 }

macro		fdiv
 {
	fdivp	st1,st0
 }

macro		fsubr
 {
	fsubrp	st1,st0
 }

macro		fdivr
 {
	fdivrp	st1,st0
 }


;=====================================================
; Dla uzykownikow Netwide Assemblera ( NASM'a ) :
;=====================================================

%ifdef		equ	if defined
%ifndef		equ	if ~defined
%if		equ	if
%elseif		equ	else if
%else		equ	else
%endif		equ	end if

macro	%idefine co, cos
 {
	co	equ	cos
 }

macro	%define co, cos
 {
	co	equ	cos
 }

global		equ	public
GLOBAL		equ	global

extern		equ	extrn
EXTERN		equ	extern



end if		; __2_FASM_

