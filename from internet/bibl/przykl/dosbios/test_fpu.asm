.model small
.stack 200h
.code

include bibl\incl\dosbios\std_bibl.inc

start:
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov	di, offset iloraz


	pisz
	db	'Podaj liczbe nr 1: ', 0
	wed32
	nwln
	piszd32

	pisz
	db	cr, lf, 'Podaj liczbe nr 2: ', 0
	wed64
	nwln
	piszd64

	pisz
	db	cr, lf, 'Podaj liczbe nr 3: ', 0
	wed80
	nwln
	piszd80



	nwln
	nwln
	fild	qp [dzielna]
	fild	qp [dzielnik]
	fdivp
	fstp	dwp [iloraz]
	piszd32


	nwln
	fild	qp [dzielna]
	fild	qp [dzielnik]
	fdivp
	fstp	qp [iloraz]
	piszd64


	nwln
	fild	qp [dzielna]
	fild	qp [dzielnik]
	fdivp
	fstp	tp [iloraz]
	piszd80

	wyjscie


dzielna DQ 1234ddh
dzielnik DQ 0ffffh
iloraz DT 0

end start

