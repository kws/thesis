#!/bin/csh -f

set dev = epsf_p

source /user/kcs/pgpixf3/pgpixf3_setup

rm gks74.ps* >& /dev/null
gunzip *.gz

cat <<EOF
Warning!
  This script does not automatically update the model fits. If you change
  the parameters you have to re-create the model fits!

EOF

source ../../wht_config/hd207198
echo ""
echo "v=$fit_v y=$fit_y Teff=$fit_t log g=$fit_g rot=$rot (current)"
foreach f (*mod.sdf)
  set f1 = $f:r
  set p = `hdstrace $f1 | grep TITLE | cut -d\' -f2`
  echo "$p ($f)"
end

pgpixf3 <<EOF
begin $dev
paper 1450 1260
paper 1200 260
vport 0.05 0.95 0.1 0.9
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"

%##################1#################
vport 0.05 0.275 0.1 0.9
window 4195 4205 0.6 1.05
box bcnst 0 0 bcnst 0 0

sch 1.25
mtext "LV" -2 .10 0.0 "HeII \gl4200\A "
sch 1.0

rdsdf he2_4200modnorm
bin t

sls 2
rdsdf he2_4200modnorm_mod
bin t
sls 1

%###################2##################
vport 0.275 0.5 0.1 0.9
window 4536 4546 0.6 1.05
box bcmst 0 0 bcst 0 0

sch 1.25
mtext "LV" -2 .10 0.0 "HeII \gl4541\A "
sch 1.0

rdsdf he2_4541modnorm
bin t

sls 2
rdsdf he2_4541modnorm_mod
bin t
sls 1

%####################3##################
vport 0.5 0.725 0.1 0.9
window 4680 4690 0.6 1.05
box bcnst 0 0 bcst 0 0

sch 1.25
mtext "LV" -2 .10 0.0 "HeII \gl4686\A "
sch 1.0

rdsdf he2_4685modnorm
bin t

sls 2
rdsdf he2_4685modnorm_mod
bin t
sls 1

%##################4###################
vport 0.725 0.95 0.1 0.9
window 5406 5416 0.6 1.05
box bcmst 0 0 bcst 0 0

sch 1.25
mtext "LV" -2 .10 0.0 "HeII \gl5411\A "
sch 1.0

rdsdf he2_5411modnorm
bin t

sls 2
rdsdf he2_5411modnorm_mod
bin t
sls 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps hd207198.eps
endif

gzip -9 *.sdf
