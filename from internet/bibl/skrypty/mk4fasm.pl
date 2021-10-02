#!/usr/bin/perl
#
# make4fasm.pl - Skrypt generujacy Makefile dla plikow obecnych w katalogu
# make4fasm.pl - A script which generates a Makefile for the files present in the directory
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
#		./make4fasm.pl [-d] [-r] [-C dir]
#
#	-d: usun istniejacy Makefile (domyslnie: dopisuj)
#	-r: rekursywnie w podkatalogach (domyslnie: nie)
#	-C: zmien katalog na 'dir' przed rozpoczeciem pracy
#
#	-d: delete existing Makefile (default: append)
#	-r: recursively in subdirectories (default: no)
#	-C: change current directory to 'dir' before starting
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
# # as published by the Free Software Foundation; either version 3
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
use Cwd;
use File::Spec::Functions;
use Getopt::Long;

my ($usuwaj, $rekursja, $katalog_b, $katalog_d, $help, $help_msg, $return, $lic, $lic_msg);

$usuwaj   = 0;
$rekursja = 0;
$katalog_b = cwd();
$katalog_d = cwd();

$help_msg = "$0: Skrypt generujacy Makefile dla plikow FASMa w katalogu.\n".
	" / A script which generates a Makefile for FASM files in the directory.\nAutor/Author: Bogdan Drozdowski, ".
	"http://rudy.mif.pg.gda.pl/~bogdro/inne/\n".
 	"Skladnia/Syntax: $0 [-d] [-r] [-C dir] [--help] [--license]\n\n".
		"-d:\t\tUsun istniejacy Makefile / Delete existing Makefile\n".
		"-r:\t\tPrzeszukuj podkatalogi rekursywnie/ Recurse into subdirectories\n".
		"-C dir:\t\tZmien katalog na <dir> przed rozpoczeciem pracy /\n".
		"\t\t\tChange directory to <dir> before starting.\n".
		"--help:\t\tWyswietl skladnie / Display the syntax.\n".
		"--license:\tWyswietl licencje / Display the license.\n";

$lic_msg = "$0: Skrypt generujacy Makefile dla plikow obecnych w katalogu.\n".
	" / A script which generates a Makefile for the files present in the directory.\nAutor/Author: Bogdan Drozdowski, ".
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

Getopt::Long::Configure("ignore_case", "ignore_case_always");

if ( ! GetOptions(
	'h|help|?'		=>	\$help,
	'd'			=>	\$usuwaj,
	'r'			=>	\$rekursja,
	'license|licence|L'	=>	\$lic,
	'C=s'			=>	\$katalog_d
	)
   ) {

	print $help_msg;
	exit 1;
}

if ( $lic ) {
	print $lic_msg;
	exit 1;
}

if ( $help ) {

	print $help_msg;
	exit 1;
}

chdir $katalog_d || die "$0: chdir($katalog_d): $!\n";

$return = zrob_katalog(curdir());

chdir $katalog_b;

exit $return;

# ============================ zrob_katalog ===============================

sub zrob_katalog {

	my $katalog = shift;
	my ($format, $nie_fasm, $moze_com, $pliki_asm, $makefile, $dir_h, $asm_h, $plik,
		$rozsz, $include, $output, $ret);
	$pliki_asm = "";

	chdir $katalog || die "$0: chdir($katalog): $!\n";

	# jesli mamy usunac Makefile, otwieramy do zapisu
	# (if we have to delete the Makefile, we open it for writing)
	if ( $usuwaj ) {

		if ( !open ( $makefile, "> Makefile" ) ) {
			print "$0: Makefile: $!\n";
			return -1;
		}

	# jesli mamy nie usuwac Makefile, otwieramy do dopisywania
	# (if we mustn't delete the Makefile, we open it for appending)
	} else {

		if ( !open ( $makefile, ">> Makefile" ) ) {
			print "$0: Makefile: $!\n";
			return -1;
		}
	}

	print $makefile " # Stworzone przez make4fasm\n # Zobacz http://rudy.mif.pg.gda.pl/~bogdro/\n\n";
	print $makefile " # Generated by make4fasm\n # See http://rudy.mif.pg.gda.pl/~bogdro/inne/ for details\n\n";

	print $makefile "FASM\t\t=\tfasm\n\n";

	if ( !opendir ( $dir_h, curdir() ) ) {

		print "$0: CWD: $!\n";
		close $makefile;
		return -2;
	}

	while ( defined($plik = readdir($dir_h)) ) {

		if ( -d $plik ) {

			# jesli mamy przegladac rekursywnie
			# (if we have to browse recursively)
			if ( $rekursja && $plik ne curdir() && $plik ne updir() ) {

				print "$0: Wchodze do katalogu (Entering directory): $plik\n";
				$ret = zrob_katalog($plik);
				print "$0: Wychodze z katalogu (Leaving  directory): $plik\n";
				chdir(updir());
				if ( $ret < 0 ) {
					close $makefile;
					closedir $dir_h;
					return $ret;
				}
			}
			# teraz pomijamy katalog (skip the directory now)
			next;
		}

		# pomijamy pliki nie-assemblerowe (skip non-assembler files)
        	next if ( $plik !~ /\.asm$/io && $plik !~ /\.fasm$/io );

        	# otwieramy plik do odczytu (open the file for reading)
		if ( !open ( $asm_h, "$plik" ) ) {

			print "$0: $plik: $!\n";
			close $makefile;
			closedir $dir_h;
			return -1;
		}

		$format = "";
		$nie_fasm = 0;
		$include = "";
		$rozsz = "";
		$moze_com = 0;

		while ( <$asm_h> ) {

			# szukamy dyrektywy "format" (look for the "format" directive)
			if ( !$format && /^\s*format\s+(.+)$/io ) {

				($format = $1) =~ s/;.*//;
			}
			# szukamy nie-FASMowych dyrektyw (look for non-FASM directives)
			if ( /^\s*\%/o || /^\s*\.?(model|code|data|stack)/io ) { $nie_fasm = 1; }

			# dodajemy dolaczane pliki do zaleznosci
			# (add the included files to dependencies)
			if ( /^\s*include\s+[\'\"]([\%\w\-\.\\\/]+)[\'\"]/io ) { $include .= "$1 "; }

			# sprawdzamy, czy moze to zostac plikiem .com
			# (check if this can become a .com file)
			if ( /^\s*org\s+(0x100|100h|\$100)/io ) { $moze_com = 1; }
		}
		close $asm_h;

		# Jesli plik nie zawiera "format", a zawiera jakies nie-FASMowe dyrektywy, pomijamy go
		#	i wyswietlimy wiadomosc
		# (If the file has no "format" and has some non-FASM directives, we skip it
		#	and print a message)
		if ( $format eq "" && $nie_fasm ) {

			print "$0: $plik: Nie plik FASMa / Not a FASM file.\n";
			next;
		}

		if ( $format eq "" ) { $format = "binary"; }

		if    ( $format =~ /DLL/io ) 				{ $rozsz = ".dll"; }
		elsif ( $format =~ /PE/io || $format =~ /MZ/io ) 	{ $rozsz = ".exe"; }
		elsif ( $format =~ /COFF/io ) 				{ $rozsz = ".obj"; }
		elsif ( $format =~ /executable/io ) 			{ $rozsz = "";     }
		elsif ( $format =~ /ELF/io ) 				{ $rozsz = ".o";   }
		else {
			# format binary
			if ( $^O =~ /Win/io || $^O =~ /DOS/io || $moze_com )	{ $rozsz = ".com"; }
			else 						{ $rozsz = ".bin"; }
		}

		# ustaw nazwe pliku wyjsciowego (set output filename)
		( $output = $plik ) =~ s/\.f?asm/$rozsz/i;

		# zamiana separatorow w sciezkach (change path separators)
		if ( $^O =~ /Win/io || $^O =~ /DOS/io ) {

			$include =~ s/\//\\/go;

		} else { $include =~ s/\\/\//go; }

		# zmiana zmiennych srodowiskowych na ich wartosc
		# (substituting environmental variables by their value)
		$include =~ s/\%(\w+)\%/$ENV{$1}/g;

		# zapisujemy regulke do Makefile'a (write a rule to the Makefile)
		print $makefile "$output:\t$include\n\t\$(FASM)\t$plik\t$output\n\n";

        	$pliki_asm .= "$output ";

	}

	print $makefile "all:\t$pliki_asm\n\n" if $usuwaj;
	close $makefile;

	closedir $dir_h;
	return 0;
}
