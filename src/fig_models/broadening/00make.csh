#!/bin/csh -f

set dev = epsf_p

source /user/kws/tgkiel/tgkiel3_setup
source /user/kcs/pgpixf3/pgpixf3_setup

set tf = tmp.cmd

set steps = (25 75 125 175)

rm gks74.ps* >& /dev/null

cat <<EOF >! $tf
epslon 0.4
loadf
rdsdf he1_4143modnorm
mapgr
EOF


foreach v ($steps)
cat <<EOF >> $tf
inter 35.0 3.5
conmod $v
wrmod mod_rot_$v
inter 35.0 3.5
conmod -$v
wrmod mod_mac_$v
EOF
end

echo "quit" >> $tf

tgset old v00 y09 33.0 37.0 3.3 3.7 1.0 0.1
tgkiel < $tf

here:

cat <<EOF >! $tf
begin $dev  2 2
paper 1200 1200
vport 0.1 0.9 0.1 0.9
scf 2
EOF

foreach v ($steps)
cat <<EOF >> $tf
page
sch 1.0
window 4138.5 4148.5 0.74 1.02
box bcnst 0 0 bcnst 0 0
sch 1.25
mtext B 2.0 0.5 0.5 "Wavelength (\A)"
mtext L 2.0 0.5 0.5 "Intensity"
mtext B -1.5 0.05 0.0 "\fiv\fr = $v km s\u-1"
sch 1.0

rdsdf mod_rot_$v
clipx
conect

sls 2
rdsdf mod_mac_$v
clipx
conect
sls 1

EOF
end

cat <<EOF >> $tf
end
quit
EOF

pgpixf3 < $tf

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps comparison.eps
endif

rm mod*.sdf
rm $tf

