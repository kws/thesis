#!/bin/csh -f
####################################
set dev = epsf_p
####################################

source /user/kcs/pgpixf3/pgpixf3_setup
rm gks74*

pgpixf3 <<EOF
begin $dev 2 4
paper 800 1200
page
input display_he1.cmd
end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps ../errors_he1.eps
endif

pgpixf3 <<EOF
begin $dev 2 2
paper 800 600
page
input display_he2.cmd
end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps ../errors_he2.eps
endif


