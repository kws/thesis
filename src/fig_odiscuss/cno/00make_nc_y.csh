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
  set op = `cat mes/$star.mes | grep 'N/C' | awk -f 0log_ratio.awk`
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

  set sch = `echo "$fit_y * 10" | bc`

#  echo sch $sch >> $file
  if ($?fill) then
    echo sci $fill >> $file
    echo dot $fit_y $n_c 1 $type >> $file
    echo sci 1 >> $file
  endif

  echo $fit_y $n_c $n_c_err >> 0$sch.$type.pt

  echo $fit_y $n_c >> prob1.asc

end

$prog/lincor < prob1.asc >! lincor.out
set op = `cat lincor.out |grep Spear`
set rs1 = `printf "%5.1f" $op[2]`
set ps1 = `printf "%3.2f" $op[3]`
set op = `cat lincor.out |grep Ken`
set t1 = `printf "%5.4f" $op[2]`
set pt1 = `printf "%3.2f" $op[4]`

cat <<EOF >! junk.pgp
begin $pgdev 1 1
paper 1200 900
vport 0.1 0.9 0.15 0.95
scf 2

page
window 0.08 .22  0 2
sch 1
box bcnst 0 0 bcnst 0 0
sch 1.25
mtext B 3.0 0.5 0.5 "Helium number fraction, \fiy"
mtext L 3.0 0.5 0.5 "log\d10\u (N II 4630 / C II 4267)"
sch 0.75
mtext T -2.0 0.05 0.0 "\fir\fr\ds\u = $rs1 (\fip\fr = $ps1)"
mtext T -3.0 0.05 0.0 "\gt = $t1 (\fip\fr = $pt1)"
sch 1.0

input $file
EOF

foreach f (*.pt)
  set file = $f:r
  set type = $file:e
  set sch  = $file:r

  cat <<EOF >> junk.pgp

sch 1.0
data $f
xcolum 1
ycolum 2
kpoint 2 $type
dycolm 3
kerry 1 $type 1

EOF

end

cat <<EOF >> junk.pgp

end
quit
EOF

cat junk.pgp | pgpixf3

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps nc_y.eps
endif

rm *.cmd *.asc junk* *.pt lincor*


















