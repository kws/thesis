#!/bin/csh -f

set dev = epsf_p

########### SETUP LINES
set lnpth = ~/new/scr/lines
set xmin = 4194
set xmax = 4206
set closeness = 1.2

printf '%s/lines.scholtz72\n%e\n%e\n%e\n' $lnpth $xmin $xmax $closeness | $lnpth/lines
mv fort.15 lines.cmd

rm gks74* >& /dev/null

source /user/kcs/pgpixf3/pgpixf3_setup


cat <<EOF | pgpixf3
begin $dev 
input plot.cmd
window 4192 4208 0.3 1.20
input lines.cmd
end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps he2_4200_fit.eps
endif
