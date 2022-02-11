# This is file tophatwithwings.m
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

# Its purpose is to return the probabilty density in the top-hat
# distribution with wings proposed as a prior over certain
# parameters by Hatton:2003:SPE

function probabilitydensity = tophatwithwings(lowedge,highedge,x)

  if (x < lowedge)
    probabilitydensity ...
    = 5.32*exp(-(5.32*(2*x-(highedge+lowedge)) ...
		 /(2*(highedge-lowedge)))^2/2) ...
      /(sqrt(2)*(highedge-lowedge)) ;
  elseif (x < highedge)
    probabilitydensity = 127/(128*(highedge-lowedge)) ;
  else
    probabilitydensity = ...
    = 5.32*exp(-(5.32*(2*x-(highedge+lowedge)) ...
		 /(2*(highedge-lowedge)))^2/2) ...
      /(sqrt(2)*(highedge-lowedge)) ;
  endif

endfunction
