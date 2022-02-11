# This is file drawfromtophatwithwings.m
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

# Its purpose is to return a single sample from the top-hat
# distribution with wings proposed as a prior over certain
# parameters by Hatton:2003:SPE

function thesample = drawfromtophatwithwings(lowedge,highedge)

  linsample = rand() ;
  [thesample,dummy1,dummy2,dummy3] ...
  = fzero(@(X) linsample ...
	  -quad(@(x) tophatwithwings(lowedge,highedge,x), ...
		-realmax,X),lowedge+(highedge-lowedge)*linsample) ;

endfunction
