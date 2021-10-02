format ELF64

include "bibl/incl/linuxbsd/fasm/std_bibl.inc"

section ".text" executable

public _start

_start:
	pisz
	db	"Dlugosc: ", 0
	mov	rsi, spr_dlugosc
	dlugosc
	pisz32e
	nwln

	pisz
	db	"Zamiana na male: ", 0
	mov	rsi, spr_na_male
	na_male
	pisz_dssi
	nwln

	pisz
	db	"Zamiana na wielkie: ", 0
	mov	rsi, spr_na_male
	na_duze
	pisz_dssi
	nwln

	pisz
	db	"Porownanie, proba 1: ", 0
	mov	rsi, spr_porow1
	mov	rdi, spr_porow2
	porownaj
	pisz32ez
	nwln

	pisz
	db	"Porownanie, proba 2: ", 0
	mov	rsi, spr_porow1
	mov	rdi, spr_porow2
	mov	rcx, 5
	porownaj_dl
	pisz32ez
	nwln

	pisz
	db	"Porownanie, proba 3: ", 0
	mov	rsi, spr_porow3
	mov	rdi, spr_porow2
	porownaj
	pisz32ez
	nwln

	pisz
	db	"Porownanie, proba 4: ", 0
	mov	rsi, spr_porow3
	mov	rdi, spr_porow4
	porownaj
	pisz32ez
	nwln

	pisz
	db	"Zcalanie, proba 1: ", 0
	mov	rsi, spr_zcal1
	mov	rdi, spr_zcal2
	zcal
	pisz_dssi
	nwln

	pisz
	db	"Zcalanie, proba 2: ", 0
	mov	rsi, spr_zcal2
	mov	rdi, spr_zcal3
	mov	rcx, 2
	zcal_dl
	pisz_dssi
	nwln

	pisz
	db	"Znajdowanie, ", 0
	mov	rsi, spr_znaj1
	mov	rdi, spr_znaj2
	znajdz
	pisz32ez
	nwln

	mov	rsi, spr_odwroc
	pisz_dssi
	nwln
	pisz
	db	"Odwracanie: ", 0
	odwroc
	pisz_dssi
	nwln

	mov	rsi, spr_odwroc
	pisz_dssi
	nwln
	pisz
	db	"Liczenie znakow K: ", 0
	mov	al, 'K'
	policz
	pisz32e
	nwln

        mov     rsi, spr_zamien
	pisz_dssi
	nwln
	pisz
	db      "Zamiana znakow A na K: ", 0
	mov	ah, 'A'
	mov     al, 'K'
	zamien
	pisz_dssi
	nwln


	wyjscie

section ".data" writeable

spr_dlugosc	db	'aaaaabbbbb',0
spr_na_male	db	'aAbBcCdD',0
spr_porow1	db	'ssssAAAb',0
spr_porow2	db	'ssssAAAB',0
spr_porow3	db	'ssSsAAAC',0
spr_porow4	db	's',0
spr_znaj1	db	'aAaAbBbBccccDDD',0
spr_znaj2	db	'AB',0

spr_odwroc	db	"Kobyla Ma Maly boK",0
spr_zamien	db	"AaBbCcDd", 0

; lancuchy do zcalania musza byc zadeklarowane jako ostatnie!!!

spr_zcal3	db	'cccccccccc',0
spr_zcal2	db	'bbbbb',0
spr_zcal1	db	'aaaaa',0
		rb	20

