#!/bin/csh -f

source ../00bsconfig

set vsinid = $bsdir/vsini
set specd   = $bsdir/spec
set bscd   = $bsdir/cats/bsc5

rm vs*.dat

awk -f 0vsini.awk $vsinid/vsini.op.corr | sort >! vsinis
awk -f 0bsc.awk   $bscd/bsc5.asc.sptype | sort >! bsctypes
join vsinis bsctypes | awk '{print $2,$1,$4 > "vsini_"$3".dat"}'

rm vsinis bsctypes
