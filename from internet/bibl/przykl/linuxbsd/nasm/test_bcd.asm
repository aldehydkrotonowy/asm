%include "bibl/incl/linuxbsd/nasm/std_bibl.inc"

global _start

_start:
	pisz
	db	"Podaj liczbe BCD 8-bit: ", 0
	we8bcd
	mov	bl, al
	pisz8bcd
	nwln
	pisz8h
	clc
	nwln

	pisz
	db	"rbcd2sbcd: ", 0
	rbcd_na_sbcd8
	pisz8h
	clc
	nwln

	pisz
	db	"sbcd2rbcd: ", 0
	mov	al, bl
	sbcd_na_rbcd8
	pisz8h
	jnc	.no_carry8_1
	pisz
	db	", CF=1", 0
.no_carry8_1:
	clc
	nwln

	pisz
	db	"sbcd2bin: ", 0
	mov	al, bl
	sbcd_na_bin8
	pisz8h
	jnc	.no_carry8_2
	pisz
	db	", CF=1", 0
.no_carry8_2:
	clc
	nwln

	pisz
	db	"rbcd2bin: ", 0
	mov	al, bl
	rbcd_na_bin8
	pisz8h
	clc
	nwln

	pisz
	db	"bin2rbcd: ", 0
	mov	al, bl
	bin_na_rbcd8
	pisz8h
	jnc	.no_carry8_3
	pisz
	db	", CF=1", 0
.no_carry8_3:
	clc
	nwln

	pisz
	db	"bin2sbcd: ", 0
	mov	al, bl
	bin_na_sbcd8
	pisz8h
	jnc	.no_carry8_4
	pisz
	db	", CF=1", 0
.no_carry8_4:
	clc
	nwln

; ---------------------------

	pisz
	db	"Podaj liczbe BCD 16-bit: ", 0
	we16bcd
	mov	bx, ax
	pisz16bcd
	nwln
	pisz16h
	clc
	nwln

	pisz
	db	"rbcd2sbcd: ", 0
	rbcd_na_sbcd16
	pisz16h
	clc
	nwln

	pisz
	db	"sbcd2rbcd: ", 0
	mov	ax, bx
	sbcd_na_rbcd16
	pisz16h
	jnc	.no_carry16_1
	pisz
	db	", CF=1", 0
.no_carry16_1:
	clc
	nwln

	pisz
	db	"sbcd2bin: ", 0
	mov	ax, bx
	sbcd_na_bin16
	pisz16h
	jnc	.no_carry16_2
	pisz
	db	", CF=1", 0
.no_carry16_2:
	clc
	nwln

	pisz
	db	"rbcd2bin: ", 0
	mov	ax, bx
	rbcd_na_bin16
	pisz16h
	clc
	nwln

	pisz
	db	"bin2rbcd: ", 0
	mov	ax, bx
	bin_na_rbcd16
	pisz16h
	jnc	.no_carry16_3
	pisz
	db	", CF=1", 0
.no_carry16_3:
	clc
	nwln

	pisz
	db	"bin2sbcd: ", 0
	mov	ax, bx
	bin_na_sbcd16
	pisz16h
	jnc	.no_carry16_4
	pisz
	db	", CF=1", 0
.no_carry16_4:
	clc
	nwln

; ---------------------------

	pisz
	db	"Podaj liczbe BCD 32-bit: ", 0
	we32bcd
	mov	bx, ax
	mov	si, dx
	pisz32bcd
	nwln
	pisz32h
	clc
	nwln

	pisz
	db	"rbcd2sbcd: ", 0
	rbcd_na_sbcd32
	pisz32h
	clc
	nwln

	pisz
	db	"sbcd2rbcd: ", 0
	mov	ax, bx
	mov	dx, si
	sbcd_na_rbcd32
	pisz32h
	jnc	.no_carry32_1
	pisz
	db	", CF=1", 0
.no_carry32_1:
	clc
	nwln

	pisz
	db	"sbcd2bin: ", 0
	mov	ax, bx
	mov	dx, si
	sbcd_na_bin32
	pisz32h
	jnc	.no_carry32_2
	pisz
	db	", CF=1", 0
.no_carry32_2:
	clc
	nwln

	pisz
	db	"rbcd2bin: ", 0
	mov	ax, bx
	mov	dx, si
	rbcd_na_bin32
	pisz32h
	clc
	nwln

	pisz
	db	"bin2rbcd: ", 0
	mov	ax, bx
	mov	dx, si
	bin_na_rbcd32
	pisz32h
	jnc	.no_carry32_3
	pisz
	db	", CF=1", 0
.no_carry32_3:
	clc
	nwln

	pisz
	db	"bin2sbcd: ", 0
	mov	ax, bx
	mov	dx, si
	bin_na_sbcd32
	pisz32h
	jnc	.no_carry32_4
	pisz
	db	", CF=1", 0
.no_carry32_4:
	clc
	nwln

; ---------------------------

	pisz
	db	"Podaj liczbe BCD 32-bit: ", 0
	we32ebcd
	mov	ebx, eax
	pisz32ebcd
	nwln
	pisz32eh
	nwln

	pisz
	db	"rbcd2sbcd: ", 0
	rbcd_na_sbcd32e
	pisz32eh
	clc
	nwln

	pisz
	db	"sbcd2rbcd: ", 0
	mov	eax, ebx
	sbcd_na_rbcd32e
	pisz32eh
	jnc	.no_carry32e_1
	pisz
	db	", CF=1", 0
.no_carry32e_1:
	clc
	nwln

	pisz
	db	"sbcd2bin: ", 0
	mov	eax, ebx
	sbcd_na_bin32e
	pisz32eh
	jnc	.no_carry32e_2
	pisz
	db	", CF=1", 0
.no_carry32e_2:
	clc
	nwln

	pisz
	db	"rbcd2bin: ", 0
	mov	eax, ebx
	rbcd_na_bin32e
	pisz32eh
	clc
	nwln

	pisz
	db	"bin2rbcd: ", 0
	mov	eax, ebx
	bin_na_rbcd32e
	pisz32eh
	jnc	.no_carry32e_3
	pisz
	db	", CF=1", 0
.no_carry32e_3:
	clc
	nwln

	pisz
	db	"bin2sbcd: ", 0
	mov	eax, ebx
	bin_na_sbcd32e
	pisz32eh
	jnc	.no_carry32e_4
	pisz
	db	", CF=1", 0
.no_carry32e_4:
	clc
	nwln

; ---------------------------
	pisz
	db	"Podaj liczbe BCD 64-bit: ", 0
	we64bcd
	mov	ebx, eax
	mov	esi, edx
	pisz64bcd
	nwln
	pisz64h
	nwln

	pisz
	db	"rbcd2sbcd: ", 0
	rbcd_na_sbcd64
	pisz64h
	clc
	nwln

	pisz
	db	"sbcd2rbcd: ", 0
	mov	eax, ebx
	mov	edx, esi
	sbcd_na_rbcd64
	pisz64h
	jnc	.no_carry64_1
	pisz
	db	", CF=1", 0
.no_carry64_1:
	clc
	nwln

	pisz
	db	"sbcd2bin: ", 0
	mov	eax, ebx
	mov	edx, esi
	sbcd_na_bin64
	pisz64h
	jnc	.no_carry64_2
	pisz
	db	", CF=1", 0
.no_carry64_2:
	clc
	nwln

	pisz
	db	"rbcd2bin: ", 0
	mov	eax, ebx
	mov	edx, esi
	rbcd_na_bin64
	pisz64h
	clc
	nwln

	pisz
	db	"bin2rbcd: ", 0
	mov	eax, ebx
	mov	edx, esi
	bin_na_rbcd64
	pisz64h
	jnc	.no_carry64_3
	pisz
	db	", CF=1", 0
.no_carry64_3:
	clc
	nwln

	pisz
	db	"bin2sbcd: ", 0
	mov	eax, ebx
	mov	edx, esi
	bin_na_sbcd64
	pisz64h
	jnc	.no_carry64_4
	pisz
	db	", CF=1", 0
.no_carry64_4:
	clc
	nwln

; ---------------------------

	wyjscie
