#!/bin/csh -f

source ../00bsconfig

set dev = epsf_p
source $pgpsetup
rm gks* >& /dev/null

set BIe = `wc vsini_BIe.dat | awk '{print $1}'`
set BIl = `wc vsini_BIl.dat | awk '{print $1}'`
set BVe = `wc vsini_BVe.dat | awk '{print $1}'`
set BVl = `wc vsini_BVl.dat | awk '{print $1}'`

sed -e "s/%BIe%/$BIe/g"  -e "s/%BIl%/$BIl/g" \
    -e "s/%BVe%/$BVe/g"  -e "s/%BVl%/$BVl/g" \
    dist.tplt >! tmp.cmd


cat <<EOF | pgpixf3
begin $dev 2 1
paper 1400 700
page

input tmp.cmd
end
quit

EOF

rm tmp.cmd

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps dist_bsc.eps
endif

