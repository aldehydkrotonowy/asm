# Makefile dla biblioteki procedur napisanych w asemblerze
# Copyright (C) 2007-2021 Bogdan 'bogdro' Drozdowski, bogdandr @ op . pl
# Data: 2021-02-08
#
# Ta biblioteka jest wolnym oprogramowaniem; mozesz ja rozpowszechniac
# i/lub modyfikowac zgodnie z licencja GNU Lesser General Public License
# (GNU LGPL) w wersji wydanej przez Fundacje Wolnego Oprogramowania;
# wedlug wersji 3 Licencji lub (jesli wolisz) jednej z pozniejszych wersji.
#
# Ta biblioteka jest udostepniana z nadzieja, ze bedzie uzyteczna, lecz
# BEZ JAKIEJKOLWIEK GWARANCJI; nawet domyslnej gwarancji PRZYDATNOSCI
# HANDLOWEJ albo PRZYDATNOSCI DO OKRESLONYCH ZASTOSOWAN. W celu uzyskania
# blizszych informacji - Licencja GNU Lesser General Public License.
#
# Z pewnoscia wraz z niniejszym programem otrzymales tez egzemplarz
# Licencji GNU Lesser General Public License; jesli nie - napisz do
# Fundacji Wolnego Oprogramowania:
#		Free Software Foundation
#		51 Franklin Street, Fifth Floor
#		Boston, MA 02110-1301
#		USA
#
#     This library is free software; you can redistribute it and/or
#     modify it under the terms of the GNU Lesser General Public
#     License as published by the Free Software Foundation; either
#     version 3 of the License, or (at your option) any later version.
#
#     This library is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#     Lesser General Public License for more details.
#
#     You should have received a copy of the GNU Lesser General Public
#     License along with this library; if not, write to the Free Software
#     Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#	 MA  02110-1301  USA
#

NASM		= nasm
NASM_OPCJE	= -O999 -w+orphan-labels
ARCH		= bibl.zip
ZIP		= zip
ZIP_OPCJE	= -9 -r -T
TYTUL_PLIK	= tmpnapis

ifeq ($(findstring exe,$(subst EXE,exe,$(MAKE))),exe)
	MAKEDOS = 1
else
	MAKEDOS = 0
endif

ifeq ($(MAKEDOS),1)
	PATHSEP	= \\
	BIBLDOS	= ..$(PATHSEP)lib$(PATHSEP)bibldos.$(LIBEXT)
	BIBLBIOS= ..$(PATHSEP)lib$(PATHSEP)biblbios.$(LIBEXT)
 # parametr 'COFF' pojawia sie na linii komend
 ifeq ($(COFF),1)
	DOSOPTS	= -f coff -D__DOS=1 -D__BIOS=0 -D__LINUX=0 -D__BSD=0 -D__COFF=1
	BIOSOPTS= -f coff -D__DOS=0 -D__BIOS=1 -D__LINUX=0 -D__BSD=0 -D__COFF=1
	OBJEXT	= o
	LIBEXT	= a
	MAKELIBD= ar -surf $(BIBLDOS)  ..$(PATHSEP)out$(PATHSEP)*.$(OBJEXT)
	MAKELIBB= ar -surf $(BIBLBIOS) ..$(PATHSEP)out$(PATHSEP)*.$(OBJEXT)
 else
	DOSOPTS	= -f obj -D__DOS=1 -D__BIOS=0 -D__LINUX=0 -D__BSD=0 -D__COFF=0
	BIOSOPTS= -f obj -D__DOS=0 -D__BIOS=1 -D__LINUX=0 -D__BSD=0 -D__COFF=0
	OBJEXT	= obj
	LIBEXT	= lib
	MAKELIBD= lib /S /Q /W $(BIBLDOS)  @..$(PATHSEP)lib$(PATHSEP)lib.txt
	MAKELIBB= lib /S /Q /W $(BIBLBIOS) @..$(PATHSEP)lib$(PATHSEP)lib.txt
 endif
	BIBL	= $(BIBLDOS) #$(BIBLBIOS)
	SYSINC	= ..$(PATHSEP)incl$(PATHSEP)dosbios$(PATHSEP)nasm$(PATHSEP)
	RM_F	= del
	LS_L	= dir
#	PACK	= zip -9 -r -T -x "*.$(OBJEXT)" \
#		..$(PATHSEP)..$(PATHSEP)$(ARCH) ..$(PATHSEP)..$(PATHSEP)bibl
	HTML	= htm
	DEPGEN	= nasm -M $(DOSOPTS)
else
 # parametr 'BIT64' pojawia sie na linii komend
	LIBEXT	= a
	PATHSEP	= /
 ifeq ($(BIT64),1)
	FORMAT	= elf64
	BIBL	= ..$(PATHSEP)lib$(PATHSEP)libasmio64.$(LIBEXT)
 else
	FORMAT	= elf
	BIBL	= ..$(PATHSEP)lib$(PATHSEP)libasmio.$(LIBEXT)
 endif
	OPCJE	= $(NASM_OPCJE) -f $(FORMAT) -w+gnu-elf-extensions -D__LINUX=1 \
		-D__BSD=1 -D__DOS=0 -D__BIOS=0 -D__COFF=0
	OBJEXT	= o
	SYSINC	= ..$(PATHSEP)incl$(PATHSEP)linuxbsd$(PATHSEP)nasm$(PATHSEP)
#	ARCH	= bibl_linux_bsd.tar.gz
	RM_F	= rm -f
	LS_L	= ls -l
	MAKELIB	= ar -surf $(BIBL) ..$(PATHSEP)out$(PATHSEP)*.$(OBJEXT)
#	PACK	= tar zc --exclude="*.$(OBJEXT)" -f \
#		..$(PATHSEP)..$(PATHSEP)$(ARCH) ..$(PATHSEP)..$(PATHSEP)bibl
	HTML	= html
	DEPGEN	= nasm -M $(OPCJE)
endif

# lista plikow musi byc w dwoch grupach, bo inaczej przekraczamy
# limit dlugosci linii komend w DOS
PLIKI_O_1	= ..$(PATHSEP)out$(PATHSEP)pisz.$(OBJEXT)	\
		  ..$(PATHSEP)out$(PATHSEP)f_pisz.$(OBJEXT)	\
		  ..$(PATHSEP)out$(PATHSEP)fn_pisz.$(OBJEXT)	\
		  ..$(PATHSEP)out$(PATHSEP)wej.$(OBJEXT)	\
		  ..$(PATHSEP)out$(PATHSEP)procesor.$(OBJEXT)
PLIKI_O_2	= ..$(PATHSEP)out$(PATHSEP)f_wej.$(OBJEXT)	\
		  ..$(PATHSEP)out$(PATHSEP)fn_wej.$(OBJEXT)	\
		  ..$(PATHSEP)out$(PATHSEP)dzwiek.$(OBJEXT)	\
		  ..$(PATHSEP)out$(PATHSEP)losowe.$(OBJEXT)	\
		  ..$(PATHSEP)out$(PATHSEP)lancuchy.$(OBJEXT)	\
		  ..$(PATHSEP)out$(PATHSEP)bcd.$(OBJEXT)

PLIKI_O		= $(PLIKI_O_1) $(PLIKI_O_2)

.PHONY: all clean clean_o czysc paczka help pomoc doc linie

# parameter 'BIOS' pojawia sie na linii komend po zbudowaniu biblioteki DOS
ifeq ($(BIOS),1)
all:	$(BIBLBIOS)
OPCJE	= $(NASM_OPCJE) $(BIOSOPTS)
else
ifneq ($(BIBLDOS),)
OPCJE	= $(NASM_OPCJE) $(DOSOPTS)
endif
all:	$(BIBL)
endif

ifneq ($(BIBLDOS),)
$(BIBLDOS):	clean_o $(PLIKI_O)
	@echo	=========
	@$(RM_F) $(BIBLDOS) > NUL
	$(MAKELIBD)
	@echo	=========
	@echo	Biblioteka:
	@$(LS_L) $(BIBLDOS)
	@$(MAKE) BIOS=1
ifneq ($(COFF),1)
	@$(MAKE) COFF=1
#@$(MAKE) BIOS=1 COFF=1
endif

endif

ifneq ($(BIBLBIOS),)
$(BIBLBIOS):	clean_o $(PLIKI_O)
	@echo	=========
	@$(RM_F) $(BIBLBIOS) > NUL
	$(MAKELIBB)
	@echo	=========
	@echo	Biblioteka:
	@$(LS_L) $(BIBLBIOS)
endif

ifeq ($(MAKEDOS),0)
$(BIBL):	clean_o $(PLIKI_O)
	@echo	" "
	@$(RM_F) $(BIBL)
	$(MAKELIB)
	@echo	" "
	@echo	"Biblioteka:"
	@$(LS_L) $(BIBL)
ifneq ($(BIT64),1)
	@$(MAKE) BIT64=1
endif

endif

..$(PATHSEP)out$(PATHSEP)pisz.$(OBJEXT):	pisz.asm $(SYSINC)n_const.inc $(SYSINC)n_system.inc wewnetrz.inc
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)pisz.$(OBJEXT)	pisz.asm

..$(PATHSEP)out$(PATHSEP)f_pisz.$(OBJEXT):	f_pisz.asm $(SYSINC)n_const.inc wewnetrz.inc
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)f_pisz.$(OBJEXT)	f_pisz.asm

..$(PATHSEP)out$(PATHSEP)fn_pisz.$(OBJEXT):	fn_pisz.asm $(SYSINC)n_const.inc wewnetrz.inc
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)fn_pisz.$(OBJEXT)	fn_pisz.asm

..$(PATHSEP)out$(PATHSEP)wej.$(OBJEXT):		wej.asm $(SYSINC)n_const.inc $(SYSINC)n_system.inc wewnetrz.inc
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)wej.$(OBJEXT)	wej.asm

..$(PATHSEP)out$(PATHSEP)procesor.$(OBJEXT):	procesor.asm $(SYSINC)n_const.inc wewnetrz.inc
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)procesor.$(OBJEXT)	procesor.asm

..$(PATHSEP)out$(PATHSEP)f_wej.$(OBJEXT):	f_wej.asm $(SYSINC)n_const.inc wewnetrz.inc
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)f_wej.$(OBJEXT)	f_wej.asm

..$(PATHSEP)out$(PATHSEP)fn_wej.$(OBJEXT):	fn_wej.asm $(SYSINC)n_const.inc wewnetrz.inc
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)fn_wej.$(OBJEXT)	fn_wej.asm

..$(PATHSEP)out$(PATHSEP)dzwiek.$(OBJEXT):	dzwiek.asm $(SYSINC)n_system.inc wewnetrz.inc
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)dzwiek.$(OBJEXT)	dzwiek.asm

..$(PATHSEP)out$(PATHSEP)losowe.$(OBJEXT):	losowe.asm $(SYSINC)n_const.inc $(SYSINC)n_system.inc wewnetrz.inc
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)losowe.$(OBJEXT)	losowe.asm

..$(PATHSEP)out$(PATHSEP)lancuchy.$(OBJEXT):	lancuchy.asm wewnetrz.inc
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)lancuchy.$(OBJEXT)	lancuchy.asm

..$(PATHSEP)out$(PATHSEP)bcd.$(OBJEXT):		bcd.asm $(SYSINC)n_const.inc wewnetrz.inc
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)bcd.$(OBJEXT)	bcd.asm

clean:		czysc
czysc:		clean_o
	$(RM_F) $(BIBL)
	$(RM_F) zalezn

# usuwanie plikow musi byc w dwoch komendach, bo inaczej przekraczamy
# limit dlugosci linii komend w DOS
clean_o:
	$(RM_F) $(PLIKI_O_1)
	$(RM_F) $(PLIKI_O_2)

paczka:		$(BIBL)
	$(RM_F) ..$(PATHSEP)..$(PATHSEP)$(ARCH)
	cd ../.. && $(ZIP) $(ZIP_OPCJE) $(ARCH) bibl -x "*.o"

help:		pomoc
pomoc:
	@echo	" "
	@echo	"Wpisz 'make' (bez argumentow), aby skompilowac biblioteke."
	@echo	"Wymagane sa programy:"
	@echo	" - NASM, The Netwide Assembler, http://nasm.sf.net"
	@echo	" - GNU make"
	@echo	" - Gnu AR (dostepny w binutils) dla wersji Linux/BSD"
	@echo	" - LIB (popatrz w czytaj.txt) dla wersji DOS/BIOS"
	@echo	" "
	@echo	"Jesli 'make' wypisze, ze nie ma nic do roboty w 'all',"
	@echo	" to znaczy, ze biblioteka jest aktualna."

doc:	..$(PATHSEP)doc$(PATHSEP)index.$(HTML)

..$(PATHSEP)doc$(PATHSEP)index.$(HTML):	*.asm
	echo "Biblioteka jêzyka asembler" | iconv -f iso-8859-2 \
		-t utf-8 > $(TYTUL_PLIK)
	perl ..$(PATHSEP)skrypty$(PATHSEP)asmdoc.pl -author \
		-charset ISO-8859-2 -d ..$(PATHSEP)doc \
		-encoding ISO-8859-2 -lang pl -version -windowtitle \
		"`cat $(TYTUL_PLIK)`" *.asm || $(RM_F) $(TYTUL_PLIK)
	$(RM_F) $(TYTUL_PLIK)

# trzeba uzyc 'cat', bo inaczej na poczatku wyswietlana jest nazwa pliku
# i wyrazenie wycinajace komentarze nigdy nie zadziala
linie:
	@echo -n "Wszystkich linii: "
	@wc -l *.asm | tail -1
	@echo -n "Niepustych linii: "
	@egrep '.' *.asm | wc -l
	@echo -n "Linii kodu: "
	@cat *.asm | egrep '.' | egrep -v '^[[:space:]]*;' | wc -l

zalezn:
	$(RM_F) zalezn
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)pisz.$(OBJEXT) -M pisz.asm >> zalezn
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)f_pisz.$(OBJEXT) -M f_pisz.asm >> zalezn
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)fn_pisz.$(OBJEXT) -M fn_pisz.asm >> zalezn
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)wej.$(OBJEXT) -M wej.asm >> zalezn
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)procesor.$(OBJEXT) -M procesor.asm >> zalezn
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)f_wej.$(OBJEXT) -M f_wej.asm >> zalezn
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)fn_wej.$(OBJEXT) -M fn_wej.asm >> zalezn
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)dzwiek.$(OBJEXT) -M dzwiek.asm >> zalezn
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)losowe.$(OBJEXT) -M losowe.asm >> zalezn
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)lancuchy.$(OBJEXT) -M lancuchy.asm >> zalezn
	$(NASM) $(OPCJE) -o..$(PATHSEP)out$(PATHSEP)bcd.$(OBJEXT) -M bcd.asm >> zalezn
