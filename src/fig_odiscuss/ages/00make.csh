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
set files  = `echo $files | sed -e "s|$conf/hd012323||g"`

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
#  set spect = `echo $sptype | sed -f spec2int.sed`
#  set y = `echo "scale = 10;(($fit_t - 30000) / 10000) +1" | bc`


  # Get ages
  set temp = `echo "scale=2;$fit_t / 1000" | bc`
  set cat = `echo $cat | tr 'A-Z' ' '`
  set star = `echo $star | tr 'A-z' ' '`
  echo $star $temp $fit_g $Mv > junk.$$
  if ($lumcl == 1) then
    set mode = 1
  else
    set mode = 2
  endif
  set op = `$prog/star2 $mode junk.$$ |grep $star`
  rm junk.$$
  set L = $op[5]
  set op = `$prog/interp $prog/evol_mods $temp $L | grep -i age`
  set age = $op[3]
  set agefrac = $op[5]

  set type = 20
  if ($lumcl > 3) set type = 4
  
  set file_a = ages.cmd
  set file_f = frac.cmd
  touch $file_a $file_f prob1.asc prob2.asc
  if ("$ocn" == "c") then
    set fill = 1
  else if ("$ocn" == "n") then
    set fill = 5
  else
    unset fill
  endif
  if ($?fill) then
    echo sci $fill >> $file_a
    echo sci $fill >> $file_f
    echo dot $age $fit_y 1 $type >> $file_a
    echo dot $agefrac $fit_y 1 $type >> $file_f
    echo sci 1 >> $file_a
    echo sci 1 >> $file_f
  endif

  echo dot $age $fit_y 2 $type >> $file_a
  echo dot $agefrac $fit_y 2 $type >> $file_f

  echo $age $fit_y >> prob1.asc
  echo $agefrac $fit_y >> prob2.asc
end

# Get correlation coeff
$prog/lincor < prob1.asc >! lincor.out
set op = `cat lincor.out |grep Spear`
set rs1 = `printf "%5.1f" $op[2]`
set ps1 = `printf "%3.2f" $op[3]`
set op = `cat lincor.out |grep Ken`
set t1 = `printf "%5.4f" $op[2]`
set pt1 = `printf "%3.2f" $op[4]`

$prog/lincor < prob2.asc >! lincor.out
set op = `cat lincor.out |grep Spear`
set rs2 = `printf "%5.1f" $op[2]`
set ps2 = `printf "%3.2f" $op[3]`
set op = `cat lincor.out |grep Ken`
set t2 = `printf "%5.4f" $op[2]`
set pt2 = `printf "%3.2f" $op[4]`

cat <<EOF |pgpixf3
begin $pgdev 1 2
paper 1200 1800
vport 0.1 0.9 0.15 0.95
scf 2

page
window 0 6.E6 0.08 0.21
sch 1.25
box bcnst 0 0 bcnst 0 0
mtext B 3.0 0.5 0.5 "Age (yr)"
mtext L 3.0 0.5 0.5 "Helium number fraction, \fiy"
sch 0.75
mtext T -2.0 0.05 0.0 "\fir\fr\ds\u = $rs1 (\fip\fr = $ps1)"
mtext T -3.0 0.05 0.0 "\gt = $t1 (\fip\fr = $pt1)"
sch 1.0

input $file_a

page
window 0 1 0.08 0.21
sch 1.25
box bcnst 0 0 bcnst 0 0
mtext B 3.0 0.5 0.5 "Age / H-burning lifetime"
mtext L 3.0 0.5 0.5 "Helium number fraction, \fiy"
sch 0.75
mtext T -2.0 0.05 0.0 "\fir\fr\ds\u = $rs2 (\fip\fr = $ps2)"
mtext T -3.0 0.05 0.0 "\gt = $t2 (\fip\fr = $pt2)"
sch 1.0

input $file_f

end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps age.eps
endif

rm *.cmd *.asc

















