#!/bin/csh -f
source ../00bsconfig
awk -v CORRFILE=$bsdir/vsini/vsini.op.corr -f 0make.awk \
       $bsdir/cats/bsc5/bsc5.asc.sptype

set files = `ls vs*.dat | sed -e "s/.dat//g"`

foreach file ($files)
  echo $file
  set type = `echo $file | sed -e "s/vsini_//g"`
  awk -f 0make_dist.awk $file.dat >! dist_$type.dat
  awk -f 0make_cdist.awk $file.dat >! cdist_$type.dat
end

cat vsini_gr*.dat | awk -f 0make_dist.awk >! dist_allgr.dat
cat vsini_gr*.dat | awk -f 0make_cdist.awk >! cdist_allgr.dat
