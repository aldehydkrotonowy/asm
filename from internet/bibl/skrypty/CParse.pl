# A simple parser for C/C++ header files that calls the given
#  subroutines when a symbol of a specified type is encountered.
#
#	Copyright (C) 2012 Bogdan 'bogdro' Drozdowski, http://rudy.mif.pg.gda.pl/~bogdro/inne/
#		(bogdandr AT op.pl, bogdro AT rudy.mif.pg.gda.pl)
#
#	Licence:
#	GNU General Public Licence v3+
#
#	Last modified : 2012-03-31
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

sub max
{
	my $a = shift, $b = shift;
	return $a if $a > $b;
	return $b;
}

sub parse_struct
{
	my $infile = shift; # input file handle
	my $outfile = shift; # output file handle
	$_ = shift;
	my $struct_start_sub = shift; # subroutine that converts structures
	my $struct_entry_sub = shift; # subroutine that converts structures
	my $struct_end_sub = shift; # subroutine that converts structures
	my $union_start_sub = shift; # subroutine that converts unions
	my $union_entry_sub = shift; # subroutine that converts unions
	my $union_end_sub = shift; # subroutine that converts unions
	my $comment_sub = shift; # subroutine that converts comments
	my $preproc_sub = shift; # subroutine that converts proceprocessor directives

	# skip over "struct foo;"
	if ( /^\s*struct\s+[\w\s\$\*]+(\[[^\]]*\])?;/o && ! /{/o )
	{
		# changing the comments
		if ( $comment_sub )
		{
			$_ = &$comment_sub($_);
			print $outfile $_ if $outfile and $_;
		}
		return (0, '');
	}

	# the name of the structure
	my $str_name = '';
	if ( /^\s*struct\s+(\w+)/o )
	{
		if ( $1 and $1 ne '' and $1 !~ /\{/o )
		{
			$str_name = $1;
		}
		s/^\s*struct\s+\w+//o;
	}
	my $size = 0;
	my ($memb_size, $name);
	my $line;
	$line = &$struct_start_sub($str_name) if $struct_start_sub;
	print $outfile $line if $outfile and $line;

	# a structure can end in the same line or contain many declaration per line
	#   we simply put a newline after each semicolon and go on

	s/;/;\n/go;
	# changing the comments
	if ( $comment_sub )
	{
		$_ = &$comment_sub($_);
	}

	do
	{
		s/{//go;
		# joining lines
		while ( /[\\,]$/o )
		{
			s/\\\n//o;
			$_ .= <$infile>;
		}

		# many variables of the same type - we put each on a separate line together with its type
		if ( /\/\*/o )
		{
			while ( /,\s*$/o )
			{
				s/\n//o;
				$_ .= <$infile>;
			}
			while ( /,.*\/\*/o && !/\(/o )
			{
				if ( /\[.*\/\*/o )
				{
					s/([\w ]*)\s+(\w+)\s*(\[\w+\]),\s*(.*)/$1 $2$3;\n$1 $4/;
				}
				else
				{
					s/([\w ]*)\s+([\w\*]+)\s*,\s*(.*)/$1 $2;\n$1 $3/;
				}
			}
		}
		else
		{
			while ( /,\s*$/o )
			{
				s/\n//o;
				$_ .= <$infile>;
			}
			while ( /,.*/o && !/\(/o )
			{
				if ( /\[/o )
				{
					s/([\w ]*)\s+(\w+)\s*(\[\w+\]),\s*(.*)/$1 $2$3;\n$1 $4/;
				}
				else
				{
					s/([\w ]*)\s+([\w\*]+)\s*,\s*(.*)/$1 $2;\n$1 $3/;
				}
			}
		}

		# changing the comments
		if ( $comment_sub )
		{
			$_ = &$comment_sub($_);
		}

		while ( /^\s*union\s+(\w+)/o )
		{
			($memb_size, $name) = parse_union($infile, $outfile, $_,
				#$union_start_sub, $union_entry_sub, $union_end_sub,
				#$struct_start_sub, $struct_entry_sub, $struct_end_sub,
				undef, undef, undef,
				undef, undef, undef,
				$comment_sub, $preproc_sub);
			$line = &$struct_entry_sub($name, $memb_size) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			$_ = '';
			$size += $memb_size;
			goto STR_END;
		}

		while ( /^\s*union/o )
		{
			my ($memb_size, $name) = parse_union($infile, $outfile, $_,
				#$union_start_sub, $union_entry_sub, $union_end_sub,
				#$struct_start_sub, $struct_entry_sub, $struct_end_sub,
				undef, undef, undef,
				undef, undef, undef,
				$comment_sub, $preproc_sub);
			$line = &$struct_entry_sub($name, $memb_size) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			$_ = '';
			$size += $memb_size;
			goto STR_END;
		}

		# first we remove the ":digit" from the structure fields
		s/(.*):\s*\d+\s*/$1/g;

		# skip over 'volatile'
		s/_*volatile_*//gio;

		# pointers to functions
		while ( /.+\(\s*\*\s*(\w+)\s*\)\s*\(.*\)\s*;/o )
		{
			$line = &$struct_entry_sub($1, 4) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 4;
		}
		# pointer type
		while ( /.+\*\s*(\w+)\s*;/o )
		{
			$line = &$struct_entry_sub($1, 4) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 4;
		}

		# arrays
		while ( /.*struct\s+(\w+)\s+(\w+)\s*\[(\w+)\]\s*;/o )
		{
			$line = &$struct_entry_sub($2, 0) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/.*struct\s+(\w+)\s+(\w+)\s*\[(\w+)\]\s*;//o;
		}
		while ( /.*(signed|unsigned)?\s+long\s+long(\s+int)?\s+(\w+)\s*\[(\w+)\]\s*;/o )
		{
			my $var_name = $3;
			my $count = $4;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$struct_entry_sub($var_name, 8 * $count) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 8 * $count;
		}
		while ( /.*long\s+double\s+(\w+)\s*\[(\w+)\]\s*;/o )
		{
			my $var_name = $1;
			my $count = $2;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$struct_entry_sub($var_name, 10 * $count) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 10 * $count;
		}
		while ( /.*(char|unsigned\s+char|signed\s+char)\s+(\w+)\s*\[(\w+)\]\s*;/o )
		{
			my $var_name = $2;
			my $count = $3;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$struct_entry_sub($var_name, 1 * $count) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 1 * $count;
		}
		while ( /.*float\s+(\w+)\s*\[(\w+)\]\s*;/o )
		{
			my $var_name = $1;
			my $count = $2;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$struct_entry_sub($var_name, 4 * $count) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 4 * $count;
		}
		while ( /.*double\s+(\w+)\s*\[(\w+)\]\s*;/o )
		{
			my $var_name = $1;
			my $count = $2;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$struct_entry_sub($var_name, 8 * $count) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 8 * $count;
		}
		while ( /.*(short|signed\s+short|unsigned\s+short){1}(\s+int)?\s+(\w+)\s*\[(\w+)\]\s*;/o )
		{
			my $var_name = $3;
			my $count = $4;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$struct_entry_sub($var_name, 2 * $count) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 2 * $count;
		}
		while ( /.*(long|signed|signed\s+long|unsigned|unsigned\s+long|int){1}(\s+int)?\s+(\w+)\s*\[(\w+)\]\s*;/o )
		{
			my $var_name = $3;
			my $count = $4;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$struct_entry_sub($var_name, 4 * $count) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 4 * $count;
		}

		# variables' types
		while ( /.*struct\s+(\w+)\s+(\w+)\s*;/o )
		{
			$line = &$struct_entry_sub($2, 0) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/.*struct\s+\w+\s+\w+\s*;//o;
		}
		while ( /^\s*struct/o )
		{
			my ($memb_size, $name) = parse_struct($infile, $outfile, $_,
				#$struct_start_sub, $struct_entry_sub, $struct_end_sub,
				#$union_start_sub, $union_entry_sub, $union_end_sub,
				undef, undef, undef,
				undef, undef, undef,
				$comment_sub, $preproc_sub);
			$line = &$struct_entry_sub($name, $memb_size) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			$_ = '';
			$size += $memb_size;
			goto STR_END;
		}

		# all "\w+" stand for the variable name
		while ( /.*(signed|unsigned)?\s+long\s+long(\s+int)?\s+(\w+)\s*;/o )
		{
			$line = &$struct_entry_sub($3, 8) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 8;
		}
		while ( /.*long\s+double\s+(\w+)\s*;/o )
		{
			$line = &$struct_entry_sub($1, 10) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 10;
		}
		while ( /.*(char|unsigned\s+char|signed\s+char)\s+(\w+)\s*;/o )
		{
			$line = &$struct_entry_sub($2, 1) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 1;
		}
		while ( /.*float\s+(\w+)\s*;/o )
		{
			$line = &$struct_entry_sub($1, 4) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 4;
		}
		while ( /.*double\s+(\w+)\s*;/o )
		{
			$line = &$struct_entry_sub($1, 8) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 8;
		}
		while ( /.*(short|signed\s+short|unsigned\s+short){1}(\s+int)?\s+(\w+)\s*;/o )
		{
			$line = &$struct_entry_sub($3, 2) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 2;
		}
		while ( /.*(long|signed|signed\s+long|unsigned|unsigned\s+long|int){1}(\s+int)?\s+(\w+)\s*;/o )
		{
			$line = &$struct_entry_sub($3, 4) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size += 4;
		}

		# look for the end of the structure
		if ( /}/o )
		{
			# add a structure size definition
			my $var_name = '';
			if ( /\}\s*(\*?)\s*(\w+)[^;]*;/o )
			{
				$var_name = $2;
			}
			if ( /\}\s*\*/o )
			{
				$size = 4;
			}
			$line = &$struct_end_sub($var_name, $size, $str_name) if $struct_end_sub;
			print $outfile $line if $outfile and $line;
			$_ = '';
			return ($size, $var_name);
		}

		# processing of conditional compiling directives
		if ( $preproc_sub )
		{
			$_ = &$preproc_sub($_);
		}
		print $outfile $_ if $outfile and $_;

	STR_END: } while ( <$infile> );

}

sub parse_union
{
	my $infile = shift; # input file handle
	my $outfile = shift; # output file handle
	$_ = shift;
	my $union_start_sub = shift; # subroutine that converts unions
	my $union_entry_sub = shift; # subroutine that converts unions
	my $union_end_sub = shift; # subroutine that converts unions
	my $struct_start_sub = shift; # subroutine that converts structures
	my $struct_entry_sub = shift; # subroutine that converts structures
	my $struct_end_sub = shift; # subroutine that converts structures
	my $comment_sub = shift; # subroutine that converts comments
	my $preproc_sub = shift; # subroutine that converts proceprocessor directives

	# skip over "union foo;"
	if ( /^\s*union\s+[^;{}]*;/o )
	{
		# changing the comments
		if ( $comment_sub )
		{
			$_ = &$comment_sub($_);
			print $outfile $_ if $outfile and $_;
		}
		return (0, '');
	}

	# the name of the union
	my $union_name = '';

	if ( /^\s*union\s+(\w+)/o )
	{
		if ( $1 and $1 ne '' and $1 !~ /\{/o )
		{
			$union_name = $1;
		}
		s/^\s*union\s+\w+//o;
	}
	my $size = 0;
	my ($memb_size, $name);
	my $line;
	$line = &$union_start_sub($union_name) if $union_start_sub;
	print $outfile $line if $outfile and $line;

	# if there was a '{' in the first line, we put it in the second
	if ( !/union/o )
	{
		s/\s*\{/\n\{\n/o;
	}
	else
	{
		s/\s*union\s*{//o;
		s/\s*union//o;
	}

	# an union can end in the same line or contain many declaration per line
	#   we simply put a newline after each semicolon and go on

	s/;/;\n/go;

	do
	{
		s/{//go;
		# changing the comments
		if ( $comment_sub )
		{
			$_ = &$comment_sub($_);
		}

		# pointer type
		while ( /.+\*\s*(\w+)\s*;/o )
		{
			$line = &$union_entry_sub($1, 4) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 4);
		}

		while ( /.*struct\s+(\w+)\s+(\w+)\s*;/o )
		{
			$line = &$union_entry_sub($2, 0) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/.*struct\s+\w+\s+\w+\s*;//o;
		}

		while ( /^\s*struct/o )
		{
			my ($memb_size, $name) = parse_struct($infile, $outfile, $_,
				#$struct_start_sub, $struct_entry_sub, $struct_end_sub,
				#$union_start_sub, $union_entry_sub, $union_end_sub,
				undef, undef, undef,
				undef, undef, undef,
				$comment_sub, $preproc_sub);
			$line = &$union_entry_sub($name, $memb_size) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			$size = max($size, $memb_size);
			$_ = '';
			goto STR_END;
		}

		# variables' types
		# all "\w+" stand for the variable name
		while ( /.*(signed|unsigned)?\s+long\s+long(\s+int)?\s+(\w+)\s*;/o )
		{
			$line = &$union_entry_sub($3, 8) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 8);
		}

		while ( /.*long\s+double\s+(\w+)\s*;/o )
		{
			$line = &$union_entry_sub($1, 10) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 10);
		}

		while ( /.*(char|unsigned\s+char|signed\s+char)\s+(\w+)\s*;/o )
		{
			$line = &$union_entry_sub($2, 1) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 1);
		}

		while ( /.*float\s+(\w+)\s*;/o )
		{
			$line = &$union_entry_sub($1, 4) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 4);
		}

		while ( /.*double\s+(\w+)\s*;/o )
		{
			$line = &$union_entry_sub($1, 8) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 8);
		}

		while ( /.*(short|signed\s+short|unsigned\s+short){1}(\s+int)?\s+(\w+)\s*;/o )
		{
			$line = &$union_entry_sub($3, 2) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 2);
		}

		while ( /.*(long|signed|signed\s+long|unsigned|unsigned\s+long|int){1}(\s+int)?\s+(\w+)\s*;/o )
		{
			$line = &$union_entry_sub($3, 4) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 4);
		}

		# arrays

		while ( /.*struct\s+(\w+)\s+(\w+)\s*\[(\w+)\]\s*;/o )
		{
			$line = &$union_entry_sub($2, 0) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/.*struct\s+(\w+)\s+(\w+)\s*\[(\w+)\]\s*;//o;
		}

		while ( /.*(signed|unsigned)?\s+long\s+long(\s+int)?\s+(\w+)\s*\[(\d+)\]\s*;/o )
		{
			my $var_name = $3;
			my $count = $4;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$union_entry_sub($var_name, 8 * $count) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 8 * $count);
		}

		while ( /.*long\s+double\s+(\w+)\s*\[(\d+)\]\s*;/o )
		{
			my $var_name = $1;
			my $count = $2;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$union_entry_sub($var_name, 10 * $count) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 10 * $count);
		}

		while ( /.*(char|unsigned\s+char|signed\s+char)\s+(\w+)\s*\[(\d+)\]\s*;/o )
		{
			my $var_name = $2;
			my $count = $3;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$union_entry_sub($var_name, 1 * $count) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 1 * $count);
		}

		while ( /.*float\s+(\w+)\s*\[(\d+)\]\s*;/o )
		{
			my $var_name = $1;
			my $count = $2;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$union_entry_sub($var_name, 4 * $count) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 4 * $count);
		}

		while ( /.*double\s+(\w+)\s*\[(\d+)\]\s*;/o )
		{
			my $var_name = $1;
			my $count = $2;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$union_entry_sub($var_name, 8 * $count) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 8 * $count);
		}

		while ( /.*(short|signed\s+short|unsigned\s+short){1}(\s+int)?\s+(\w+)\s*\[(\d+)\]\s*;/o )
		{
			my $var_name = $3;
			my $count = $4;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$union_entry_sub($var_name, 2 * $count) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 2 * $count);
		}

		while ( /.*(long|signed|signed\s+long|unsigned|unsigned\s+long|int){1}(\s+int)?\s+(\w+)\s*\[(\d+)\]\s*;/o )
		{
			my $var_name = $3;
			my $count = $4;
			if ( $count =~ /^0/o )
			{
				$count = oct("$count");
			}
			$line = &$union_entry_sub($var_name, 4 * $count) if $union_entry_sub;
			print $outfile $line if $outfile and $line;
			# remove the parsed element
			s/^[^;]*;//o;
			$size = max($size, 4 * $count);
		}

		while ( /^\s*union/o )
		{
			my ($memb_size, $name) = parse_union($infile, $outfile, $_,
				#$union_start_sub, $union_entry_sub, $union_end_sub,
				#$struct_start_sub, $struct_entry_sub, $struct_end_sub,
				undef, undef, undef,
				undef, undef, undef,
				$comment_sub, $preproc_sub);
			$line = &$struct_entry_sub($name, $memb_size) if $struct_entry_sub;
			print $outfile $line if $outfile and $line;
			$_ = '';
			$size = max($size, $memb_size);
		}

		# look for the end of the union
		if ( /\s*\}.*/o )
		{
			my $var_name = '';
			if ( /\s*\}\s*(\w+)[^;]*;/o )
			{
				$var_name = $1;
			}
			$line = &$union_end_sub($var_name, $size, $union_name) if $union_end_sub;
			print $outfile $line if $outfile and $line;
			$_ = '';
			return ($size, $var_name);
		}

		# processing of conditional compiling directives
		if ( $preproc_sub )
		{
			$_ = &$preproc_sub($_);
		}
		print $outfile $_ if $outfile and $_;

	STR_END: } while ( <$infile> );
}

sub parse_file
{
	my $infile = shift; # input file handle
	my $outfile = shift; # output file handle
	my $preproc_sub = shift; # subroutine that converts proceprocessor directives
	my $extern_sub = shift; # subroutine that converts external declarations
	my $typedef_sub = shift; # subroutine that converts typedefs
	my $struct_start_sub = shift; # subroutine that converts structures
	my $struct_entry_sub = shift; # subroutine that converts structures
	my $struct_end_sub = shift; # subroutine that converts structures
	my $enum_start_sub = shift; # subroutine that converts enumerations
	my $enum_entry_sub = shift; # subroutine that converts enumerations
	my $enum_end_sub = shift; # subroutine that converts enumerations
	my $union_start_sub = shift; # subroutine that converts unions
	my $union_entry_sub = shift; # subroutine that converts unions
	my $union_end_sub = shift; # subroutine that converts unions
	my $comment_sub = shift; # subroutine that converts comments

	return unless $infile;

	my $line;
	READ: while ( <$infile> )
	{
		# empty lines go without change
		if ( /^\s*$/o )
		{
			print $outfile "\n" if $outfile;
			next;
		}

		# joining lines
		while ( /[\\,]$/o )
		{
			s/\\\n//o;
			s/,\n/,/o;
			$_ .= <$infile>;
		}

		# check if a comment is the only thing on this line
		if ( /^\s*\/\*.*\*\/\s*$/o || m#^\s*//#o )
		{
			if ( $comment_sub )
			{
				$_ = &$comment_sub($_);
			}
			else
			{
				$_ = '';
			}
			print $outfile $_ if $outfile;
			next;
		}

		# processing of preprocessor directives
		if ( /^\s*#/o )
		{
			if ( $comment_sub )
			{
				$_ = &$comment_sub($_);
			}
			if ( $preproc_sub )
			{
				$_ = &$preproc_sub($_);
			}
			else
			{
				$_ = '';
			}
			print $outfile $_ if $outfile;
			next;
		}

		# externs
		if ( /^\s*extern/o )
		{
			if ( $comment_sub )
			{
				$_ = &$comment_sub($_);
			}

			# joining lines
			while ( ! /;/o )
			{
				s/\n//o;
				$_ .= <$infile>;
			}

			# external functions

			# extern "C", extern "C++"
			s/^\s*extern\s+"C"\s*{//o;
			s/^\s*extern\s+"C"/extern/o;
			s/^\s*extern\s+"C\+\+"\s*{//o;
			s/^\s*extern\s+"C\+\+"/extern/o;

			# first remove: extern MACRO_NAME ( fcn name, args, ... )
			s/^\s*\w*\s*extern\s+\w+\s*\([^*].*//o;
			# 	typ	  ^^^^^^	(type)

			# extern pointers to functions:
			if ( /^\s*\w*\s*extern\s+[\w\*\s]+\(\s*\*\s*(\w+)[()\*\s\w]*\)\s*\(.*/o )
			{
				if ( $extern_sub )
				{
					$_ = &$extern_sub($1);
				}
				else
				{
					$_ = '';
				}
			}

			if ( /^\s*\w*\s*extern\s+[\w\*\s]+?(\w+)\s*\(.*/o )
			{
				if ( $extern_sub )
				{
					$_ = &$extern_sub($1);
				}
				else
				{
					$_ = '';
				}
			}

			# external variables
			if ( /^\s*extern[\w\*\s]+\s+\**(\w+)\s*;/o )
			{
				if ( $extern_sub )
				{
					$_ = &$extern_sub($1);
				}
				else
				{
					$_ = '';
				}
			}

			print $outfile $_ if $outfile;
			next;
		}

		# typedef
		if ( /^\s*typedef/o )
		{
			if ( /\(/o )
			{
				while ( ! /\)/o or /,\s*$/o )
				{
					s/\n//og;
					$_ .= <$infile>;
				}
			}

			if ( /\(/o )
			{
				s/^.*$/\n/o;
			}
			elsif ( !/{/o && /;/o )
			{
				/\s*typedef([\w\*\s]+)\s+\**(\w+)(\[[^\]]*\])?\s*;/o;
				if ( $typedef_sub )
				{
					$_ = &$typedef_sub($1, $2);
				}
				else
				{
					$_ = '';
				}
				print $outfile $_ if $outfile;
				next;
			}
			# "typedef struct ...."  ----> "struct ....."
			elsif ( /(struct|union|enum)/o )
			{
				s/^\s*typedef\s+//i;
			}

			# no NEXT here
		}

		# structures:

		if ( /^\s*struct/o )
		{
			# skip over expressions of the type:
			# struct xxx;
			# struct xxx function(arg1, ...);
			if ( /^\s*struct[^{;]+;.*$/o || /\(/o )
			{
				$_ = '';
			}
			else
			{
				parse_struct($infile, $outfile, $_,
					$struct_start_sub, $struct_entry_sub, $struct_end_sub,
					$union_start_sub, $union_entry_sub, $union_end_sub,
					$comment_sub, $preproc_sub);
			}
			next;
		}

		# enumerations
		if ( /^\s*enum/o )
		{
			# remove the 'enum' and its name
			if ( /^.*enum\s+(\w+)\s*\{?/o )
			{
				$line = &$enum_start_sub($1) if $enum_start_sub;
				print $outfile $line if $outfile and $line;
				s/^.*enum\s+\w+\s*\{?//o;
			}
			my $curr_value = 0;

			# check if one-line enum
			if ( /}/o )
			{
				# there are no conditional compiling directives in one-line enums
				#if ( $preproc_sub )
				#{
				#	$_ = &$preproc_sub($_);
				#}
				#else
				#{
				#	$_ = '';
				#}

				while ( /,.*;/o )
				{
					if ( /([\w\s]*)\s+(\w+)\s*=\s*(\w+)\s*,/o )
					{
						$line = &$enum_entry_sub ($2, $3) if $enum_entry_sub;
						print $outfile $line if $outfile and $line;
						$curr_value = $3+1;
						s/[\w\s]*\s+\w+\s*=\s*\w+\s*,//o
					}
					if ( /([\w\s]*)\s+(\w+)\s*,/o )
					{
						$line = &$enum_entry_sub ($2, $curr_value) if $enum_entry_sub;
						print $outfile $line if $outfile and $line;
						$curr_value++;
						s/[\w\s]*\s+\w+\s*,//o
					}
				}

				# the last line has no comma
				if ( /^\s*(\w+)\s*=\s*(\w+)\s*\}\s*;/o )
				{
					$line = &$enum_entry_sub ($1, $2) if $enum_entry_sub;
					print $outfile $line if $outfile and $line;
					s/^\s*\w+\s*=\s*\w+\s*\}\s*;//o
				}
				if ( /^\s*(\w+)\s*\}\s*;/o )
				{
					$line = &$enum_entry_sub ($1, $curr_value) if $enum_entry_sub;
					print $outfile $line if $outfile and $line;
					s/^\s*\w+\s*\}\s*;//o
				}

				$line = &$enum_end_sub() if $enum_end_sub;
				print $outfile $line if $outfile and $line;
				# changing the comments
				if ( $comment_sub )
				{
					$_ = &$comment_sub($_);
					print $outfile $_ if $outfile;
				}
				next;
			}
			else
			{
				while ( <$infile> )
				{
					# processing of conditional compiling directives
					if ( /^\s*#/o )
					{
						if ( $preproc_sub )
						{
							$_ = &$preproc_sub($_);
						}
						else
						{
							$_ = '';
						}
						print $outfile $_ if $outfile;
						next;
					}

					# skip over the first '{' character
					#next if /^\s*\{\s*$/o;
					s/{//go;

					next if /^\s*;/o;

					# if the constant has a value, we don't touch it
					if ( /=/o )
					{
						if ( /^\s*(\w+)\s*=\s*(\w+)\s*,?/o )
						{
							$line = &$enum_entry_sub ($1, $2) if $enum_entry_sub;
							print $outfile $line if $outfile and $line;
							$curr_value = $2 + 1;
							s/^\s*\w+\s*=\s*\w+\s*,?//o;
						}
					}
					else
					{
						# assign a subsequent value
						if ( /^\s*(\w+)\s*,?/o )
						{
							$line = &$enum_entry_sub ($1, $curr_value) if $enum_entry_sub;
							print $outfile $line if $outfile and $line;
							$curr_value++;
							s/^\s*\w+\s*,?//o;
						}
					}

					# changing the comments
					if ( $comment_sub )
					{
						$_ = &$comment_sub($_);
					}

					# look for the end of the enum
					if ( /\s*\}.*/o )
					{
						$line = &$enum_end_sub() if $enum_end_sub;
						print $outfile $line if $outfile and $line;
						next READ;
					}

					print $outfile $_ if $outfile;
				}
			}
		}

		if ( /^\s*union/o )
		{
			# skip over expressions of the type:
			# union xxx;
			# union xxx function(arg1, ...);
			if ( /^\s*union[^{;]+;.*$/o || /\(/o )
			{
				$_ = '';
			}
			else
			{
				parse_union($infile, $outfile, $_,
					$union_start_sub, $union_entry_sub, $union_end_sub,
					$struct_start_sub, $struct_entry_sub, $struct_end_sub,
					$comment_sub, $preproc_sub);
			}
			next;
		}

		# remove any }'s left after <extern "C">, for example
		s/}//go;
		if ( $comment_sub )
		{
			$_ = &$comment_sub($_);
		}
		print $outfile $_ if $outfile;
	}
}

1; # successful result of parsing this file
