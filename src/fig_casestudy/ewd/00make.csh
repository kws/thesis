#!/bin/csh -f 

source /user/kcs/pgpixf3/pgpixf3_setup

rm gks74*

cat << EOF | pgpixf3
begin epsf_p 
paper 1200 900
vport 0.1 0.9 0.1 0.9

input fig_y09v15.cmd
end
quit
EOF

gks_convert gks74.ps
mv gks74.ps ewd.eps

