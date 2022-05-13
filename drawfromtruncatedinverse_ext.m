# This is file drawfromtruncatedinverse_ext.m
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
# truncated inverse distribution, which is to a scale parameter
# as a top-hat distribution is to a location parameter

addpath(fileparts(mfilename('fullpath'))) ;
output_precision(floor(-log(eps(1))/log(10))) ;
drawfromtruncatedinverse(str2num(argv(){1}),str2num(argv(){2}))
