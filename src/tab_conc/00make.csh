#!/bin/csh -f

set cfdir = ../wht_config
set prog = ../programs

echo -n '' >! tmp.summ

foreach f ($cfdir/hd* $cfdir/BD*)
  source $f
  echo "Working on $star"

  set s = `echo $sptype |tr -d 'A-z'`
  set l = `echo "$lumcl" | tr 'a-z' ' '`
  set l = `echo $l[1] | sed -f $prog/lumcl2int.sed`

  printf "%10s %3.1f %1d %6d %3.1f\n" $star $s $l $fit_t $fit_g >> tmp.summ

end

awk -f 00make.awk tmp.summ >! summ.tex

rm tmp.summ
