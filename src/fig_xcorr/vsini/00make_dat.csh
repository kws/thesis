#!/bin/csh -f

source ../00bsconfig

set vsinid = $bsdir/vsini
set specd  = $bsdir/spec

make -C $vsinid vsini.op

rm vs*.dat

set tplts = (tausco iother picet alplyr)
set workdir = $cwd

rm vsini*.dat
awk -f 0spectypes.awk $specd/spectypes.ref |sort >! spectypes.ref
awk -f 0vsini.awk $vsinid/vsini.op.corr |sort >! vsinis
join spectypes.ref vsinis | awk -f 0makedat.awk 

rm spectypes.ref vsinis
