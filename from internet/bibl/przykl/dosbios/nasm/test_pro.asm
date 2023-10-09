%include "bibl\incl\dosbios\nasm\std_bibl.inc"
%include "bibl\incl\dosbios\nasm\do_nasma.inc"

.model small
.stack 200h
.code

..start:
	procesor
	pisz16
	nwln
	koprocesor
	pisz16
	wyjscie
end start

