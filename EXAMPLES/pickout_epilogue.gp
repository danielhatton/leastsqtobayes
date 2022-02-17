pickout(x,thenumber,currentrow) = abs(currentrow-thenumber) < 0.5 ? usr_function(x)+1.0 : usr_function(x)
set fit maxiter 1
FIT_MAXITER = 1
array inversesquareoreareffectiveuncertainties[numberofdata]
do for [currentrow = 1:numberofdata] {
load 'fitresults.par'
fit pickout(x,y,currentrow) 'usr_data_noxuncert.dat' using ($1):($0+1.0):(usr_function($1)):($2):(0.0):($4) errors x,y,z via 'fitresults.par'
inversesquareoreareffectiveuncertainties[currentrow] = FIT_WSSR
}
