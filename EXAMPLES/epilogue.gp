set print 'gnuplot_outputs.m'
print 'differencebetweennumberofdataandnumberofparams = ', FIT_NDF, ' ;'
print 'paramvaluesatminchisquared = [', gradient, ',', intercept, '] ;'
print 'minchisquared = ', FIT_WSSR, ' ;'
print 'squarerootsofdiagonalelementsofdoubletheinversehessianatminchisquared = [', gradient_err, ',', intercept_err, '] ;'
print 'doubletheinversehessianatminchisquared = [', FIT_COV_gradient_gradient, ',', FIT_COV_gradient_intercept, ';', FIT_COV_intercept_gradient, ',', FIT_COV_intercept_intercept, '] ;'
save fit 'fitresults.par'
numberofparams = 2
numberofdata = FIT_NDF+numberofparams
set print 'numberofdata.gp'
print 'numberofdata = ', numberofdata
