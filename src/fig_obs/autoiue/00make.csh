#!/bin/csh -f

################################
set dev = epsf_p
################################

source /user/kcs/pgpixf3/pgpixf3_setup

rm gks74.ps* >& /dev/null

pgpixf3 <<EOF

begin $dev
paper 1200 500
scf 2
vport 0.1 0.95 0.1 0.95

window 1600 1800 0 4.5
box bcnst 0 0 " " 0 0
sch 1.25
mtext B 2.5 0.5 0.5 "Wavelength (\A)"
mtext L 2.5 0.5 0.5 "Rectified Intensity"
sch 1.0

ptext 1.0 "GPHOT" 1795 4.2 0.0
ptext 1.0 "PHOT/PI"  1795 3.2 0.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vport 0.1 0.95 0.76 0.95
window 1600 1800 0.5 1.5
box "" 0 0 bcmst 0.5 2

rdsdf swp5652_gs_norm
bin t

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vport 0.1 0.95 0.1 0.76
window 1600 1800 -1.99 1.5
box "" 0 0 bcnst 1 4

rdsdf swp5652_ps_norm
bin t
end
quit

EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps autoiue_swp5652.eps
endif
