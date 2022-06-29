# About this documentation file

[comment1]: # (This is file `README_raw.md`)

[comment2]: # (`README_raw.md` is the documentation for software package `leastsqtobayes` (see "Description" section below).)

[comment3]: # (`README_raw.md` was written by Dr. Daniel C. Hatton)

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
of Gnuplot [@Williams:2015:GRM] and the matrix and scalar arithmetic
capabilities of Octave [@Eaton:2012:GOR], producing outputs useful in
Bayesian parameter estimation [qv. @Jeffreys:1931:SI;
@Jeffreys:1932:TEL] and model comparison [qv. @Jeffreys:1935:STS], in
a way that neither Gnuplot nor Octave applied separately (nor, to the
best of the author's knowledge, any other widely-available software
package) can straightforwardly achieve.  Specifically, the outputs
produced are the posterior expectations and standard errors of the
model's adjustable parameters, and the marginal likelihood, a
goodness-of-fit measure for the model that can be used directly in
model comparison.

# Scope

The situation to which this softare is relevant is one in which:

* it is thought possible that the value of some dependent variable
  depends on the values of some collection of zero or more independent
  variables;
* there exists a data set of empirical measurements of the value of
  the dependent variable, each accompanied by empirical measurements
  of the corresponding values of all of the independent variables;
* there exists at least one theoretical model for predicting the value
  of the dependent variable from the values of the independent
  variables;
* each theoretical model contains zero or more adjustable
  parameters, i.e. quantities that are asserted in the theoretical
  model to be constant, and which affect the mapping from independent
  variable values to dependent variable value, but whose exact values
  are not known a priori as part of the model; and
* one wishes to infer from the data set the values of any adjustable
  parameters in the theoretical models, and, if there is more than one
  theoretical model, which of the theoretical models is most probably
  true.

# Background

## Least squares fitting

Least squares fitting is [@Legendre:1805:NMD] a particular approach, in the
situation described above, to measuring how bad a fit a theoretical
model, with given values of its adjustable parameters, is to the
empirical data-set, and to minimizing that badness of fit with respect
to the parameter values.

The badness of fit is [@Bevington:2003:DRE] measured by a statistic
known as chi-squared.  The chi-squared statistic is
[@Epstein:1967:MOM] the sum, over all the individual empirical
measurements of the dependent variable, of the square of the quotient,
by the effective standard uncertainty in the measurement of the
dependent variable, of the difference between the measured value of
the dependent variable and the value of the dependent variable
predicted, from the values of the independent variables and adjustable
parameters, by the formula in the theoretical model.  Ideally, the
effective standard uncertainty should take account of uncertainty in
both the dependent variable and the independent variable(s), using the
method proposed by @Orear:1982:LSB; this is a key driver for the
selection of Gnuplot as the provider of least-squares fitting
capability: while many widely-available software packages provide
least-squares fitting routines, only two, to the present author's
knowledge, have the capability to include uncertainties in independent
variables in the analysis by the @Orear:1982:LSB method.  These two
are Gnuplot [@Williams:2015:GRM] and Wolfram Experimental Data Analyst
[@::EDA].  The latter is closed-source and requires payment of a
licence fee, leading the present author to focus on the former.

Typically, the least-squares fitting routine uses the
Levenberg-Marquardt algorithm [@Levenberg:1944:MSC;
@Marquardt:1963:ALS] to minimize chi-squared with respect to the
values of the parameters.  It then outputs the values of the
parameters that minimize chi-squared (intended as estimates of the
"true" parameter values), the minimum value of chi-squared, and in
some cases, information about some or all of the elements of the
Hessian of chi-squared with respect to the parameters at the minimum
(intended for use in estimating the standard errors of the parameters
by heuristic methods, qv. @Box:1956:ADC).

## Bayesian parameter estimation

Bayesian methodology also concerns itself [@Wrinch:1921:CFP], in this
situation, with the badness --- or rather goodness --- of fit of a
theoretical model to a data set.  From a Bayesian perspective, the
theoretical model is [@Wrinch:1921:CFP] conceived of as defining a
probability density distribution over the dependent-variable values
obtained for the particular measured sets of independent-variable
values, conditional on the "event" that the theoretical model is
correct, and on particular values of the adjustable parameters.  When
that probability density function, evaluated at the actual, measured
values of the dependent variable, is viewed as a function of the
parameter values, it is known as the "likelihood"
[qv. @Jeffreys:1935:STS], and is the Bayesian measure of the goodness
of fit of the model, with particular parameter values, to the data.

To estimate the values of the parameters, Bayes' theorem is
[@Jeffreys:1931:SI; @Jeffreys:1932:TEL] used to "invert" the
likelihood, i.e. to compute the probability density distribution over
the true values of the parameters, conditional on the "event" that the
theoretical model is correct, and on the actual values of the
measurements.  (The present paper will take for granted that it is
philosophically valid to represent by a probability how strongly one
believes in the truth of an assertion, but readers should be aware
that this is a matter of active controversy.)  This "posterior"
probability distribution is [@Jeffreys:1931:SI; @Jeffreys:1932:TEL]
proportional to the product of the likelihood with a "prior"
probability distribution that represents the analyst's beliefs about
the values of the parameters before this data set was considered.  The
posterior distribution over the parameters can [@Jeffreys:1931:SI;
@Jeffreys:1932:TEL] be summarized by the expectation values of those
parameters over the distribution, with either their marginal standard
deviations or their conditional standard deviations over the
distribution being the standard errors.

## Bayesian model comparison

Bayesian methodology can [@Jeffreys:1935:STS] also apply the same
principle to evaluate the relative probabilities of the truth of
different theoretical models, in cases where there is more than one
theoretical model.  For each theoretical model, the probability
density distribution over the dependent-variable values obtained for
the particular measured sets of independent-variable values,
conditional on the "event" that the theoretical model is correct, is
[@Jeffreys:1935:STS] given by integrating, with respect to the
adjustable parameters and over all values of those adjustable
parameters, the product of the model's prior probability density
function over the parameters and the probability density distribution
over the dependent-variable values obtained for the particular
measured sets of independent-variable values, conditional on the
"event" that the theoretical model is correct, _and_ on particular
values of the adjustable parameters.

When that probability density function, evaluated at the actual,
measured values of the dependent variable, is viewed as a property of
the model, it is known as the "marginal likelihood" [@Khanna:1964:SRD;
@Ando:1965:BAI], or sometimes as the "evidence" [@MacKay:1992:BI], and
is the Bayesian measure of the goodness of fit of the model to the
data.  Note that it is an average goodness of fit over all values of
the parameters: the Bayesian version of Occam's razor inheres
[@MacKay:1992:BI] in the fact that the marginal likelihood is, in
general, lower than the highest likelihood that can be achieved by
fine-tuning the parameter values; due to the presence of this inbuilt
Occam's razor, one can, indeed must, use the same data set for both
parameter estimation and model comparison.

At this point, if more than one theoretical model is available, Bayes'
theorem can [@Jeffreys:1935:STS] be used again, to invert the
probability density over the dependent-variable values obtained for
the particular measured sets of independent-variable values,
conditional on each "event" that a theoretical model is correct, and
compute the probability of the "event" that each theoretical model is
correct, conditional on the data being as they in fact are, i.e. the
"posterior probability" of each model.  This posterior probability is
[@Jeffreys:1935:STS] proportional to the product of the marginal
likelihood with the "prior probability" of the model, representing how
strongly one believes that model to be correct before taking into
account these data.  That completes the Bayesian inference process.

## Using least-squares fitting to achieve Bayesian parameter estimation
   and model comparison

In the Bayesian approach, the form of the probability density
distribution over dependent-variable values obtained for the
particular measured sets of independent-variable values, conditional
on the "event" that the theoretical model is correct, and on
particular values of the adjustable parameters, is a property of the
theoretical model.  Many theoretical models choose a Gaussian form
(@Jeffreys:1931:SI provides a detailed argument for why this should be
so), in which case there is an important link between the Bayesian
approach and least-squares fitting, namely that the likelihood
contains [@Bevington:2003:DRE] a factor that decays exponentially with
increasing chi-squared.  As a result, the integrals that define the
posterior expectations and standard errors of the parameters, and the
marginal likelihood, are amenable to approximate solution using
Laplace's method: in the notation of the detailed exposition of
Laplace's method due to @Olver:1997:ASF, chi-squared plays the role of
$$2xp\left(t\right)$$.

On this basis, algebraic formulae for the leading-order Laplace's
method approximations to the posterior expectations and standard
deviations of parameters are provided by @Lindley:1980:ABM, and an
algebraic formula for the leading-order Laplace's method approximation
to the marginal likelihood is provided by @Kass:1995:BF.  Yet despite
these formulae having been in the open literature for decades,
@Dunstan:2022:ECB attribute the perceived complexity of computing the
marginal likelihood, which they believe leads to the absence of
marginal likelihood computations in most applications of least-squares
fitting, to a failure to use these formulae.

# Outputs

The software outputs the leading-order Laplace's method approximations
to the following moments of the posterior probability distribution
over the parameters, given the data set:

* the posterior expectation of each parameter, computed using a single
  application of equation 3 of @Lindley:1980:ABM;
* the posterior marginal standard error of each parameter, computed
  using two applications of equation 3 of @Lindley:1980:ABM (one to
  compute the posterior expectation of the square of the parameter,
  one to compute the posterior expectation of the parameter itself;
* the posterior conditional (on the other parameters taking their
  expectation values) standard error of each parameter, computed using
  two applications of equation 3 of @Lindley:1980:ABM as above;
* the coefficients needed to construct linear combinations of the
  parameters over which the posterior probability distributions are
  (to leading order) mutually independent, as described by
  @Atzinger:1970:MEM;
* the posterior expectation of each of those linear combinations of
  the parameters, computed using a single application of equation 3 of
  @Lindley:1980:ABM;
* the posterior standard error of each of those linear combinations of
  the parameters, computed using two applications of equation 3 of
  @Lindley:1980:ABM as above (there's no distinction between marginal
  standard error and conditional standard error in the case where the
  posterior probability distributions are mutually independent); and
* the marginal likelihood of the model, computed using equation 5 of
  @Kass:1995:BF, for use in the model-comparison step of
  Bayesian inference, i.e. in determining the relative probability
  that each model is correct in the case where there is more than one
  model.

# Prerequisites

To install and use `leastsqtobayes`, you will need a system on which
Perl, Gnuplot (version 5.0 or higher), Octave, and GNU Make are
installed; to explore fully the available test case (see the "testing"
section below), you will also need the Maxima computer algebra system
[@Dautermann:2017:MM].

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
function definition [qv. @Crawford:2021:G].  The name of the function
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

* `lorentzian` for the Lorentzian prior proposed by @Jeffreys:1961:TP
  as a noniformative prior for a location parameter: be aware that,
  because this gives special status to unity as a parameter value, it
  can [@Jeffreys:1961:TP] be appropriate only if the parameter has
  quantity dimension 1;
* `loglorentzian` for the prior distribution over the parameter that
  is equivalent to a Lorentzian prior over the natural logarithm of
  the parameter, i.e. the prior that is to a scale parameter as a
  Lorentzian prior is to a location parameter;
* `truncatedquadratic` for the truncated quadratic prior proposed by
  @Jeffreys:1961:TP as an otherwise noniformative prior for a parameter
  whose value is known to lie between a lower bound and an upper bound:
  in this case, there should be two further columns in the relevant
  row of the table, with the third column containing the lower-bound
  value of the parameter, and the fourth column containing the
  upper-bound value of the parameter;
* `tophat` for the top-hat prior proposed by @Jeffreys:1935:STS, a
  simpler way to handle the case of a location parameter that is known
  to lie between a lower bound and an upper bound: in this case, there
  should be two further columns in the relevant row of the table, with
  the third column containing the lower-bound value of the parameter,
  and the fourth column containing the upper-bound value of the
  parameter;
* `tophatwithwings` for the top-hat distribution with wings proposed
  as a prior over certain parameters by @Hatton:2003:SPE :
  in this case, there should be two further columns in the relevant
  row of the table, with the third column containing the
  value of the parameter at the lower edge of the top hat, and the
  fourth column containing the value of the parameter at the upper
  edge of the top-hat;
* `truncatedinverse` for the prior distribution, as proposed by
  @Jeffreys:1935:STS, over the parameter that is equivalent to a
  top-hat prior over the natural logarithm of the parameter, i.e. the
  prior that is to a scale parameter as a top-hat prior is to a
  location parameter: in this case, there should be two further
  columns in the relevant row of the table, with the third column
  containing the lower-bound value of the parameter, and the fourth
  column containing the upper-bound value of the parameter; or
* `gaussian` for a Gaussian prior, which might [@Militky:1987:ABA] be
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
  0.8257223485361581\*gradient+0.5640767705977013\*intercept =
  10.60(37);
* second "mutually independent posterior distributions" linear
  combination of parameters and its posterior expectation value and
  standard error:
  0.5640767705977012\*gradient-0.825722348536158\*intercept = -2.4(1.0);
* marginal likelihood: 4.053649961753398e-6;
* natural logarithm of marginal likelihood: -12.4158928575811.

