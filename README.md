# About this documentation file

This is file `README.md`

`README.md` is the documentation for software package `leastsqtobayes`
(see "Description" section below).

`README.md` was written by Dr. Daniel C. Hatton

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

# Contact

Daniel Hatton can be contacted on <dan.hatton@physics.org>.

# Description

`leastsqtobayes` brings to bear the least-squares fitting capabilities
of Gnuplot (Williams & Kelley, 2015) and the matrix and scalar
arithmetic capabilities of Octave (Eaton, 2012), producing outputs
useful in Bayesian parameter estimation and model comparison
(qv. Jeffreys, 1961), in a way that neither Gnuplot nor Octave applied
separately (nor, to the best of the author's knowledge, any other
widely-available software package) can straightforwardly achieve.

# Scope

The software is applicable to a situation where there is a theoretical
model (possibly chosen from among two or more such models), which
predicts the value of a dependent variable from the values of one or
more independent variables and the (constant but initially unknown)
values of one or more adjustable parameters; and there exists a data
set of measured values of the independent variable(s) and
corresponding measured values of the dependent variable.

# Outputs

The software outputs the leading-order Laplace's method approximations
to the following moments of the posterior probability distribution
over the parameters, given the data set:
* the posterior expectation of each parameter, computed using a single
  application of equation 3 of Lindley (1980);
* the posterior marginal standard error of each parameter, computed
  using two applications of equation 3 of Lindley (1980) (one to
  compute the posterior expectation of the square of the parameter,
  one to compute the posterior expectation of the parameter itself;
* the posterior conditional (on the other parameters taking their
  expectation values) standard error of each parameter, computed
  using two applications of equation 3 of Lindley (1980) as above;
* the coefficients needed to construct linear combinations of the
  parameters over which the posterior probability distributions are
  (to leading order) mutually independent, as described by Atzinger
  (1970);
* the posterior expectation of each of those linear combinations of
  the parameters, computed using a single application of equation 3 of
  Lindley (1980);
* the posterior  standard error of each parameter, computed
  using two applications of equation 3 of Lindley (1980) as above
  (there's no distinction between marginal standard error and
  conditional standard error in the case where the posterior
  probability distributions are mutually independent); and
* the marginal likelihood of the model, computed using equation 5 of
  Kass & Raftery (1995), for use in the model-comparison step of
  Bayesian inference, i.e. in determining the relative probability
  that each model is correct in the case where there is more than one
  model.

# Prerequisites

To install and use `leastsqtobayes`, you will need a system on which
Perl, Gnuplot (version 5.0 or higher), Octave, and GNU Make are
installed; to explore fully the available test case (see the "testing"
section below), you will also need the Maxima computer algebra system.

# Installation

I assume a GNU/Linux or similar environment.  The installation process
(and the use of the software) has been tested using Perl v5.30.0,
Gnuplot 5.2 patchlevel 8, and Octave 5.2.0 under Ubuntu 20.04.3.

* Copy the source code tree to your local filesystem, e.g. using `git
  clone https://github.com/danielhatton/leastsqtobayes`.
* Change working directory into the top-level directory of the source
  code tree (`cd leastsqtobayes` will do this in the context I think
  most likely to pertain).
* Run `./configure`.  If you want to install the software into a
  hierarchy other than `/usr/local`, then use the `--prefix`
  command-line option, e.g. `./configure --prefix=/usr`.
* Run `make install` with root privileges, e.g. via `sudo make
  install`.

# Invocation

To invoke `leastsqtobayes`, issue the command

`leastsqtobayes <usr_params_and_priors.par> <usr_function> <usr_data.dat>`

`<usr_params_and_priors.par>` is the name of a text file containing a
whitespace-separated table, with the names of the adjustable
parameters in the first column, and the corresponding selection of
prior probability distribution over each parameter in the second
column (see "priors" section below for more details).

`<usr_function>.gp` is the name of a text file containing the
specification of the theoretical model, in the format of a Gnuplot
function definition (qv. Crawford, 2021).  The name of the function
should also be `<usr_function>`, i.e. the same as the core of the
filename, and the list of arguments of the function should include
only the independent variables, not the adjustable parameters.

`<usr_data.dat>` is the name of a text file containing a
whitespace-separated table of the measured data.  The first column of
the table should contain the measured values of the first independent
variable, the second column the standard uncertainties in the
measurements of the first independent variable, the third column
contains the measured values of the second independent variable (if
there is more than one independent variable), the fourth column the
standard uncertainties in the measurements of the second independent
variable (if there is more than one independent variable), and so on,
until the penultimate column contains the measured values of the
dependent variable, and the last column contains the standard
uncertainties in the measurements of the dependent variable.  Hence,
the total number of columns should be two more than twice the number
of independent variables.  The ordering of independent variables
("first", "second", etc.) should be the same as the order in which
they appear in the list of arguments to the function in
`<usr_function>.gp`.

# Priors

As outlined in the "invocation" section above, the second column of
the table in `<usr_params_and_priors.par>` needs to contain the
selection of prior probability distribution over each parameter named
in the first column.  The string in the second column of any given row
should be one of:
* `lorentzian` for the Lorentzian prior proposed by Jeffreys (1961)
  as a noniformative prior for a location parameter: be aware that,
  because this gives special status to unity as a parameter value, it
  can (Jeffreys, 1961) be appropriate only if the parameter has
  quantity dimension 1;
* `loglorentzian` for the prior distribution over the parameter that
  is equivalent to a Lorentzian prior over the natural logarithm of
  the parameter, i.e. the prior that is to a scale parameter as a
  Lorentzian prior is to a location parameter;
* `truncatedquadratic` for the truncated quadratic prior proposed by
  Jeffreys (1961) as an otherwise noniformative prior for a parameter
  whose value is known to lie between a lower bound and an upper bound:
  in this case, there should be two further columns in the relevant
  row of the table, with the third column containing the lower-bound
  value of the parameter, and the fourth column containing the
  upper-bound value of the parameter;
* `tophat` for a top-hat prior, a simpler way to handle the case of a
  location parameter that is known to lie between a lower bound and an
  upper bound: in this case, there should be two further columns in
  the relevant row of the table, with the third column containing the
  lower-bound value of the parameter, and the fourth column containing
  the upper-bound value of the parameter;
* `tophatwithwings` for the top-hat distribution with wings proposed
  as a prior over certain parameters by Hatton (2003):
  in this case, there should be two further columns in the relevant
  row of the table, with the third column containing the
  value of the parameter at the lower edge of the top hat, and the
  fourth column containing the value of the parameter at the upper
  edge of the top-hat;
* `truncatedinverse` for the prior distribution over the parameter that
  is equivalent to a top-hat prior over the natural logarithm of
  the parameter, i.e. the prior that is to a scale parameter as a
  top-hat prior is to a location parameter: in this case, there should
  be two further columns in the relevant row of the table, with the
  third column containing the lower-bound value of the parameter, and
  the fourth column containing the upper-bound value of the parameter;
  or
* `gaussian` for a Gaussian prior, which might (Militkỳ & Čáp, 1987) be
  a suitable  prior over a parameter if, e.g., that parameter has been
  the subject of a previous cycle of estimation from data: in this
  case, there should be two further columns in the relevant row of the
  table, with the third column containing the mean of the Gaussian,
  and the fourth column containing the standard deviation of the
  Gaussian.

# Demonstration

To demonstrate (some of) the capabilities of the software, change
working directory into the supplied `EXAMPLES` directory, and run the
command

`leastsqtobayes usr_params_and_priors.par usr_function usr_data.dat`.

This will carry out the inference process on a relatively simple toy
case with a linear model (hence two parameters) fitted to a small data
set with just one independent variable.

# Testing

To test the software is working, change working directory into the
supplied `EXAMPLES` directory, and run the command

`leastsqtobayes usr_params_and_priors.par usr_function usr_data_noxuncert.dat`.

This will carry out the inference process on an even simpler case than
that described in the "demonstration" section above.  The correct
results from this even simpler toy problem can, alternatively, be
determined by hand or using a computer algebra system.  The file
`otherway.mc`, within the `EXAMPLES` directory, is a script for the
Maxima computer algebra system that does exactly this, and reveals
that the results should be:
* posterior expectation value and marginal standard error of gradient
  parameter: 7.41(46);
* posterior expectation value and marginal standard error of intercept
  parameter: 7.94(61);
* posterior expectation value and conditional standard error of gradient
  parameter: 7.41(31);
* posterior expectation value and conditional standard error of intercept
  parameter: 7.94(41);
* first "mutually independent posterior distributions" linear
  combination of parameters and its posterior expectation value and
  standard error:
  0.8257223485361581*gradient+0.5640767705977013*intercept =
  10.60(37);
* second "mutually independent posterior distributions" linear
  combination of parameters and its posterior expectation value and
  standard error:
  0.5640767705977012*gradient-0.825722348536158*intercept = -2.4(1.0);
* marginal likelihood: 4.053649961753398e-6;
* natural logarithm of marginal likelihood: -12.4158928575811.

# References

* Atzinger, E. M. (1970, September). _Mixed effects model estimation -
  optimal properties_. Ph.D. thesis, Pennsylvania State University:
  Department of Statistics.
* Crawford, D. (2021, December). _Gnuplot 5.4: An interactive plotting
  program_.  Retrieved from
  <https://web.archive.org/web/20220121095125/www.gnuplot.info/docs_5.4/Gnuplot_5_4.pdf>
* Eaton, J. W. (2012, September). GNU Octave: A high-level interactive
  language for numerical computations. _J. Process Control_,
  **22**(8), 1433-1438. doi:`10.1016/j.jprocont.2012.04.006`
* Hatton, D. C. (2003, August). _Spin-polarized electron scattering at
  ferromagnetic interfaces_. Ph.D. thesis, University of Cambridge:
  Girton College.
* Jeffreys, H. (1961). _Theory of probability_. The International
  Series of Monographs on Physics (third edition). Oxford: Clarendon
  Press.
* Kass, R. E., & Raftery, A. E. (1995, June). Bayes
  factors. _J. Am. Stat. Assoc._, **90**(430),
  773-795. doi:`10.1080/01621459.1995.10476572`
* Lindley, D. V. (1980, February). Approximate Bayesian
  methods. _Trab. Estad. Investig. Oper._, **31**(1),
  223-237. doi:`10.1007/BF02888353`
* Militkỳ, J., & Čáp, J. (1987, September). Application of the Bayes
  approach to adaptive Lₚ nonlinear regression. _Comput. Stat. Data
  Anal._, **5**(4), 381-389. doi:`10.1016/0167-9473(87)90060-0`
* Williams, T., & Kelley, C. (2015, August). _Gnuplot 5.0 reference
  manual_. Thames Ditton: Samurai Media.