#!/bin/csh -f

set dev = epsf_p

set swp = $1
set ymax = $2
set xscr = $3
@ yscr = 4 / $xscr
@ tmp = $xscr * $yscr

if ($tmp < 4) then
  @ yscr++
endif

source ../00bsconfig
source $pgpsetup
source /star/bin/dipso/dipsosetup

set tplts = (tausco iother picet alplyr)
set gtplt = ("\gt Sco" "\gi Her" "\gp Cet" "\ga Lyr")

rm gks*.ps >& /dev/null

foreach t ($tplts)
  dipso <<EOF
restore ${fitd}/${t}/${swp}_${t}
pop 3, sp0wr ${t}_ccf
pop 4, sp0wr ${t}_fit
quit
EOF

end

@ scale = 1400 / $xscr
@ yscale = $scale * $yscr

cat <<EOF >! tmp.cmd
begin $dev $xscr $yscr
paper 1400 $yscale
vport 0.1 0.9 0.1 0.9
scf 2

EOF

set c = 1
foreach t ($tplts)
  cat <<EOF >> tmp.cmd
page
sch 1.25
window -1000 1000 -0.1 $ymax
box bcnst 0 0 bcnst 0 0
mtext L 2.5 0.5 0.5 "CCF"
mtext B 2.5 0.5 0.5 "Velocity (km s\u-1\d)"
sch 1.5
mtext T 0.5 0.5 0.5 "$gtplt[$c]"
sch 1.0

rdsdf ${t}_ccf
bin t
sls 2
rdsdf ${t}_fit
conect
sls 1

EOF

  @ c++

end

cat <<EOF >> tmp.cmd
end
quit
EOF

pgpixf3 < tmp.cmd

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps $swp.eps
endif

rm *.sdf *.cmd





