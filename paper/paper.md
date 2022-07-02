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
* the value of some dependent variable depends on the values of some
  collection of zero or more independent variables;
* there exists a data set of empirical measurements of the value of
  the dependent variable, each accompanied by empirical measurements
  of the corresponding values of all the independent variables;
* there exists at least one theoretical model for predicting the value
  of the dependent variable from the values of the independent
  variables;
* each model contains zero or more adjustable parameters,
  i.e. quantities asserted in the model to be constant, and which
  affect the mapping from independent variable values to dependent
  variable value, but whose exact values are not known a priori; and
* one wishes to infer from the data the values of the parameters
  in each model, and, if there is more than one model, which model is
  most probably true.

## Action

In Bayesian parameter estimation, beliefs about the values of
parameters, in light of data, can [@Jeffreys:1931:SI;
@Jeffreys:1932:TEL] be summarized in a posterior expectation value and
standard error.  If the model has more than one parameter, the
posterior standard error comes [@Jeffreys:1931:SI; @Jeffreys:1932:TEL]
in two versions: a conditional standard error, based on the assumption
that the other parameters take their posterior expectation values; and
a marginal standard error, which is a probability-weighted average
over all values of the other parameters.  In Bayesian model
comparison, the goodness of fit of a model to data is
[@Jeffreys:1935:STS] measured by a quantity known as the marginal
likelihood, which automatically embodies Occam's razor and is
therefore suitable for direct comparison with other models.

However, in software procurement terms, it is much easier to obtain
software packages and libraries which, rather than Bayesian parameter
estimation and model comparison, instead perform least squares fitting
[qv. @Legendre:1805:NMD], which defines a badness of fit measure
called chi-squared for a model _with specific values of its
parameters_.  Software typically outputs the minimum value of
chi-squared with respect to the parameters, estimators of the
parameters computed as the point in parameter space that achieves that
minimum chi-squared, and some or all of the elements of the Hessian of
chi-squared with respect to the parameters at that point in parameter
space, intended for use in estimating the standard errors of the
parameters by heuristic methods.  Software documentation also often
suggests heuristic ways of attempting model comparison with these
outputs.  This is convenient, but lacks clear epistemological
underpinning.

By a happy coincidence, however, these typical outputs of
least-squares fitting software contain enough information to obtain,
with some calculation, leading-order Laplace's method approximations
to the Bayesian posterior expectations and standard errors (both
versions) of the parameters, and to the marginal likelihood.  This
calculation is not entirely straightforward, and that is where the
present package, `leastsqtobayes`, comes in.  It is written in a
combination of three languages: Gnuplot [@Williams:2015:GRM], which
has powerful built-in capabilities for least-squares fitting; Octave
[@Eaton:2012:GOR], which has the matrix and scalar arithmetic
capabilities for the conversion; and Perl [@Wall:2022:P], with the
text-processing capabilities to create bespoke sections Octave code
containing results produced by Gnuplot and vice versa.

`leastsqtobayes` takes as input an empirical data set; a formula
representing a model; and specifications of the prior
probability distributions over the parameters; and provides as
output the Bayesian posterior expectations and standard errors of the
parameters; and the marginal likelihood.

# Statement of need

## Parameter estimation step

Several recent workers [e.g. @Fenton:2022:UVA; @Albert:2022:BAE;
@Gerster:2022:EBC] have, in attempting to infer the posterior
expectations and standard errors of parameters in a model from data,
particularly in cases where the distinction between conditional
standard errors and marginal standard errors matters, found themselves
unable to obtain those values with "off the peg" least-squares fitting
processes, and have had to resort to bespoke computational approaches.
Indeed, the present author has [@Hatton:2003:SPE; @Sammonds:2017:MSI]
found himself in the same position.

## Model comparison step

@Dunstan:2022:ECB argue that all users of least-squares fitting should
supply the value of the marginal likelihood for each model they fit,
and note the current ubiety of applications of least-squares fitting
in which such a value is not supplied.  They further point out that a
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
fitting, to a failure to use these formulae.

However, @Dunstan:2022:ECB leave as an exercise for the reader the
implementation issues of how to extract, from the outputs of standard
least-squares fitting software, the information required as input to
the @Lindley:1980:ABM and @Kass:1995:BF formulae, and how to perform
the actual computation.  The primary challenge in that computation is
that it involves the determinant of the Hessian of the chi-squared
statistic with respect to the parameters, at the location in parameter
space that minimizes chi-squared.  That is where the present software,
`leastsqtobayes`, comes in: it resolves these issues by having the
Gnuplot least-squares fitting system output its results in a format
suitable for direct import to the Octave scientific programming
language, with its inbuilt determinant-finding capability, then have
Octave compute the determinant, by way of using Perl's text-processing
capabilities to generate bespoke Gnuplot and Octave code for any given
inference problem.
