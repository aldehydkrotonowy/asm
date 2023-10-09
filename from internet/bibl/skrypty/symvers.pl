#!/usr/bin/perl -W
#
# symvers.pl - Skrypt dopisujacy do modulu jadra 2.6 sekcje '__versions'
# symvers.pl - A script which adds the '__versions' section to a 2.6 kernel module
#
#	Copyright (C) 2006-2007 Bogdan 'bogdro' Drozdowski, http://rudy.mif.pg.gda.pl/~bogdro/inne/
#		(bogdandr AT op.pl, bogdro AT rudy.mif.pg.gda.pl)
#
#	Licencja / Licence:
#	Powszechna Licencja Publiczna GNU v2 / GNU General Public Licence v2
#
#	Ostatnia modyfikacja / Last modified : 2007-01-17
#
#	Sposob uzycia / Syntax:
#		./symvers.pl xxx.asm
#
# Jesli za nazwe pliku wejsciowego podano "-", czytane jest standardowe wejscie,
#	a wynik jest zapisywany na standardowe wyjscie.
#
# If the input filename is "-", standard input will be read and the result will
#	be written to the standard output.
#
#
#    Niniejszy program jest wolnym oprogramowaniem; mozesz go
#    rozprowadzac dalej i/lub modyfikowac na warunkach Powszechnej
#    Licencji Publicznej GNU, wydanej przez Fundacje Wolnego
#    Oprogramowania - wedlug wersji 2-giej tej Licencji lub ktorejs
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
# as published by the Free Software Foundation; either version 2
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

my ($wyj, $wersja, $sekcja, $plik);

my ($help, $lic, $help_msg, $lic_msg);

$help_msg = "$0: Skrypt dopisujacy do modulu jadra 2.6 sekcje '__versions'.\n".
	" / A script which adds the '__versions' section to a 2.6 kernel module.\nAutor/Author: Bogdan Drozdowski, ".
	"http://rudy.mif.pg.gda.pl/~bogdro/inne/\n".
	"Skladnia/Syntax: \n$0 [--help] [--license] [--symvers sciezka/do/Module.symvers] xxx.asm
$0 [--help] [--license] [--symvers path/to/Module.symvers] xxx.asm\n\n
 Jesli za nazwe pliku wejsciowego podano \"-\", czytane jest standardowe
wejscie, a wynik jest zapisywany na standardowe wyjscie.

 If the input filename is \"-\", standard input will be read and the
result will be written to the standard output.\n";

$lic_msg = "$0: Skrypt dopisujacy do modulu jadra 2.6 sekcje '__versions'.\n".
	" / A script which adds the '__versions' section to a 2.6 kernel module.\nAutor/Author: Bogdan Drozdowski, ".
	"http://rudy.mif.pg.gda.pl/~bogdro/inne/\n\n".
	"    Niniejszy program jest wolnym oprogramowaniem; mozesz go
    rozprowadzac dalej i/lub modyfikowac na warunkach Powszechnej
    Licencji Publicznej GNU, wydanej przez Fundacje Wolnego
    Oprogramowania - wedlug wersji 2-giej tej Licencji lub ktorejs
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
 as published by the Free Software Foundation; either version 2
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

Getopt::Long::Configure ( "ignore_case", "ignore_case_always" );

if ( ! GetOptions(
	'symvers=s'		=>	\$plik,
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

##########################################################
# Otwieranie plikow (opening the files)

if ( $ARGV[0] eq "-" ) {

	if ( !open ( WE, "< $ARGV[0]" ) ) {
	#	$! jest trescia bledu. ($! is the error message)
		print "$0: $ARGV[0]: $!\n";
		exit 2;
	}

} else {

	if ( !open ( WE, "+< $ARGV[0]" ) ) {
	#	$! jest trescia bledu. ($! is the error message)
		print "$0: $ARGV[0]: $!\n";
		exit 2;
	}
}

$wersja = `uname -r`;
{
	local $/ = "";
	chomp $wersja;
}

if ( ! $plik && $wersja ) {
		if (	-r "/lib/modules/$wersja/build/Module.symvers" )
			{ $plik = "/lib/modules/$wersja/build/Module.symvers"; }

		elsif (	-r "/usr/src/kernels/$wersja/Module.symvers" )
			{ $plik = "/usr/src/kernels/$wersja/Module.symvers"; }

		elsif (	-r "/usr/src/linux-$wersja/Module.symvers" )
			{ $plik = "/usr/src/linux-$wersja/Module.symvers"; }
}

if ( ! $plik && ! $wersja && -r "/usr/src/linux/Module.symvers" ) {
	$plik = "/usr/src/linux/Module.symvers";
}

if ( ! $plik ) {

	print "Nie moge znalezc Module.symvers. Zainstaluj zrodla jadra lub pakiet devel.\n".
		"Can't find Module.symvers. Install kernel sources or the kernel devel package.\n";
	exit 4;
}

if ( !open ( SYMVER, $plik ) ) {
#	$! jest trescia bledu. ($! is the error message)
	print "$0: $plik: $!\n";
	close WE;
	exit 3;
}

my $symvers;

read SYMVER, $symvers, -s $plik;
close SYMVER;

my $licznik = 0;
my $symbol = "struct_module";

$symvers =~ /.*(0x[[:xdigit:]]+)\s+$symbol\s+.*/i;
my $crc = $1;

$sekcja = "\n\nsection \"__versions\" align 32\n____versions:\n".
	"\tdd\t$crc\n.s$licznik:\tdb\t\"$symbol\", 0\n\ttimes\t64-4-(\$-.s$licznik) db 0\n\n";
$licznik++;


##########################################################
# Przetwarzanie (processing):

CZYTAJ: while ( <WE> ) {

	if ( $ARGV[0] eq "-" ) { print; }

	if ( /exte?rn\s+(\w+)/i ) {

		$symbol = $1;

		# Sprawdzamy, czy ten symbol ma swoj wpis
		# (Check if this symbol has its entry)
		$symvers =~ /.*(0x[[:xdigit:]]+)\s+$symbol\s+.*/i or next CZYTAJ;
		$crc = $1;

		# Dodajemy do sekcji __versions blok:
		# (We add this block to the __versions section:)
		#	dd	0xfa02c634
		#  .sX:	db	"symbol_name", 0
		#	times	64-4-($-.sX) db 0

		$sekcja .= "\tdd\t$crc\n.s$licznik:\tdb\t\"$symbol\", 0\n\ttimes\t64-4-(\$-.s$licznik) db 0\n\n";
		$licznik++;
	}

}

if ( $ARGV[0] eq "-" ) { print $sekcja; }
else { print WE $sekcja; }

if ( $ARGV[0] ne "-" ) { close WE; }
