;;
; Biblioteka Standardowa -
; Wykrywanie rodzaju procesora i koprocesora.
; Wersja Linux: 2004-02-04
; Ostatnia modyfikacja kodu: 2021-02-26
; @author Bogdan 'bogdro' Drozdowski, bogdandr@op.pl (2002-08)
;;


; Copyright (C) 2002-2021 Bogdan 'bogdro' Drozdowski, bogdandr @ op . pl
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

global	_procesor
global	_koprocesor

%ifndef __DOS
 %error "Zdefiniuj '__DOS' na 1 albo 0, w zaleznosci od systemu."
%endif

%ifndef __BIOS
 %error "Zdefiniuj '__BIOS' na 1 albo 0, w zaleznosci od systemu."
%endif

%ifndef __LINUX
 %error "Zdefiniuj '__LINUX' na 1 albo 0, w zaleznosci od systemu."
%endif

%ifndef __BSD
 %error "Zdefiniuj '__BSD' na 1 albo 0, w zaleznosci od systemu."
%endif

%if ( (__DOS > 0) || (__BIOS > 0) ) && ( (__LINUX > 0) || (__BSD > 0) )
 %error "Zdefiniuj albo '__DOS' i/lub '__BIOS' na 1, albo '__LINUX' i/lub '__BSD' na 1, nie wszystkie."
%endif

%include "wewnetrz.inc"

%if (__DOS > 0) || (__BIOS > 0)
 ; %include	"..\incl\dosbios\nasm\n_const.inc"
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 %if (__COFF == 0)
  segment         biblioteka_procesor
 %else
  segment         .text
 %endif
%else
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 section         .data
%endif

; **************************************

_fpu_status     dw 0

; **************************************

%if (__LINUX > 0) || (__BSD > 0)
section		.text
%endif

;;
; Wykrywa rodzaj procesora.
; Makro: procesor
; @return AX = 86, 186, 286, 386, 486 lub 586, w zaleznosci od modelu.
;;
_procesor:
%if (__KOD_16BIT > 0)
	pushf
	push	bx
	push	cx
	push	dx

	push	ds
	push	es

	xor	ax, ax
	mov	bx, biblioteka_procesor
	mov	es, ax
	mov 	ds, bx

	les	bx, [es:6 << 2]

	mov	[_stare06+2], es
	mov	[_stare06], bx

	mov	es, ax
	mov	word [es:(6 << 2)], moje06
	mov	word [es:(6 << 2) + 2], biblioteka_procesor


;8088: zmniejsza SP przed umieszczeniem na stosie, reszta procesorow - po

	mov	bx, 88			; znacznik
	mov	ax, sp
	push	sp
	pop	cx
	xor	ax, cx
	jz	.procesor_ok
	jmp	.procesor_juz
.procesor_ok:

;8086: bity 12-15 flag zawsze=1

	mov	bx, 86
	pushf
	pop	ax
	and	ax, 0fffh		; czyscimy bity 12-15
	push	ax
	popf
	pushf
	pop	ax
	and	ax, 0f000h
	cmp	ax, 0f000h		; jesli ustawione, to 8086
	jnz	.spr_186

	mov	ax, 1
	db	0c1h, 0e2h, 5		; shl dx,5
	or	ax, ax
	jz	.procesor_juz

.spr_186:

;80186:

	mov	bx, 186
	mov	ax, 1
	db	0fh, 1, 0e2h		; smsw dx
	or	ax, ax
	jz	.procesor_juz

;80286: bity 12-15 flag zawsze=0

	mov	bx, 286
	pushf
	pop	ax
	or	ax, 0f000h		; ustawiamy bity 12-15
	push	ax
	popf
	pushf
	pop	ax
	and	ax, 0f000h		; jesli wyczyszczone, to 286
	jnz	.spr_386

	mov	ax, 1
	db	66h
	push	dx			; push edx
	db	0fh, 20h, 0c2h		; mov edx,cr0 (386+)
	db	66h
	pop	dx			; pop edx
	or	ax, ax
	jz	.procesor_juz

.spr_386:
%else
	push_f
	push	rej(bx)
	push	rej(cx)
	push	rej(dx)
%endif

%if (__KOD_16BIT > 0)
 cpu 386
%endif
;i386: nie mozna zmienic bitu 18 flag

	mov	bx, 386

	mov	rej(dx), rej(sp)
	and	rej(sp), ~3		; aby uniknac AC fault
	push_f
	pop	rej(ax)
	mov	ecx, eax
	xor	eax, 40000h
	push	rej(ax)
	pop_f
	push_f
	pop	rej(ax)

	; przywrocenie bitu AC:
	push_f
%if (__KOD_64BIT > 0)
	xor	dword [rsp], 40000h
%else
	xor	dword [esp], 40000h
%endif
	pop_f

	xor	eax, ecx
	mov	rej(sp), rej(dx)
	jz	.procesor_juz

.nie386:

;i486: mozna zmienic bit 18 flag
;486: nie mozna zmienic bitu 21 we flagach

	mov	bx, 486

	push_f
	pop	rej(ax)
	mov	ecx, eax
	xor	eax, 200000h
	push	rej(ax)
	pop_f
	push_f
	pop	rej(ax)
	xor	eax, ecx
	jz	.procesor_juz
	mov	bx, 586

.procesor_juz:

	mov	ax, bx

%if (__KOD_16BIT > 0)
	pop	es
	pop	ds
%endif

	pop	rej(dx)
	pop	rej(cx)
	pop	rej(bx)
	pop_f
	bibl_ret

%if (__KOD_16BIT > 0)
_stare06 dw 0,0,0

moje06:
	pop	ax
	add	ax, 3
	push	ax
	xor	ax, ax
	iret

%endif

; **************************************

;;
; Wykrywa rodzaj koprocesora.
; Makro: koprocesor
; @return AX = 0, 87, 287 lub 387, w zaleznosci od modelu (0 oznacza brak).
; @return Niszczy zawartosc rejestrow FPU.
;;
_koprocesor:
	pushf

%if (__KOD_16BIT > 0)
	push	ds

	mov	ax, biblioteka_procesor
	mov	ds, ax
%endif

	fninit

	mov	word [_fpu_status], 5a5ah	; niezerowe slowo statusu
	fnstsw	[_fpu_status]		; zapisz slowo statusowe, bez czekania
	mov	ax, [_fpu_status]
	or	al, al			; jesli zapisalo dobrze, to jest FPU
	jz	._status_ok

	xor	ax, ax

	jmp	short ._fpu_juz

._status_ok:
	fnstcw	[_fpu_status]		; zachowaj slowo kontrolne, bez czekania
	mov	ax, [_fpu_status]
	and	ax, 103fh			; wybrane czesci do sprawdzenia
	cmp	ax, 3fh
	jz	._kontrolne_ok

	xor	ax, ax

	jmp	short ._fpu_juz

._kontrolne_ok:
	and	word [_fpu_status], 0ff7fh
	fldcw	[_fpu_status]		; zaladuj slowo kontrolne, czekaj
	fdisi
	fstcw	[_fpu_status]		; zachowaj slowo kontrolne, czekaj
	test	byte [_fpu_status],80h
	jz	._f2i387

	mov	ax, 87
	jmp	short ._fpu_juz

._f2i387:
	finit

	fld1				; st(0)=1
	fldz				; st(0)=0,st(1)=1
	fdivp st1			; tworzymy nieskonczonosc
	fld st0				; st(1)=st(0)=niesk.
	fchs				; st(0)= -niesk.

	fcompp				; 8087/287: -niesk. == +niesk.
					; 387: -niesk. != +niesk.

	fstsw	[_fpu_status]
	mov	ax, [_fpu_status]
	sahf				; zapisz AH we flagach
	mov	ax, 287
	jz	._fpu_juz

	mov	ax, 387

._fpu_juz:

%if (__KOD_16BIT > 0)
	pop	ds
%endif
	popf
	bibl_ret
