#!/usr/bin/perl -W
#
# nasm2fasm.pl - Skrypt konwertujacy kod w skladni NASMa na kod w skladni FASMa
# nasm2fasm.pl - A script which converts NASM code to FASM code.
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
#		./nasm2fasm.pl xxx.asm [yyy.fsm]
#
# Jesli nazwa pliku wyjsciowego nie zostanie podana, jest brana taka sama jak pliku
#	wejsciowego (tylko rozszerzenie sie zmieni na .fsm). Jesli za nazwe
#	pliku wejsciowego podano "-", czytane jest standardowe wejscie.
#	Jesli nazwa pliku wyjsciowego to "-" (lub nie ma jej, gdy wejscie to stdin),
#	wynik bedzie na standardowym wyjsciu.
#
# If there's no output filename, then it is assumed to be the same as the
#	input filename (only the extension will be changed to .fsm). If the
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

$help_msg = "$0: Konwerter z NASM do FASMa / NASM-to-FASM converter.\nAutor/Author: Bogdan Drozdowski, ".
	"http://rudy.mif.pg.gda.pl/~bogdro/inne/\n".
	"Skladnia/Syntax: $0 [--help] [--license] xxx.asm [yyy.fsm]\n\n
 Jesli nazwa pliku wyjsciowego nie zostanie podana, jest brana taka sama jak
pliku wejsciowego (tylko rozszerzenie sie zmieni na .fsm). Jesli za nazwe
pliku wejsciowego podano \"-\", czytane jest standardowe wejscie.
 Jesli nazwa pliku wyjsciowego to \"-\" (lub nie ma jej, gdy wejscie to stdin),
wynik bedzie na standardowym wyjsciu.

 If there's no output filename, then it is assumed to be the same as the
input filename (only the extension will be changed to .fsm). If the
input filename is \"-\", standard input will be read.
 If the output filename is \"-\" (or missing, when input is stdin),
the result will be written to the standard output.\n";

$lic_msg = "$0: Konwerter z NASMa do FASMa / NASM-to-FASM converter.\nAutor/Author: Bogdan Drozdowski, ".
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
	# Zmieniamy rozszerzenie z .asm na .fsm (change the extension from .asm to .fsm)
	$wyj =~ s/\.n?asm$/\.fsm/io;
	# Zmieniamy rozszerzenie z .inc na .fnc dla plikow naglowkowych
	# (change the extension from .inc to .fnc for header files)
	$wyj =~ s/\.n?inc$/\.fnc/io;
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
	if ( /^\s*$/o ) {
		print $wy "\n";
		next;
	}

	# sklejanie wierszy (joining lines)
	while ( /\\$/o ) {

		s/\\\n//o;
		$_ .= <$we>;
	}

	# sprawdzamy, czy komentarz jest jedyny na linii (check if a comment is the only thing on this line)
	if ( /^\s*;.*$/o ) { print $wy "$_"; next; }

	# przetwarzanie dyrektyw kompilacji warunkowej (processing of conditional compiling directives)
	&kom_war(0);

	# pomijamy 'wrt' (skip over 'wrt')
	s/\s+wrt\s+\w+/ /gio;

	# pomijamy 'strict' (skip over 'strict')
	s/\s+strict\s+/ /gio;

	#	Include'y (includes)
	if ( /^\s*\%\s*include/io ) {

		s/^\s*\%\s*include\s*([\"\w\/\.]+)(.*)$/include $1 $2 \n/i;
		#	nazwa pliku	  ^^^^^^ 	(filename)

		print $wy "$_";
		next;
	}

	#	Extern'y (externs)

	if ( /^\s*extern/io ) {

		s/^\s*extern\s+(\w+)\s+(.*)$/extrn $1 $2\n/i;

		print $wy "$_";
		next;
	}

	if ( /^\s*cpu/io ) {

		print $wy "\n";
		next;
	}

	#	Symbole publiczne (pubilc symbols)

	if ( /^\s*global/io ) {

		s/^\s*global\s+(\w+)\s+(.*)$/public $1 $2\n/i;

		print $wy "$_";
		next;
	}

	#	Struktury (structures):

	if ( /^\s*struc/io ) {

		# nazwa struktury (the name of the structure)
		s/^\s*struc\s+(\w+)/struc $1 {/i;
		my $nazwa = $1;

		do {

			s/res([bwdqt])/r$1/i;

			# szukamy konca struktury (look for the end of the structure)
			if ( /\s*endstruc.*/io ) {

				# dolaczamy pole zawierajace rozmiar struktury (add a structure size field)
				#s/\s*\}.*/\n\t.${nazwa}_size\t= \$ - .\n\}\n/;
				s/\s*endstruc.*/\n}\n/io;
				print $wy "$_";
				next CZYTAJ;
			}

			# przetwarzanie dyrektyw kompilacji warunkowej (processing of conditional compiling directives)
			&kom_war(0);
			print $wy "$_";

		} while ( <$we> );

		next;
	}

	if ( /^\s*\%i?macro/io ) {

		s/\.nolist//io;
		if ( /^\s*\%i?macro\s+(\w+)\s+(\d+)\-([\*\d]+)\s*(.*)/io ) {

			s/^\s*\%i?macro\s+(\w+)\s+(\d+)\-(\*|\d+)\s+(.*)/macro $1 /i;
			my $n_param;

			# skonczona liczba parametrow (finite amount of parameters)
			if ( $3 ne "*" ) {

				$n_param = $3;

				if ( $n_param > 0 ) {

					chomp;
					# budujemy (build): "param1, param2, ..., paramN"
					for (my $i=1; $i < $n_param; $i++ ) {

						$_ .= "param$i, ";
					}
					$_ .= "param$n_param ";
				}

			# nieskonczona liczba parametrow (infinite amount of parameters)
			} else {

				# $2 zawiera minimalna liczbe ($2 contains the minimum number)
				$n_param = $2;

				for (my $i=1; $i < $n_param; $i++ ) {

					$_ .= "param$i, ";
				}
				$_ .= "[param$n_param] ";
			}

			$_ .= "\n{\n";

			if ( "$4" !~ /"\s*"/o ) {

				my @param_def = split( /,/o, $4);
				for (my $i=1; $i <= $#param_def+1; $i++ ) {

					$_ .= "if param$i eq\n\tparam$i = $param_def[$i-1]\nend if\n";
				}

			}


		} else {

			s/^\s*\%i?macro\s+(\w+)\s+(\d+)\s*(.*)/macro $1 /i;
			my $n_param = $2;

			if ( $n_param > 0 ) {

				# budujemy (build): "param1, param2, ..., paramN"
				for (my $i=1; $i < $n_param; $i++ ) {

                                        chomp;
					$_ .= "param$i, ";
				}
				$_ .= "param$n_param ";
			}

			$_ .= "\n{\n";

			if ( "$3" !~ /"\s+"/o ) {

				my @param_def = split( /,/o, $3);
				for (my $i=1; $i <= $#param_def+1; $i++ ) {

					$_ .= "if param$i eq\n\tparam$i = $param_def[$i-1]\nend if\n";
				}

			}

		}

		do {

			s/\%(\d+)/param$1/g;
			s/\%-(\d+)/n#param$1/g;

			# etykiety lokalne makra: definicja i uzycie
			# (macro-local labels: definition and use)
			s/\%\%\s*(\w+)\s*:/local $1\n\t$1:/;
			s/\%\%\s*(\w+)\s*/$1/;

			# szukamy konca makra (look for the end of the macro)
			if ( /^\s*\%endm.*/io ) {

				s/^\s*\%endm.*/\n}\n/io;
				print $wy "$_";
				next CZYTAJ;
			}

			# przetwarzanie dyrektyw kompilacji warunkowej (processing of conditional compiling directives)
			&kom_war(0);
			print $wy "$_";

		} while ( <$we> );

		next;

	}

	if ( /^\s*alignb?/io ) {

		s/&/ and /go;
		s/\|/ or /go;
		s/\^/ xor /go;
		s/~/ not /go;
		s/%/ mod /go;
		s/%%/ mod /go;
		s/\// div /go;
		s/\/\// div /go;
		s/<</ shl /go;
		s/>>/ shr /go;

		s/^\s*alignb?\s+(.*)/align $1\n/i;
		print $wy "$_";
		next;
	}


	if ( /^\s*incbin/io ) {

		s/^\s*incbin\s+(.*)/file $1\n/i;
		print $wy "$_";
		next;
	}

	if ( /^\s*\%rep/io ) {

		s/^\s*\%rep\s+(.*)/repeat $1\n/i;
		print $wy "$_";
		next;
	}

	if ( /^\s*istruc/io ) {

		s/^\s*istruc\s+(.*)/ $1\n/i;
		print $wy "$_";
		next;
	}

	if ( /^\s*bits/io ) {

		s/^\s*bits\s+(\d+)/use $1\n/i;
		print $wy "$_";
		next;
	}

	if ( /^\s*common/io ) {

		s/^\s*common\s+(\w+)\s+(\w+)/$1: times $2 db 90h\n/i;
		print $wy "$_";
		next;
	}

	if ( /^\s*(segment|section)/io ) {

		s/^\s*(segment|section)\s+[\"\']([\.\w]+)[\"\']/section "$2" align 4096\n/i;
		s/^\s*(segment|section)\s+([\.\w]+)/section "$2" align 4096\n/i;
		print $wy "$_";
		next;
	}

	if ( /^\s*absolute/io ) {

		s/^\s*absolute\s+(\w+)/virtual at $1\n/i;
		print $wy "$_";
		next;
	}

	if ( /res([bwdqt])/io ) {
		s/res([bwdqt])/r$1/i;
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

	# pomijamy makra (skip over macros)
	if ( /^\s*\%\s*[ix]{0,2}define\s+\w+\s*\(/io )	{ return; }

	# sklejanie argumentow: %+ (concatenating arguments: %+)
	s/\%\+/#/go;


	# %assign:
	if ( /^\s*\%\s*assign/io )	{

		s/^\s*\%\s*assign\s+(\w+)\s+(\w+)/$1\tequ\t$2/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	# %rotate:
	if ( /^\s*\%\s*rotate/io )	{

		s/^\s*\%\s*rotate\s+(\w+)//io;
		if ( $drukuj ) { print $wy "$_"; }
	}

	# %undef:
	if ( /^\s*\%\s*undef/io )	{

		s/^\s*\%\s*undef\s+(\w+)/purge\t$1/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	# %endrep:
	if ( /^\s*\%\s*endrep/io )	{

		s/^\s*\%\s*endrep\s+(\w+)/end repeat\t$1/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	# %substr:
	if ( /^\s*\%\s*substr/io )	{

#		s/^\s*\%\s*substr\s+(\w+)\s+([\w\s\"\'\`]+)\s+(\d+)/$1 = $2[$3]/i;
		if ( $drukuj ) { print $wy "display WARNING: skipped \%substr"; }
	}

	# %strlen:
	if ( /^\s*\%\s*strlen/io )	{

#		s/^\s*\%\s*strlen\s+(\w+)\s+([\w\s\"\'\`]+)/\@\@: db $2\n$1 = \$-\@b/i;
		if ( $drukuj ) { print $wy "display WARNING: skipped \%strlen"; }
	}

	# pomijamy contekst (skip over context)
	if ( /^\s*\%\s*(ifctx|push|pop|repl|\$\w+)/io ) {

		s/^\s*\%\s*(ifctx|push|pop|repl)(.*)$//io;
		s/^\s*\%\s*\$(\w+)/.$1/;
		if ( $drukuj ) { print $wy "$_"; }
	}

	# identycznosc napisow (identity of strings)
	if ( /^\s*\%\s*ifidni?/io ) {

		s/^\s*\%\s*ifidni?\s+([\w+\'\"\`]+)\s+([\w+\'\"\`]+)/if $1 = $2/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	# sprawdzanie typu (type checking)
	if ( /^\s*\%\s*if(id|num|str)/io ) {

		s/^\s*\%\s*ifid\s+([\w+\'\"\`]+)/if $1 eqtype label:/i;
		s/^\s*\%\s*ifnum\s+([\w+\'\"\`]+)/if ($1 eqtype 1) or ($1 eqtype 1.0)/i;
		s/^\s*\%\s*ifstr\s+([\w+\'\"\`]+)/if $1 eqtype ""/i;
		if ( $drukuj ) { print $wy "$_"; }
	}


	#	Definicje stalych #define (definitions of #define constants)
	if ( /^\s*\%\s*[ix]{0,2}define\s+/io ) {

		# bez wartosci - ustawiamy na 1; zasieg: assembler (without a value - set to 1; scope: assembler)
		s/^\s*\%\s*[ix]{0,2}define\s+(\w+)\s*$/$1\t=\t1\n/i;

		# z wartoscia; zasieg: assembler (with a value; scope: assembler)
		# dopuszczamy "(-cyfry)" / "(-digits)" is allowed
		s/^\s*\%\s*[ix]{0,2}define\s+(\w+)\s+(\(?-?[a-fA-Fx\d]+[oqbh]?\)?)\s+/$1\t=\t$2\n/i;

		# z wartoscia nienumeryczna; zasieg: preprocesor (with a non-number value; scope: preprocessor)
		s/^\s*\%\s*[ix]{0,2}define\s+(\w+)\s+([\w\"\|\&\<\>\(\)\-\+]*)/$1\tequ\t$2/i;

		if ( $drukuj ) { print $wy "$_"; }
	}

	#	Kompilacja warunkowa (conditional compiling)
	if ( /^\s*\%\s*if(def|macro)/io ) {

		s/^\s*\%\s*if(def|macro)(.*)$/if defined $2/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*\%\s*ifndef/io ) {

		# zgodnie z podrecznikiem (according to the manual)
		s/^\s*\%\s*ifndef(.*)$/if ~defined $1 | defined \@f\n\@\@:/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*\%\s*endif/io ) {

		s/^\s*\%\s*endif.*$/end if/io;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*\%\s*elif/io ) {

		s/^\s*\%\s*elif(.*)$/else if $1/i;

	#	Operatory logiczne, mod i div (logical operators, mod and div):
		s/&/ and /go;
		s/\|/ or /go;
		s/\^/ xor /go;
		s/~/ not /go;
		s/%/ mod /go;
		s/%%/ mod /go;
		s/\// div /go;
		s/\/\// div /go;
		s/<</ shl /go;
		s/>>/ shr /go;

		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*\%\s*else/io ) {

		s/^\s*\%\s*else(.*)$/else $1/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*\%\s*if/io ) {

		s/^\s*\%\s*if(.*)$/if $1/i;
		s/~\s*defined\s+(\w+)/(~defined $1 | defined \@f)/gi;

	#	Operatory logiczne, mod i div (logical operators, mod and div):
		s/&/ and /go;
		s/\|/ or /go;
		s/\^/ xor /go;
		s/~/ not /go;
		s/%/ mod /go;
		s/%%/ mod /go;
		s/\// div /go;
		s/\/\// div /go;
		s/<</ shl /go;
		s/>>/ shr /go;

		if ( /~defined/io )	{ s/$/\n\@\@:\n/o; };
		if ( $drukuj ) { print $wy "$_"; }
	}

	if ( /^\s*\%\s*error/io  ) {

		s/^\s*\%\s*error(.*)$/display "$2"/i;
		if ( $drukuj ) { print $wy "$_"; }
	}

}

##########################################################
# Koniec (the end):


close $wy;
close $we;

