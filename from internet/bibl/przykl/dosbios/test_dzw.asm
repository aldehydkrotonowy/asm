.model small
.stack 200h
.code
.8086

include bibl\incl\dosbios\std_bibl.inc

start:
	mov	bx, dzw_c1
	mov	cx, 0fh
	mov	dx, 4240h		; CX:DX = milion
	graj
	jnc	dalej0
	pisz
	db	'Zle!', 0
dalej0:

	mov	bx, dzw_c1@
	graj
	jnc	juz0
	pisz
	db	'Zle!!', 0

juz0:
	mov	bx, dzw_d1
;	mov	cx, 0fh
;	mov	dx, 4240h		; milion
	graj
	jnc	dalej1
	pisz
	db	'Zle!!!', 0
dalej1:

	mov	bx, dzw_d1@
	graj
	jnc	juz1
	pisz
	db	'Zle!!!!', 0

juz1:

	mov	bx, dzw_e1
	graj
	jnc	dalej2
	pisz
	db	'Zle!!!!!', 0

dalej2:

	mov	bx, dzw_f1
	graj
	jnc	juz2
	pisz
	db	'Zle!!!!!', 0

juz2:

	mov	bx, dzw_f1@
	graj
	jnc	dalej3
	pisz
	db	'Zle!!!!!', 0

dalej3:

	mov	bx, dzw_g1
	graj
	jnc	juz3
	pisz
	db	'Zle!!!!!', 0

juz3:

	mov	bx, dzw_g1@
	graj
	jnc	dalej4
	pisz
	db	'Zle!!!!!',0

dalej4:

	mov	bx, dzw_a1
	graj
	jnc	juz4
	pisz
	db	'Zle!!!!!', 0

juz4:

	mov	bx, dzw_a1@
	graj
	jnc	dalej5
	pisz
	db	'Zle!!!!!', 0

dalej5:

	mov	bx, dzw_h1
	graj
	jnc	juz5
	pisz
	db	'Zle!!!!!', 0

juz5:

	wyjscie

end start

