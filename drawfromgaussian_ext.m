# This is file drawfromgaussian_ext.m
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

# This is a script in the Octave scientific programming language.

# Its purpose is to print to STDOUT a single sample from a
# Gaussian distribution, which might be \citep{Militky:1987:ABA} a
# suitable prior over a parameter if, e.g., that parameter has been
# the subject of a previous cycle of estimation from data

addpath(fileparts(mfilename('fullpath'))) ;
output_precision(floor(-log(eps(1))/log(10))) ;
drawfromgaussian(argv(1),argv(2))
