;;
; Biblioteka Standardowa -
; Procedury pobierajace liczby w postaci ulamka dziesietnego.
; Procedury wymagaja koprocesora.
; Wersja Linux: 2004-02-04
; Ostatnia modyfikacja kodu: 2021-02-24
; <br><b>UWAGA:</b> W zwiazku z ograniczona precyzja dzialan na koprocesorze,
; nie wszystkie liczby moga byc przedstawiane z calkowita dokladnoscia.
; Jednakze zazwyczaj precyzja wynosi tyle cyfr po przecinku, ile miala
; liczba wprowadzona (z ewentualnym zaokragleniem).
; @author Bogdan 'bogdro' Drozdowski, bogdandr@op.pl (2002-09)
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

global	_f_we_32
global	_f_we_64
global	_f_we_80

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

extern	_koprocesor
extern	_we_z
extern	_czysc_klaw

%if (__DOS > 0) || (__BIOS > 0)
extern	_pisz_z
%endif

%if (__DOS > 0) || (__BIOS > 0)
 ; %include	"..\incl\dosbios\nasm\n_const.inc"
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 %if (__COFF == 0)
  segment         biblioteka_f_we
 %else
  segment         .text
 %endif
%else
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 section         .data
%endif

; **************************************

dziesiec	dw	10
status		dw	0
cyfra		db	0,0			; 2 razy dla "fild wp"

%define rozmiar_bufora 200h

_f_wej_bufor	times	rozmiar_bufora	db	0

stan_fpu	times	108	db	0

; **************************************

%if (__LINUX > 0) || (__BSD > 0)
section		.text
%endif

;;
; Pobiera z klawiatury liczbe ulamkowa o pojedynczej precyzji (32 bit) i
; zwraca ja w [ES:DI] / [EDI] / [RDI] (bufor musi miec rozmiar co najmniej 4 bajty).
; Makro: wed32.
; @param ES:DI / EDI / RDI - adres bufora dlugosci co najmniej 4 bajtow.
; @return [ES:DI] / [EDI] / [RDI] = wczytana liczba, lub zero w przypadku bledu
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu
;;
_f_we_32:
	push	bx
	mov	bl, 32

_f_32_start:

	pushf
	push	ax
%if (__KOD_16BIT > 0)
	push	ds

	mov	ax, biblioteka_f_we
	mov	ds, ax
%endif

	fsave	[stan_fpu]

	bibl_call	_koprocesor		; spr., czy jest koprocesor

	test	ax, ax
	jnz	._f_32_dalej

;	frstor [stan_fpu]

%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	ax
	popf
	stc				; blad, nie ma koprocesora
	pop	bx

	bibl_ret

._f_32_dalej:

	push	rej(si)
	push	cx


	finit				; st: (pusty)


	fldz				; st: 0
	fild	word [dziesiec]		; st: 10, 0


; ===============================================================


._f_32_poczatek:
	xor	bh, bh
	xor	rej(si), rej(si)
	xor	cx, cx

	bibl_call	_we_z			; pobierz znak

	cmp	al, lf			; czy Enter?
	je	._f_32_juz		; jesli tak, to wychodzimy

	cmp	al, cr
	je	._f_32_juz

%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp		; czy BackSpace?
	je	._f_32_poczatek

	bibl_call	_pisz_z
%endif
	cmp	al, spc
	je	._f_32_poczatek		; przepuszczamy spacje

	cmp	al, '.'			; czy kropka?
	jne	._f_spr_14
	mov	[_f_wej_bufor], al
	inc	rej(si)
	jmp	._f_32_przec

._f_spr_14:
	cmp	al, ','			; czy przecinek?
	jne	._f_spr_15
	mov	[_f_wej_bufor], al
	inc	rej(si)
	jmp	._f_32_przec

._f_spr_15:
	cmp	al, '+'			; czy plus?
	jne	._f_spr_7
	xor	bh, bh			; znacznik
	mov	[_f_wej_bufor], al
	inc	rej(si)

	jmp	short ._f_32_ok

._f_spr_7:
	cmp	al, '-'			; czy minus?
	jne	._f_32_pocz
	inc	bh			; znacznik
	mov	[_f_wej_bufor], al
	inc	rej(si)
	jmp	short ._f_32_ok

._f_32_pocz:				; jesli znak wpisany jest < '0'
					; lub > '9' to blad
	cmp	al, '0'
	jnb	._f_spr_1
	jmp	._f_32_blad

._f_spr_1:
	cmp	al, '9'
	jna	._f_spr_2
	jmp	._f_32_blad

._f_spr_2:

	and	al, 0fh

	mov	[_f_wej_bufor + rej(si)], al	; cyfra do bufora
	mov	[cyfra], al

	inc	rej(si)
	cmp	rej(si), rozmiar_bufora	; czy koniec bufora?
	jna	._f_spr_6
	jmp	._f_32_blad

._f_spr_6:

					; st: 10, liczba
;	fmulp	st1			; st: 10 * liczba
	fmul	st1, st0		; 10, liczba*10

;	fstsw	[status]		; spr., czy wystapil jakis wyjatek
;	mov	ax, [status]
%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h			; spr., czy over-/under-flow
	jz	.mulp_ok
	jmp	._f_32_blad
.mulp_ok:

	fild	word [cyfra]		; ladujemy ostatnia cyfre,
					; st: cyfra, 10, 10 * liczba

;	faddp	st1, st0		; st: liczba * 10 + cyfra
	faddp	st2, st0		; 10, liczba*10 + cyfra

;	fild	word [dziesiec]		; st: 10, nowa liczba




._f_32_ok:
	bibl_call	_we_z			; pobieramy kolejny znak

	cmp	al, lf			; czy Enter?
	je	._f_32_juz		; jesli tak, to wychodzimy

	cmp	al, cr
	je	._f_32_juz

%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp		; czy BackSpace?
	je	._f_32_bksp
	bibl_call	_pisz_z
%endif
	cmp	al, spc
	je	._f_32_ok		; przepuszczamy spacje

	cmp	al, '.'			; czy kropka?
	jne	._f_spr_3

	mov	[_f_wej_bufor + rej(si)], al
	inc	rej(si)
	jmp	._f_32_przec


._f_spr_3:
	cmp	al, ','			; czy przecinek?
	jne	._f_32_pocz
	mov	[_f_wej_bufor + rej(si)], al
	inc	rej(si)

	jmp	._f_32_przec

; ===============================================================

%if (__DOS > 0) || (__BIOS > 0)
._f_32_bksp:				; nacisnieto BackSpace
					; SI -> miejsce na kolejna cyfre
	test	rej(si), rej(si)
	jz	._bksp_pocz		; jesli si=0, to skasowalismy pierwsza
					; cyfre i poczatek

	mov	al, bksp
	bibl_call	_pisz_z
	mov	al, spc
	bibl_call	_pisz_z		; wypisz spacje
	mov	al, bksp		; wypisz backspace
	bibl_call	_pisz_z

					; SI -> ostatnia cyfra, +1 -> miejsce
					; na kolejna cyfre

					; st: 10, liczba

					; spr., czy ostatnia cyfra to nie
					; '+' ani '-' :

	mov	al, [_f_wej_bufor + rej(si) - 1]
					; czy skasowany znak to cyfra, czy
					; cos innego?

	cmp	al, 9
	jna	._f_spr_5
._bksp_pocz:

	fstp	st0
	fstp	st0			; st: (pusty)

	fldz				; st: 0
	fild	word [dziesiec]		; st: 10, 0

					; bo tak ma byc przy "f_32_poczatek"
					; ze wzgledu na fmul

	jmp	._f_32_poczatek		; pobieramy wszystko od nowa

._f_spr_5:

	dec	rej(si)
					; pobrac ostatnia cyfre (SI):
	mov	[cyfra], al
	fild	word [cyfra]
					; st: ost.cyfra, 10, liczba

					; odjac ja od liczby:
	fsubp	st2, st0
					; st: 10, liczba

					; i podzielic przez 10:
	fdivp	st1, st0
	fstsw	[status]		; spr., czy wystapil jakis wyjatek
	mov	ax, [status]

	and	al, 18h			; spr., czy over-/under-flow
	jz	.divp_ok
	jmp	._f_32_blad
.divp_ok:

					; st: liczba/10
	fild	word [dziesiec]
					; st: 10, nowa liczba

	test	rej(si), rej(si)
	jnz	._f_32_ok		; jesli si!=0, to _f_32_ok

					; jesli si=0, to _f_32_poczatek
	fstp	st0
	fstp	st0			; st: (pusty)

	fldz				; st: 0
	fild	word [dziesiec]		; st: 10, 0

					; bo tak ma byc przy "f_32_poczatek"
					; ze wzgl. na fmul

	jmp	._f_32_poczatek
%endif
; ===============================================================

._f_32_blad:				; st: 10, liczba

	fstp	st0
	fstp	st0

	fldz				; st: 0

._f_liczba_blad:			; zapisz zero ( blad ) w odpowiednim
					; formacie pod EDI
	cmp bl,64
	jb	._f_32_blad_st32
	ja	._f_32_blad_st80

%if (__KOD_16BIT > 0)
	fstp	qword [es:di]
%else
	fstp	qword [rej(di)]
%endif
	jmp	short ._f_32_blad_koniec

._f_32_blad_st32:
%if (__KOD_16BIT > 0)
	fstp	dword [es:di]
%else
	fstp	dword [rej(di)]
%endif
	jmp	short ._f_32_blad_koniec

._f_32_blad_st80:
%if (__KOD_16BIT > 0)
	fstp	tword [es:di]
%else
	fstp	tword [rej(di)]
%endif

._f_32_blad_koniec:

	frstor [stan_fpu]		; przywroc stan FPU

	pop	cx
	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif

	pop	ax

	bibl_call	_czysc_klaw

	popf
	stc				; zwroc blad

	pop	bx

	bibl_ret

; ===============================================================


._f_32_juz:

	fclex				; czyscimy wyjatki
	fstp	st0			; usuwamy st(0)=10,  st: liczba
	test	bh, bh
	jz	._f_liczba_ok		; spr, czy wpisano minus
	fchs

._f_liczba_ok:				; zapisz liczbe w odpowiednim
					; formacie pod EDI
	cmp	bl, 64
	jb	._f_32_st32
	ja	._f_32_st80

%if (__KOD_16BIT > 0)
	fstp	qword [es:di]		; <=
%else
	fstp	qword [rej(di)]		; <=
%endif
;	fstsw	[status]		;spr., czy wystapil jakis wyjatek
;	mov	ax, [status]
%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h			; spr., czy over-/under-flow
	jz	._f_32_koniec		; jesli nie, to wychodzimy normalnie


	frstor [stan_fpu]		; przywroc stan FPU

	pop	cx
	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	ax
	popf
	stc				; zwroc blad
	pop	bx

	bibl_ret



._f_32_st32:
%if (__KOD_16BIT > 0)
	fstp	dword [es:di]		; <=
%else
	fstp	dword [rej(di)]		; <=
%endif

;	fstsw	[status]		;spr., czy wystapil jakis wyjatek
;	mov	ax, [status]
%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h			; spr., czy over-/under-flow
	jz	._f_32_koniec		; jesli nie, to wychodzimy normalnie


	frstor	[stan_fpu]		; przywroc stan FPU

	pop	cx
	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	ax
	popf
	stc				; zwroc blad
	pop	bx

	bibl_ret


._f_32_st80:
%if (__KOD_16BIT > 0)
	fstp	tword [es:di]		; <=
%else
	fstp	tword [rej(di)]		; <=
%endif
;	fstsw	[status]		;spr., czy wystspil jakis wyjatek
;	mov	ax, [status]
%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h			; spr., czy over-/under-flow
	jz	._f_32_koniec		; jesli nie, to wychodzimy normalnie

	frstor	[stan_fpu]		; przywroc stan FPU

	pop	cx
	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	ax
	popf
	stc				; zwroc blad
	pop	bx

	bibl_ret



._f_32_koniec:
					; st: (pusty)

	frstor	[stan_fpu]		; przywroc stan FPU

	pop	cx
	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	ax
	popf
	clc				; zwroc brak bledu
	pop	bx

	bibl_ret


; ===============================================================

._f_32_przec:
					; st: 10, liczba
	xor	cx, cx
					;nie akceptowac kropki, przecinka, +, -
					;pobierac cyfry tylko do bufora,

._f_32_przec_we:			; wcisnieto '.' lub ','
	bibl_call	_we_z			; pobierz znak

	cmp	al,lf			; czy Enter?
	je	._f_32_przec_juz	; jesli tak, to wyjscie

	cmp	al, cr
	je	._f_32_przec_juz

%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp		; czy BackSpace?
	je	._f_32_przec_bksp

	bibl_call	_pisz_z
%endif
	cmp	al, spc
	je	._f_32_przec_we		; przepuszczamy spacje

	cmp	al, '0'			; blad, jesli nie wczytalismy cyfry
	jb	._f_32_blad

	cmp	al, '9'
	ja	._f_32_blad

	and	al, 0fh			; AL = wartosc cyfry
	inc	cl			; licznik cyfr po przecinku

	mov	[_f_wej_bufor + rej(si)],al	; cyfra do bufora
	inc	rej(si)
	cmp	rej(si), rozmiar_bufora	; czy koniec bufora?

	ja	._f_32_blad

	jmp	short ._f_32_przec_we

._f_32_przec_juz:
					; st: 10, liczba

					; po Enterze odczytywac cyfry
					; do st(0) wstecz,
					; dzielac kazdorazowo przez 10
					; az do znalezienia kropki/przecinka
					; wtedy dodajemy ulamek do liczby i
					; idziemy do f_32_juz

	fldz			; st: 0 (pozniej "stary ulamek"), 10, liczba

					; SI-1  -> ostatnia cyfra w buforze
._f_32_przec_juz2:

	cmp	byte [_f_wej_bufor + rej(si) - 1], 9
	jna	._f_przec_dalej

	faddp	st2, st0		; st: 10, liczba+ulamek
	jmp	._f_32_juz

._f_przec_dalej:
					; st: stary ulamek, 10, liczba
	mov	al, [_f_wej_bufor + rej(si) - 1]
	mov	[cyfra], al

	fild	word [cyfra]	; st: ostatnia cyfra, stary ulamek, 10, liczba

	faddp	st1, st0	; st: nowa "liczba mieszana", 10, liczba

	fdiv	st0, st1	; st: nowa "liczba mieszana"/10 = nowy ulamek,
				; 10, liczba

;	fstsw	[status]		; spr., czy wystapil jakis wyjatek
;	mov	ax, [status]
%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h			; spr., czy over-/under-flow
	jnz	._f_32_blad

	dec	rej(si)
	jmp	short ._f_32_przec_juz2


%if (__DOS > 0) || (__BIOS > 0)
._f_32_przec_bksp:
					; bksp = dec si
					; spr., czy [si] to kropka/przecinek
					; jesli tak, to _f_32_ok
					; jesli nie, to _f_32_przec
	dec	cl

					; wypisz bksp, spacje i bksp
	mov	al, bksp
	bibl_call	_pisz_z
	mov	al, spc
	bibl_call	_pisz_z
	mov	al, bksp
	bibl_call	_pisz_z

	test	rej(si), rej(si)
	jnz	._przec_bksp_dalej

	jmp	._f_32_poczatek
._przec_bksp_dalej:
	dec	rej(si)
	cmp	byte [_f_wej_bufor + rej(si)], 9
						; jesli usunelismy przecinek,
						; to wczytujemy dalej cyfry

	jna	._f_spr_9			; jesli nie, to wczyt. cyfry
						; po przecinku
	jmp	._f_32_ok
._f_spr_9:
	jmp	._f_32_przec_we
%endif

; **************************************

;;
; Pobiera z klawiatury liczbe ulamkowa o podwojnej precyzji (64 bit) i
; zwraca ja w [ES:DI] / [EDI] / [RDI] (bufor musi miec rozmiar co najmniej 8 bajtow).
; Makro: wed64.
; @param ES:DI / EDI / RDI - adres bufora dlugosci co najmniej 8 bajtow.
; @return [ES:DI] / [EDI] / [RDI] = wczytana liczba, lub zero w przypadku bledu
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu
;;
_f_we_64:
	push	bx
	mov	bl, 64
	jmp	_f_32_start


; **************************************

;;
; Pobiera z klawiatury liczbe ulamkowa o rozszerzonej precyzji (80 bit) i
; zwraca ja w [ES:DI] / [EDI] / [RDI] (bufor musi miec rozmiar co najmniej 10 bajtow).
; Makro: wed80.
; @param ES:DI / EDI / RDI - adres bufora dlugosci co najmniej 10 bajtow.
; @return [ES:DI] / [EDI] / [RDI] = wczytana liczba, lub zero w przypadku bledu
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu
;;
_f_we_80:
	push	bx
	mov	bl, 80
	jmp	_f_32_start
