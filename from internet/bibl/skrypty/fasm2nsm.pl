#!/usr/bin/perl -W
#
# fasm2nasm.pl - Skrypt konwertujacy kod w skladni FASMa na kod w skladni NASMa
# fasm2nasm.pl - A script which converts FASM code to NASM code.
#
#	Copyright (C) 2006-2010 Bogdan 'bogdro' Drozdowski, http://rudy.mif.pg.gda.pl/~bogdro/inne/
#		(bogdandr AT op.pl, bogdro AT rudy.mif.pg.gda.pl)
#
#	Licencja / Licence:
#	Powszechna Licencja Publiczna GNU v3+ / GNU General Public Licence v3+
#
#	Ostatnia modyfikacja / Last modified : 2010-06-27
#
#	Sposob uzycia / Syntax:
#		./fasm2nasm.pl xxx.asm [yyy.nsm]
#
# Jesli nazwa pliku wyjsciowego nie zostanie podana, jest brana taka sama jak pliku
#	wejsciowego (tylko rozszerzenie sie zmieni na .nsm). Jesli za nazwe
#	pliku wejsciowego podano "-", czytane jest standardowe wejscie.
#	Jesli nazwa pliku wyjsciowego to "-" (lub nie ma jej, gdy wejscie to stdin),
#	wynik bedzie na standardowym wyjsciu.
#
# If there's no output filename, then it is assumed to be the same as the
#	input filename (only the extension will be changed to .nsm). If the
#	input filename is "-", standard input will be read. If the
#	output filename is "-" (or missing, when input is stdin),
#	the result will be written to the standard output.
#
#    Niniejszy program jest wolnym oprogramowaniem; mozesz go
#    rozprowadzac dalej i/lub modyfikowac na warunkach Powszechnej
#    Licencji Publicznej GNU, wydanej przez Fundacje Wolnego
#    Oprogramowania - wedlug wersji 3-ciej tej Licencji lub ktorejs
#    z pozniejszych wersji.
#
#    Niniejszy program rozpowszechniany jest z nadzieja, iz bedzie on
#    uzyteczny - jednak BEZ JAKIEJKOLWIEK GWARANCJI, nawet domyslnej
#    gwarancji PRZYDATNOSCI HANDLOWEJ albo PRZYDATNOSCI DO OKRESLONYCH
#    ZASTOSOWAN. W celu uzyskania blizszych informacji - Powszechna
#    Licencja Publiczna GNU.
#
#    Z pewnoscia wraz z niniejszym programem otrzymales tez egzemplarz
#    Powszechnej Licencji Publicznej GNU (GNU General Public License);
#    jesli nie - napisz do Free Software Foudation:
#		Free Software Foundation
#		51 Franklin Street, Fifth Floor
#		Boston, MA 02110-1301
#		USA
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foudation:
#		Free Software Foundation
#		51 Franklin Street, Fifth Floor
#		Boston, MA 02110-1301
#		USA

use strict;
use warnings;
use Getopt::Long;

my ($wyj);

my ($help, $lic, $help_msg, $lic_msg);

$help_msg = "$0: Konwerter z FASMa do NASMa / FASM-to-NASM converter.\nAutor/Author: Bogdan Drozdowski, ".
	"http://rudy.mif.pg.gda.pl/~bogdro/inne/\n".
	"Skladnia/Syntax: $0 [--help] [--license] xxx.asm [yyy.nsm]\n\n
 Jesli nazwa pliku wyjsciowego nie zostanie podana, jest brana taka sama jak
pliku wejsciowego (tylko rozszerzenie sie zmieni na .nsm). Jesli za nazwe
pliku wejsciowego podano \"-\", czytane jest standardowe wejscie.
 Jesli nazwa pliku wyjsciowego to \"-\" (lub nie ma jej, gdy wejscie to stdin),
wynik bedzie na standardowym wyjsciu.

 If there's no output filename, then it is assumed to be the same as the
input filename (only the extension will be changed to .nsm). If the
input filename is \"-\", standard input will be read.
 If the output filename is \"-\" (or missing, when input is stdin),
the result will be written to the standard output.\n";

$lic_msg = "$0: Konwerter z FASMa do NASMa / FASM-to-NASM converter.\nAutor/Author: Bogdan Drozdowski, ".
	"http://rudy.mif.pg.gda.pl/~bogdro/inne/\n\n".
	"    Niniejszy program jest wolnym oprogramowaniem; mozesz go
    rozprowadzac dalej i/lub modyfikowac na warunkach Powszechnej
    Licencji Publicznej GNU, wydanej przez Fundacje Wolnego
    Oprogramowania - wedlug wersji 3-ciej tej Licencji lub ktorejs
    z pozniejszych wersji.

    Niniejszy program rozpowszechniany jest z nadzieja, iz bedzie on
    uzyteczny - jednak BEZ JAKIEJKOLWIEK GWARANCJI, nawet domyslnej
    gwarancji PRZYDATNOSCI HANDLOWEJ albo PRZYDATNOSCI DO OKRESLONYCH
    ZASTOSOWAN. W celu uzyskania blizszych informacji - Powszechna
    Licencja Publiczna GNU.

    Z pewnoscia wraz z niniejszym programem otrzymales tez egzemplarz
    Powszechnej Licencji Publicznej GNU (GNU General Public License);
    jesli nie - napisz do Free Software Foudation:
		Free Software Foundation
		51 Franklin Street, Fifth Floor
		Boston, MA 02110-1301
		USA

 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 3
 of the License, or (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software Foudation:
		Free Software Foundation
		51 Franklin Street, Fifth Floor
		Boston, MA 02110-1301
		USA\n";

if ( @ARGV == 0 ) {
	print $help_msg;
	exit 1;
}

Getopt::Long::Configure("ignore_case", "ignore_case_always");

if ( ! GetOptions(
	'h|help|?'		=>	\$help,
	'license|licence|L'	=>	\$lic
	)
   ) {

	print $help_msg;
	exit 1;
}

if ( $lic ) {
	print $lic_msg;
	exit 1;
}

if ( @ARGV == 0 || $help ) {
	print $help_msg;
	exit 1;
}

if ( @ARGV > 1 && $ARGV[0] ne "-" && $ARGV[0] eq $ARGV[1] ) {

	print "$0: Plik wejsciowy i wyjsciowy NIE moga byc takie same.\n";
	print "$0: Input file and output file must NOT be the same.\n";
	exit 4;
}


##########################################################
# Otwieranie plikow (opening the files)

my ($we, $wy);

if ( !open ( $we, $ARGV[0] ) ) {
#	$! jest trescia bledu. ($! is the error message)
	print "$0: $ARGV[0]: $!\n";
	exit 2;
}

if ( @ARGV > 1 )  {
	$wyj = $ARGV[1];

} else {
	# bierzemy tylko nazwe pliku (take only the filename)
	($wyj = $ARGV[0]) =~ s/[\w\-\/\s]+\/([\w\-]+)/$1/;
	# Zmieniamy rozszerzenie z .asm na .nsm (change the extension from .asm to .nsm)
	$wyj =~ s/\.f?asm$/\.nsm/io;
	# Zmieniamy rozszerzenie z .inc na .nnc dla plikow naglowkowych
	# (change the extension from .inc to .nnc for header files)
	$wyj =~ s/\.f?inc$/\.nnc/io;
#	Zmieniamy spacje na podkreslenia (change spaces to underlines)
	$wyj =~ s/\s+/_/g;

	if ( $wyj eq $ARGV[0] && $wyj ne "-" ) { $wyj .= ".asm"; }
}

if ( !open ( $wy, "> $wyj" ) ) {
	print "$0: $wyj: $!\n";
	close $we;
	exit 3;
}

##########################################################
# Przetwarzanie (processing):

CZYTAJ: while ( <$we> ) {

	#	puste linie przepisujemy (empty lines go without change)
	if (/^\s*$/o) {
		print $wy "\n";
		next;
	}

	# sklejanie wierszy (joining lines)
	while ( /\\$/o ) {

		s/\\\n//o;
		$_ .= <$we>;
	}

	# sprawdzamy, czy komentarz jest jedyny na linii (check if a comment is the only thing on this line)
	if ( /^\s*;.*$/ ) { print $wy "$_"; next; }

	# przetwarzanie dyrektyw kompilacji warunkowej (processing of conditional compiling directives)
	&kom_war(0);

	s/fix/equ/io;
	if ( /^\s*format/io )	{ s/^\s*format.*/\n/io; print $wy "$_"; next; }

	if ( /^\s*(stack|heap)/io )	{

		s/^\s*(stack|heap)\s+(\w+)/segment stack stack\n\tresb $2\nends/i;
		print $wy "$_";
		next;

	}

	#	Sekcje (sections)
	if ( /^\s*section/io ) {

		s/^\s*section\s+[\"\'](\w+)[\"\'](.*)$/section $1\n/i;

		print $wy "$_";
		next;
	}

	#	Include'y (includes)
	if ( /^\s*include/io ) {

		s/^\s*include\s*([\"\w\/\.]+)(.*)$/\%include $1 $2 \n/i;
		#	nazwa pliku	  ^^^^^^ 	(filename)

		print $wy "$_";
		next;
	}

	#	Extern'y (externs)

	if ( /^\s*extrn/io ) {

		s/^\s*extrn\s+(\w+)\s+(.*)$/extern $1 $2\n/i;

		print $wy "$_";
		next;
	}

	#	Symbole publiczne (pubilc symbols)

	if ( /^\s*public/io ) {

		s/^\s*public\s+(\w+)\s+(.*)$/global $1 $2\n/i;

		print $wy "$_";
		next;
	}

	#	Struktury (structures):

	if ( /^\s*struc/io ) {

		# nazwa struktury (the name of the structure)
		s/^\s*struc\s+(\w+)/struc $1/i;
		my $nazwa = $1;

		do {

			s/r([bwdqt])/res$1/i;

			# szukamy konca struktury (look for the end of the structure)
			if ( /\s*}.*/o ) {

				# dolaczamy pole zawierajace rozmiar struktury (add a structure size field)
				#s/\s*\}.*/\n\t.${nazwa}_size\t= \$ - .\n\}\n/;
				s/\s*}.*/\nendstruc\n/;
				print $wy "$_";
				next CZYTAJ;
			}

			# przetwarzanie dyrektyw kompilacji warunkowej (processing of conditional compiling directives)
			&kom_war(0);
			print $wy "$_";

		} while ( <$we> );

		next;
	}

	if ( /^\s*macro/io ) {

		s/^\s*macro\s+(\w+)\s+([\w\s\,]+)$/\%imacro\t$1 /i;
		my @args = split(/,/o, $2);
		chomp;
		$_ .= $#args+1;
		print $wy "$_";

		while ( <$we> ) {

			s/r([bwdqt])/res$1/i;

			# szukamy konca makra (look for the end of the macro)
			if ( /\s*}.*/o ) {

				# dolaczamy pole zawierajace rozmiar struktury (add a structure size field)
				#s/\s*\}.*/\n\t.${nazwa}_size\t= \$ - .\n\}\n/;
				s/\s*}.*/\n\%endm\n/o;
				print $wy "$_";
				next CZYTAJ;
			}

			# przetwarzanie dyrektyw kompilacji warunkowej (processing of conditional compiling directives)
			&kom_war(0);
			print $wy "$_" unless /(^\s*(\%|\{))|(equ\s+param)/io;

		}

	}

	s/\s+eq\s+/ equ\t/gio if /.*eq\s+\w+/io;
	s/\s+eq\s+/ equ\n/gio if /.*eq\s+$/io;
	s/mod/\%/gio;

	if ( /^\s*align/io ) {

		s/mod/\%/gio;
		s/div/\//gio;
		s/shl/<</gio;
		s/shr/>>/gio;

		s/^\s*align\s+(.*)/align $1\n/i;
		print $wy "$_";
		next;
	}


	if ( /^\s*file/io ) {

		s/^\s*file\s+(.*)/incbin $1\n/i;
		print $wy "$_";
		next;
	}

	if ( /^\s*repeat/io ) {

		s/^\s*repeat\s+(.*)/\%rep $1\n/i;
		print $wy "$_";
		next;
	}

	if ( /^\s*virtual/io ) {

		s/^\s*virtual\s+at\s+(\w+)/absolute $1\n/i;
		print $wy "$_";
		next;
	}

	if ( /(^\s*|\s+)r([bwdqt])\s+/io ) {

		s/r([bwdqt])/res$1/i;
		print $wy "$_";
		next;
	}

	print $wy "$_";
}	# koniec petli CZYTAJ (end of CZYTAJ loop)


##########################################################
# Kompilacja warunkowa (conditional compiling)

sub	kom_war {

	# parametr = 0 => nie ma drukowania (when the parameter is 0, there will be no printing)
	my $drukuj = shift;

	# sklejanie argumentow: %+ (concatenating arguments: %+)
	s/#/\%\+/gio;

	# purge:
	if ( /^\s*(purge|restruc)/io )	{

		s/^\s*purge\s+(\w+)/\%undef\t$1/i;
		s/^.*restruc.*$//io;
		if ( $drukuj ) { print $wy "$_"; }
	}

	# rept:
	if ( /^\s*rep(ea)?t/io )	{

		s/^\s*rept\s+(\d+)\s*[\w\:]+\s*\{([\w\s]+)\}/\%rep $1\n$2\n\%endrep/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	# irp/s:
	if ( /^\s*irps?/io )	{

		#s/^\s*irps?\s+(\d+)\s*[\w\:]+\s*\{([\w\s]+)\}/\%rep $1\n$2\n\%endrep/i;
		if ( $drukuj ) { print $wy "\%error WARNING: skipped IRP/IRPS"; }
	}

	# match:
	if ( /^\s*match/io )	{

		#s/^\s*match\s+([\w\-]+)\s*,\s*([\w\-]+)\s*\{([\w\s]+)\}/\%if $1 = $2\n$3\n\%endif/i;
		if ( $drukuj ) { print $wy "\%error WARNING: skipped MATCH"; }
	}

	# end repeat:
	if ( /^\s*end\s+repeat/io )	{

		s/^\s*end\s+repeat\s+(\w+)/\%endrep\t$1/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	#	Definicje stalych #define (definitions of #define constants)
	if ( /^\s*\w+\s*=\s*\w+/o ) {

		s/^\s*(\w+)\s*=\s*(\w+)(.*)/\%idefine\t$1\t$2 $3\n/;
		if ( $drukuj ) { print $wy "$_"; }
	}

	#	Kompilacja warunkowa (conditional compiling)
	if ( /^\s*if\s+defined/io ) {

		s/^\s*if\s+defined(.*)$/\%ifdef $1/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*if\s+~\s*defined/io ) {

		s/^\s*if\s+~\s*defined(.*)$/\%ifndef $1/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*end\s+if/io ) {

		s/^\s*end\s+if.*$/\%endif/io;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*else\s+if/io ) {

		s/^\s*else\s+if(.*)$/\%elif $1/i;

	#	Operatory logiczne, mod i div (logical operators, mod and div):
		s/and/&&/gio;
		s/or/||/gio;
		s/&/&&/go;
		s/\|/||/go;
		s/xor/^^/gio;
		s/~/!/go;
		s/mod/\%/gio;
		s/div/\//gio;
		s/shl/<</gio;
		s/shr/>>/gio;

		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*else/io ) {

		s/^\s*else(.*)$/\%else $1/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*if/io ) {

		s/^\s*if(.*)$/\%if $1/i;

	#	Operatory logiczne, mod i div (logical operators, mod and div):
		s/and/&&/gio;
		s/or/||/gio;
		s/&/&&/go;
		s/\|/||/go;
		s/xor/^^/gio;
		s/~/!/go;
		s/mod/\%/gio;
		s/div/\//gio;
		s/shl/<</gio;
		s/shr/>>/gio;

		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*display/io  ) {

		s/^\s*display(.*)$/\%error "$2"/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

}

##########################################################
# Koniec (the end):


close $wy;
close $we;

