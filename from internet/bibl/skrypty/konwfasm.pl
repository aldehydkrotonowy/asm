#!/usr/bin/perl -W
#
# konw-fasm.pl - Skrypt konwertujacy pliki naglowkowe jezyka C na pliki naglowkowe dla FASMa
# konw-fasm.pl - A script which converts C header files to FASM-compatible header files
#
#	Copyright (C) 2006-2010,2012 Bogdan 'bogdro' Drozdowski, http://rudy.mif.pg.gda.pl/~bogdro/inne/
#		(bogdandr AT op.pl, bogdro AT rudy.mif.pg.gda.pl)
#
#	Licencja / Licence:
#	Powszechna Licencja Publiczna GNU v3+ / GNU General Public Licence v3+
#
#	Ostatnia modyfikacja / Last modified : 2012-03-31
#
#	Sposob uzycia / Syntax:
#		./konw-fasm.pl [--help] [--license] [--prefix <string>] [--suffix <string>] xxx.h [yyy.inc]
#
# Jesli nazwa pliku wyjsciowego nie zostanie podana, jest brana taka sama jak pliku
#	wejsciowego (tylko rozszerzenie sie zmieni na .inc). Jesli za nazwe
#	pliku wejsciowego podano "-", czytane jest standardowe wejscie.
#	Jesli nazwa pliku wyjsciowego to "-" (lub nie ma jej, gdy wejscie to stdin),
#	wynik bedzie na standardowym wyjsciu.
#
# If there's no output filename, then it is assumed to be the same as the
#	input filename (only the extension will be changed to .inc). If the
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
require "CParse.pl";

my $outfile_name;
my ($help, $lic, $help_msg, $lic_msg);
my $prefix = '';
my $suffix = '';

$help_msg = "$0:\n Skrypt konwertujacy pliki naglowkowe jezyka C na pliki naglowkowe dla FASMa\n".
	"  / A script which converts C header files to FASM-compatible header files.\nAutor/Author: Bogdan Drozdowski, ".
	"http://rudy.mif.pg.gda.pl/~bogdro/inne/\n".
	"Skladnia/Syntax: $0 [--help] [--license] [--prefix <string>] [--suffix <string>] xxx.h [yyy.inc]\n\n
 Jesli nazwa pliku wyjsciowego nie zostanie podana, jest brana taka sama jak
pliku wejsciowego (tylko rozszerzenie sie zmieni na .inc). Jesli za nazwe
pliku wejsciowego podano \"-\", czytane jest standardowe wejscie.
 Jesli nazwa pliku wyjsciowego to \"-\" (lub nie ma jej, gdy wejscie to stdin),
wynik bedzie na standardowym wyjsciu.

 If there's no output filename, then it is assumed to be the same as the
input filename (only the extension will be changed to .inc). If the
input filename is \"-\", standard input will be read.
 If the output filename is \"-\" (or missing, when input is stdin),
the result will be written to the standard output.\n";

$lic_msg = "$0:\n Skrypt konwertujacy pliki naglowkowe jezyka C na pliki naglowkowe dla FASMa\n".
	"  / A script which converts C header files to FASM-compatible header files.\nAutor/Author: Bogdan Drozdowski, ".
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

if ( @ARGV == 0 )
{
	print $help_msg;
	exit 1;
}

Getopt::Long::Configure ( 'ignore_case', 'ignore_case_always' );

if ( ! GetOptions(
	'h|help|?'		=>	\$help,
	'license|licence|L'	=>	\$lic,
	'prefix=s'		=>	\$prefix,
	'suffix=s'		=>	\$suffix
	)
   )
{
	print $help_msg;
	exit 1;
}

if ( $lic )
{
	print $lic_msg;
	exit 1;
}

if ( @ARGV == 0 || $help )
{
	print $help_msg;
	exit 1;
}

if ( @ARGV > 1 && $ARGV[0] ne "-" && $ARGV[0] eq $ARGV[1] )
{
	print "$0: Plik wejsciowy i wyjsciowy NIE moga byc takie same.\n";
	print "$0: Input file and output file must NOT be the same.\n";
	exit 4;
}


##########################################################
# opening the files

my ($infile, $outfile);

if ( !open ( $infile, $ARGV[0] ) )
{
	# $! is the error message
	print "$0: $ARGV[0]: $!\n";
	exit 2;
}

if ( @ARGV > 1 )
{
	$outfile_name = $ARGV[1];
}
else
{
	# take only the filename
	($outfile_name = $ARGV[0]) =~ s/.*\/([^\/]+)/$1/;
	# change the extension from .h to .inc
	$outfile_name =~ s/\.h$/\.inc/io;
	# change spaces to underlines
	$outfile_name =~ s/\s+/_/go;

	if ( $outfile_name eq $ARGV[0] && $outfile_name ne "-" )
	{
		$outfile_name .= '.inc';
	}
}

if ( !open ( $outfile, "> $outfile_name" ) )
{
	print "$0: $outfile_name: $!\n";
	close $infile;
	exit 3;
}

##########################################################
# processing:

my $extrn_sub = sub
{
	my $symbol = shift;
	my $ret = "extrn\t$prefix$symbol$suffix\n";
	if ( $prefix || $suffix )
	{
		$ret .= "$symbol equ $prefix$symbol$suffix\n";
	}
	return $ret;
};

my $comment_sub = sub
{
	my $line = shift;
	# one-line comments:
	if ( $line =~ /(.+)\/\*(.*)\*\/(.+)$/o )
	{
		$line =~ s/(.+)\/\*(.*)\*\/(.+)$/$1 $3 ; $2/g;
		return $line;
	}
	if ( $line =~ /\/\*(.*)\*\/(.+)$/o )
	{
		$line =~ s/\/\*(.*)\*\/(.+)$/$2 ; $1/g;
		return $line;
	}
	if ( $line =~ /(.+)\/\*(.*)\*\/$/o )
	{
		$line =~ s/(.+)\/\*(.*)\*\/$/$1 ; $2/g;
		return $line;
	}

	if ( $line =~ m#(.+)//#o )
	{
		$line =~ s#(.+)//(.*)#$1; $2#g;
		return $line;
	}

	# if the comment is the only thing on this line, we print it to the file and go further
	if ( $line =~ /^\s*\/\*(.*)\*\/$/o )
	{
		$line =~ s/^\s*\/\*(.*)\*\/$/; $1/g;
		return $line;
	}
	if ( $line =~ m#^\s*//#o )
	{
		$line =~ s#^\s*//(.*)#; $1#g;
		return $line;
	}

	# multi-line comments
	if ( $line =~ /(.*)\/\*(.*)$/o )
	{
		# we remove the /*, saving whatever was in front of it
		$line =~ s/(.*)\/\*(.*)$/$1; $2/;

		while ( <$infile> )
		{
			# we simply add a semicolon in front of every line
			s/^(.*)$/; $1/;

			# when we find */, we remove it and stop this loop
			if ( /\*\//o )
			{
				s/\*\///o;
				$line .= $_;
				$_ = '';
				return $line;
			}
			$line .= $_;
		}
	}

	return $line;
};

my $preproc_sub = sub
{
	my $line = shift;
	# includes
	if ( $line =~ /^\s*#\s*include/io )
	{
		# changing the comments
		$line = &$comment_sub($line);
		$line =~ s/^\s*#\s*include\s*<([^>]+)>(.*)$/include\t"$1" $2 \n/i;
		$line =~ s/^\s*#\s*include\s*"([^"]+)"(.*)$/include\t"$1" $2 \n/i;

		return $line;
	}

	# skip over macros
	if ( $line =~ /^\s*\#\s*define\s+\w+\(/io )
	{
		# changing the comments
		$line = &$comment_sub($line);

		$line =~ s/\s*\#\s*define\s+\w+\s*\(.*/\n/io;
		return '';
	}


	# definitions of #define constants
	if ( $line =~ /^\s*#\s*define\s+/io )
	{
		# changing the comments
		$line = &$comment_sub($line);

		# without a value - set to 1; scope: assembler
		$line =~ s/\s*#\s*define\s+(\w+)\s*$/$1\t=\t1\n/i;

		# with a value; scope: assembler
		# "(-digits)" is allowed
		#$line =~ s/\s*#\s*define\s+(\w+)\s+(\(?[+-]?0x[a-fA-F\d]+\)?)/$1\t=\t$2\n/i;
		#$line =~ s/\s*#\s*define\s+(\w+)\s+(\(?[+-]?\d+(\.?\d*e?[+-]?\d*)\)?)/$1\t=\t$2\n/i;
		#$line =~ s/\s*#\s*define\s+(\w+)\s+(\(?[+-]?[\d\.]+\)?)/$1\t=\t$2\n/i;

		# with a non-number value; scope: preprocessor
		$line =~ s/\s*#\s*define\s+(\w+)\s+(.*)/$1\tequ\t$2\n/i;

		return $line;
	}

	# conditional compiling
	if ( $line =~ /^\s*#\s*ifdef/io )
	{
		# changing the comments
		$line = &$comment_sub($line);

		$line =~ s/\s*#\s*ifdef(.*)$/if defined $1\n/i;
		return $line;
	}

	if ( $line =~ /^\s*#\s*ifndef/io )
	{
		# changing the comments
		$line = &$comment_sub($line);

		# according to the manual
		$line =~ s/\s*#\s*ifndef(.*)$/if ~defined $1 | defined \@f\n\@\@:\n/i;
		return $line;
	}

	if ( $line =~ /^\s*#\s*endif/io )
	{
		# changing the comments
		$line = &$comment_sub($line);

		$line =~ s/\s*#\s*endif(.*)$/end if$1\n/io;
		return $line;
	}

	if ( $line =~ /^\s*#\s*else\s+if/io )
	{
		# changing the comments
		$line = &$comment_sub($line);

		# logical operators, mod and div:
		$line =~ s/&&/&/go;
		$line =~ s/\|\|/|/go;
		$line =~ s/!/~/go;
		$line =~ s/%/mod/go;
		$line =~ s/\//div/go;
		$line =~ s/<</shl/go;
		$line =~ s/>>/shr/go;

		$line =~ s/\s*#\s*else\s+if(.*)$/else if $1\n/i;
		return $line;
	}

	if ( $line =~ /^\s*#\s*elif/io )
	{
		# changing the comments
		$line = &$comment_sub($line);

		# logical operators, mod and div:
		$line =~ s/&&/&/go;
		$line =~ s/\|\|/|/go;
		$line =~ s/!/~/go;
		$line =~ s/%/mod/go;
		$line =~ s/\//div/go;
		$line =~ s/<</shl/go;
		$line =~ s/>>/shr/go;

		$line =~ s/\s*#\s*elif(.*)$/else if $1\n/i;
		return $line;
	}

	if ( $line =~ /^\s*#\s*else/io )
	{
		# changing the comments
		$line = &$comment_sub($line);

		$line =~ s/\s*#\s*else(.*)$/else $1\n/i;
		return $line;
	}

	if ( $line =~ /^\s*#\s*if/io )
	{
		# changing the comments
		$line = &$comment_sub($line);

		# logical operators, mod and div:
		$line =~ s/&&/&/go;
		$line =~ s/\|\|/|/go;
		$line =~ s/!/~/go;
		$line =~ s/%/mod/go;
		$line =~ s/\//div/go;
		$line =~ s/<</shl/go;
		$line =~ s/>>/shr/go;

		$line =~ s/\s*#\s*if(.*)$/if $1/i;
		$line =~ s/~\s*defined\s+(\w+)/(~defined $1 | defined \@f)\n/gi;
		if ( /~defined/io )
		{
			$line =~ s/$/\n\@\@:\n/o;
		}
		return $line;
	}

	if ( $line =~ /^\s*#\s*error/io || /^\s*#\s*warning/io )
	{
		# changing the comments
		$line = &$comment_sub($line);

		$line =~ s/\s*#\s*(error|warning)(.*)$/display "$2"\n/i;
		return $line;
	}

	return $line;
};

my $typedef_sub = sub
{
	my $part1 = shift;
	my $part2 = shift;
	return "$part2 equ $part1\n";
};

my $struct_start_sub = sub
{
	my $name = shift;
	return "struc $name\n{\n";
};

my $struct_entry_sub = sub
{
	my $name = shift;
	my $size = shift;
	return "\t.$name:\trb\t$size\n";
};

my $struct_end_sub = sub
{
	my $name = shift;
	my $size = shift;
	my $struct_name = shift;
	my $ret = '';
	$ret = "\t${struct_name}_size\t=\t\$ - .\n" if $struct_name;
	$ret .= "}\n";
	if ( $name )
	{
		$ret .= "$name:\n";
		$ret .= "rb $size\n" if $size;
	}
	return $ret;
};

my $enum_start_sub = sub
{
	return '';
};

my $enum_entry_sub = sub
{
	my $name = shift;
	my $value = shift;
	return "$name equ $value\n";
};

my $enum_end_sub = sub
{
	return '';
};

my $union_start_sub = sub
{
	my $name = shift;
	return "struc $name\n{\n";
};

my $union_entry_sub = sub
{
	my $name = shift;
	my $size = shift;
	return "\t.$name:\n";
};

my $union_end_sub = sub
{
	my $name = shift;
	my $size = shift;
	my $union_name = shift;
	my $ret = '';
	$ret = "\t${union_name}_size\t=\t\$ - .\n" if $union_name;
	$ret .= "}\n";
	if ( $name )
	{
		$ret .= "$name: \n";
		$ret .= "rb $size\n" if $size;
	}
	return $ret;
};


# 	my $infile = shift; # input file handle
# 	my $outfile = shift; # output file handle
# 	my $preproc_sub = shift; # subroutine that converts proceprocessor directives
# 	my $extern_sub = shift; # subroutine that converts external declarations
# 	my $typedef_sub = shift; # subroutine that converts typedefs
# 	my $struct_start_sub = shift; # subroutine that converts structures
# 	my $struct_entry_sub = shift; # subroutine that converts structures
# 	my $struct_end_sub = shift; # subroutine that converts structures
# 	my $enum_start_sub = shift; # subroutine that converts enumerations
# 	my $enum_entry_sub = shift; # subroutine that converts enumerations
# 	my $enum_end_sub = shift; # subroutine that converts enumerations
# 	my $union_start_sub = shift; # subroutine that converts unions
# 	my $union_entry_sub = shift; # subroutine that converts unions
# 	my $union_end_sub = shift; # subroutine that converts unions
# 	my $comment_sub = shift; # subroutine that converts comments

parse_file ($infile, $outfile, $preproc_sub, $extrn_sub, $typedef_sub,
	$struct_start_sub, $struct_entry_sub, $struct_end_sub,
	$enum_start_sub, $enum_entry_sub, $enum_end_sub,
	$union_start_sub, $union_entry_sub, $union_end_sub,
	$comment_sub);

##########################################################
# the end:


close $outfile;
close $infile;

