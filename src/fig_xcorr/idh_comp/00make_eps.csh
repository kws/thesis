#!/bin/csh -f

source ../00bsconfig
set vsinid = $bsdir/vsini

set dev = epsf_p
source $pgpsetup

rm gks* >& /dev/null

foreach f (idh*.dat)
  awk '{printf "%4d %5.3f %9s\n",$1,log($2/$1)/log(10),$3}' $f>! $f:r.rat
end

awk '{printf "%4d %5.3f\n", $1, log($4)/log(10)}' $vsinid/tausco.corr >! tausco.corr
awk '{printf "%4d %5.3f\n", $1, log($4)/log(10)}' $vsinid/iother.corr >! iother.corr

cat <<EOF | pgpixf3
begin $dev 
paper 1200 1200

input idhcomp.cmd
end
quit

EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps idhcomp.eps
endif





