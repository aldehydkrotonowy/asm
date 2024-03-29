#!/usr/bin/perl -W
#
# fasm2gas.pl - Skrypt konwertujacy kod w skladni FASMa na kod w skladni GAS (GNU as)
# fasm2gas.pl - A script which converts FASM code to GAS (GNU as) code.
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
#		./fasm2gas.pl xxx.[f]asm [yyy.s]
#
# Jesli nazwa pliku wyjsciowego nie zostanie podana, jest brana taka sama jak pliku
#	wejsciowego (tylko rozszerzenie sie zmieni na .s). Jesli za nazwe
#	pliku wejsciowego podano "-", czytane jest standardowe wejscie.
#	Jesli nazwa pliku wyjsciowego to "-" (lub nie ma jej, gdy wejscie to stdin),
#	wynik bedzie na standardowym wyjsciu.
#
# If there's no output filename, then it is assumed to be the same as the
#	input filename (only the extension will be changed to .s). If the
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
use Asm::X86 qw(conv_intel_instr_to_att conv_intel_addr_to_att);

my ($wyj, $context);

my ($help, $lic, $help_msg, $lic_msg);

$help_msg = "$0: Konwerter z FASMa do GNU as / FASM-to-GNU as converter.\nAutor/Author: Bogdan Drozdowski, ".
	"http://rudy.mif.pg.gda.pl/~bogdro/inne/\n".
	"Skladnia/Syntax: $0 [--help] [--license] xxx.[f]asm [yyy.s]\n\n
 Jesli nazwa pliku wyjsciowego nie zostanie podana, jest brana taka sama jak
pliku wejsciowego (tylko rozszerzenie sie zmieni na .s). Jesli za nazwe
pliku wejsciowego podano \"-\", czytane jest standardowe wejscie.
 Jesli nazwa pliku wyjsciowego to \"-\" (lub nie ma jej, gdy wejscie to stdin),
wynik bedzie na standardowym wyjsciu.

 If there's no output filename, then it is assumed to be the same as the
input filename (only the extension will be changed to .s). If the
input filename is \"-\", standard input will be read.
 If the output filename is \"-\" (or missing, when input is stdin),
the result will be written to the standard output.\n";

$lic_msg = "$0: Konwerter z FASMa do GNU as / FASM-to-GNU as converter.\nAutor/Author: Bogdan Drozdowski, ".
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
	($wyj = $ARGV[0]) =~ s/.*\/([^\/]+)/$1/;
# 	Zmieniamy rozszerzenie z .[f]asm na .s (change the extension from .[f]asm to .s)
	$wyj =~ s/\.f?asm$/\.s/io;
#	Zmieniamy spacje na podkreslenia (change spaces to underlines)
	$wyj =~ s/\s+/_/g;

	if ( $wyj eq $ARGV[0] && $wyj ne "-" ) { $wyj .= ".s"; }
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

	# sprawdzamy, czy komentarz jest jedyny na linii (check if a comment is the only thing on this line)
	if ( /^\s*;.*$/o ) { &komen(1); next; }

	# przetwarzanie dyrektyw kompilacji warunkowej (processing of conditional compiling directives)
	&kom_war(0);

	# zmiana liczb heksadecymalnych na postac 0x... (changing hexadecimal numbers to 0x... form):
	s/\b([[:xdigit:]]+)h/0x$1/gio;
	s/\b\$([[:xdigit:]]+)/0x$1/gio;

	if ( /^\s*\}(.*)$/o ) {

		if ( $context eq "macro" ) { $_ = ".endm $1\n"; print $wy "$_"; }
		if ( $context eq "irp" || $context eq "rep" ) { $_ = ".endr $1\n"; print $wy "$_"; }
		$context = "";
		next;
	}


	# ==================== Etykiety (labels)

	# jesli sama w wierszu (if the only thing on a line)
	if ( /^\s*([\w\.]+)\s*:\s*$/o )	{ s/\s*(\w+)\s*:\s*$/$1:\n/; print $wy "$_"; next; }

	# jesli za nia cos jest (if there's something following it)
	s/^\s*([\w\.]+)\s*:\s*(.*)$/$1:\n\t$2/;

	# ==================== Dyrektywy (directives)

	if ( /^\s*format/io )		{ next; }

	if ( /^\s*public\b/io )	 	{ s/^\s*public\s*(.*)/\.globl\t$1/i; print $wy "$_"; next; }

	if ( /^\s*include\b/io ) 	{ s/^\s*include\s*(.*)/\.include\t$1/i; print $wy "$_"; next; }

	if ( /^\s*\w+\s+equ\b/io ) 	{ s/^\s*(\w+)\s+equ(.*)/\.equ $1, $2/i; print $wy "$_"; next; }

	if ( /^\s*align\b/io ) 		{ s/^\s*align\s+(\d+)/\.align $1/i; s/shl/<</io; print $wy "$_"; next; }

	if ( /^\s*extrn\b/io ) 		{ s/^\s*extrn\s*(.*)/\.extern\t$1/i; print $wy "$_"; next; }

	if ( /^\s*org\b/io )		{ s/^\s*org(.*)(,.*)?$/\.org\t$1/i; print $wy "$_"; next; }

	if ( /^\s*macro\b/io )	{

		s/^\s*macro\s+(\w+)\s+([\w,\s]+)/macro $1 $2/i;

		my $args = $2;
		# zmiana przecinków na spacje (change commas to spaces)
		$args =~ s/,//go;

		s/^\s*macro\s+(\w+).*/\.macro\t$1 $args\n/i;
		$context = "macro";
		print $wy "$_";
		next;
	}

	if ( /^\s*struc\b/io )	{

		while ( <$we> && ! /^\s*}/o ) {};
		$context = "struc";
		next;
	}

	if ( /^\s*virtual\b/io )	{

		while ( <$we> && ! /^\s*end/io ) {};
		$context = "struc";
		next;
	}

	# ==================== Sekcje (sections)

	if ( /^\s*(section|segment)/io )	{

		if ( /^\s*(section|segment)\s+['"].text['"]/io || /^\s*\.(section|segment).*exec/io  ) { print $wy ".text\n"; next; }
		if ( /^\s*(section|segment)\s+['"].data['"]/io || /^\s*\.(section|segment).*write/io ) { print $wy ".data\n"; next; }
		if ( /^\s*(section|segment)\s+['"].bss['"]/io ) { print $wy ".bss"; next; }

		if ( /^\s*(section|segment)\s+['"](.+)['"](.*)/io ) { print $wy "\.section $2\n"; next; }

		if ( /^\s*(section|segment) \.*read/io ) { print $wy ".data\n"; next; }
	}

	# ==================== Dane (data)

	if ( /^[^;]*\bdb\b/io )		{

		if ( ! /"/o && ! /'/o ) {
			s/\bdb\b(.*)/\.byte $1/i;
		} else {

			s/^[^;]*\bdb\b//io;
			s/""\s*,?\s*//go;
			s/''//go;
			s/^\s*([^"']+)/\n.byte $1/gi;
			s/\"([^"]*)\"/\n\.ascii "$1"\n/gi;
			s/\'([^']*)\'/\n\.ascii "$1"\n/gi;
			s/\n[^\.\s]/\n.byte/gio;

			s/,\s*$/\n/go;
			s/,\s*\./\n\./go;

		}
		print $wy "$_";
		next;
	}
	if ( /^[^;]*\bd[wu]\b/io )	{ s/\bd[wu]\b(.*)/\.word $1/i; print $wy "$_"; next; }
	if ( /^[^;]*\bdd\b/io )		{
		# float?
		if ( /\d+\./o ) {
			s/\bdd\b(.*)/\.float $1/i;
			print $wy "$_";
			next;
		} else {
			s/\bdd\b(.*)/\.long $1/i;
			print $wy "$_";
			next;
		}
	}
	if ( /^[^;]*\bd[pf]\b/io )	{ s/\bd[pf]\b(.*)/\.quad $1/i; print $wy "$_"; next; }
	if ( /^[^;]*\bdq\b/io )		{
		# float?
		if ( /\d+\./o ) {
			s/^\bdq\b(.*)/\.double $1/i;
			print $wy "$_";
			next;
		} else {
			s/\bdq\b(.*)/\.quad $1/i;
			print $wy "$_";
			next;
		}
	}
	if ( /^[^;]*\bdt\b/io )		{ s/\bdt\b(.*)/\.tfloat $1/i; print $wy "$_"; next; }

	# times:
	if ( /^[^;]*\btimes\b/io )	{

		my $rozmiar = 1;
		if ( /times\s+(\w+)\s+[rd][wu]\b/io ) { $rozmiar = 2; }
		if ( /times\s+(\w+)\s+[rd]d\b/io ) { $rozmiar = 4; }
		if ( /times\s+(\w+)\s+[rd][pf]\b/io ) { $rozmiar = 6; }
		if ( /times\s+(\w+)\s+[rd]q\b/io ) { $rozmiar = 8; }
		if ( /times\s+(\w+)\s+[rd]t\b/io ) { $rozmiar = 10; }
		s/times\s+(\w+)\s+\w+\s+(.*)/\.fill $1, $rozmiar, $2\n/i;
		print $wy "$_";
		next;
	}

	# ==================== Instrukcje (instructions)

	$_ = conv_intel_instr_to_att ($_);

	# ==================== Zmiana odnoszenia sie do pamieci (changing memory references):

	$_ = conv_intel_addr_to_att ($_);

	# zmiana komentarzy (change the comments)
	&komen(0);

	print $wy "$_";

}


##########################################################
# Zmiana komentarzy (changing the comments).
# GAS ma takie same komentarze, jak C (GAS has the same comments as C)

sub	komen {

	# parametr = 0 => nie ma drukowania (when the parameter is 0, there will be no printing)
	my $drukuj = shift;

	s/;(.*)/\/\* $1 \*\//;

	print $wy "$_" if $drukuj;
}

##########################################################
# Kompilacja warunkowa (conditional compiling)

sub	kom_war {

	# parametr = 0 => nie ma drukowania (when the parameter is 0, there will be no printing)
	my $drukuj = shift;

	# sklejanie argumentow: (concatenating arguments:)
	s/#/,/go;

	s/^[\{\s]+$/\n/go;

	# purge:
	if ( /^\s*(purge|restruc)/io )	{

		if ( $drukuj ) { print $wy "\.err \"WARNING: skipped PURGE/RESTRUC\""; }
		return;
	}

	# rept:
	if ( /^\s*rept/io )	{

		if ( /}/o ) {
			s/^\s*rept\s+(\d+)\s*[\w\:]+\s*\{([\w\s]+)\}/.rept $1\n$2\n/i;
		} else {
			s/^\s*rept\s+(\d+)\s*[\w\:]+\s*\{?/.rept $1\n/i;
			$context = "rep";
		}
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	if ( /^\s*repeat/io )	{

		s/^\s*repeat\s+(\d+)/.rept $1\n/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	# irp/s:
	if ( /^\s*irps?/io )	{

		if ( /}/o ) {
			s/^\s*irps?\s+(\d+)\s*[\w\:]+\s*\{([\w\s]+)\}/\.irp $1\n$2\n/i;
		} else {
			s/^\s*irps?\s+(\d+)\s*[\w\:]+\s*\{?/\.irp $1\n/i;
			$context = "irp";
		}
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	# match:
	if ( /^\s*match/io )	{

		if ( $drukuj ) { print $wy "\.err \"WARNING: skipped MATCH\""; }
		return;
	}

	# end repeat:
	if ( /^\s*end\s+repeat/io )	{

		s/^\s*end\s+repeat\s+(\w+)/\.endr\t$1/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	#	Definicje stalych (definitions of constants)
	if ( /^\s*\w+\s*=\s*\w+/o ) {

		s/^\s*(\w+)\s*=\s*(\w+)(.*)/\t.equ \t$1, $2 $3\n/;
		if ( $drukuj ) { print $wy "$_"; }
	}

	#	Kompilacja warunkowa (conditional compiling)
	if ( /^\s*if\s+defined/io ) {

		s/^\s*if\s+defined(.*)$/\.ifdef $1/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	if ( /^\s*if\s+~\s*defined/io ) {

		s/^\s*if\s+~\s*defined(.*)$/\.ifndef $1/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	if ( /^\s*end\s+if/io ) {

		s/^\s*end\s+if.*$/\.endif/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	if ( /^\s*else\s+if/io ) {

		s/^\s*else\s+if(.*)$/\.elseif $1/i;

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
		return;
	}

	if ( /^\s*else/io ) {

		s/^\s*else(.*)$/\.else $1/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	if ( /^\s*if/io ) {

		s/^\s*if(.*)$/\.if $1/i;

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
		return;
	}

	if ( /^\s*display/io  ) {

		s/^\s*display(.*)$/\.err "$2"/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

}


##########################################################
# Koniec (the end):

close $wy;
close $we;

