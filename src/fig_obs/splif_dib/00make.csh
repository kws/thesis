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

! Create frame
sch 1.25
vport 0.15 0.9 0.65 0.9
window 4380 4480 0.9 1.1
box cst 0 0 bcnst 0.1 5

vport 0.15 0.9 0.15 0.65
window 4380 4480 0.5 0.9
box bnst 0 0 bcst 0.1 5

vport 0.15 0.9 0.15 0.9
mtext B 3.0 0.5 0.5 "Wavelength (\A)"
mtext L 3.0 0.5 0.5 "Rectified Intensity"
sch 1.0

! Start plotting

vport 0.15 0.9 0.5975 0.9
window 4380 4480 0.85 1.1
rdsdf merged
clipx
bin t

vport 0.15 0.9 0.3475 0.650
window 4380 4480 0.85 1.1
rdsdf 1
clipx
bin t
rdsdf 3
clipx
bin t

vport 0.15 0.9 0.2225 0.525
window 4380 4480 0.85 1.1
rdsdf 2
clipx
bin t
rdsdf 4
clipx
bin t

end
quit

EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps hd218195_dib.eps
endif

echo Compressing files....
gzip -9 *.sdf
