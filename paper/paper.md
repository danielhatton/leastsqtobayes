---
title: 'leastsqtobayes: Bayesian outputs from least-squares fitting'
tags:
  - Gnuplot
  - M
  - Perl
  - statistics
  - Bayesian model comparison
  - Bayesian parameter estimation
authors:
  - name: Daniel C. Hatton
    orcid: 0000-0002-4585-3336
    affiliation: "1" # (Multiple affiliations must be quoted)
affiliations:
 - name: Independent Researcher
   index: 1
date: "24 June 2022"
bibliography: paper.bib
---

# Summary of high-level functionality

## Scope

This software is relevant to a situation in which:

* the value of some dependent variable depends on the values of zero
  or more independent variables;
* there exists a data set of empirical measurements of the value of
  the dependent variable, each accompanied by empirical measurements
  of corresponding values of all the independent variables;
* there exists at least one theoretical model for predicting the value
  of the dependent variable from the values of the independent
  variables;
* each model contains zero or more adjustable parameters,
  i.e. constant quantities which affect the mapping from independent
  variable values to dependent variable value, whose exact values are
  not known a priori; and
* one wishes to infer from the data the values of the parameters
  in each model, and, if there is more than one model, which model is
  most probably true.

## Action

In Bayesian parameter estimation, beliefs about parameter values, in
light of data, can [@Jeffreys:1931:SI; @Jeffreys:1932:TEL] be
summarized in a posterior expectation value and standard error.  If
the model has more than one parameter, the posterior standard error
has [@Jeffreys:1931:SI; @Jeffreys:1932:TEL] two variants: a
conditional standard error, based on the assumption that the other
parameters take their posterior expectation values; and a marginal
standard error, which involves a probability-weighted average over all
values of the other parameters.  In Bayesian model comparison, the
goodness of fit of a model to data is [@Jeffreys:1935:STS] measured by
a quantity known as the marginal likelihood, which automatically
embodies [@MacKay:1992:BI] Occam's razor and is therefore suitable for
direct comparison with other models.

However, it is much easier to obtain software packages and libraries
which, rather than Bayesian parameter estimation and model comparison,
instead perform least squares fitting [qv. @Legendre:1805:NMD], which
defines a badness of fit measure called chi-squared for a model _with
specific values of its parameters_.  Software typically outputs the
minimum value of chi-squared with respect to the parameters; the
parameter values that achieve that minimum chi-squared; and some or
all of the elements of the Hessian of chi-squared with respect to the
parameters at that point in parameter space, intended for use in
estimating the standard errors of the parameters by heuristic methods.
Software documentation also often suggests heuristic ways of
attempting model comparison with these outputs.  This is convenient,
but lacks clear epistemological underpinning.

By a happy coincidence, however, these typical outputs of
least-squares fitting software contain enough information to obtain,
with some calculation, leading-order Laplace's method approximations
to the Bayesian posterior expectations and standard errors (both
versions) of the parameters, and to the marginal likelihood.  This
calculation is not entirely straightforward, and that is where the
present package, `leastsqtobayes`, comes in.  It is written in a
combination of three languages: Gnuplot [@Williams:2015:GRM], which
has powerful (indeed uniquely suitable in its handling of measurement
uncertainties) built-in capabilities for least-squares fitting; Octave
[@Eaton:2012:GOR], which has the matrix and scalar arithmetic
capabilities for the calculations; and Perl [@Wall:2022:P], with the
text-processing capabilities to facilitate intercommunication between
Gnuplot and Octave code.

`leastsqtobayes` takes as input an empirical data set; a formula
representing a model; and specifications of the prior
probability distributions over the parameters; and provides as
output the Bayesian posterior expectations and standard errors of the
parameters; and the marginal likelihood.

# Statement of need

## Parameter estimation step

Several recent workers [e.g. @Fenton:2022:UVA; @Albert:2022:BAE;
@Gerster:2022:EBC], in common with the present author
[@Hatton:2003:SPE; @Sammonds:2017:MSI], have, in attempting to infer
posterior expectations and standard errors of parameters in a model
from data, found themselves unable to obtain those values with "off
the peg" least-squares fitting processes, and have had to resort to
bespoke computational approaches, with all the risks and duplication
of effort in software quality control this implies.  This has been
particularly prevalent in cases where the distinction between
conditional and marginal standard errors matters.

## Model comparison step

@Dunstan:2022:ECB argue that all users of least-squares fitting should
supply the value of the marginal likelihood for each model they fit,
and note the current ubiety of applications of least-squares fitting
in which no such value is supplied.  They further point out that a
reason for general non-reporting of marginal likelihood values is the
perceived computational complexity of obtaining those values.

Algebraic formulae for the leading-order Laplace's method
approximations to the posterior expectations and standard deviations
of parameters are provided by @Lindley:1980:ABM, and an algebraic
formula for the leading-order Laplace's method approximation to the
marginal likelihood is provided by @Kass:1995:BF.  Yet despite these
formulae having been in the open literature for decades,
@Dunstan:2022:ECB attribute the perceived complexity of computing the
marginal likelihood, which they believe leads to the absence of
marginal likelihood computations in most applications of least-squares
fitting, to a widespread failure to use these formulae.

# From the need to the software

However, @Dunstan:2022:ECB leave as an exercise for the reader finding
how to extract, from the outputs of standard least-squares fitting
software, the information required as input to the @Lindley:1980:ABM
and @Kass:1995:BF formulae, and how to perform the actual computation.
Both are somewhat challenging, the former because Gnuplot outputs its
results in a format that is not very readily interoperable with other
systems, and the latter because of the need to compute the determinant
of the Hessian.  That is where the present software, `leastsqtobayes`,
comes in: it resolves the former issue using the text-processing
capabilities of Perl, and the latter using the matrix algebra
capabilities of Octave.  The final output to the user includes all the
quantities for which an inferential need is identified above.
