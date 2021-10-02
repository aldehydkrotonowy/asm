; Zalacznik do biblioteki, skladnia NASM

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

%ifndef __NASM_STD_BIBL
%define __NASM_STD_BIBL

%include	"bibl\incl\dosbios\nasm\n_skacz.inc"

%include	"bibl\incl\dosbios\nasm\n_const.inc"
%include	"bibl\incl\dosbios\nasm\n_pisz.inc"
%include	"bibl\incl\dosbios\nasm\n_wej.inc"
%include	"bibl\incl\dosbios\nasm\n_prcsor.inc"
%include	"bibl\incl\dosbios\nasm\n_losowe.inc"

%include	"bibl\incl\dosbios\nasm\n_f_pisz.inc"
%include	"bibl\incl\dosbios\nasm\n_dzwiek.inc"
%include	"bibl\incl\dosbios\nasm\n_f_wej.inc"
%include	"bibl\incl\dosbios\nasm\nfn_pisz.inc"
%include	"bibl\incl\dosbios\nasm\n_fn_wej.inc"

%include	"bibl\incl\dosbios\nasm\n_lanc.inc"
%include	"bibl\incl\dosbios\nasm\n_bcd.inc"


%endif		; __NASM_STD_BIBL

