#!/bin/csh -f

echo "Using parameters from McErlan et al."
./0calculate.csh 29.0 3.06 -7.0 |tee  results.mcerlan

#echo "Using parameters from Lames and Leitherer"
#./0calculate.csh 28.0 2.85 -7.0

echo "Groenewegen  et. al."
../../programs/interp ../../programs/evol_mods 28.0 5.80

rm *.asc *.cmd
