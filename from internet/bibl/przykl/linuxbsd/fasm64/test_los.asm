format ELF64

include "bibl/incl/linuxbsd/fasm/std_bibl.inc"

section ".text" executable

public _start

_start:

	mov	cx, 20
	xor	di, di
	xor	si, si
	mov	bx, 100

	mov	cx, 20
los8:
	losuj8
	pisz8
	nwln
	loop	los8




	we_z
	czysc

	mov	bx, 2000
	mov	cx, 20
los16:
	losuj16
	pisz16
	nwln
	loop	los16




	we_z
	czysc

	mov	cx, 20
los32:
	losuj32
	pisz32
	nwln
	loop	los32


	we_z
	czysc

	mov	cx, 20
los32e:
	losuj32e
	pisz32e
	nwln
	loop	los32e



	we_z
	czysc

	mov	cx, 20
los64:
	losuj64
	pisz64
	nwln
	loop	los64

	wyjscie

