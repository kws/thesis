#!/bin/csh -f

rm gks74* >& /dev/null

source /user/kcs/pgpixf3/pgpixf3_setup

cat <<EOF | pgpixf3
begin epsf_p 1 3
paper 1400 1900
page
input logg.cmd
page
input y.cmd
page
input rot.cmd
end
quit
EOF

mv gks74.ps hydrogen.eps

gks_convert hydrogen.eps
