format ELF64

include "bibl/incl/linuxbsd/fasm/std_bibl.inc"

section ".text" executable

public _start

_start:
	procesor
	pisz16
	nwln
	koprocesor
	pisz16
	nwln

	wyjscie

