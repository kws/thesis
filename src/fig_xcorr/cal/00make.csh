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
begin $dev 2 2
paper 1400 1400
vport 0.1 0.9 0.1 0.9
scf 2
page

window 0 500 0 500
box bcnst 0 0 bcnst 0 0
mtext L 2.5 0.5 0.5 "FWHM  (km s\u-1\d)"
mtext B 2.5 0.5 0.5 "\fiv\fr\de\u sin\fii\fr (km s\u-1\d)"


rdalas tausco.func
conect
sls 2
rdalas iother.func
conect
sls 3
rdalas picet.func
conect
sls 4
rdalas alplyr.func
conect
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

window 0 500 0 500
box bcnst 0 0 bcnst 0 0
input 1-2.cmd
input 1-2_fit.cmd
sls 2,move 0 0,draw 500 500,sls 1
mtext L 2.5 0.5 0.5 "\gt Sco \fiv\fr\de\u sin\fii\fr (km s\u-1\d)"
mtext B 2.5 0.5 0.5 "\gi Her \fiv\fr\de\u sin\fii\fr (km s\u-1\d)"

page

window 0 500 0 500
box bcnst 0 0 bcnst 0 0
input 2-3.cmd
input 2-3_fit.cmd
sls 2,move 0 0,draw 500 500,sls 1
mtext L 2.5 0.5 0.5 "\gi Her \fiv\fr\de\u sin\fii\fr (km s\u-1\d)"
mtext B 2.5 0.5 0.5 "\gp Cet \fiv\fr\de\u sin\fii\fr (km s\u-1\d)"

page

window 0 500 0 500
box bcnst 0 0 bcnst 0 0
input 3-4.cmd
input 3-4_fit.cmd
sls 2,move 0 0,draw 500 500,sls 1
mtext L 2.5 0.5 0.5 "\gp Cet \fiv\fr\de\u sin\fii\fr (km s\u-1\d)"
mtext B 2.5 0.5 0.5 "\ga Lyr \fiv\fr\de\u sin\fii\fr (km s\u-1\d)"

end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps cal.eps
endif


