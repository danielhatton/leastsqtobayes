#!/usr/bin/gnuplot

# This is file pickout.gp
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

# This is a script in the Gnuplot plotting and fitting language.

# Its purpose is to expose the \citet{Orear:1982:LSB} effective
# uncertainties from Gnuplot's least-squares fitting capability
# externally.

set fit noerrorscaling # The noerrorscaling option prevents fit from
                       # doing some weird rescalings to the Hessian of
		       # chi-squared (or at least its diagonal
		       # elements) that make the results harder to
		       # interpret in a Bayesian framework.

set fit errorvariables # The errorvariables option makes fit record
                       # the (inverse square roots of the) diagonal
		       # elements of the Hessian of chi-squared in
		       # user-accessible variables.

set fit covariancevariables # The covariancevariables option makes
                            # fit record the) off-diagonal elements
			    # of the Hessian of chi-squared in
			    # user-accessible variables.

load 'loadinfunction.gp'

load 'numberofdata.gp'

load 'pickout_epilogue.gp'
