#!/bin/csh -f

set files = `ls vs*.dat | sed -e "s/.dat//g"`

foreach file ($files)
  echo $file
  set type = `echo $file | sed -e "s/vsini_//g"`
  awk -f 0make_dist.awk $file.dat > dist_$type.dat
  awk -f 0make_cdist.awk $file.dat > cdist_$type.dat
end

