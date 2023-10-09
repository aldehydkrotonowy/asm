format ELF64

include "bibl/incl/linuxbsd/fasm/std_bibl.inc"

section ".text" executable

public _start

_start:

	mov	eax, -523
	mov	edx, 4687056

	pisz16
	nwln
	pisz16h
	nwln
	pisz16z
	nwln
	pisz16zh
	nwln
	pisz16b
	nwln
	pisz16o

	push	rax
	pisz
	db	lf, 'Nacisnij klawisz...', 0
	we_z
	czysc
	pop	rax

	pisz32
	nwln
	pisz32h
	nwln
	pisz32z
	nwln
	pisz32zh
	nwln
	pisz32b
	nwln
	pisz32o

	pisz
	db	lf, 'Nacisnij klawisz...', 0
	we_z
	czysc

	mov	eax, 569370
	mov	edx, -7356234

	pisz32e
	nwln
	pisz32eh
	nwln
	pisz32ez
	nwln
	pisz32ezh
	nwln
	pisz32eb
	nwln
	pisz32eo

	push	rax
	pisz
	db	lf, 'Nacisnij klawisz...', 0
	we_z
	czysc
	pop	rax

	pisz64
	nwln
	pisz64h
	nwln
	pisz64z
	nwln
	pisz64zh
	nwln
	pisz64b
	nwln
	pisz64o

	pisz
	db	lf, 'Nacisnij klawisz...', 0
	we_z
	czysc

	mov	al, 'b'
	pisz_z
	mov	al, 7
	pisz_c
	mov	al, 12
	pisz_ch
	nwln

	mov	rsi, info
	pisz_dssi
	nwln

	mov	rsi, info32
	pisz_esi
	nwln

	mov	rsi, tekst
	mov	cx, 5
	pisz_dl
	nwln

	mov	rcx, 7
	mov	rsi, tekst32
	pisz_dl32

	nwln
;	procesor
;	pisz16
	nwln
;	koprocesor
;	pisz16

	mov	al, 129

	nwln
	nwln
	pisz8
	nwln
	pisz8h
	nwln
	pisz8z
	nwln
	pisz8zh
	nwln
	pisz8b
	nwln
	pisz8o
	nwln

	czysc

	xor	eax, eax
	pozycja


	wyjscie

section ".data" writeable

_b_bufor_pisz	db	0

iloraz32	db	0
info		db	'Info2', 0
tekst		db	'abcdefghijkl'
info32		db	'Info3333', 0
tekst32		db	'txt32_01234', 0

