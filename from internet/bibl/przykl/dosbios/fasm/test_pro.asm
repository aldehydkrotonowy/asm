
format COFF
use16

public start

include "bibl\incl\dosbios\fasm\std_bibl.inc"

start:
	mov	ax, cs
        mov	ds, ax
        mov	es, ax
	mov	ss, ax
	mov	esp, nasz_stosik

	procesor
	pisz16
	nwln
	koprocesor
	pisz16
	wyjscie


	times 400h db 0
nasz_stosik:

