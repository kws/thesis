#!/bin/csh -f

##### CONFIG
set dev = epsf_p
set spec = ~/new/new/spectra/
set closeness = 1.5
set xr = "4620 4680"

##### SETUP
source /user/kcs/pgpixf3/pgpixf3_setup
rm gks74* >& /dev/null

##### CREATE LINES
printf "%s\n%e\n%e\n%e\n" lines.ocn $xr $closeness | ~/new/scr/lines/lines
mv fort.15 lines.ocn.cmd

##### MAKE DIAGRAM
cat <<EOF | pgpixf3
begin $dev 1 1
magic
paper 1200 350
vport 0.05 0.95 0.15 0.95
scf 2

sch 1.25
window $xr 0.5 1.2
box bcnst 0 0  bnst 0 0
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"
ptext 0.0 "HD 191781 - ON9.7 Iab" 4621 1.05 0.0
ptext 0.0 "HD 194280 - OC9.7 Iab" 4621 0.85 0.0

rdsdf $spec/hd191781
clipx
bin t

window $xr 0.7 1.4
box " " 0 0 cmst 0 0

rdsdf $spec/hd194280
clipx
bin t

sch 1.1
window $xr 0.5 1.2
input lines.ocn.cmd


end
quit

EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps on_oc.eps
endif

rm *.cmd