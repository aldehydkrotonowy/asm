%include "bibl\incl\dosbios\nasm32\std_bibl.inc"
%include "bibl\incl\dosbios\nasm\do_nasma.inc"

global start

start:
	procesor
	pisz16
	nwln
	koprocesor
	pisz16
	wyjscie
end start

