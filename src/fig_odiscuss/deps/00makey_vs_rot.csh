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

make -C $prog lincor

rm loggplot*.cmd >& /dev/null

foreach f ($files)
  set type = 20
  set ocn = o
  echo Reading config $f
  source $f
  echo $sptype | grep "ON" >& /dev/null
  if (!($status)) set ocn = n
  echo $sptype | grep "OC" >& /dev/null
  if (!($status)) set ocn = c
#  set sptype = `echo $sptype | tr 'A-Z' ' '`
  set lumcl  = `echo $lumcl  | tr 'a-z' ' '`
  if ($#lumcl != 1) set lumcl=$lumcl[1]
#  set spect = `echo $sptype | sed -f spec2int.sed`
  set y = `echo "$fit_y * 10" | bc`

  if ($rot_vel < 0) @ rot_vel = 0 - $rot_vel

  if ("$lumcl" == "V") set type = 4
  if ("$ocn" == "n") then
    set fill = 5
  else if ("$ocn" == "c") then
    set fill = 1
  else 
    unset fill
  endif

  set file = loggplot.cmd
  touch $file prob1.cmd
  
  if ($?fill) then
    echo sci $fill >> $file
    echo dot $rot_vel $fit_y 1 $type >> $file
    echo sci 1 >> $file
  endif
  echo dot $rot_vel $fit_y 2 $type >> $file
  echo $rot_vel $fit_y >> prob1.cmd
end

$prog/lincor < prob1.cmd >! lincor.out
set op = `cat lincor.out |grep Spear`
echo $op
set rs1 = `printf "%5.1f" $op[2]`
set ps1 = `printf "%3.2f" $op[3]`
echo $rs1 $ps1
set op = `cat lincor.out |grep Ken`
echo $op
set t1 = `printf "%5.4f" $op[2]`
set pt1 = `printf "%3.2f" $op[4]`
echo $t1 $pt1

cat <<EOF |pgpixf3
begin $pgdev
paper 1200 900
vport 0.1 0.9 0.15 0.95
scf 2

window 0 220 0.08 0.25
sch 1.25
box bcnst 0 0 bcnst 0 0
mtext L 3.0 0.5 0.5 "Helium number fraction, \fiy"
mtext B 3.0 0.5 0.5 "Line Broadening Velocity"
sch 0.75
mtext T -2.0 0.05 0.0 "\fir\fr\ds\u = $rs1 (\fip\fr = $ps1)"
mtext T -3.0 0.05 0.0 "\gt = $t1 (\fip\fr = $pt1)"
sch 1.0

input loggplot.cmd

end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps vsini.eps
endif

rm *.cmd lincor*



