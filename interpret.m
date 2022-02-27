# This is file interpret.m
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

# Its purpose is to take the outputs from a Gnuplot fit process,
# and reexpress them in terms of moments of a posterior distribution
# over parameters (obtained using the leading-order Laplace's method
# approximation set out in \citet{Lindley:1980:ABM}) and a marginal
# likelihood (obtained using the leading-order Laplace's method
# approximation set out in \citet{Kass:1992:ABF} and
# \citet{Kass:1995:BF}).

# First load the outputs from Gnuplot

run("gnuplot_outputs.m") ;
run("inversesquareoreareffectiveuncertainties.m") ;

# Also load the list of parameter names and the list of priors over the
# parameters

run("priorsforoctave.m") ;

Lindleysigmatwosubscripts = doubletheinversehessianatminchisquared ;
LindleyLtwosubscripts = -inv(Lindleysigmatwosubscripts) ;

# To find the (leading-order Laplace's-method approximation to the)
# marginal posterior standard error of any given parameter, one
# applies equation 3 of \citet{Lindley:1980:ABM} first with the square
# of that parameter as u, then with that parameter as u, then
# subtracts the square of the second result from the first result, and
# finally takes the square root.  In the subtraction, a lot of awkward
# terms cancel to leading order: in particular, all the terms
# involving the prior and all the terms involving the third
# derivatives of the natural log likelihood go away, and the final
# result is just the square root of the relevant diagonal element of
# the sigma matrix.

# The same analysis applied to a single integral (i.e. an integral
# with respect to just the one parameter) means that the
# (leading-order Laplace's-method approximation to the) conditional
# posterior standard error of any given parameter is just the square
# root of minus the reciprocal of the relevant diagonal element of the
# Hessian of the natural log likelihood

margpoststderr = zeros(0) ;
condpoststderr = zeros(0) ;
for paramnumber = [1:columns(paramvaluesatminchisquared)]
  margpoststderr(paramnumber) = ...
  sqrt(Lindleysigmatwosubscripts(paramnumber,paramnumber)) ;
  condpoststderr(paramnumber) = ...
  sqrt(-1/LindleyLtwosubscripts(paramnumber,paramnumber)) ;
endfor

# Whether one uses the conditional standard errors or the marginal
# standard errors, the (posterior) probability distributions over the
# several parameters whose standard deviations are those standard
# errors are not mutually independent.  That's a problem if one wants
# to do onward calculations with the estimated parameter values
# straightforwardly, i.e. propagating standard errors by adding them
# in quadrature.

# Fortunately, if one works in terms of those linear combinations of
# the original parameters that diagonalize the Hessian of the natural
# log likelihood, i.e. the linear combinations represented by the
# eigenvectors of the Hessian, then the marginal standard errors in
# those linear combinations, estimated by the above-described method,
# will be the same as the conditional standard errors, again estimated
# by the above-described method.  That is to say, the posterior
# probability distributions over those linear combinations of
# parameters will \citep{Atzinger:1970:MEM} be, to leading order,
# mutually independent, and propagating the errors by adding in
# quadrature will be OK.

[principalaxes,diagonalizedLindleysigma] ...
= eig(Lindleysigmatwosubscripts) ;

rotatedparamvaluesatminchisquared ...
= principalaxes*paramvaluesatminchisquared' ;
rotatedparamvaluesatminchisquared = rotatedparamvaluesatminchisquared' ;
rotatedpoststderr = zeros(0) ;

for newparamnumber = [1:columns(paramvaluesatminchisquared)]
  rotatedpoststderr(newparamnumber) ...
  = sqrt(diagonalizedLindleysigma(newparamnumber, ...
				  newparamnumber)) ;
endfor

# Compute the marginal likelihood for use in model comparison using
# equation 5 of \citet{Kass:1995:BF}.

productoforearuncertainties = 1 ;
sumofnaturallogsoforearuncertainties = 0 ;

for currentinversesquareorearuncertainty ...
    = inversesquareoreareffectiveuncertainties
  productoforearuncertainties ...
  /= sqrt(currentinversesquareorearuncertainty) ;
  sumofnaturallogsoforearuncertainties ...
  -= log(currentinversesquareorearuncertainty)/2 ;
endfor

prioratminchisquared = 1 ;
naturallogofprioratminchisquared = 0 ;

for priornumber = [1:columns(priorindices)]
  if priorindices(priornumber) < 0.5
    prioratminchisquared *= ...
    lorentzian(paramvaluesatminchisquared(priornumber)) ;
    naturallogofprioratminchisquared ...
    += log(lorentzian(paramvaluesatminchisquared(priornumber))) ;
  elseif priorindices(priornumber) < 1.5
    prioratminchisquared *= ...
    loglorentzian(paramvaluesatminchisquared(priornumber)) ;
    naturallogofprioratminchisquared ...
    += log(loglorentzian(paramvaluesatminchisquared(priornumber))) ;
  elseif priorindices(priornumber) < 2.5
    prioratminchisquared *= ...
    truncatedquadratic(firsthyperparameters(priornumber), ...
		       secondhyperparameters(priornumber), ...
		       paramvaluesatminchisquared(priornumber)) ;
    naturallogofprioratminchisquared ...
    += log(truncatedquadratic(firsthyperparameters(priornumber), ...
			      secondhyperparameters(priornumber), ...
			      paramvaluesatminchisquared(priornumber))) ;
  elseif priorindices(priornumber) < 3.5
    prioratminchisquared *= ...
    tophat(firsthyperparameters(priornumber), ...
	   secondhyperparameters(priornumber), ...
	   paramvaluesatminchisquared(priornumber)) ;
    naturallogofprioratminchisquared ...
    += log(tophat(firsthyperparameters(priornumber), ...
		  secondhyperparameters(priornumber), ...
		  paramvaluesatminchisquared(priornumber))) ;
  elseif priorindices(priornumber) < 4.5
    prioratminchisquared *= ...
    tophatwithwings(firsthyperparameters(priornumber), ...
		    secondhyperparameters(priornumber), ...
		    paramvaluesatminchisquared(priornumber)) ;
    naturallogofprioratminchisquared ...
    += log(tophatwithwings(firsthyperparameters(priornumber), ...
			   secondhyperparameters(priornumber), ...
			   paramvaluesatminchisquared(priornumber))) ;
  elseif priorindices(priornumber) < 5.5
    prioratminchisquared *= ...
    truncatedinverse(firsthyperparameters(priornumber), ...
		     secondhyperparameters(priornumber), ...
		     paramvaluesatminchisquared(priornumber)) ;
    naturallogofprioratminchisquared ...
    += log(truncatedinverse(firsthyperparameters(priornumber), ...
			    secondhyperparameters(priornumber), ...
			    paramvaluesatminchisquared(priornumber))) ;
  elseif priorindices(priornumber) < 6.5
    prioratminchisquared *= ...
    gaussian(firsthyperparameters(priornumber), ...
	     secondhyperparameters(priornumber), ...
	     paramvaluesatminchisquared(priornumber)) ;
    naturallogofprioratminchisquared ...
    += log(gaussian(firsthyperparameters(priornumber), ...
		    secondhyperparameters(priornumber), ...
		    paramvaluesatminchisquared(priornumber))) ;
  endif
endfor

if -real(naturallogofprioratminchisquared) > realmax()/8
  # Is this the best way to test for the prior being zero?
  disp("") ;
  error("The prior probability density functon over parameters\nis zero at the point in parameter space where chi-squared is at\nits minimum.  In this case, Laplace's method is still capable of\nsupplying leading-order estimates of the various moments this\nprogram seeks to calculate, but via formulas radically different\nfrom those that apply if the minimum value of chi-squared occurs\nin a region where the prior is non-zero.  This program does not\ncontain the formulas appropriate to a case where the minimum\nchi-squared occurs in a region of zero prior, and therefore\ncannot give you a good answer in this case.") ;
endif

marginallikelihood ...
= (det(Lindleysigmatwosubscripts))^(1/2) ...
  *exp(-minchisquared/2) ...
  *prioratminchisquared ...
  /((2*pi)^differencebetweennumberofdataandnumberofparams ...
    *productoforearuncertainties) ;
naturallogofmarginallikelihood ...
= log(det(Lindleysigmatwosubscripts))/2 ...
  -minchisquared/2+naturallogofprioratminchisquared ...
  -differencebetweennumberofdataandnumberofparams*(log(2)+log(pi)) ...
  -sumofnaturallogsoforearuncertainties ;

# Write some results to STDOUT


disp("") ;
disp("Note: all the following results are leading-order Laplace's-method") ;
disp("approximations.") ;
disp("") ;
disp("The parameter values with their marginal standard errors:") ;
disp("") ;

for thisparam = [1:columns(paramnames)]
  thestring = cstrcat(cell2mat(paramnames(thisparam))," = ", ...
		      isouncert(paramvaluesatminchisquared(thisparam), ...
				margpoststderr(thisparam))) ;
  disp(thestring) ;
endfor

disp("") ;
disp("The parameter values with their conditional standard errors:") ;
disp("") ;

for thisparam = [1:columns(paramnames)]
  thestring = cstrcat(cell2mat(paramnames(thisparam))," = ", ...
		      isouncert(paramvaluesatminchisquared(thisparam), ...
				condpoststderr(thisparam))) ;
  disp(thestring) ;
endfor

disp("") ;
disp("The posterior probability distributions over the several parameters") ;
disp("whose standard deviations the standard errors above represent are") ;
disp("not mutually independent.  This will create problems if one wants") ;
disp("to do onward calculations and propagate the standard errors by") ;
disp("straightforward combination in quadrature.  Fortunately, there are") ;
disp("certain linear combinations of the parameters over which the") ;
disp("posterior probability distributions are \\citep{Atzinger:1970:MEM},") ;
disp("to leading order, mutually independent.  The values of those linear") ;
disp("combinations, with their standard errors (there is no distinction") ;
disp("between marginal standard error and conditional standard error") ;
disp("in the case where the posterior distributions are independent)") ;
disp("follow.") ;
disp("") ;

for thisparam = [1:columns(paramnames)]
  lincomb = "" ;
  for thatparam = [1:columns(paramnames)]
    lincomb = cstrcat(lincomb, ...
		      num2str(principalaxes(thisparam,thatparam), ...
			      floor(-log(eps(1))/log(10))),"*", ...
		      cell2mat(paramnames(thatparam))) ;
    if (thatparam < columns(paramnames)-0.5) ...
       && (principalaxes(thisparam,thatparam+1) >= 0)
      lincomb = cstrcat(lincomb,"+") ;
    endif
  endfor
  thestring ...
  = cstrcat(lincomb," = ", ...
	    isouncert(rotatedparamvaluesatminchisquared(thisparam), ...
		      rotatedpoststderr(thisparam))) ;
  disp(thestring) ;
endfor

disp("") ;
disp("The marginal likelihood:") ;
disp("") ;

disp(num2str(marginallikelihood,floor(-log(eps(1))/log(10)))) ;

disp("") ;
disp("If the data set is moderately large, it's quite easy for the") ;
disp("marginal likelihood to become so small that the machine") ;
disp("floating-point number implementation can't tell it apart") ;
disp("from zero.  In these cases, it may be useful to have the") ;
disp("natural logarithm of the marginal likelihood:") ;
disp("") ;

disp(num2str(naturallogofmarginallikelihood, ...
	     floor(-log(eps(1))/log(10)))) ;
