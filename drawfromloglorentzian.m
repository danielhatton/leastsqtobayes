# This is file drawfromloglorentzian.m
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

# Its purpose is to return a single sample from a log-Lorentzian
# distribution; if a Lorentzian is a suitable noninformative prior
# for a location parameter, it follows that the log-Lorentzian is
# a suitable noninformative prior for a scale parameter

function thesample = drawfromloglorentzian()

  thesample = exp(tan(pi*(rand()-1/2))) ;

endfunction
