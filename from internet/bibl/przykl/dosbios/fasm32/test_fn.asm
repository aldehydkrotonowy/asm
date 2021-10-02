format COFF

public start

include "bibl\incl\dosbios\fasm32\std_bibl.inc"

start:
	finit

	mov	edi, l1
	pisz
	db	'Podaj l1: ', 0
	wed32n

	jnc	ok1
	pisz
	db	cr, lf, 'Blad1-1', 0
ok1:
	pisz
	db	cr, lf, 'l1=', 0
	piszd32n
	jnc	ok1_2
	pisz
	db	cr, lf, 'Blad1-2', 0
ok1_2:

	mov	edi, l2
	pisz
	db	cr, lf, cr, lf, 'Podaj l2: ', 0
	wed64n

	jnc	ok2
	pisz
	db	cr,lf,'Blad2-1',0
ok2:

	pisz
	db	cr, lf, 'l2=', 0
	piszd64n
	jnc	ok2_2
	pisz
	db	cr, lf, 'Blad2-2', 0
ok2_2:

	mov	edi, l3
	pisz
	db	cr, lf, cr, lf, 'Podaj l3: ', 0
	wed80n

	jnc	ok3
	pisz
	db	cr, lf, 'Blad3-1', 0
ok3:

	pisz
	db	cr, lf, 'l3=',0
	piszd80n
	jnc	ok3_2
	pisz
	db	cr, lf, 'Blad3-2', 0
ok3_2:

	wyjscie

l1	dd	6300.0
l2	dq	3561894.25
l3	dt	206841393211.75

