#!/bin/csh -f

set dev = epsf_p

source ../00bsconfig
source $pgpsetup

set vsinid = $bsdir/vsini

rm gks*.ps >& /dev/null

awk -f 0make.awk 1-2w.dat >! 1-2.cmd
awk -f 0make.awk 2-3w.dat >! 2-3.cmd
awk -f 0make.awk 3-4w.dat >! 3-4.cmd


pgpixf3 <<EOF
begin $dev 1 2
paper 700 1400
vport 0.1 0.9 0.1 0.9
scf 2
page

window 0 500 0 500
box bcnst 0 0 bcnst 0 0
mtext L 2.5 0.5 0.5 "\fiv\fr\dcor\u (km s\u-1\d)"
mtext B 2.5 0.5 0.5 "\fiv\fr (km s\u-1\d)"

data tausco.corr,xcol 1,ycol 2,conect
sls 2
data iother.corr,xcol 1,ycol 2,conect
sls 3
data picet.corr,xcol 1,ycol 2,conect
sls 4
data alplyr.corr,xcol 1,ycol 2,conect
sls 1

window 0 470 20 500

ptext 0.0 "\gt Sco" 410 100 0.0
ptext 0.0 "\gi Her" 410 80 0.0
ptext 0.0 "\gp Cet" 410 60 0.0
ptext 0.0 "\ga Lyr" 410 40 0.0

sls 1,move 375 102,draw 400 102
sls 2,move 375  82,draw 400  82
sls 3,move 375  62,draw 400  62
sls 4,move 375  42,draw 400  42
sls 1

page


window 0 500 0.5 1.5
box bcnst 0 0 bcnst 0 0
mtext L 2.5 0.5 0.5 "\fiv\fr\dcor\u/\fiv\fr"
mtext B 2.5 0.5 0.5 "\fiv\fr (km s\u-1\d)"

data tausco.corr,xcol 1,ycol 3,conect
sls 2
data iother.corr,xcol 1,ycol 3,conect
sls 3
data picet.corr,xcol 1,ycol 3,conect
sls 4
data alplyr.corr,xcol 1,ycol 3,conect
sls 1

end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps cor_funcs.eps
endif


