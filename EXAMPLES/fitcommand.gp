fit usr_function(x) 'usr_data_noxuncert.dat' using ($1):($3):($2):($4) errors x,z via 'initialguesses.par'
