#!/bin/csh -f

set dev = epsf_p

#set swp = hd004180_swp20436
set swp = hd000144_swp15936

source ../00bsconfig
source $pgpsetup
source /star/bin/dipso/dipsosetup

set t = picet
set gtplt = "\gp Cet"

rm gks*.ps >& /dev/null


dipso <<EOF
restore ${fitd}/${t}/${swp}_${t}
pop 1, sp0wr ${t}_ccfu
pop 2, sp0wr ${t}_fitu
pop 3, sp0wr ${t}_ccf
pop 4, sp0wr ${t}_fit
quit
EOF

pgpixf3 <<EOF
begin $dev 2 1
paper 1400 700
vport 0.1 0.9 0.1 0.9
scf 2

page
sch 1.25
window -2000 2000 -0.1 0.6
box bcnst 0 0 bcnst 0 0
mtext L 2.5 0.5 0.5 "CCF"
mtext B 2.5 0.5 0.5 "Velocity (km s\u-1\d)"
sch 1.1
mtext T -1.5 0.95 1.0 "$gtplt"
mtext T -1.5 0.05 0.0 "HD 144"
mtext T -2.5 0.05 0.0 "SWP 15936"
sch 1.0

rdsdf ${t}_ccfu
bin t
sls 2
rdsdf ${t}_fitu
conect
sls 1

page
sch 1.25
window -2000 2000 -0.1 0.6
box bcnst 0 0 bcnst 0 0
mtext L 2.5 0.5 0.5 "CCF"
mtext B 2.5 0.5 0.5 "Velocity (km s\u-1\d)"
sch 1.1
mtext T -1.5 0.95 1.0 "$gtplt"
mtext T -1.5 0.05 0.0 "HD 144"
mtext T -2.5 0.05 0.0 "SWP 15936"
sch 1.0sch 1.0

rdsdf ${t}_ccf
bin t
sls 2
rdsdf ${t}_fit
conect
sls 1

end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps example.eps
endif

rm *.sdf *.cmd





