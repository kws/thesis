#!/bin/tcsh -f

if ($#argv != 2) then 
  echo Usage: errors.csh line ew
  exit 1
endif

set line = $1
set ew   = $2

@ lmin = $line - 5
@ lmax = $line + 5

@ err = $ew / 20 + 1

@ min = $ew - $err
@ max = $ew + $err

source /user/kws/tgkiel/tgkiel3_setup

tgset old v15 y09 30000 40000 3.5 4.5 1000. 0.1

tgkiel << EOF

pgdev x2w
loady
yint .09

ewfast $lmin $lmax
pewt $ew

pga 
pgsc 2

pewt $min
pewt $max

quit
EOF

csplit fort.10 "/Equivalent/" "{2}"

cat xx01 | grep -v "%" > ${line}.dat
cat xx02 | grep -v "%" > ${line}_mns.dat
cat xx03 | grep -v "%" > ${line}_pls.dat
rm xx*

