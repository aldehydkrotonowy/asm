;=====================================================
; Dla uzytkownikow Turbo Assemblera ( TASM'a ) i
; Microsoft Macro Assemblera ( MASM'a ) :
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

%ifndef __2_NASM
%define __2_NASM




;----------------------------------------
; modele pamieci
;----------------------------------------




%imacro		.model 1-*
	%endm

%idefine	..model		.model
%idefine	model		.model




;----------------------------------------
; segmenty
;----------------------------------------




%idefine	.code		section .text
%idefine	..code		.code
%idefine	CODESEG		.code

;-----

%imacro		.data	0
		section .data			; aby uniknac rekurencji
	%endm

%idefine	..data		.data
%idefine	DATASEG		.data

;-----


%imacro		.STACK	0-1 200h
	%endm

%idefine	..stack		.STACK



%imacro		.const	0
		section		.const
	%endm

%imacro		.data?	0
		section		.bss
	%endm

%imacro		.dosseg	0
	%endm

%idefine	dosseg		.dosseg


;----------------------------------------
; specyfikacje architektury
;----------------------------------------




%define		.8086		CPU 8086
%idefine	P8086		CPU 8086

%define		.186		CPU 186
%idefine	P186		CPU 186

%define		.286		CPU 286
%idefine	.286p		CPU 286
%idefine	.286c		CPU 286
%idefine	P286		CPU 286
%idefine	P286N		CPU 286

%define		.386		CPU 386
%idefine	.386p		CPU 386
%idefine	.386c		CPU 386
%idefine	P386		CPU 386
%idefine	P386N		CPU 386

%define		.486		CPU 486
%idefine	.486c		CPU 486
%idefine	.486p		CPU 486
%idefine	P486		CPU 486
%idefine	P486N		CPU 486

%define		.586		CPU 586
%idefine	.586c		CPU 586
%idefine	.586p		CPU 586
%idefine	P586		CPU 586
%idefine	P586N		CPU 586

%define		.686		CPU 686
%idefine	.686p		CPU 686
%idefine	P686		CPU 686

%idefine	.mmx		CPU 686
%idefine	.xmm		CPU P4
%idefine	.k3d		CPU P4


%define		.8087		CPU 8086
%idefine	P8087		CPU 8086
%define		.187		CPU 186
%define		.287		CPU 286
%define		.387		CPU 386
%define		.487		CPU 486
%define		.587		CPU 586



;----------------------------------------
; slowa kluczowe
;----------------------------------------


%idefine	st(i)	st %+ i		; rejestry koprocesora: st(0)...st(7)
					; staja sie st0...st7

%define		?	0


%imacro		dp	1-*
	%error "Dyrektywa 'dp' nie jest obslugiwana."
	%endm

%imacro		df	1-*
	%error "Dyrektywa 'df' nie jest obslugiwana."
	%endm

%imacro		pword	1
	%error "Slowo kluczowe 'pword' nie jest obslugiwane."
	%endm

%imacro		fword	1
	%error "Slowo kluczowe 'fword' nie jest obslugiwane."
	%endm

%idefine	near16		near
%idefine	far16		far

%idefine	real10		dt		; MASM
%idefine	real8		dq
%idefine	real4		dd

%idefine	sbyte		db		; MASM
%idefine	sword		dw
%idefine	sdword		dd

%idefine	xmmword
%idefine	oword		xmmword
%idefine	tbyte		tword




%imacro		end	0-1
;;	end			; pomijamy etykiete stojaca przy 'end'
	%if %0 == 1		; i czynimy ja globalna
		global %1
	%endif
	%endm


%idefine	public		global
%idefine	extrn		extern
%idefine	external	extern
%idefine	externdef	extern

%idefine	offset
%idefine	ptr



%imacro		include	1-*

	%rep %0

		%define		_nazwa13glg57_pliku00		%1
		%include	"_nazwa13glg57_pliku00"
		%undef		_nazwa13glg57_pliku00

		%rotate 1

	%endrep

	%endm


;-----


%imacro		radix	1

	%if %1 != 10
	%error "NASM nie obsluguje slowa kluczowego 'radix'. \
		Niektore liczby moga byc niepoprawne. Program moze \
		nie dzialac prawidlowo."

	%endif
	%endm

%idefine	.radix		radix
%idefine	..radix		radix

;-----

%imacro		macro	0-*
	%error	"Skladnia makra w NASMie: %macro nazwa ilosc_argumentow \
		[tresc] %endm"

	%endm

%idefine	endm	%endm

;-----


%imacro		label	1
	%error	"Dyrektywa 'label' nie jest obslugiwana. Aby \
		zarezerwowac miejsce, nalezy uzyc resb, resw, ..."
	%endm

;-----

%idefine	ERR	%error
%idefine	IF	%if
%idefine	ELSEIF	%elif
%idefine	ELSE	%else
%idefine	ENDIF	%endif
%idefine	EQ	==
%idefine	NE	!=
%idefine	GE	>=
%idefine	GT	>
%idefine	LE	<=
%idefine	LT	<
%idefine	MOD	%%




%idefine	REPT	%rep

%idefine	display
%idefine	IDEAL

%imacro		even 0
	align 2
	%endm

%imacro		evendata 0
	align 2
	%endm

%imacro		exitcode 0-1 0

	mov ax, (4ch << 8) | (%1 & 0ffh)
	int 21h

		%endm

%imacro		.exit 0-1 0

	mov ax, (4ch << 8) | (%1 & 0ffh)
	int 21h

		%endm


;----------------------------------------
; instrukcje
;----------------------------------------

; Nie definiowac jednoargumentowych operatorow takich jak:
; and, or, xor, not, shl, shr
; jako ze sa one takze instrukcjami.

%imacro		faddp	0
	faddp	st1,st0
	%endm

%imacro		fsubp	0
	fsubp	st1,st0
	%endm

%imacro		fmulp	0
	fmulp	st1,st0
	%endm

%imacro		fdivp	0
	fdivp	st1,st0
	%endm

%imacro		fsubrp	0
	fsubrp	st1,st0
	%endm

%imacro		fdivrp	0
	fdivrp	st1,st0
	%endm



%imacro		fadd	0
	faddp	st1,st0
	%endm

%imacro		fsub	0
	fsubp	st1,st0
	%endm

%imacro		fmul	0
	fmulp	st1,st0
	%endm

%imacro		fdiv	0
	fdivp	st1,st0
	%endm

%imacro		fsubr	0
	fsubrp	st1,st0
	%endm

%imacro		fdivr	0
	fdivrp	st1,st0
	%endm




%imacro		loopd	1
	loop	%1,ecx
	%endm


;----------------------------------------
; obsluga procedur
;----------------------------------------


%imacro		proc 0-*
	%if %0 > 0		; mamy argumenty

		%error "Dyrektywa 'proc' jest pomijana. Jakiekolwiek \
			argumenty przy etykiecie \
			procedury nie sa obslugiwane. Nalezy uzywac \
			tylko samych etykiet."
	%endif

	%endm

;-----

%imacro		uses 0-*
	%error "Dyrektywa 'uses' nie jest obslugiwana."
	%endm


;-----


%idefine	arg	%arg
%idefine	local	%local


;-----

%imacro		endp	0
	%error "Cala linijke zawierajaca 'endp' nalezy usunac."
	%endm


;-----

%imacro		assume 1-*
	%endm





;=====================================================
; Dla uzytkownikow Flat Assemblera ( FASM'a ) :
;=====================================================

%imacro		format	1
	%endm

%imacro		entry	1
	global %1
	%endm

%imacro		heap	1
	%endm

; nie mozna zdefiniowac "stack" jako ".stack"



%endif  ; __2_NASM

