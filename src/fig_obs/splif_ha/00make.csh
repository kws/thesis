#!/bin/csh -f

#####################################################
set dev = epsf_p
#####################################################

rm gks*.ps >& /dev/null

source /user/kcs/pgpixf3/pgpixf3_setup
echo Uncompressing files....
gunzip *.gz

echo Lauching plot.....

pgpixf3 <<EOF
begin $dev
paper 1200 700

magic 

sch 1.25
vport 0.15 0.9 0.15 0.9
window 6440 6660 0.85 1.4
box bcnst 0 0 bcnst 0 0
mtext B 3.0 0.5 0.5 "Wavelength (\A)"
mtext L 3.0 0.5 0.5 "Rectified Intensity"
sch 1.0

rdsdf hd195592_ha
bin t

end
quit

EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps hd195592_ha.eps
endif

echo Compressing files....
gzip -9 *.sdf



