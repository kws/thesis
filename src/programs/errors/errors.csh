#!/bin/csh -f

# This script calculates errors on the calculated parameters.....

set prog = ../.

make -C $prog star2

set t = 35.0
set g = 3.5
set m = -5
set mode = 2 # 1 - supergiant mode; 2 - other mode

set dt = 1.0
set dg = 0.1
set dm = 0.3

echo "Temp: $t +/- $dt"
echo "logg: $g+/- $dg"
echo "Mv  : $m +/- $dm (mode: $mode)"
echo ""

echo -n "" >! testfile.asc
foreach temp (`awk -vVAL=$t -vERR=$dt -f err.awk`)
  foreach logg (`awk -vVAL=$g -vERR=$dg -f err.awk`)
    foreach Mv (`awk -vVAL=$m -vERR=$dm -f err.awk`)
      echo "      " $temp $logg $Mv >> testfile.asc
    end
  end
end

$prog/star2 $mode testfile.asc >! newfile.asc

awk -f err_print.awk newfile.asc

rm *.asc



