#!/bin/csh -f

source ../00bsconfig
set dev = epsf_p

source $pgpsetup
rm gks* >& /dev/null

foreach f (vslet*.dat)
  awk '{printf "%4d %5.3f %9s\n",$1,log($2/$1)/log(10),$3}' $f>! $f:r.rat
end

cat <<EOF | pgpixf3
begin $dev 
paper 1200 1200

input sletcomp.cmd
end
quit

EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps sletcomp.eps
endif




