#!/bin/csh -f

######### CHANGE THIS FOR DIFFERENT DEVICE###
set pgdev = epsf_p
#############################################

rm gks* >& /dev/null

source /user/kcs/pgpixf3/pgpixf3_setup

set conf = ../../wht_config
set prog = ../../programs

#Create input file
set files = `ls $conf/hd* $conf/BD*`
make -C $prog interp star2 lincor

#Remove HD12323 because it falls below MS
#set files  = `echo $files | sed -e "s|$conf/hd012323||g"`

foreach f ($files)
  set ocn = o
  echo Reading config $f
  source $f
  echo $sptype | grep "ON" >& /dev/null
  if (!($status)) then 
    set ocn = n
  endif
  echo $sptype | grep "OC" >& /dev/null
  if (!($status)) then
    set ocn = c
  endif
  set sptype = `echo $sptype | tr 'A-Z' ' '`
  set lumcl  = `echo $lumcl  | tr 'a-z' ' '`
  if ($#lumcl != 1) set lumcl=$lumcl[1]
  set lumcl = `echo $lumcl | sed -f ../../programs/lumcl2int.sed`
#  set spect = `echo $sptype | sed -f ../../programs/spec2int.sed`
#  set y = `echo "scale = 10;(($fit_t - 30000) / 10000) +1" | bc`


  set temp = `echo "scale=2;$fit_t / 1000" | bc`
#  set cat = `echo $cat | tr 'A-Z' ' '`
#  set star = `echo $star | tr 'A-z' ' '`
#  echo $star $temp $fit_g $Mv > junk.$$
#  if ($lumcl == 1) then
#    set mode = 1
#  else
#    set mode = 2
#  endif
#  set op = `$prog/star2 $mode junk.$$ |grep $star`
#  # Get evolutionary masses
#  $prog/interp $prog/evol_mods $temp $op[5] >! junk.$$
#  set m_0 = `grep 'M_0' junk.$$`
#  set m_e = `grep 'M_e' junk.$$`
#  set dm = `echo "scale=2;$m_e[3] - $op[7]" | bc`
#  set age = `grep -i 'age' junk.$$`

# Get n/c ratio
  set op = `cat mes/$star.mes | grep 'N/C'`
  echo $op
  set n_c = $op[2]
  set n_c_err = $op[4]

  set type = 20
  if ($lumcl > 3) set type = 4
  
  set file = massd.cmd
  touch $file  prob1.asc
  if ("$ocn" == "c") then
    set fill = 1
  else if ("$ocn" == "n") then
    set fill = 5
  else
    unset fill
  endif


  set int = `printf "%i" $n_c`
  if ($int < 3) then
    set sch = 0.8
  else if ($int < 6 ) then
    set sch = 1.1
  else if ($int < 11) then
    set sch = 1.4
  else if ($int < 16) then
    set sch = 1.8
  else 
    set sch = 2.2
  endif

  echo sch $sch >> $file
  if ($?fill) then
    echo sci $fill >> $file
    echo dot $fit_t $fit_g 1 $type >> $file
    echo sci 1 >> $file
  endif

  echo $fit_t $fit_g $n_c_err >> 0$sch.$type.pt

  echo $fit_t $fit_g >> prob1.asc

end

cat prob1.asc
# Get correlation coeff
#set op = `cat prob1.asc | $prog/lincor`
#set r1 = `printf "%3.2f" $op[2]`
#set prob1 = `printf "%3.2f" $op[3]`

cat <<EOF >! junk.pgp
begin $pgdev 1 1
paper 1200 900
vport 0.1 0.9 0.15 0.95
scf 2

page
sch 1.0
window 40 30 4.5 2.7
box bcnst 0 0 bcnst 0 0
window 40000 30000 4.5 2.7
sch 1.25
mtext B 3.0 0.5 0.5 "\fiT\fr\deff\u (kK)"
mtext L 3.0 0.5 0.5 "log\d10\u \fig"
sch 0.75
sch 1.0

input $file
EOF

foreach f (*.pt)
  set file = $f:r
  set type = $file:e
  set sch  = $file:r

  cat <<EOF >> junk.pgp

sch $sch
data $f
xcolum 1
ycolum 2
kpoint 2 $type
%dycolm 3
%kerry 1 $type 1

EOF

end

cat <<EOF >> junk.pgp

window 0 10 0 10
move 7.4 0
draw 7.4 3.1
draw 10 3.1

sch 1.0
ptext 0.5 "N/C ratio" 8.7 2.7 0.0
sch 0.8
dot 7.7 2.3 2 4
dot 8.3 2.3 2 20
sch 1.0
ptext 0.5 "0   2" 9.2 2.25 0.0
ptext 0.5 "-" 9.2 2.25 0.0

sch 1.1
dot 7.7 1.8 2 4
dot 8.3 1.8 2 20
sch 1.0
ptext 0.5 "3   5" 9.2 1.75 0.0
ptext 0.5 "-" 9.2 1.75 0.0

sch 1.4
dot 7.7 1.3 2 4
dot 8.3 1.3 2 20
sch 1.0
ptext 0.5 " 6   10" 9.2 1.25 0.0
ptext 0.5 "-" 9.2 1.25 0.0


sch 1.8
dot 7.7 0.8 2 4
dot 8.3 0.8 2 20
sch 1.0
ptext 0.5 "11   15" 9.2 0.75 0.0
ptext 0.5 "-" 9.2 0.75 0.0

sch 2.2
dot 7.7 0.3 2 4
dot 8.3 0.3 2 20
sch 1.0
ptext 0.5 "16+" 9.2 0.25 0.0

end
quit
EOF

cat junk.pgp | pgpixf3

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps nc_behaviour.eps
endif

rm *.cmd *.asc junk* *.pt


















