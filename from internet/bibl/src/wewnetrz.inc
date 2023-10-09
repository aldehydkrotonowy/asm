;;
; Biblioteka Standardowa -
; Makra przydatne w kodach wewnetrznych
; Ostatnia modyfikacja kodu: 2021-02-09
; @author Bogdan 'bogdro' Drozdowski, bogdandr@op.pl (2012-12)
;;


; Copyright (C) 2012-2021 Bogdan 'bogdro' Drozdowski, bogdandr @ op . pl
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

%ifndef __BIBL_WEWNETRZNY
%define __BIBL_WEWNETRZNY

%if ((__DOS > 0) || (__BIOS > 0)) && (__COFF == 0)
	%define __KOD_16BIT 1
	%define __KOD_32BIT 0
	%define __KOD_64BIT 0

	%define	rej(x) x
	%define	push_f	pushf
	%define	pop_f	popf
	bits 16
	cpu 8086
%else
 %if (__LINUX > 0) || (__BSD > 0)
  section .note.GNU-stack noalloc noexec nowrite progbits
 %endif
 %ifidn __OUTPUT_FORMAT__, elf64
	%define __KOD_16BIT 0
	%define __KOD_32BIT 0
	%define __KOD_64BIT 1

	%define rej(x) r%+ x
	%define	push_f	pushfq
	%define	pop_f	popfq
	bits 64
	cpu x64
 %else
	%define __KOD_16BIT 0
	%define __KOD_32BIT 1
	%define __KOD_64BIT 0

	%define rej(x) e%+ x
	%define	push_f	pushfd
	%define	pop_f	popfd
	bits 32
	cpu 386
 %endif
%endif

%macro bibl_call 1
 %if (__KOD_16BIT > 0)
	call	far %1
 %else
	call	%1
 %endif
%endm

%macro bibl_ret 0
 %if (__KOD_16BIT > 0)
	retf
 %else
	ret
 %endif
%endm


%endif		; __BIBL_WEWNETRZNY
