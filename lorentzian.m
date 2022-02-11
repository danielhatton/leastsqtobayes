# This is file lorentzian.m
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

# Its purpose is to return the probabilty density in a Lorentzian
# distribution, which is suggested by Jeffreys:1961:TP as a
# noninformative prior for a location parameter when one's plans
# include model comparison

function probabilitydensity = lorentzian(x)

  probabilitydensity = 1/(pi*(1+x^2)) ;

endfunction
