#!/bin/csh -f

set progs = ../../programs

set t = $1
set g = $2
set mv = $3

cat <<EOF

`basename $0`: Running with

  Teff = $t
  logg = $g
  Mv   = $mv

EOF

make -C $progs star2 interp

echo "37128     $t $g $mv" >! junk
$progs/star2 1 junk  >! junk2
set op = `cat junk2|grep 37128`

$progs/interp $progs/evol_mods $t $op[5] >! junk3

set m_0 = `grep 'M_0' junk3`
set m_e = `grep 'M_e' junk3`
set dm = `echo "scale=2;$m_e[3] - $op[7]" | bc`

echo "Results:"
cat junk2
cat junk3

echo "Mass disc: $dm"

rm junk* *.asc *.cmd



