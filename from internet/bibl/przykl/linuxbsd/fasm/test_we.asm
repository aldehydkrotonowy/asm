format ELF

include "bibl/incl/linuxbsd/fasm/std_bibl.inc"

section ".text" executable

public _start

_start:

	pisz
	db	'Podaj liczbe 16bit: ', 0
	we16
	nwln
	pisz16
	nwln
	pisz
	db	'Podaj liczbe 16bit hex: ', 0
	we16h
	nwln
	pisz16h
	nwln
	pisz
	db	'Podaj liczbe 16bit ze znakiem: ', 0
	we16z
	nwln
	pisz16z
	nwln
	pisz
	db	'Podaj liczbe 16bit hex ze znakiem: ', 0
	we16zh
	nwln
	pisz16zh
	nwln
	pisz
	db	'Podaj liczbe 16bit binarnie: ', 0
	we16b
	nwln
	pisz16b
	nwln
	pisz
	db	'Podaj liczbe 16bit osemkowo: ', 0
	we16o
	nwln
	pisz16o

	push	ax
	pisz
	db	lf, 'Nacisnij klawisz...', 0
	we_z
	czysc
	pop	ax

	pisz
	db	'Podaj liczbe 32bit: ', 0
	we32
	nwln
	pisz32
	nwln
	pisz
	db	'Podaj liczbe 32bit hex: ', 0
	we32h
	nwln
	pisz32h
	nwln
	pisz
	db	'Podaj liczbe 32bit ze znakiem: ', 0
	we32z
	nwln
	pisz32z
	nwln
	pisz
	db	'Podaj liczbe 32bit hex ze znakiem: ', 0
	we32zh
	nwln
	pisz32zh
	nwln
	pisz
	db	'Podaj liczbe 32bit binarnie: ', 0
	we32b
	nwln
	pisz32b
	nwln
	pisz
	db	'Podaj liczbe 32bit osemkowo: ', 0
	we32o
	nwln
	pisz32o

	pisz
	db	lf, 'Nacisnij klawisz...', 0
	we_z
	czysc

	pisz
	db	'Drugi raz podaj liczbe 32bit: ', 0
	we32e
	nwln
	pisz32e
	nwln
	pisz
	db	'Podaj liczbe 32bit hex: ', 0
	we32eh
	nwln
	pisz32eh
	nwln
	pisz
	db	'Podaj liczbe 32bit ze znakiem: ', 0
	we32ez
	nwln
	pisz32ez
	nwln
	pisz
	db	'Podaj liczbe 32bit hex ze znakiem: ', 0
	we32ezh
	nwln
	pisz32ezh
	nwln
	pisz
	db	'Podaj liczbe 32bit binarnie: ', 0
	we32eb
	nwln
	pisz32eb
	nwln
	pisz
	db	'Podaj liczbe 32bit osemkowo: ', 0
	we32eo
	nwln
	pisz32eo

	push	eax
	pisz
	db	lf, 'Nacisnij klawisz...', 0
	we_z
	czysc
	pop	eax


	pisz
	db	'Podaj liczbe 64bit: ', 0
	we64
	nwln
	pisz64
	nwln
	pisz
	db	'Podaj liczbe 64bit hex: ', 0
	we64h
	nwln
	pisz64h
	nwln
	pisz
	db	'Podaj liczbe 64bit ze znakiem: ', 0
	we64z
	nwln
	pisz64z
	nwln
	pisz
	db	'Podaj liczbe 64bit hex ze znakiem: ', 0
	we64zh
	nwln
	pisz64zh
	nwln
	pisz
	db	'Podaj liczbe 64bit binarnie: ', 0
	we64b
	nwln
	pisz64b
	nwln
	pisz
	db	'Podaj liczbe 64bit osemkowo: ', 0
	we64o
	nwln
	pisz64o

	pisz
	db	lf, 'Nacisnij klawisz...', 0
	we_z
	czysc

	pisz
	db	'Podaj liczbe 8bit: ', 0
	we8
	nwln
	pisz8
	nwln
	pisz
	db	'Podaj liczbe 8bit hex: ', 0
	we8h
	nwln
	pisz8h
	nwln
	pisz
	db	'Podaj liczbe 8bit ze znakiem: ', 0
	we8z
	nwln
	pisz8z
	nwln
	pisz
	db	'Podaj liczbe 8bit hex ze znakiem: ', 0
	we8zh
	nwln
	pisz8zh
	nwln
	pisz
	db	'Podaj liczbe 8bit binarnie: ', 0
	we8b
	nwln
	pisz8b
	nwln
	pisz
	db	'Podaj liczbe 8bit osemkowo: ', 0
	we8o
	nwln
	pisz8o

	push	eax
	pisz
	db lf,'Nacisnij klawisz...', 0
	we_z
	czysc
	pop	eax

	pisz
	db	'Podaj znak, cyfre i cyfre hex: ', 0
	we_z
	nwln
	pisz_z
	nwln
	we_c
	nwln
	pisz_c
	nwln
	we_ch
	nwln
	pisz_ch
	nwln


	mov	edi, tekst
	pisz
	db	'Podaj tekst: ', 0
	we			; nie zmienia EDI
	mov	esi, tekst
	nwln
	pisz_dssi		; nie zmienia ESI

	mov	edi, tekst2
	mov	cx, 10
	pisz
	db	lf, 'Podaj inny tekst:', 0
	we_dl			; nie zmienia EDI, ale CX
	jnc	txt_ok
	pisz
	db	lf, 'Zle.', 0
	jmp	koniec
txt_ok:
	nwln
	mov	esi, edi
	pisz_dl
	nwln

koniec:
	wyjscie

section ".data" writeable

tekst:	times 20 db 0
tekst2:	times 10 db 0

