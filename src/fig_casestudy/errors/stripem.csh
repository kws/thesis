#!/bin/tcsh -f

set files = *.dat

foreach f ($files)
  cp $f $f.bak
  awk -f stripem.awk $f.bak >! $f
  rm $f.bak
end 


