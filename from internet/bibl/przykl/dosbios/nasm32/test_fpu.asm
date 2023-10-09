%include "bibl\incl\dosbios\nasm32\std_bibl.inc"
%include "bibl\incl\dosbios\nasm\do_nasma.inc"

global start

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
	fild	dword [dzielna]
	fild	dword [dzielnik]
	fdivp
	fstp	dword [iloraz]
	piszd32


	nwln
	fild	dword [dzielna]
	fild	dword [dzielnik]
	fdivp
	fstp	qword [iloraz]
	piszd64


	nwln
	fild	dword [dzielna]
	fild	dword [dzielnik]
	fdivp
	fstp	tword [iloraz]
	piszd80

	wyjscie


dzielna		dd	1234ddh
dzielnik	dd	0ffffh
iloraz		dt	0.0

end start

