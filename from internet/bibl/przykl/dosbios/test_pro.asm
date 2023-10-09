.model small
.stack 200h
.code

include bibl\incl\dosbios\std_bibl.inc

start:
	procesor
	pisz16
	nwln
	koprocesor
	pisz16
	wyjscie
end start

