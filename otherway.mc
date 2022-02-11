/*This is file interpret.m
written by Dr. Daniel C. Hatton 

Daniel Hatton can be contacted on <dan.hatton@physics.org> 

Copyright (C) 2022 Dr. Daniel C. Hatton

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation: version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program (in file LICENSE).  If not, see
<https://www.gnu.org/licenses/>.

This is a script for the Maxima computer algebra system.

Its purpose is to compute exactly some moments of a posterior
distribution over parameters (obtained using the leading-order
Laplace's method approximation set out in \citet{Lindley:1980:ABM})
and a marginal likelihood (obtained using the leading-order Laplace's
method approximation set out in \citet{Kass:1992:ABF} and
\citet{Kass:1995:BF}) in a very simple regression problem, primarily
as a benchmark for the leastsqtobayes system, which computes such
moments using numerical optimization in a much wider range of
regression problems.*/

load("eigen") $
chisquarednoxuncert(gradient,intercept,x1,Deltax1,y1,Deltay1,x2,Deltax2,y2,Deltay2,x3,Deltax3,y3,Deltay3) := (y1-gradient*x1-intercept)^2/(Deltay1^2)+(y2-gradient*x2-intercept)^2/(Deltay2^2)+(y3-gradient*x3-intercept)^2/(Deltay3^2) $
chisquarednoyuncert(gradient,intercept,x1,Deltax1,y1,Deltay1,x2,Deltax2,y2,Deltay2,x3,Deltax3,y3,Deltay3) := (y1-gradient*x1-intercept)^2/((gradient*Deltax1)^2)+(y2-gradient*x2-intercept)^2/((gradient*Deltax2)^2)+(y3-gradient*x3-intercept)^2/((gradient*Deltax3)^2) $
prior(gradient,intercept) := 1/(%pi^2*(1+gradient^2)*(1+intercept^2)) $
extwrtgnoxuncert : diff(chisquarednoxuncert(gradient,intercept,x1,Deltax1,y1,Deltay1,x2,Deltax2,y2,Deltay2,x3,Deltax3,y3,Deltay3),gradient) = 0 $
extwrtinoxuncert : diff(chisquarednoxuncert(gradient,intercept,x1,Deltax1,y1,Deltay1,x2,Deltax2,y2,Deltay2,x3,Deltax3,y3,Deltay3),intercept) = 0 $
thesolnsnoxuncert : solve([extwrtgnoxuncert,extwrtinoxuncert],[gradient,intercept]) $
hessianofchisquarednoxuncert : matrix([diff(chisquarednoxuncert(gradient,intercept,x1,Deltax1,y1,Deltay1,x2,Deltax2,y2,Deltay2,x3,Deltax3,y3,Deltay3),gradient,2),diff(diff(chisquarednoxuncert(gradient,intercept,x1,Deltax1,y1,Deltay1,x2,Deltax2,y2,Deltay2,x3,Deltax3,y3,Deltay3),gradient),intercept)],[diff(diff(chisquarednoxuncert(gradient,intercept,x1,Deltax1,y1,Deltay1,x2,Deltax2,y2,Deltay2,x3,Deltax3,y3,Deltay3),gradient),intercept),diff(chisquarednoxuncert(gradient,intercept,x1,Deltax1,y1,Deltay1,x2,Deltax2,y2,Deltay2,x3,Deltax3,y3,Deltay3),intercept,2)]) $
subst(first(first(thesolnsnoxuncert)),hessianofchisquarednoxuncert) $
hessianofchisquarednoxuncertatminchisquared : subst(second(first(thesolnsnoxuncert)),%) $
Lindleysigmanoxuncert : 2*invert(hessianofchisquarednoxuncertatminchisquared) $
LindleyLnoxuncert : hessianofchisquarednoxuncertatminchisquared/2 $
gradientstderrmargnoxuncert : sqrt(Lindleysigmanoxuncert[1,1]) $
interceptstderrmargnoxuncert : sqrt(Lindleysigmanoxuncert[2,2]) $
gradientstderrcondnoxuncert : 1/sqrt(LindleyLnoxuncert[1,1]) $
interceptstderrcondnoxuncert : 1/sqrt(LindleyLnoxuncert[2,2]) $
theevsnoxuncert : eigenvalues(Lindleysigmanoxuncert) $
diagsigmanoxuncert : matrix([first(first(theevsnoxuncert)),0],[0,second(first(theevsnoxuncert))]) $
diagLnoxuncert : matrix([1/first(first(theevsnoxuncert)),0],[0,1/second(first(theevsnoxuncert))]) $
principalaxesnouncert : uniteigenvectors(Lindleysigmanoxuncert) $
marglike : (determinant(Lindleysigmanoxuncert))^(1/2)*exp(-chisquarednoxuncert(rhs(first(first(thesolnsnoxuncert))),rhs(second(first(thesolnsnoxuncert))),x1,Deltax1,y1,Deltay1,x2,Deltax2,y2,Deltay2,x3,Deltax3,y3,Deltay3)/2)/((2*%pi)^(1/2)*Deltay1*Deltay2*Deltay3)*prior(rhs(first(first(thesolnsnoxuncert))),rhs(second(first(thesolnsnoxuncert)))) $
x1value : x1 = -0.15322 $
x2value : x2 = 1.1342 $
x3value : x3 = 2.0054 $
y1value : y1 = 6.9014 $
y2value : y2 = 16.104 $
y3value : y3 = 22.952 $
Deltay1value : Deltay1 = 1.0 $
Deltay2value : Deltay2 = 1.0 $
Deltay3value : Deltay3 = 1.0 $
thesolnsnoxuncert,x1value,x2value,x3value,y1value,y2value,y3value,Deltay1value,Deltay2value,Deltay3value ;
gradientstderrmargnoxuncert,x1value,x2value,x3value,y1value,y2value,y3value,Deltay1value,Deltay2value,Deltay3value ;
interceptstderrmargnoxuncert,x1value,x2value,x3value,y1value,y2value,y3value,Deltay1value,Deltay2value,Deltay3value ;
gradientstderrcondnoxuncert,x1value,x2value,x3value,y1value,y2value,y3value,Deltay1value,Deltay2value,Deltay3value ;
interceptstderrcondnoxuncert,x1value,x2value,x3value,y1value,y2value,y3value,Deltay1value,Deltay2value,Deltay3value ;
diagsigmanoxuncert,x1value,x2value,x3value,y1value,y2value,y3value,Deltay1value,Deltay2value,Deltay3value ;
principalaxesnouncert,x1value,x2value,x3value,y1value,y2value,y3value,Deltay1value,Deltay2value,Deltay3value ;
marglike,x1value,x2value,x3value,y1value,y2value,y3value,Deltay1value,Deltay2value,Deltay3value,numer ;
