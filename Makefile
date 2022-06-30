# This is file Makefile
# written by Dr. Daniel C. Hatton 

# Daniel Hatton can be contacted on <dan.hatton@physics.org> 

# Copyright (C) 2022 Dr. Daniel C. Hatton

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation: version 3 of the License.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program (in file LICENSE).  If not, see
# <https://www.gnu.org/licenses/>.

.ONESHELL : 

SHELL = /usr/bin/perl
.SHELLFLAGS = -e

.PHONY : install clean

install : leastsqtobayes dothefit.gp pickout.gp

	use strict ;
	use warnings ;
	use File::Copy qw(copy) ;
	require "./prefix" ;
	my $$prefix = &prefix() ;
	my $$uidofroot   = getpwnam("root") ;
	my $$gidofroot   = getpwnam("root") ;
	if(!(-d $$prefix . "/bin")) {
	mkdir($$prefix . "/bin") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/bin") ;
	chmod(0755, $$prefix . "/bin") ;
	}
	copy("leastsqtobayes", $$prefix . "/bin/leastsqtobayes") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/bin/leastsqtobayes") ;
	chmod(0755, $$prefix . "/bin/leastsqtobayes") ;
	if(!(-d $$prefix . "/share")) {
	mkdir($$prefix . "/share") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share") ;
	chmod(0755, $$prefix . "/share") ;
	}
	if(!(-d $$prefix . "/share/gnuplot")) {
	mkdir($$prefix . "/share/gnuplot") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/gnuplot") ;
	chmod(0755, $$prefix . "/share/gnuplot") ;
	}
	if(!(-d $$prefix . "/share/gnuplot/gnuplot")) {
	mkdir($$prefix . "/share/gnuplot/gnuplot") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/gnuplot/gnuplot") ;
	chmod(0755, $$prefix . "/share/gnuplot/gnuplot") ;
	}
	copy("dothefit.gp", $$prefix . "/share/gnuplot/gnuplot/leastsqtobayes_dothefit.gp") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/gnuplot/gnuplot/leastsqtobayes_dothefit.gp") ;
	chmod(0644, $$prefix . "/share/gnuplot/gnuplot/leastsqtobayes_dothefit.gp") ;
	copy("pickout.gp", $$prefix . "/share/gnuplot/gnuplot/leastsqtobayes_pickout.gp") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/gnuplot/gnuplot/leastsqtobayes_pickout.gp") ;
	chmod(0644, $$prefix . "/share/gnuplot/gnuplot/leastsqtobayes_pickout.gp") ;
	if(!(-d $$prefix . "/share/octave")) {
	mkdir($$prefix . "/share/octave") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave") ;
	chmod(0755, $$prefix . "/share/octave") ;
	}
	if(!(-d $$prefix . "/share/octave/m")) {
	mkdir($$prefix . "/share/octave/m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m") ;
	chmod(0755, $$prefix . "/share/octave/m") ;
	}
	if(!(-d $$prefix . "/share/octave/m/leastsqtobayes")) {
	mkdir($$prefix . "/share/octave/m/leastsqtobayes") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes") ;
	chmod(0755, $$prefix . "/share/octave/m/leastsqtobayes") ;
	}
	copy("interpret.m", $$prefix . "/share/octave/m/leastsqtobayes/interpret.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/interpret.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/interpret.m") ;
	copy("gaussian.m", $$prefix . "/share/octave/m/leastsqtobayes/gaussian.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/gaussian.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/gaussian.m") ;
	copy("drawfromgaussian.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromgaussian.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromgaussian.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromgaussian.m") ;
	copy("drawfromgaussian_ext.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromgaussian_ext.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromgaussian_ext.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromgaussian_ext.m") ;
	copy("lorentzian.m", $$prefix . "/share/octave/m/leastsqtobayes/lorentzian.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/lorentzian.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/lorentzian.m") ;
	copy("drawfromlorentzian.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromlorentzian.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromlorentzian.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromlorentzian.m") ;
	copy("drawfromlorentzian_ext.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromlorentzian_ext.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromlorentzian_ext.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromlorentzian_ext.m") ;
	copy("loglorentzian.m", $$prefix . "/share/octave/m/leastsqtobayes/loglorentzian.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/loglorentzian.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/loglorentzian.m") ;
	copy("drawfromloglorentzian.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromloglorentzian.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromloglorentzian.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromloglorentzian.m") ;
	copy("drawfromloglorentzian_ext.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromloglorentzian_ext.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromloglorentzian_ext.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromloglorentzian_ext.m") ;
	copy("tophat.m", $$prefix . "/share/octave/m/leastsqtobayes/tophat.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/tophat.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/tophat.m") ;
	copy("drawfromtophat.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromtophat.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtophat.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtophat.m") ;
	copy("drawfromtophat_ext.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromtophat_ext.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtophat_ext.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtophat_ext.m") ;
	copy("tophatwithwings.m", $$prefix . "/share/octave/m/leastsqtobayes/tophatwithwings.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/tophatwithwings.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/tophatwithwings.m") ;
	copy("drawfromtophatwithwings.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromtophatwithwings.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtophatwithwings.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtophatwithwings.m") ;
	copy("drawfromtophatwithwings_ext.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromtophatwithwings_ext.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtophatwithwings_ext.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtophatwithwings_ext.m") ;
	copy("truncatedquadratic.m", $$prefix . "/share/octave/m/leastsqtobayes/truncatedquadratic.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/truncatedquadratic.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/truncatedquadratic.m") ;
	copy("drawfromtruncatedquadratic.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromtruncatedquadratic.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtruncatedquadratic.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtruncatedquadratic.m") ;
	copy("drawfromtruncatedquadratic_ext.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromtruncatedquadratic_ext.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtruncatedquadratic_ext.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtruncatedquadratic_ext.m") ;
	copy("truncatedquadratic.m", $$prefix . "/share/octave/m/leastsqtobayes/truncatedquadratic.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/truncatedquadratic.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/truncatedquadratic.m") ;
	copy("drawfromtruncatedinverse.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromtruncatedinverse.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtruncatedinverse.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtruncatedinverse.m") ;
	copy("drawfromtruncatedinverse_ext.m", $$prefix . "/share/octave/m/leastsqtobayes/drawfromtruncatedinverse_ext.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtruncatedinverse_ext.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/drawfromtruncatedinverse_ext.m") ;
	copy("isouncert.m", $$prefix . "/share/octave/m/leastsqtobayes/isouncert.m") ;
	chown($$uidofroot, $$gidofroot, $$prefix . "/share/octave/m/leastsqtobayes/isouncert.m") ;
	chmod(0644, $$prefix . "/share/octave/m/leastsqtobayes/isouncert.m") ;

README.md : README_raw.md README.bib

	system("pandoc README_raw.md -t gfm-citations -o README.md --bibliography README.bib") ;

clean :

	unlink("prefix") ;
	unlink("README.md) ;
