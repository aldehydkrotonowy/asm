;;
; Biblioteka Standardowa -
; Operacje na lancuchach znakow.
; Ostatnia modyfikacja kodu: 2021-02-25
; @author Bogdan 'bogdro' Drozdowski, bogdandr@op.pl (2004-06)
;;


; Copyright (C) 2004-2021 Bogdan 'bogdro' Drozdowski, bogdandr @ op . pl
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

global	_lan_dlugosc
global	_lan_na_male
global	_lan_na_duze
global	_lan_porownaj
global	_lan_dl_porownaj

global	_lan_zcal
global	_lan_dl_zcal
global	_lan_znajdz
global	_lan_odwroc
global	_lan_policz

global	_lan_zamien

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
 %if (__COFF == 0)
  segment         biblioteka_lan
 %else
  segment         .text
 %endif
%else
 section	.text
%endif

; ***********************************************

;;
; Zwraca w dlugosc lancucha znakow (bez bajtu zerowego)
; wskazywanego przez DS:SI / ESI / RSI i zakonczonego bajtem zerowym.
; Makro: dlugosc.
; @param DS:SI / ESI / RSI - adres lancucha znakow
; @return AX / EAX / RAX - dlugosc lancuca znakow
;;
_lan_dlugosc:
	push_f
	push	rej(cx)
	push	rej(si)
	xor	rej(cx), rej(cx)

.szukaj:
	lodsb
	test	al, al			; sprawdz, czy nie zero
	jz	.juz

	inc	rej(cx)			; zwieksz licznik znakow
	jmp	short .szukaj		; i dalej

.juz:
	mov	rej(ax), rej(cx)	; xAX = dlugosc

	pop	rej(si)
	pop	rej(cx)
	pop_f
	bibl_ret

; ***********************************************

;;
; Zamienia wszystkie litery na male w lancuchu zakonczonym bajtem zerowym.
; Makro: na_male.
; @param DS:SI / ESI / RSI - adres lancucha znakow
;;
_lan_na_male:
	push_f
	push	rej(ax)
	push	rej(si)

	dec	rej(si)
.zamieniaj:
	inc	rej(si)			; przejdz na kolejny znak
	mov	al, [rej(si)]		; pobierz kolejny znak

	test	al, al			; sprawdz, czy nie koniec lancucha
	jz	.juz

				; jesli AL to nie wielka litera, nie rob nic
	cmp	al, 'A'
	jb	.zamieniaj
	cmp	al, 'Z'
	ja	.zamieniaj

	or	al, 20h			; zamien na mala
	mov	[rej(si)], al		; zapisz z powrotem

	jmp	short .zamieniaj	; i dalej

.juz:
	pop	rej(si)
	pop	rej(ax)
	pop_f
	bibl_ret

; ***********************************************

;;
; Zamienia wszystkie litery na wielkie w lancuchu zakonczonym bajtem zerowym.
; Makro: na_duze
; @param DS:SI / ESI / RSI - adres lancucha znakow
;;
_lan_na_duze:
	push_f
	push	rej(ax)
	push	rej(si)
	dec	rej(si)
.zamieniaj:
	inc	rej(si)			; przejdz na kolejny znak
	mov	al, [rej(si)]		; pobierz kolejny znak

	test	al, al			; sprawdz, czy nie koniec lancucha
	jz	.juz

				; jesli AL to nie mala litera, nie rob nic
	cmp	al, 'a'
	jb	.zamieniaj
	cmp	al, 'z'
	ja	.zamieniaj

	and	al, ~20h		; zamien na wielka
	mov	[rej(si)], al		; zapisz z powrotem

	jmp	short .zamieniaj	; i dalej

.juz:
	pop	rej(si)
	pop	rej(ax)
	pop_f
	bibl_ret

; ***********************************************

;;
; Porownuje 2 lancuchy znakow zakonczone bajtem zerowym.
; Makro: porownaj
; @param DS:SI / ESI / RSI - adres pierwszego lancucha.
; @param DS:DI / EDI / RDI - adres drugiego lancucha.
; @return AX / EAX / RAX = -1, 0, 1 (oraz odpowiednie flagi) gdy lancuch pierwszy jest
; odpowiednio: mniejszy, rowny lub wiekszy niz drugi (w sensie ASCII).
;;
_lan_porownaj:
	push	rej(bx)
	push	rej(di)
	push	rej(si)
	push_f
	xor	rej(bx), rej(bx)	; na poczatku zakladamy rownosc
.sprawdzaj:
	mov	al, [rej(si)]
	cmp	al, [rej(di)]		; porownaj znaki
	jne	.nie_rowne		; jesli nie rowne, to sprawdz jakie

	test	al, al
	jz	.spr_drugi		; gdy koniec lancucha 1
	cmp	byte [rej(di)], 0
	jz	.wiekszy1		; gdy koniec lancucha 2, a AL!=0

	inc	rej(si)			; sprawdzaj kolejne znaki
	inc	rej(di)
	jmp	short .sprawdzaj	; i dalej

.spr_drugi:
		; koniec pierwszego lancucha. jesli drugi ma jeszcze znaki,
		; to drugi jest wiekszy, a wiec pierwszy - mniejszy.
	cmp	byte [rej(di)], 0
	jne	.pierwszy_mniejszy
		; [SI]=0 i [DI]=0 => rowne
	jmp	short .juz

.nie_rowne:
	ja	.wiekszy1	; flagi byly zachowane, wiec mozemy sprawdzic
					; wynik porownania
.pierwszy_mniejszy:
	or	rej(bx), -1		; lancuch 1 (xSI) < lancuch 2 (xDI)
	jmp	short .juz

.wiekszy1:
	or	rej(bx), 1		; lancuch 1 (xSI) > lancuch 2 (xDI)

.juz:
	mov	rej(ax), rej(bx)
	pop_f
	cmp	rej(ax), 0		; ustawimy flagi

	pop	rej(si)
	pop	rej(di)
	pop	rej(bx)
	bibl_ret

; ***********************************************

;;
; Porownuje co najwyzej CX / ECX / RCX znakow z 2 lancuchow znakow zakonczonych
; bajtem zerowym.
; Makro: porownaj_dl
; @param CX / ECX / RCX - liczba bajtow do porownania.
; @param DS:SI / ESI / RSI - adres pierwszego lancucha.
; @param DS:DI / EDI / RDI - adres drugiego lancucha.
; @return AX / EAX / RAX = -1, 0, 1 (oraz odpowiednie flagi) gdy porownany fragment
; lancucha pierwszego jest odpowiednio: mniejszy, rowny lub wiekszy niz
; odpowiedni fragment lancucha drugiego (w sensie ASCII).
;;
_lan_dl_porownaj:
	push	rej(bx)
	push	rej(cx)
	push	rej(di)
	push	rej(si)
	push_f

	xor	rej(bx), rej(bx)	; na poczatku zakladamy rownosc
.sprawdzaj:
	mov	al, [rej(si)]
	cmp	al, [rej(di)]
	jne	.nie_rowne

	test	al, al
	jz	.spr_rown		; gdy koniec lancucha 1
	cmp	byte [rej(di)], 0
	jz	.wiekszy1		; gdy koniec lancucha 2, a AL!=0
	; AL != 0 && [DI] == 0 => 1-szy wiekszy
	jz	.wiekszy1

	inc	rej(si)		; sprawdzaj kolejne znaki (tyle, ile trzeba)
	inc	rej(di)

	dec	rej(cx)		; zmniejsz ilosc znakow do sprawdzenia
	jnz	.sprawdzaj	; gdy sprawdzilismy wszystkie, to konczymy

	jmp	short .juz

.nie_rowne:
	ja	.wiekszy1
.pierwszy_mnieszy:
	or	rej(bx), -1		; lancuch 1 (xSI) < lancuch 2 (xDI)
	jmp	short .juz

.wiekszy1:
	or	rej(bx), 1		; lancuch 1 (xSI) > lancuch 2 (xDI)
	jmp 	short .juz

.spr_rown:
	cmp	byte [rej(di)], 0
	jz	.juz
	; AL == 0 && [DI] != 0 => 2-gi wiekszy
	jmp	short .pierwszy_mnieszy

.juz:
	mov	rej(ax), rej(bx)	; xAX = wynik porownan

	pop_f

	cmp	rej(ax), 0		; ustawiamy odpowiednio flagi

	pop	rej(si)
	pop	rej(di)
	pop	rej(cx)
	pop	rej(bx)
	bibl_ret

; ***********************************************

;;
; Zcala 2 lancuchy znakow, dopisujac znaki z drugiego do pierwszego.
; Makro: zcal
; @param DS:SI / ESI / RSI - adres pierwszego lancucha.
; @param DS:DI / EDI / RDI - adres drugiego lancucha.
;;
_lan_zcal:
	push_f
	push	rej(ax)
	push	rej(cx)
	push	rej(si)
	push	rej(di)

	bibl_call	_lan_dlugosc	; pobierz dlugosc lancucha 1
	add	rej(si), rej(ax)	; xSI -> koniec lancucha 1

	xchg	rej(si), rej(di)	; xDI -> koniec lancucha 1 (bajt zerowy),
					; xSI -> poczatek lancucha 2
	bibl_call	_lan_dlugosc
	mov	rej(cx), rej(ax)	; xCX = dlugosc lancucha 2
	inc	rej(cx)			; dopiszemy od razu bajt zerowy

.kopiuj:				; kopiowanie xCX znakow:
	mov	al, [rej(si)]
	mov	[rej(di)], al
	inc	rej(si)
	inc	rej(di)

	dec	rej(cx)			; kopiuj tylko tyle, ile trzeba
	jnz	.kopiuj

	pop	rej(di)
	pop	rej(si)
	pop	rej(cx)
	pop	rej(ax)
	pop_f
	bibl_ret

; ***********************************************

;;
; Zcala 2 lancuchy znakow, dopisujac co najwyzej CX / ECX / RCX znakow
; z drugiego do pierwszego.
; Makro: zcal_dl
; @param DS:SI / ESI / RSI - adres pierwszego lancucha.
; @param DS:SI / EDI / RDI - adres drugiego lancucha.
; @param CX / ECX / RCX - liczba znakow do dopisania
;;
_lan_dl_zcal:
	push_f
	push	rej(ax)
	push	rej(cx)
	push	rej(si)
	push	rej(di)

	bibl_call	_lan_dlugosc	; pobierz dlugosc lancucha 1
	add	rej(si), rej(ax)	; xSI -> koniec lancucha 1
	xchg	rej(si), rej(di)

.kopiuj:				; kopiowanie xCX znakow:
	mov	al, [rej(si)]
	mov	[rej(di)], al
	inc	rej(si)
	inc	rej(di)

	test	al, al			; konczymy na bajcie zerowym
	jz	.koniec

	dec	rej(cx)			; kopiuj tylko tyle, ile trzeba
	jnz	.kopiuj

	mov	al, 0
	mov	[rej(di)], al

.koniec:
	pop	rej(di)
	pop	rej(si)
	pop	rej(cx)
	pop	rej(ax)
	pop_f
	bibl_ret

; ***********************************************

;;
; Szuka drugiego lancucha w pierwszym.
; Makro: znajdz
; @param DS:SI / ESI / RSI - adres pierwszego lancucha.
; @param DS:DI / EDI / RDI - adres drugiego lancucha.
; @return AX / EAX / RAX = pozycja drugiego lancucha wzgledem poczatku pierwszego
; lub -1 w przypadku nieznalezienia.
;;
_lan_znajdz:
	push_f
	push	rej(bx)
	push	rej(cx)
	push	rej(dx)
	push	rej(si)
	push	rej(di)

	bibl_call	_lan_dlugosc
	mov	rej(dx), rej(ax)	; xDX = dlugosc pierwszego lancucha
	or	rej(ax), -1
	test	rej(dx), rej(dx)
	jz	.koniec

	mov	rej(bx), rej(si)	; xBX = poczatek pierwszego lancucha

	xchg	rej(si), rej(di)
	bibl_call	_lan_dlugosc
	mov	rej(cx), rej(ax)	; xCX = dlugosc lancucha 2

	or	rej(ax), -1
	test	rej(cx), rej(cx)
	jz	.koniec
	cmp	rej(cx), rej(dx)
	ja	.koniec

	sub	rej(dx), rej(cx)	; xDX-xCX=tyle bajtow od poczatku
					; lancucha wystarczy przeszukac,
					; aby znalezc drugi lancuch

	inc	rej(dx)			; na wszelki wypadek

	xchg	rej(si), rej(di)
.szukaj:
	bibl_call	_lan_dl_porownaj	; szukamy lancucha [xDI] pod [xSI+...]
	jz	.znaleziono

	inc	rej(si)		; zacznij sprawdzanie od nastepnego znaku

	dec	rej(dx)
	jnz	.szukaj		; sprawdz, czy przeszukalismy juz wszystkie
					; mozliwe znaki

	or	rej(ax), -1		; nie znaleziono
	jmp	short .koniec

.znaleziono:
	sub	rej(si), rej(bx)	; xSI = poczatek lancucha2 -
					; poczatek pierwszego lancucha

	mov	rej(ax), rej(si)	; xAX = pozycja lancucha 2. w 1.

.koniec:
	pop	rej(di)
	pop	rej(si)
	pop	rej(dx)
	pop	rej(cx)
	pop	rej(bx)
	pop_f
	bibl_ret

; ***********************************************

;;
; Nadpisuje lancuch soba samym wspak.
; Makro: odwroc
; @param DS:SI / ESI / RSI - adres lancucha.
;;
_lan_odwroc:
	push_f
	push	rej(ax)
	push	rej(si)
	push	rej(di)
	push	rej(bx)

	bibl_call	_lan_dlugosc	; xAX = dlugosc lancucha
	mov	rej(bx), rej(ax)

	lea	rej(di), [rej(si) + rej(bx) - 1]
					; xDI -> prawy znak zamieniany,
					; xSI -> lewy znak zamieniany
.zamieniaj:
	mov	al, [rej(si)]		; zamiena znaki miejscami
	mov	ah, [rej(di)]
	mov	[rej(si)], ah
	mov	[rej(di)], al

	inc	rej(si)			; przejdz na kolejne znaki
	dec	rej(di)

	cmp	rej(di), rej(si)
	ja	.zamieniaj	; przestan zamieniac, gdy prawy znak znajdzie
				; sie z lewej strony lewego, lub gdy oba sie
				; spotkaja

	pop	rej(bx)
	pop	rej(di)
	pop	rej(si)
	pop	rej(ax)
	pop_f
	bibl_ret

; ***********************************************

;;
; Podaje ilosc wystapien znaku w podanym lancuchu.
; Makro: policz
; @param DS:SI / ESI / RSI - adres lancucha.
; @param AL - znak, ktorego wystapienia maja byc zliczane.
; @return AX / EAX / RAX - ilosc wystapien znaku
;;
_lan_policz:
	push_f
	push	rej(bx)
	push	rej(si)

	xor	rej(bx), rej(bx)
.policz:
	cmp	al, [rej(si)]		; czy te znaki sa rowne?
	jne	.nie_rowne

	inc	rej(bx)			; jesli tak, to zwieksz ilosc znalez.

.nie_rowne:
	cmp	byte [rej(si)], 0	; czy koniec lancucha?
	je	.koniec

	inc	rej(si)
	jmp	short .policz

.koniec:
	mov	rej(ax), rej(bx)

	pop	rej(si)
	pop	rej(bx)
	pop_f
	bibl_ret

; ***********************************************

;;
; Zamienia wszystkie wystapienia podanego znaku na inny znak.
; Makro: zamien
; @param DS:SI / ESI / RSI - adres lancucha
; @param AH - znak do znalezienia
; @param AL - znak, ktory bedzie wstawiany w miejsce znalezionego.
;;
_lan_zamien:
	push_f
	push	rej(si)

	dec	rej(si)
.petla:
	inc	rej(si)
	cmp	byte [rej(si)], 0
	je	.koniec

	cmp	[rej(si)], ah
	jne	.petla

	mov	[rej(si)], al
	jmp	short .petla

.koniec:
	pop	rej(si)
	pop_f

	bibl_ret
