#!/bin/csh -f

set conf = ../../wht_config
set prog = ../../programs

#Create input file
set files = `ls $conf/hd* $conf/BD*`

set ot = cn_ew.tex
echo -n "% Automatically generate tex table " >! $ot
date >> $ot
echo "% Created by $0 ($cwd)" >> $ot
foreach f ($files)
  echo Reading config $f
  source $f  

  echo "Reading ew's for $cat"
  set c = `grep -v N mes/$star.mes`
  set n = `grep N mes/$star.mes`
  set r = `grep N/C mes/$star.mes`

  printf '%11s & $%5.1f \\pm%5.1f$ & $%5.1f\\pm%5.1f$ & $%5.1f \\pm%5.1f$ \\\\\n' \
         "$cat" $n[2] $n[4] $c[2] $c[4] $r[2] $r[4] >> $ot
end




