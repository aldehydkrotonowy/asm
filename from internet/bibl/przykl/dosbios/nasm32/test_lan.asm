%include "bibl\incl\dosbios\nasm32\std_bibl.inc"
%include "bibl\incl\dosbios\nasm\do_nasma.inc"

global start

start:
	pisz
	db	"Dlugosc: ", 0
	mov	esi, spr_dlugosc
	dlugosc
	pisz16
	nwln

	pisz
	db	"Zamiana na male: ", 0
	mov	esi, spr_na_male
	na_male
	pisz_dssi
	nwln

	pisz
	db	"Zamiana na wielkie: ", 0
	mov	esi, spr_na_male
	na_duze
	pisz_dssi
	nwln

	pisz
	db	"Porownanie, proba 1: ", 0
	mov	esi, spr_porow1
	mov	edi, spr_porow2
	porownaj
	pisz16z
	nwln

	pisz
	db	"Porownanie, proba 2: ", 0
	mov	esi, spr_porow1
	mov	edi, spr_porow2
	mov	cx, 5
	porownaj_dl
	pisz16z
	nwln

	pisz
	db	"Porownanie, proba 3: ", 0
	mov	esi, spr_porow3
	mov	edi, spr_porow2
	porownaj
	pisz16z
	nwln

	pisz
	db	"Porownanie, proba 4: ", 0
	mov	esi, spr_porow3
	mov	edi, spr_porow4
	porownaj
	pisz16z
	nwln

	pisz
	db	"Zcalanie, proba 1: ", 0
	mov	esi, spr_zcal1
	mov	edi, spr_zcal2
	zcal
	pisz_dssi
	nwln

	pisz
	db	"Zcalanie, proba 2: ", 0
	mov	esi, spr_zcal2
	mov	edi, spr_zcal3
	mov	cx, 2
	zcal_dl
	pisz_dssi
	nwln

	pisz
	db	"Znajdowanie, ", 0
	mov	esi, spr_znaj1
	mov	edi, spr_znaj2
	znajdz
	pisz16z
	nwln

	mov	esi, spr_odwroc
	pisz_dssi
	nwln
	pisz
	db	"Odwracanie: ", 0
	odwroc
	pisz_dssi
	nwln

	mov	esi, spr_odwroc
	pisz_dssi
	nwln
	pisz
	db	"Liczenie znakow K: ", 0
	mov	al, 'K'
	policz
	pisz16
	nwln

	mov	esi, spr_zmien
	pisz_dssi
	nwln
	pisz
	db	"Zamiana znakow A na K: ", 0
	mov	ah, 'A'
	mov	al, 'K'
	zamien
	pisz_dssi
	nwln
	wyjscie



spr_dlugosc	db	'aaaaabbbbb',0
spr_na_male	db	'aAbBcCdD',0
spr_porow1	db	'ssssAAAb',0
spr_porow2	db	'ssssAAAB',0
spr_porow3	db	'ssSsAAAC',0
spr_porow4	db	's',0
spr_znaj1	db	'aAaAbBbBccccDDD',0
spr_znaj2	db	'AB',0

spr_odwroc	db	"Kobyla Ma Maly boK",0
spr_zmien	db	'AaBbCcDd', 0

; zcalane lancuchy znakow musza byc zadeklarowane jako ostatnie!!!

spr_zcal3	db	'cccccccccc',0
spr_zcal2	db	'bbbbb',0
spr_zcal1	db	'aaaaa',0


end start

