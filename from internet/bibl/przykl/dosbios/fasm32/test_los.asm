format COFF

public start

include "bibl\incl\dosbios\fasm32\std_bibl.inc"

start:
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




	xor	ah, ah
	int	16h
	czysc

	mov	bx, 2000
	mov	cx, 20
los16:
	losuj16
	pisz16
	nwln
	loop	los16




	xor	ah, ah
	int	16h
	czysc

	mov	cx, 20
los32:
	losuj32
	pisz32
	nwln
	loop	los32



	xor	ah, ah
	int	16h
	czysc

	mov	cx, 20
los32e:
	losuj32e
	pisz32e
	nwln
	loop	los32e



	xor	ah, ah
	int	16h
	czysc

	mov	cx, 20
los64:
	losuj64
	pisz64
	nwln
	loop	los64

	wyjscie

