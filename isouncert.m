# This is file isouncert.m
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

# Its purpose is to take in the central value and standard uncertainty
# of a quantity, and return a string representing the quantity and
# its standard uncertainty in the ISO standard format

function thestring = isouncert(centralvalue,standarduncertainty)

  quantitysizeorder = floor(log(abs(centralvalue))/log(10)) ;
  uncertaintysizeorder = floor(log(abs(standarduncertainty))/log(10)) ;
  numberofsigdigsofquantityrequired ...
  = quantitysizeorder-uncertaintysizeorder+2 ;
  positionoflastdigit = uncertaintysizeorder-1 ;
  mantissa = centralvalue/10^quantitysizeorder ;
  mantissa *= 10^(numberofsigdigsofquantityrequired-1) ;
  mantissa = roundb(mantissa) ; # Not just "banker's" rounding, ISO
                                # rounding!
  mantissa /= 10^(numberofsigdigsofquantityrequired-1) ;
  centralvaluerounded = mantissa*10^quantitysizeorder ;
  standarduncertaintyfirsttwo ...
  = standarduncertainty/10^(uncertaintysizeorder-1) ;
  standarduncertaintyfirsttwo = roundb(standarduncertaintyfirsttwo) ;
  if (positionoflastdigit > 0.5) || (quantitysizeorder < -4.5)
    if numberofsigdigsofquantityrequired < 1.5
      # Do nothing
      thestring ...
      = strcat(num2str(mantissa, ...
		       cstrcat("%.", ...
			       num2str(numberofsigdigsofquantityrequired-1), ...
			       "f")), ...
	       "(",num2str(standarduncertaintyfirsttwo,"%d"),")", ...
	       "e",num2str(quantitysizeorder)) ;
    elseif numberofsigdigsofquantityrequired < 2.5
      # Put in a decimal point
      standarduncertaintyfirsttwo /= 10 ;
      thestring ...
      = strcat(num2str(mantissa, ...
		       cstrcat("%.", ...
			       num2str(numberofsigdigsofquantityrequired-1), ...
			       "f")), ...
	       "(",num2str(standarduncertaintyfirsttwo,"%.1f"),")", ...
	       "e",num2str(quantitysizeorder)) ;
    else
      thestring ...
      = strcat(num2str(mantissa, ...
		       cstrcat("%.", ...
			       num2str(numberofsigdigsofquantityrequired-1), ...
			       "f")), ...
	       "(",num2str(standarduncertaintyfirsttwo,"%d"),")", ...
	       "e",num2str(quantitysizeorder)) ;
    endif
    
  elseif positionoflastdigit > -0.5
    thestring ...
    = strcat(num2str(centralvaluerounded, ...
		     cstrcat("%.", ...
			     num2str(-positionoflastdigit), ...
			     "f")), ...
	     "(",num2str(standarduncertaintyfirsttwo,"%d"),")") ;
  elseif positionoflastdigit > -1.5
    standarduncertaintyfirsttwo /= 10 ;
    thestring = strcat(num2str(centralvaluerounded, ...
			       "%.1f"), ...
		       "(",num2str(standarduncertaintyfirsttwo,"%.1f"),")") ;
  else
    thestring = strcat(num2str(centralvaluerounded, ...
			       cstrcat("%.", ...
				       num2str(-positionoflastdigit), ...
				       "f")), ...
		       "(",num2str(standarduncertaintyfirsttwo,"%d"),")") ;
  endif
endfunction
