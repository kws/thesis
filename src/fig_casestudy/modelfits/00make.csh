#!/bin/csh -f

rm gks* >&/dev/null

source /user/kcs/pgpixf3/pgpixf3_setup

cat <<EOF | pgpixf3
begin epsf_p 2 4
paper 1500 2200

input plot_he1.cmd

input plot_he2.cmd
input plot_h.cmd
end
quit
EOF

gks_convert gks*

mv gks74.ps ../model_fit_he1.eps
mv gks74.ps.1 ../model_fit_he2+h.eps









