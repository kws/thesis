#!/bin/csh -f

set vsinid = ../../fig_xcorr/vsini_bscspec

cat $vsinid/vsini_BI[e,l].dat | awk '{print $1 $3}' | sed -e 's/[A-z,-]/ /g' | awk '{print $2, $1}' | sort -k1n -k2n >! newdist
echo +99 1 >> newdist

awk -f 0median.awk newdist | awk '{printf "B%-4s & %4s & %4s & %8s\n", $1,$3,$2,$4}' >! new.tab

awk -f 0join.awk new.tab >! median.tex
echo "Left results in median.tex"
rm new*
