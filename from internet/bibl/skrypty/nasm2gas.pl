#!/usr/bin/perl -W
#
# nasm2gas.pl - Skrypt konwertujacy kod w skladni NASMa na kod w skladni GAS (GNU as)
# nasm2gas.pl - A script which converts NASM code to GAS (GNU as) code.
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
#		./nasm2gas.pl xxx.[n]asm [yyy.s]
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

$help_msg = "$0: Konwerter z NASMa do GNU as / NASM-to-GNU as converter.\nAutor/Author: Bogdan Drozdowski, ".
	"http://rudy.mif.pg.gda.pl/~bogdro/inne/\n".
	"Skladnia/Syntax: $0 [--help] [--license] xxx.[n]asm [yyy.s]\n\n
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

$lic_msg = "$0: Konwerter z NASMa do GNU as / NASM-to-GNU as converter.\nAutor/Author: Bogdan Drozdowski, ".
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
# 	Zmieniamy rozszerzenie z .[n]asm na .s (change the extension from .[n]asm to .s)
	$wyj =~ s/\.n?asm$/\.s/io;
#	Zmieniamy spacje na podkreslenia (change spaces to underlines)
	$wyj =~ s/\s+/_/go;

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
	if ( /^\s*$/o ) {
		print $wy "\n";
		next;
	}

	# sprawdzamy, czy komentarz jest jedyny na linii (check if a comment is the only thing on this line)
	if ( /^\s*;.*$/o ) { &komen(1); next; }

	# przetwarzanie dyrektyw kompilacji warunkowej (processing of conditional compiling directives)
	&kom_war(0);

	# zmiana liczb heksadecymalnych na postac 0x... (changing hexadecimal numbers to 0x... form):
	s/\b([[:xdigit:]]+)h/0x$1/gi;
	s/\b\$([[:xdigit:]]+)/0x$1/gi;

	# ==================== Etykiety (labels)

	# jesli sama w wierszu (if the only thing on a line)
	if ( /^\s*([\w\.]+)\s*:\s*$/o )	{ s/\s*(\w+)\s*:\s*$/$1:\n/; print $wy "$_"; next; }

	# jesli za nia cos jest (if there's something following it)
	s/^\s*([\w\.]+)\s*:\s*(.*)$/$1:\n\t$2/;

	# ==================== Dyrektywy (directives)

	if ( /^\s*absolute/io )		{ next; }

	if ( /^\s*cpu/io )		{ next; }

	if ( /^\s*common/io )		{ next; }

	if ( /^\s*\%(arg|stacksize|local|line|!|push|pop|repl)/io ) { next; }

	if ( /^\s*bits/io )		{ s/^\s*bits\s*(.*)/\.code$1/i; print $wy "$_"; next; }

	if ( /^\s*global\b/io )	 	{ s/^\s*public\s*(.*)/\.globl\t$1/i; print $wy "$_"; next; }

	if ( /^\s*\%include\b/io ) 	{ s/^\s*\%include\s*(.*)/\.include\t$1/i; print $wy "$_"; next; }

	if ( /^\s*\w+\s+equ\b/io ) 	{ s/^\s*(\w+)\s+equ(.*)/\.equ $1, $2/i; print $wy "$_"; next; }

	if ( /^\s*alignb?\b/io ) 	{ s/^\s*alignb?\s+(\d+)/\.align $1/i; print $wy "$_"; next; }

	if ( /^\s*extern\b/io ) 	{ s/^\s*extern\s*(.*)/\.extern\t$1/i; print $wy "$_"; next; }

	if ( /^\s*org\b/io )		{ s/^\s*org(.*)(,.*)?$/\.org\t$1/i; print $wy "$_"; next; }

	if ( /^\s*\%macro\b/io )	{

		my $argnum = "";
		my $a1 = 0;
		my $linia = "";
		s/^\s*\%macro\s+(\w+)\s+(\d+(-(\d+|\*))?)([\w,\s]+)?/\.macro $1/i and $a1 = $2;

		if ( /\d+-(\d+)/o ) {
			($argnum = $a1) =~ s/\d+-(\d+|\*)/$1/;
		} else {
			$argnum = $a1;
		}

		$argnum =~ s/\%//go;
		my $argex ="\t.equ \%0, $argnum\n";

		for ( my $i=0; $i < $argnum; $i++ ) {

			$linia .= "arg$i ";
			$argex .= "\t .equ \%$i, arg$i\n";
		}

		s/^\s*\.macro\s+(\w+).*/\.macro\t$1\t$linia\n$argex/i;
		print $wy "$_";
		next;
	}

	if ( /^\s*\%endmacro\b/io )	{

		s/^\s*\%endmacro(.*)/\.endm$1\n/i;
		print $wy "$_";
		next;
	}

	if ( /^\s*struc/io )		{

		while ( <$we> && ! /^\s*endstruc/io ) {};
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
	if ( /^[^;]*\btimes\b/io )		{

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
	s/\%\+/,/go;

	# pomijamy makra (skip over macros)
	if ( /^\s*\%\s*[ix]{0,2}define\s+\w+\s*\(/io )	{ return; }


	# rep:
	if ( /^\s*\%rep/io )	{

		s/^\s*\%rep\s+(\d+)/.rept $1\n/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	# %endrep:
	if ( /^\s*\%\s*endrep/io )	{

		s/^\s*\%\s*endrep/\.endr\t$1/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	#	Definicje stalych #define (definitions of #define constants)
	if ( /^\s*\%\s*[ix]{0,2}define\s+/io ) {

		s/^\s*\%\s*[ix]{0,2}define\s+(\w+)\s+([\w\"\|\&\<\>\(\)\-\+]*)/\.equ\t$1, $2/i;

		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	#	Kompilacja warunkowa (conditional compiling)
	if ( /^\s*\%if(def|macro)/io ) {

		s/^\s*\%if(def|macro)(.*)$/\.ifdef $2/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	if ( /^\s*\%ifndef/io ) {

		s/^\s*\%ifndef(.*)$/\.ifndef $1/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	if ( /^\s*\%endif/io ) {

		s/^\s*\%endif.*$/\.endif/io;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	if ( /^\s*\%elif/io ) {

		s/^\s*\%elif(.*)$/\.elseif $1/i;

		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	if ( /^\s*\%else/io ) {

		s/^\s*\%else(.*)$/\.else $1/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	if ( /^\s*\%if/io ) {

		s/^\s*\%if(.*)$/\.if $1/i;

		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	if ( /^\s*\%error/io ) {

		s/^\s*\%error(.*)$/\.err "$2"/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	# %substr:
	if ( /^\s*\%\s*substr/io )	{

#		s/^\s*\%\s*substr\s+(\w+)\s+([\w\s\"\'\`]+)\s+(\d+)/$1 = $2[$3]/i;
		if ( $drukuj ) { print $wy "\.err \"WARNING: skipped \%substr\""; }
		return;
	}

	# %strlen:
	if ( /^\s*\%\s*strlen/io )	{

#		s/^\s*\%\s*strlen\s+(\w+)\s+([\w\s\"\'\`]+)/\@\@: db $2\n$1 = \$-\@b/i;
		if ( $drukuj ) { print $wy "\.err \"WARNING: skipped \%strlen\""; }
		return;
	}

	# %assign:
	if ( /^\s*\%\s*assign/io )	{

		s/^\s*\%\s*assign\s+(\w+)\s+(\w+)/\.equ\t$1, $2/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	# %rotate:
	if ( /^\s*\%\s*rotate/io )	{

		s/^\s*\%\s*rotate\s+(\w+)//io;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	# %undef:
	if ( /^\s*\%\s*undef/io )	{

		s/^\s*\%\s*undef\s+(\w+)/\.equ $1, /i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	# identycznosc napisow (identity of strings)
	if ( /^\s*\%\s*ifidni?/io ) {

		s/^\s*\%\s*ifidni?\s+([\w+\'\"\`]+)\s+([\w+\'\"\`]+)/\.if $1 = $2/i;
		if ( $drukuj ) { print $wy "$_"; }
		return;
	}

	# sprawdzanie typu (type checking)
	if ( /^\s*\%\s*if(id|num|str)/io ) {

		if ( $drukuj ) { print $wy "\n"; }
		return;
	}



}


##########################################################
# Koniec (the end):

close $wy;
close $we;

