%include "bibl/incl/linuxbsd/nasm/std_bibl.inc"

section .text

global _start

_start:
	mov	edi, iloraz


	pisz
	db	'Podaj liczbe nr 1: ', 0
	wed32
	nwln
	piszd32

	pisz
	db	lf, 'Podaj liczbe nr 2: ', 0
	wed64
	nwln
	piszd64

	pisz
	db	lf, 'Podaj liczbe nr 3: ', 0
	wed80
	nwln
	piszd80



	nwln
	nwln
	fild	dword [dzielna]
	fild	dword [dzielnik]
	fdivp	st1, st0
	fstp	dword [iloraz]
	piszd32


	nwln
	fild	dword [dzielna]
	fild	dword [dzielnik]
	fdivp	st1, st0
	fstp	qword [iloraz]
	piszd64


	nwln
	fild	dword [dzielna]
	fild	dword [dzielnik]
	fdivp	st1, st0
	fstp	tword [iloraz]
	piszd80
	nwln

	wyjscie

section .data

dzielna		dd	1234ddh
dzielnik	dd	0ffffh
iloraz		dt	0.0

