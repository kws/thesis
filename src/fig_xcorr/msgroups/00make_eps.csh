#!/bin/csh -f

source ../00bsconfig

set dev = epsf_p
source $pgpsetup 
rm gks* >& /dev/null

set GR1 = `wc vsini_gr1.dat | awk '{print $1}'`
set GR2 = `wc vsini_gr2.dat | awk '{print $1}'`
set GR3 = `wc vsini_gr3.dat | awk '{print $1}'`
set GR4 = `wc vsini_gr4.dat | awk '{print $1}'`
set AGR = `cat vsini_gr*.dat| wc | awk '{print $1}'`
set E   = `wc vsini_e.dat | awk '{print $1}'`

sed -e "s/%GR1%/$GR1/g"  -e "s/%GR2%/$GR2/g" \
    -e "s/%GR3%/$GR3/g"  -e "s/%GR4%/$GR4/g" \
    0dist_gr.tplt >! tmp.cmd

sed -e "s/%AGR%/$AGR/g"  -e "s/%E%/$E/g" \
    0dist_allgr.tplt >! tmp2.cmd

cat <<EOF | pgpixf3
begin $dev 2 1
paper 1400 700
page

input tmp.cmd
page
input tmp2.cmd
end
quit

EOF

rm tmp*

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps fig_gr.eps
endif

if (-e gks74.ps.1) then
  gks_convert gks74.ps.1
  mv gks74.ps.1 fig_allgr.eps
endif



