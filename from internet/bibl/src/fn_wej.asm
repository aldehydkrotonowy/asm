;;
; Biblioteka Standardowa -
; Procedury pobierajace liczby w postaci ulamka dziesietnego,
; w postaci wykladniczej.
; Procedury wymagaja koprocesora.
; Wersja Linux: 2004-02-04
; Ostatnia modyfikacja kodu: 2021-02-24
; <br><b>UWAGA:</b> W zwiazku z ograniczona precyzja dzialan na koprocesorze,
; nie wszystkie liczby moga byc przedstawiane z calkowita dokladnoscia.
; Jednakze zazwyczaj precyzja wynosi tyle cyfr po przecinku, ile miala
; liczba wprowadzona (z ewentualnym zaokragleniem).
; @author Bogdan 'bogdro' Drozdowski, bogdandr@op.pl (2003-02)
;;


; Copyright (C) 2003-2021 Bogdan 'bogdro' Drozdowski, bogdandr @ op . pl
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

global	_fn_we_32
global	_fn_we_64
global	_fn_we_80

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
  segment         biblioteka_fn_we
 %else
  segment         .text
 %endif
%else
 %include	"../incl/linuxbsd/nasm/n_const.inc"
 section         .data
%endif

; **************************************

dziesiec	dw	10
%if (__DOS > 0) || (__BIOS > 0)
status		dw	0
%endif
cyfra		db	0,0			; 2 razy dla "fild wp"

%define rozmiar_bufora 200h

_fn_wej_bufor	times	rozmiar_bufora	db	0

stan_fpu	times	108	db	0

; **************************************

%if (__LINUX > 0) || (__BSD > 0)
section		.text
%endif

;;
; Pobiera z klawiatury liczbe ulamkowa o pojedynczej precyzji (32 bit)
; i zwraca ja w [ES:DI] / [EDI] / [RDI] (bufor musi miec rozmiar co najmniej 4 bajtow).
; Liczba moze byc w postaci naukowej (wykladniczej).
; Makro: wed32n.
; @param ES:DI / EDI / RDI - adres bufora dlugosci co najmniej 4 bajtow.
; @return [ES:DI] / [EDI] / [RDI] = wczytana liczba, lub zero w przypadku bledu
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu
;;
_fn_we_32:
	push	bx
	mov	bl, 32
_fn_32_start:

	pushf
	push	rej(ax)
%if (__KOD_16BIT > 0)
	push	ds

	mov	ax, biblioteka_fn_we
	mov	ds, ax
%endif
	fsave	[stan_fpu]

	bibl_call	_koprocesor		; spr., czy jest koprocesor

	test	ax, ax
	jnz	._fn_32_dalej

;	frstor [stan_fpu]

%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(ax)
	popf
	stc				;blad, nie ma koprocesora
	pop	bx

	bibl_ret

._fn_32_dalej:

	push	rej(si)
	push	cx

	finit				; st: (pusty)

	fldz				; st: 0
	fild	word [dziesiec]		; st: 10, 0

; ===============================================================
; poczatek wprowadzania danych
; ===============================================================


._fn_32_poczatek:
	bibl_call	_we_z			; pobierz znak

	xor	bh, bh
	xor	si, si
	xor	cx, cx

	cmp	al, lf			; czy Enter?
	je	._fn_32_juz		; jesli tak, to wychodzimy

	cmp	al, cr
	je	._fn_32_juz

%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp		; czy BackSpace?
	je	._fn_32_poczatek

	bibl_call	_pisz_z
%endif
	cmp	al, spc
	je	._fn_32_poczatek	; przepuszczamy spacje

; ===============================================================
; sprawdzanie rodzaju wprowadzonego znaku
; ===============================================================

	cmp	al, '.'			; czy kropka?
	jne	._fn_spr_14
	mov	[_fn_wej_bufor], al
	inc	rej(si)
	jmp	._fn_32_przec

._fn_spr_14:
	cmp	al, ','			; czy przecinek?
	jne	._fn_spr_15
	mov	[_fn_wej_bufor], al
	inc	rej(si)
	jmp	._fn_32_przec
._fn_spr_15:

	cmp	al, '+'			; czy plus?
	jne	._fn_spr_7
	xor	bh, bh			; znacznik
	mov	[_fn_wej_bufor], al
	inc	rej(si)

	jmp	short ._fn_32_ok

._fn_spr_7:
	cmp	al, '-'			; czy minus?
	jne	._fn_32_pocz
	inc	bh			; znacznik
	mov	[_fn_wej_bufor], al
	inc	rej(si)
	jmp	short ._fn_32_ok

._fn_32_pocz:				; jesli znak wpisany jest < '0'
					; lub > '9' to blad
	cmp	al, '0'
	jb	 ._fn_32_blad

	cmp	al, '9'
	ja	 ._fn_32_blad

	and	al, 0fh

	mov	[_fn_wej_bufor + rej(si)],al	; cyfra do bufora
	inc	rej(si)
	cmp	rej(si), rozmiar_bufora	; czy koniec bufora?
	mov	[cyfra], al

	ja	._fn_32_blad

; ===============================================================
; wprowadzono cyfre
; ===============================================================

	fclex				; czyscimy wyjatki
					; st: 10, liczba
;	fmulp	st1			; st: 10 * liczba
	fmul	st1, st0		; 10, liczba*10

%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h			; spr., czy over-/under-flow
	jnz	 ._fn_32_blad

	fild	word [cyfra]		; ladujemy ostatnia cyfre
					; st: cyfra, 10, 10 * liczba

;	faddp	st1, st0		; st: liczba * 10 + cyfra
	faddp	st2, st0		; 10, liczba*10 + cyfra


%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h
	jnz	 ._fn_32_blad


;	fild word [dziesiec]		; st: 10, nowa liczba

; ===============================================================
; czekamy na kolejny znak i sprawdzamy jego rodzaj
; ===============================================================

._fn_32_ok:
	bibl_call	_we_z			; pobierz kolejny znak

	cmp	al, lf			; czy Enter?
	je	._fn_32_juz		; jesli tak, to wychodzimy

	cmp	al, cr
	je	._fn_32_juz

%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp		; czy BackSpace?
	je	._fn_32_bksp
	bibl_call	_pisz_z
%endif

	cmp	al, spc
	je	._fn_32_ok		; przepuszczamy spacje

	cmp	al, '.'			; czy kropka?
	jne	._fn_spr_3

	mov	[_fn_wej_bufor + rej(si)], al
	inc	rej(si)
	jmp	._fn_32_przec


._fn_spr_3:
	cmp	al, ','			; czy przecinek?
	jne	._fn_spr_4
	mov	[_fn_wej_bufor + rej(si)], al
	inc	rej(si)

	jmp	._fn_32_przec

._fn_spr_4:
	cmp	al, 'e'			; czy pobierac wykladnik?
	jne	._fn_spr_16
	mov	[_fn_wej_bufor + rej(si)], al
	inc	rej(si)

	jmp	._fn_wykl

._fn_spr_16:
	cmp	al, 'E'			; czy pobierac wykladnik?
	jne	._fn_32_pocz
	mov	[_fn_wej_bufor + rej(si)], al
	inc	rej(si)

	jmp	._fn_wykl


; ===============================================================
; glowny BackSpace
; ===============================================================

%if (__DOS > 0) || (__BIOS > 0)
._fn_32_bksp:
					; SI -> miejsce na kolejna cyfre
	test	rej(si), rej(si)
	jz	._bksp_pocz		; jesli si=0, to skasowalismy
					; pierwsza cyfre i poczatek


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

	mov	al, [_fn_wej_bufor + rej(si) - 1]
	cmp	al, 9				; czy skasowany znak to
						; cyfra, czy cos innego?
	jna	._fn_spr_5
._bksp_pocz:

	fstp	st0
	fstp	st0			; st: (pusty)

	fldz				; st: 0
	fild	word [dziesiec]		; st: 10, 0

					; bo tak ma byc przy "f_32_poczatek"
					; ze wzgl. na fmul

	jmp	._fn_32_poczatek	; pobieramy wszystko od nowa

._fn_spr_5:

	dec	rej(si)
					; pobrac ostatnia cyfre (si):
	mov	[cyfra], al
	fild	word [cyfra]
					; st: ost.cyfra, 10, liczba

					; odjac ja od liczby:
	fsubp	st2, st0
					; (st: 10, liczba)

					; i podzielic przez 10:
	fdivp	st1, st0		; (nie moze wystapic wyjatek)

					; st: liczba/10
	fild	word [dziesiec]
					; st: 10, nowa liczba

	test	rej(si), rej(si)
;	jnz	._fn_32_ok		; jesli si!=0, to _fn_32_ok
	jz	.bksp_dalej
	jmp	._fn_32_ok
.bksp_dalej:

					; jesli si=0, to _fn_32_poczatek
	fstp	st0
	fstp	st0			; st: (pusty)

	fldz				; st: 0
	fild	word [dziesiec]		; st: 10, 0

					; bo tak ma byc przy "f_32_poczatek"
					; ze wzgl. na fmul

	jmp	._fn_32_poczatek
%endif

; ===============================================================
; koniec, wyjscie z bledem
; ===============================================================


._fn_32_blad:				; st: 10, liczba

	fstp	st0
	fstp	st0

	fldz				; st: 0

._fn_liczba_blad:			; zapisz zero ( blad ) w odpowiednim
					; formacie pod EDI
	cmp	bl, 64
	jb	._fn_32_blad_st32
	ja	._fn_32_blad_st80

%if (__KOD_16BIT > 0)
	fstp	qword [es:di]
%else
	fstp	qword [rej(di)]
%endif
	jmp	short ._fn_32_blad_koniec

._fn_32_blad_st32:
%if (__KOD_16BIT > 0)
	fstp	dword [es:di]
%else
	fstp	dword [rej(di)]
%endif
	jmp	short ._fn_32_blad_koniec

._fn_32_blad_st80:
%if (__KOD_16BIT > 0)
	fstp	tword [es:di]
%else
	fstp	tword [rej(di)]
%endif

._fn_32_blad_koniec:


	frstor [stan_fpu]		; przywroc stan FPU

	pop	cx
	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(ax)

	bibl_call	_czysc_klaw		; czysci bufor klawiatury

	popf
	stc				; zwroc blad
	pop	bx

	bibl_ret

; ===============================================================
; koniec, wyjscie bez bledu
; ===============================================================

._fn_32_juz:

	fclex				; resetujemy wyjatki
	fstp	st0			; usuwamy st(0)=10,  st: liczba
	test	bh, bh
	jz	._fn_liczba_ok
	fchs

._fn_liczba_ok:				; zapisz liczbe w odpowiednim
					; formacie pod EDI
	cmp	bl, 64
	jb	._fn_32_st32
	ja	._fn_32_st80

%if (__KOD_16BIT > 0)
	fstp	qword [es:di]		; <=
%else
	fstp	qword [rej(di)]		; <=
%endif

%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h			; czy przepelnienie?
	jz	._fn_32_koniec		; jesli nie, to wyjdz normalnie

	fldz
%if (__KOD_16BIT > 0)
	fstp	qword [es:di]		; zapisujemy 0.0
%else
	fstp	qword [rej(di)]		; zapisujemy 0.0
%endif

	frstor	[stan_fpu]		; przywroc stan FPU

	pop	cx
	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(ax)
	popf
	stc				; zwroc blad
	pop	bx

	bibl_ret

._fn_32_st32:
%if (__KOD_16BIT > 0)
	fstp	dword [es:di]		; <=
%else
	fstp	dword [rej(di)]		; <=
%endif

%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h			; czy przepelnienie?
	jz	._fn_32_koniec		; jesli nie, to wyjdz normalnie


	fldz
%if (__KOD_16BIT > 0)
	fstp	dword [es:di]		; zapisujemy 0.0
%else
	fstp	dword [rej(di)]		; zapisujemy 0.0
%endif


	frstor	[stan_fpu]		; przywroc stan FPU

	pop	cx
	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(ax)
	popf
	stc				; zwroc blad
	pop	bx

	bibl_ret

._fn_32_st80:
%if (__KOD_16BIT > 0)
	fstp	tword [es:di]		; <=
%else
	fstp	tword [rej(di)]		; <=
%endif

%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h			; czy przepelnienie?
	jz	._fn_32_koniec		; jesli nie, to wyjdz normalnie


	fldz
%if (__KOD_16BIT > 0)
	fstp	tword [es:di]		; zapisz 0.0
%else
	fstp	tword [rej(di)]		; zapisz 0.0
%endif


	frstor	[stan_fpu]		; przywroc stan FPU

	pop	cx
	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(ax)
	popf
	stc				; zwroc blad
	pop	bx

	bibl_ret

._fn_32_koniec:				; "normalne" wyjscie

	frstor	[stan_fpu]		; przywroc stan FPU

	pop	cx
	pop	rej(si)
%if (__KOD_16BIT > 0)
	pop	ds
%endif
	pop	rej(ax)
	popf
	clc				; zwroc brak bledu
	pop	bx

	bibl_ret

; ===============================================================
; wprowadzanie czesci ulamkowej
; ===============================================================

._fn_32_przec:
					; st: 10, liczba
	xor	cx, cx
					; nie akceptowac kropki, przecinka, +, -
					; pobierac cyfry tylko do bufora,

._fn_32_przec_we:			; wcisnieto '.' lub ','

	bibl_call	_we_z			; poboerz nowy znak

	cmp	al, lf			; czy Enter?
	je	._fn_32_przec_juz

	cmp	al, cr
	je	._fn_32_przec_juz

%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp		; czy BackSpace?
	je	._fn_32_przec_bksp
	bibl_call	_pisz_z
%endif

	cmp	al, spc
	je	._fn_32_przec_we	; przepuszczamy spacje

	cmp	al, 'e'
	jne	._fn_spr_18
	mov	[_fn_wej_bufor + rej(si)], al
	inc	rej(si)

	jmp	._fn_wykl

._fn_spr_18:
	cmp	al, 'E'
	jne	._fn_spr_19
	mov	[_fn_wej_bufor + rej(si)], al
	inc	rej(si)

	jmp	._fn_wykl

._fn_spr_19:
	cmp	al, '0'			; blad, jesli nie wczytalismy cyfry
	jb	._fn_32_blad

	cmp	al, '9'
	ja	._fn_32_blad

	and	al, 0fh

	mov	[_fn_wej_bufor + rej(si)], al	; cyfra do bufora
	inc	rej(si)

	inc	cl			; licznik cyfr po przecinku

	cmp	rej(si), rozmiar_bufora	; czy koniec bufora?
	ja	 ._fn_32_blad

	jmp	short ._fn_32_przec_we


._fn_32_przec_juz:
					; st: 10, liczba

					; po Enterze odczytywac cyfry
					; do st(0) wstecz,
					; dzielic kazdorazowo przez 10
					; az do znalezienia kropki/przecinka
					; wtedy dodajemy ulamek do liczby i
					; f_32_juz

	fldz				; st: 0 (pozniej "stary ulamek"),
					; 10, liczba

					; SI-1  -> ostatnia cyfra w buforze
._fn_32_przec_juz2:

	cmp	byte [_fn_wej_bufor + rej(si) - 1], 9
	jna	._fn_przec_dalej

	faddp	st2, st0		; st: 10, liczba+ulamek
	jmp	._fn_32_juz		;<<wyjscie po dodaniu liczby calkowitej

._fn_przec_dalej:
					; st: stary ulamek, 10, liczba
	mov	al,[_fn_wej_bufor + rej(si) - 1]
	mov	[cyfra], al

	fild	word [cyfra]	; st: ostatnia cyfra, stary ulamek, 10, liczba

	faddp	st1, st0	; st: nowa "liczba mieszana", 10, liczba

	fdiv	st0, st1	; st: nowa "liczba mieszana"/10 = nowy ulamek,
				; 10, liczba

%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h
	jnz	._fn_32_blad

	dec	rej(si)
	jmp	short ._fn_32_przec_juz2


; ===============================================================
; BackSpace po przecinku
; ===============================================================

%if (__DOS > 0) || (__BIOS > 0)
._fn_32_przec_bksp:
					; bksp = dec si
					; spr., czy [si] to kropka/przecinek
					; jesli tak, to _fn_32_ok
					; jesli nie, to _fn_32_przec
	dec	cl

					; wypisz BkSp, Spacje i BkSp
	mov	al, bksp
	bibl_call	_pisz_z
	mov	al, spc
	bibl_call	_pisz_z
	mov	al, bksp
	bibl_call	_pisz_z

	test	rej(si), rej(si)
	jnz	._przec_bksp_dalej

	jmp	._fn_32_poczatek

._przec_bksp_dalej:
	dec	rej(si)
	cmp	byte [_fn_wej_bufor + rej(si)], 9
						; jesli usunelismy przecinek,
						; to wczytujemy dalej cyfry
	jna	._fn_spr_9			; jesli nie, to wczyt. cyfry
						; po przecinku
	jmp	._fn_32_ok

._fn_spr_9:
	jmp	._fn_32_przec_we
%endif

; ===============================================================
; wprowadzanie wykladnika
; ===============================================================

._fn_wykl:
				; st: 10, 0


	push	bx
	push	dx

	xor	bx, bx

.lz_pocz:
	bibl_call	_we_z		; pobierz znak

	xor	dx, dx

	cmp	al,lf		; czy Enter?
	je	.lz_juz		; jesli tak, to wychodzimy

	cmp	al, cr
	je	.lz_juz

%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp		; czy BackSpace?
	je	.lz_bksp1

	bibl_call	_pisz_z
%endif
	cmp	al, spc
	je	.lz_pocz	; przepuszczamy spacje

	cmp	al, '-'
	jne	.lz_dalej1
;	mov	[_fn_wej_bufor], al	; minus do bufora
;	inc	si		; zwieksz licznik cyfr
	inc	dh		; znacznik, ze wpisano minus
	jmp	.lz_ok


; ===============================================================
; BackSpace wykladnika
; ===============================================================

%if (__DOS > 0) || (__BIOS > 0)
.lz_bksp1:
	dec	rej(si)
					; SI -> ostatnia cyfra
					; wypisz bksp, spacje i bksp
	mov	al, bksp
	bibl_call	_pisz_z
	mov	al, spc
	bibl_call	_pisz_z
	mov	al, bksp
	bibl_call	_pisz_z


.lz_bksp1_2:
					; jesli skasowalismy cyfre, to
					; "lz_bksp1_dalej"

					; jesli skasowalismy 'e' lub 'E', to:
					; - jesli byl przecinek, to
					;       "_fn_32_przec_we"
					; - jesli nie, to "_fn_32_ok"

					; jesli skasowalismy znak + lub -,
					; to "lz_pocz"


	cmp	byte [_fn_wej_bufor + rej(si)],9
						; czy cyfra?
	jna	.lz_bksp1_dalej			; jesli tak

	cmp	byte [_fn_wej_bufor + rej(si)],'-'
						; czy minus?
	je	.lz_pocz			; jesli tak

	cmp	byte [_fn_wej_bufor + rej(si)],'+'
						; czy plus?
	je	.lz_pocz			; jesli tak

					; zostalo juz tylko 'e' lub 'E',
					; szukamy przecinka/kropki
	mov	rej(ax), rej(si)	; zachowujemy biezaca pozycje
.szuk_przec:
	cmp	byte [_fn_wej_bufor + rej(si)], '.'
	je	.jest_przec
	cmp	byte [_fn_wej_bufor + rej(si)], ','
	je	.jest_przec

	dec	si
	jnz	.szuk_przec
					; nie ma przecinka
	mov	rej(si), rej(ax)	; przywracamy SI
	pop	dx
	pop	bx
	jmp	._fn_32_ok		; wracamy do wprowadzania cyfr liczby

.jest_przec:
	mov	rej(si), rej(ax)
	pop	dx
	pop	bx
	jmp	._fn_32_przec_we	; wracamy do wprowadzania cyfr po
					; przecinku

.lz_bksp1_dalej:
	xor	ah, ah
	mov	al, [_fn_wej_bufor + rej(si)]
					; pobierz ostatnia cyfre
	sub	bx, ax			; odejmij ostatnia cyfre od liczby
	mov	ax, bx
	mov	bl, 10
	div	bl			; dzielimy liczbe przez 10
	mov	bx, ax

					; relacje kodow ASCII
					; '+'   <   ','   <   '-'   <   '.'

					; jesli znak poprzedzajacy skasowana
					; cyfre > '.', tzn. 'e'
					; to "lz_pocz", jesli nie, to "lz_ok"

	cmp	byte [_fn_wej_bufor + rej(si) - 1], '.'
	ja	.lz_pocz
	jmp	short .lz_ok
%endif

; ===============================================================
; sprawdzanie rodzaju znaku, ciag dalszy
; ===============================================================

.lz_dalej1:
	cmp	al, '+'
	jne	.lz_petla
;	mov	[_fn_wej_bufor], al	; plus do bufora
;	inc	si		; zwieksz licznik cyfr
	jmp	short .lz_ok

.lz_petla:
	cmp	al, '0'		; sprawdzamy, czy AL to cyfra
	jb	.lz_blad
	cmp	al, '9'
	ja	.lz_blad
	and	al, 0fh		; izolujemy wartosc

	mov	dl, al
;	mov	[_fn_wej_bufor+si],al	;cyfra do bufora
;	inc	si		; zwieksz licznik wpisanych cyfr

	mov	ax, bx		; robimy miejsce:
	shl	bx, 1
	jc	.lz_blad

	shl	ax, 1
	jc	.lz_blad
	shl	ax, 1
	jc	.lz_blad
	shl	ax, 1
	jc	.lz_blad
	add	bx, ax		; BX=BX*10 - stara liczbe mnozymy przez 10
	jc	.lz_blad

	add	bl, dl		; dodajemy cyfre
	adc	bh, 0
	jc	.lz_blad	; jesli liczba zbyt duza - blad
.lz_ok:
	bibl_call	_we_z		; pobierz nowy znak

	cmp	al, lf		; czy Enter?
	je	.lz_juz		; jesli tak, to wychodzimy

	cmp	al, cr
	je	.lz_juz

%if (__DOS > 0) || (__BIOS > 0)
	cmp	al, bksp		; czy BkSp?
	jne	.lz_nie_bksp
	jmp	.lz_bksp1
.lz_nie_bksp:

	bibl_call	_pisz_z
%endif
	cmp	al, spc
	je	.lz_ok		; przepuszczamy spacje

	jmp	short .lz_petla


; ===============================================================
; koniec, wyjscie z bledem
; ===============================================================

.lz_blad:
	pop	dx
	pop	bx
	jmp	._fn_32_blad	; nic poza tym nie jest potrzebne


; ===============================================================
; wyliczenie liczby
; ===============================================================


.lz_juz:
				; -4932, -308, -38 <  BX  < 38, 308, 4932

	cmp	bx, 4932
	ja	.lz_blad			; nie "jg"


	inc	rej(si)
.wyrzuc_e_plus:
	dec	rej(si)
	cmp	byte [_fn_wej_bufor + rej(si)],'e'	; ustawimy SI tuz przed 'e'/'E'
	jb	.wyrzuc_e_plus
						; SI -> 'e'

; ===============================================================

	push	rej(di)
	mov	rej(di), rej(si)	; zachowujemy biezaca pozycje

.lzp_szuk_przec:
	cmp	byte [_fn_wej_bufor + rej(si)], '.'
	je	.lzp_jest_przec
	cmp	byte [_fn_wej_bufor + rej(si)], ','
	je	.lzp_jest_przec

	dec	rej(si)
	jnz	.lzp_szuk_przec
					; nie ma przecinka
	mov	rej(si), rej(di)
	pop	rej(di)

.lzp_konczymy:				; <--- prawdziwy koniec
					; DH=0 czy DH!=0
	test	bx, bx
	jz	.lzp_wyjscie
					; st: 10, liczba
	test	dh, dh
	jz	.mnoz			; DH=0 - wykladnik dodatni

					; wykladnik ujemny
	fdiv	st1, st0		; st: 10, liczba/10
	jmp	short .mnoz_juz
.mnoz:
	fmul	st1, st0		; st: 10, 10*liczba

.mnoz_juz:

%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h			; czy przepelnienie?
	jnz	._fn_32_blad		; jesli tak, to blad

	dec	bx
	jmp	short .lzp_konczymy


.lzp_wyjscie:				; <--- koniec prawdziwego konca

	pop	dx
	pop	bx			; bh - znak liczby, bl - typ liczby

	jmp	._fn_32_juz		; zwrocic st: 10, liczba



; ===============================================================


.lzp_jest_przec:			; st: 10, liczba

	mov	rej(si), rej(di)
	pop	rej(di)

	fldz			; st: 0 (pozniej "stary ulamek"), 10, liczba
					; SI-1  -> ostatnia cyfra w buforze
._fn_32_lp_przec_juz2:

	cmp	byte [_fn_wej_bufor + rej(si) - 1], 9	; czy poprzednim znakiem
						; jest przecinek?
	jna	._fn_lp_przec_dalej

	faddp	st2, st0		; st: 10, liczba+ulamek
	jmp	short .lzp_konczymy	;<<wyjscie po dodaniu liczby calkowitej

._fn_lp_przec_dalej:
					; st: stary ulamek, 10, liczba
	mov	al, [_fn_wej_bufor + rej(si) - 1]
	mov	[cyfra], al

	fild	word [cyfra]	; st: ostatnia cyfra, stary ulamek, 10, liczba

	faddp	st1, st0	; st: nowa "liczba mieszana", 10, liczba

	fdiv	st0, st1	; st: nowa "liczba mieszana"/10 = nowy ulamek,
				; 10, liczba

%if (__DOS > 0) || (__BIOS > 0)
	fstsw	[status]
	mov	ax, [status]
%else
	fstsw	ax
%endif

	and	al, 18h			; czy overflow lub underflow?
	jnz	._fn_32_blad

	dec	rej(si)
	jmp	short ._fn_32_lp_przec_juz2




; **************************************

;;
; Pobiera z klawiatury liczbe ulamkowa o podwojnej precyzji (64 bit)
; i zwraca ja w [ES:DI] / [EDI] / [RDI] (bufor musi miec rozmiar co najmniej 8 bajtow).
; Liczba moze byc w postaci naukowej (wykladniczej).
; Makro: wed64n
; @param ES:DI / EDI / RDI - adres bufora dlugosci co najmniej 8 bajtow.
; @return [ES:DI] / [EDI] / [RDI] = wczytana liczba, lub zero w przypadku bledu
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu
;;
_fn_we_64:
	push	bx
	mov	bl, 64
	jmp	_fn_32_start


; **************************************

;;
; Pobiera z klawiatury liczbe ulamkowa o rozszerzonej precyzji (80 bit)
; i zwraca ja w [ES:DI] / [EDI] / [RDI] (bufor musi miec rozmiar co najmniej 10 bajtow).
; Liczba moze byc w postaci naukowej (wykladniczej).
; Makro: wed80n
; @param ES:DI / EDI / RDI - adres bufora dlugosci co najmniej 10 bajtow.
; @return [ES:DI] / [EDI] / [RDI] = wczytana liczba, lub zero w przypadku bledu
; @return CF=0 po udanej operacji, CF=1 w przypadku bledu
;;
_fn_we_80:
	push	bx
	mov	bl, 80
	jmp	_fn_32_start
