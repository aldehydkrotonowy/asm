#!/usr/bin/perl -W
#
# gas2fasm.pl - Skrypt konwertujacy kod w skladni GAS (GNU as) na kod w skladni FASMa
# gas2fasm.pl - A script which converts GAS (GNU as) code to FASM code.
#
#	Copyright (C) 2006-2010,2012 Bogdan 'bogdro' Drozdowski, http://rudy.mif.pg.gda.pl/~bogdro/inne/
#		(bogdandr AT op.pl, bogdro AT rudy.mif.pg.gda.pl)
#
#	Licencja / Licence:
#	Powszechna Licencja Publiczna GNU v3+ / GNU General Public Licence v3+
#
#	Ostatnia modyfikacja / Last modified : 2012-03-20
#
#	Sposob uzycia / Syntax:
#		./gas2fasm.pl xxx.s [yyy.asm]
#
# Jesli nazwa pliku wyjsciowego nie zostanie podana, jest brana taka sama jak pliku
#	wejsciowego (tylko rozszerzenie sie zmieni na .asm). Jesli za nazwe
#	pliku wejsciowego podano "-", czytane jest standardowe wejscie.
#	Jesli nazwa pliku wyjsciowego to "-" (lub nie ma jej, gdy wejscie to stdin),
#	wynik bedzie na standardowym wyjsciu.
#
# If there's no output filename, then it is assumed to be the same as the
#	input filename (only the extension will be changed to .asm). If the
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
use Asm::X86 qw(conv_att_instr_to_intel conv_att_addr_to_intel);

my ($wyj);

my ($help, $lic, $help_msg, $lic_msg);

$help_msg = "$0: Konwerter z GNU as do FASMa / GNU as-to-FASM converter.\nAutor/Author: Bogdan Drozdowski, ".
	"http://rudy.mif.pg.gda.pl/~bogdro/inne/\n".
	"Skladnia/Syntax: $0 [--help] [--license] xxx.s [yyy.asm]\n\n
 Jesli nazwa pliku wyjsciowego nie zostanie podana, jest brana taka sama jak
pliku wejsciowego (tylko rozszerzenie sie zmieni na .asm). Jesli za nazwe
pliku wejsciowego podano \"-\", czytane jest standardowe wejscie.
 Jesli nazwa pliku wyjsciowego to \"-\" (lub nie ma jej, gdy wejscie to stdin),
wynik bedzie na standardowym wyjsciu.

 If there's no output filename, then it is assumed to be the same as the
input filename (only the extension will be changed to .asm). If the
input filename is \"-\", standard input will be read.
 If the output filename is \"-\" (or missing, when input is stdin),
the result will be written to the standard output.\n";

$lic_msg = "$0: Konwerter z GNU as do FASMa / GNU as-to-FASM converter.\nAutor/Author: Bogdan Drozdowski, ".
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
# 	Zmieniamy rozszerzenie z .s na .asm (change the extension from .s to .asm)
	$wyj =~ s/\.s$/\.asm/io;
#	Zmieniamy spacje na podkreslenia (change spaces to underlines)
	$wyj =~ s/\s+/_/go;

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

	# zmiana komentarzy (change the comments)
	&komen;

	# sprawdzamy, czy komentarz jest jedyny na linii (check if a comment is the only thing on this line)
	if ( /^\s*;.*$/o ) { next; }

	# przetwarzanie dyrektyw kompilacji warunkowej (processing of conditional compiling directives)
	&kom_war(0);





	# ==================== Etykiety (labels)
	# zmiana ".Lnnn" na "_Lnnn", zeby etykiety byly widzialne globalnie
	# (changing ".Lnnn" to "_Lnnn", so the labels are globally visible)
	s/\.L([a-zA-Z])(\d+)/_L$1$2/gi;
	s/\.L(\d+)/_L$1/gi;

	# jesli sama w wierszu (if the only thing on a line)
	if ( /^\s*([\w\.]+)\s*:\s*$/o )	{ s/\s*(\w+)\s*:\s*$/$1:\n/; print $wy "$_"; next; }

	# jesli za nia cos jest (if there's something following it)
	s/^\s*([\w\.]+)\s*:\s*(.*)$/$1:\n\t$2/;


	# ==================== Dyrektywy (directives)
	if ( /^\s*\.globa?l/io )	{ s/^\s*\.globa?l\s*(.*)/public\t$1/i; print $wy "$_"; next; }

	if ( /^\s*\.include/io ) 	{ s/^\s*\.include\s*(.*)/include\t$1/i; print $wy "$_"; next; }

	# "xxx .equ yyy"
	if ( /^\s*\w+\.(set|equ)/io ) 	{ s/^\s*(\w+)\.(set|equ)\s*(\w+)\s*/$1\tequ\t$3/i; print $wy "$_"; next; }
	# ".equ xxx, yyy" - to uwzglednia 'equiv' ( - this includes 'equiv'):
	if ( /^\s*\.(set|equ)/io ) 	{ s/^\s*\.(set|equ)\s*(\w+)\s*,\s*(\w+)/$2\tequ\t$3/i; print $wy "$_"; next; }

	if ( /^\s*\.b?align[wl]?/io ) 	{ s/^\s*\.b?align[wl]?\s+(\d+)\s*(,.*)?/align $1\n/i; print $wy "$_"; next; }

	if ( /^\s*\.l?comm\s*(.*),(.*),(.*)/io )	{
		s/^\s*\.l?comm\s*(.*),(.*),(.*)/section ".data" writeable align 4096\nalign $3\n$1: times $2 db 0/i;
		print $wy "$_"; next;
	}
	if ( /^\s*\.l?comm\s*(.*),(.*)/io ) 		{
		s/^\s*\.l?comm\s*(.*),(.*)/section ".data" writeable align 4096\n$1: times $2 db 0/i;
		print $wy "$_"; next;
	}

	if ( /^\s*\.desc/io ) 		{ print $wy "\n"; next; }

		# pomijamy blok .def (skip over a .def block)
	if ( /^\s*\.def/io )		{

		while ( <$we> ) {

			if ( /\.endef/io ) { next CZYTAJ; }
		}
	}

	if ( /^\s*\.break/io ) 		{ print $wy "\n"; next; }

	if ( /^\s*\.(app-)?file/io ) 	{ print $wy "\n"; next; }

	if ( /^\s*\.extern/io ) 	{ s/^\s*\.extern\s*(.*)/extrn\t$1/i; print $wy "$_"; next; }

	if ( /^\s*\.fill\s*(.*),(.*),(.*)/io ) 	{ s/^\s*\.fill\s*(.*),(.*),(.*)/times $1*$2 db $3/i; print $wy "$_"; next; }
	if ( /^\s*\.fill\s*(.*),(.*)/io ) 	{ s/^\s*\.fill\s*(.*),(.*)/times $1*$2 db 0/i; print $wy "$_"; next; }
	if ( /^\s*\.fill\s*(.*)/io ) 		{ s/^\s*\.fill\s*(.*)/times $1 db 0/i; print $wy "$_"; next; }

	if ( /^\s*\.ident/io ) 		{ print $wy "\n"; next; }

	# $repeat mowi, czy jestesmy w bloku 'repeat' (= 1), czy w 'irp/s' (= 0)
	# ($repeatsays, whether we're in a 'repeat' (= 1) or a 'irp/s' (= 0) block)
	my $repeat = 0;

	if ( /^\s*\.irpc/io ) 		{ s/^\s*\.irp\s*(.*)/irps $1 {/i;    $repeat = 0; print $wy "$_"; next; }
	if ( /^\s*\.irp/io  ) 		{ s/^\s*\.irp\s*(.*)/irp $1 {/i;     $repeat = 0; print $wy "$_"; next; }
	if ( /^\s*\.rept/io ) 		{ s/^\s*\.rept\s*(.*)/repeat $1 {/i; $repeat = 1; print $wy "$_"; next; }

	if ( /^\s*\.endr/io )		{

		# irp/irpc { ... }
		if ( ! $repeat ) {

			s/^\s*\.endr.*$/}\n/io;

		# repeat ... end repeat
		} else {

			s/^\s*\.endr.*$/end repeat\n/io;
		}
		print $wy "$_";
		next;
	}

	if ( /^\s*\.lflags/io ) 	{ print $wy "\n"; next; }

	if ( /^\s*\.(line|ln)/io )	{ print $wy "\n"; next; }

	if ( /^\s*\.linkonce/io )	{ print $wy "\n"; next; }

	if ( /^\s*\.mri/io )		{ print $wy "\n"; next; }

	if ( /^\s*\.(no)?list/io )	{ print $wy "\n"; next; }

	if ( /^\s*\.macro/io )		{

		# usuwamy domyslne wartosci argumentow (remove arguments' default values)
		s/(\w+)\s*=\s*\w+/$1 /g;

		# argumenty makra moga byc oddzielone tylko spacjami
		# (macro arguments may be separated only by spaces)
		s/^\s*\.macro\s+(\w+)\s+([\w,\s]+)/.macro $1 $2/i;

		my $args = $2;
		# zmiana spacji na przecinki (change spaces to commas)
		$args =~ s/(\w+)\s+(\w+)/$1, $2/g;

		s/^\s*\.macro\s+(\w+).*/macro\t$1 $args {\n/i;
		print $wy "$_";
		next;
	}

	if ( /^\s*\.endm/io )		{ s/^\s*\.endm.*$/}\n/io; print $wy "$_"; next; }

	if ( /^\s*\.org/io )		{ s/^\s*\.org(.*)(,.*)?$/org\t$1/i; print $wy "$_"; next; }

	if ( /^\s*\.psize/io )		{ print $wy "\n"; next; }

	if ( /^\s*\.sbttl/io )		{ print $wy "\n"; next; }

	if ( /^\s*\.section/io ) 	{ s/^\s*\.section\s*([\w\-\.]+).*$/section "$1" align 32/i; print $wy "$_"; next; }

	if ( /^\s*\.(skip|space)\s*(.*),(.*)$/io ) 	{ s/^\s*\.(skip|space)\s*(.*),(.*)$/times $1 db $2/i; print $wy "$_"; next; }
	if ( /^\s*\.(skip|space)\s*(.*)$/io ) 		{ s/^\s*\.(skip|space)\s*(.*)$/times $1 db 0/i; print $wy "$_"; next; }

	if ( /^\s*\.stab[dns]/io )	{ print $wy "\n"; next; }

	if ( /^\s*\.symver/io )		{ print $wy "\n"; next; }

	if ( /^\s*\.title/io )		{ print $wy "\n"; next; }

	if ( /^\s*\.code\d{2}/io ) 	{ s/^\s*\.code(\d{2})/use $1/i; print $wy "$_"; next; }

	if ( /^\s*\.type/io )		{ print $wy "\n"; next; }

	if ( /^\s*\.size/io )		{ print $wy "\n"; next; }

	if ( /^\s*\.p2align/io )	{ s/^\s*\.p2align\s*(\d+)\s*,.*/align 1 shl $1/i; print $wy "$_"; next; }





	# ==================== Sekcje (sections)
	if ( /^\s*\.data/io ) 		{ s/\s*\.data\s*.*$/section ".data" writeable align 4096\n/io; print $wy "$_"; next; }

	if ( /^\s*\.text/io ) 		{ s/\s*\.text\s*.*$/section ".text" writeable executable align 4096\n/io; print $wy "$_"; next; }

	if ( /^\s*\.bss/io ) 		{ s/\s*\.bss\s*.*$/section ".bss" writeable align 4096\n/io; print $wy "$_"; next; }


	# ==================== Dane (data)
	if ( /\s*\.byte/io ) 		{ s/\s*\.byte\s*(.*)/ db $1/i; print $wy "$_"; next; }

	if ( /\s*\.(h?word|short)/io ) 	{ s/\s*\.(h?word|short)\s*(.*)/ dw $2/i; print $wy "$_"; next; }

	if ( /\s*\.double/io ) 		{ s/\s*\.double\s*(.*)/ dq $1/i; print $wy "$_"; next; }

	if ( /\s*\.(float|single)/io ) 	{ s/\s*\.(float|single)\s*(.*)/ dd $2/i; print $wy "$_"; next; }

	if ( /\s*\.(int|long)/io )	{ s/\s*\.(int|long)\s*(.*)/ dd $2/i; print $wy "$_"; next; }

	# FASM nie ma 'ddq', wiec wyswietli sie blad. Nie wolno tego przepuscic z mniejszym rozmiarem
	# (no 'ddq' in FASM, so an error will occur. We mustn't let this through with a smaller size)
	if ( /\s*\.octa/io ) 		{ s/\s*\.octa\s*(.*)/ ddq $1/i; print $wy "$_"; next; }

	if ( /\s*\.quad/io ) 		{ s/\s*\.quad\s*(.*)/ dq $1/i; print $wy "$_"; next; }

	if ( /\s*\.zero/io ) 		{ s/\s*\.zero\s*(\d+)/ rb $1/i; print $wy "$_"; next; }

	if ( /\s*\.(s|u)leb128/io ) 	{ print $wy "\n"; next; }

	if ( /\s*\.tfloat/io ) 		{ s/\s*\.tfloat\s*(.*)/ dt $1/i; print $wy "$_"; next; }

	if ( /\s*\.(string|ascii?z)/io )	{

		s/\n//go;
		s/\\n/", 10, "/go;
		s/\\r/", 13, "/go;
		s/\\t/", 9, "/go;
		s/\\a/", 7, "/go;
		s/\s*\.(string|ascii?z)\s*//io;
		# konczymy zerem (end with a zero)
		print $wy " db\t$_, 0\n";
		next;
	}

	if ( /\s*\.ascii/io )		{

		s/\n//go;
		s/\\n/", 10, "/go;
		s/\\r/", 13, "/go;
		s/\\t/", 9, "/go;
		s/\\a/", 7, "/go;
		s/\s*\.ascii\s*//io;
		# nie konczymy zerem (don't end with a zero)
		print $wy " db\t$_\n";
		next;
	}


	# ==================== Instrukcje (instructions)

	$_ = conv_att_instr_to_intel ($_);

	# ==================== Zmiana odnoszenia sie do pamieci (changing memory references):

	$_ = conv_att_addr_to_intel ($_);

	# usuwanie znakow '#' z dyrektyw kompilacji warunkowej
	# (removing the '#' chars form conditional compiling directives)
	s/\#//go;

	print $wy "$_";
}


##########################################################
# Zmiana komentarzy (changing the comments).
# GAS ma takie same komentarze, jak C (GAS has the same comments as C)

sub	komen {

	#	Komentarze jednolinijkowe (one-line comments):
	if ( /^(.+)\/\*(.*)\*\/(.+)$/o )	{ s/(.+)\/\*(.*)\*\/(.+)$/$1 $3 ; $2/g;	return $_; }
	if ( /^\/\*(.*)\*\/(.+)$/o )	{ s/\/\*(.*)\*\/(.+)$/$2 ; $1/g;	return $_; }
	if ( /^(.+)\/\*(.*)\*\/$/o )	{ s/(.+)\/\*(.*)\*\/$/$1 ; $2/g;	return $_; }
	if ( /^(.+)#(.*)$/o )		{ s/^(.+)#(.*)$/$1 ; $2/g;		return $_; }

	# Jesli komentarz jest jedyna rzecza w wierszu, to od razu go wypisujemy i idziemy dalej
	# (if the comment is the only thing on this line, we print it to the file and go further)
	if ( /^\/\*(.*)\*\/$/o )	{ s/\/\*(.*)\*\/$/; $1/g; print $wy "$_"; return $_; }
	if ( /^#.*$/o )			{ s/^#(.*)$/; $1/g; print $wy "$_";	return $_; }

	# Komentarze wielolinijkowe (multi-line comments)
	if ( /^(.*)\/\*(.*)$/o ) {

		# wyrzucamy /* z zachowaniem tego, co bylo przed tym
		# (we remove the /*, saving whatever was in front of it)
		s/^(.*)\/\*(.*)$/$1; $2/;
		print $wy "$_";

		while ( <$we> ) {

			# po prostu stawiamy srednik przed kazda linia
			# (we simply add a semicolon in front of every line)
			s/^(.*)$/; $1/;

			# jak trafimy na */, to go kasujemy i przerywamy ta petle
			# (when we find */, we remove it and stop this loop)
			if ( /\*\//o ) {

				s/\*\///o;
				print $wy "$_";
				return $_;
			}
			print $wy "$_";
		}
	}

}

##########################################################
# Kompilacja warunkowa (conditional compiling)

sub	kom_war {

	# parametr = 0 => nie ma drukowania (when the parameter is 0, there will be no printing)
	my $drukuj = shift;

	# UWAGA: na poczatku dajemy '#', zeby nie zostalo wziete do obrobki pozniej
	# ATTENTION: we put a '#' in front, so these won't be affected by further processing

	#	Kompilacja warunkowa (conditional compiling)
	if ( /^\s*\.ifdef/io ) {

		s/^\s*\.ifdef(.*)$/#if defined $1/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*\.ifn(ot)?def/io ) {

		# zgodnie z podrecznikiem (according to the manual)
		s/^\s*\.ifn(ot)?def(.*)$/#if ~defined $1 | defined \@f\n\@\@:/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*\.endif/io ) {

		s/^\s*\.endif.*$/#end if/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*\.elseif/io ) {

	#	Operatory logiczne, mod i div (logical operators, mod and div):
		s/&&/&/go;
		s/\|\|/|/go;
		s/!/~/go;
		s/%/mod/go;
		s/\//div/go;
		s/<</shl/go;
		s/>>/shr/go;

		s/^\s*\.elseif(.*)$/#else if $1/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*\.else/io ) {

		s/^\s*\.else(.*)$/#else $1/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*\.if/io ) {

	#	Operatory logiczne, mod i div (logical operators, mod and div):
		s/&&/&/go;
		s/\|\|/|/go;
		s/!/~/go;
		s/%/mod/go;
		s/\//div/go;
		s/<</shl/go;
		s/>>/shr/go;

		s/^\s*\.if(.*)$/#if $1/i;
		# XXX: zostawiam tu "!defined" (I leave "!defined" here)
		# s/!\s*defined\s+(\w+)/(~defined $1 | defined \@f)/g;
		# if ( /~defined/ )	{ s/$/\n\@\@:\n/; };
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /\s*\.err/io ) {

		s/\s*\.err(.*)$/#display "$1"/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

}


##########################################################
# Koniec (the end):

close $wy;
close $we;

