#!/bin/csh -f

source /user/kcs/pgpixf3/pgpixf3_setup
set tf = tmp.cmd

rm gks74.ps* >& /dev/null

set tmin = 25
set tmax = 40
set gmin = 2.5
set gmax = 4.7

set lines = (4009 4026 4143 4388 4471 4713 4922 5047)
#set lines = (4922)
set vs = (00)

cat << EOF >! $tf
begin epsf_p 2 4
paper 1200 1800
vport 0.1 0.95 0.1 0.95
window $tmax $tmin $gmax $gmin
scf 2
EOF
foreach l ($lines)
  foreach v ($vs)
    echo "page" >> $tf
    echo "sch 1.0" >> $tf
    echo "box bcnst 0 0 bcnst 0 0 " >> $tf
    echo "sch 1.25" >> $tf
    echo 'mtext B 2.0 0.5 0.5 "\\fiT\\fr\\deff\\u (kK)"' >> $tf
    echo 'mtext L 2.0 0.5 0.5 "log\\d10\\u \\fig\\fr"' >> $tf
    echo "sch 1.0" >> $tf
    echo 'mtext T -1.5 0.01 0.0 "HeI \\gl'${l}'\\A"' >>$tf
    echo "rd2sdf ${l}_v$v" >> $tf
    echo "cont 20 20 100" >> $tf
    echo "slw 3" >> $tf
    set c = 100
    while ($c <= 2000)
      echo "cont $c 1 1" >> $tf
      @ c = $c + 100
    end
    echo "slw 1,sch 0.75" >> $tf
    awk -v xpos=26.8 -f 0labels.awk ${l}_v${v}_lab >> $tf
    echo "sch 1.0" >> $tf
  end
end
echo "end" >> $tf
echo "quit" >> $tf

pgpixf3 < $tf

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps he1_cont.eps
endif








