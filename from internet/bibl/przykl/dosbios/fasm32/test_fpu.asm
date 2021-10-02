format COFF

public start

include "bibl\incl\dosbios\fasm32\std_bibl.inc"

start:
	mov	edi, iloraz

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
	fild	qword [dzielna]
	fild	qword [dzielnik]
	fdivp
	fstp	dword [iloraz]
	piszd32


	nwln
	fild	qword [dzielna]
	fild	qword [dzielnik]
	fdivp
	fstp	qword [iloraz]
	piszd64


	nwln
	fild	qword [dzielna]
	fild	qword [dzielnik]
	fdivp
	fstp	tword [iloraz]
	piszd80

	wyjscie


dzielna		dq	1234ddh
dzielnik	dq	0ffffh
iloraz		dt	0.0

