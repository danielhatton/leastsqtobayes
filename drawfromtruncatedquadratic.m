# This is file drawfromtruncatedquadratic.m
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

# Its purpose is to return a single sample from a truncated quadratic
# distribution, which is suggested by Jeffreys:1961:TP as a
# noninformative prior for a parameter constrained to lie between
# lower and upper bounds

function thesample = drawfromtruncatedquadratic(lowedge,highedge)

  linsample = rand() ;
  [thesample,dummy1,dummy2,dummy3] ...
  = fzero(@(X) linsample ...
	  -quad(@(x) truncatedquadratic(lowedge,highedge,x), ...
		lowedge,X),lowedge+(highedge-lowedge)*linsample) ;

  # Maxima claims to have a closed-form solution to this integration
  # and root-finding problem, but inserting that closed-form solution
  # into here consistently produces values in excess of highedge,
  # which is clearly unreasonable.  Hence, I'm sticking with this
  # numerical integration and root-finding approach.

endfunction
