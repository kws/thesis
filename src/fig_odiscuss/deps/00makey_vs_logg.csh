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
  set lumcl = `echo $lumcl | sed -f $prog/lumcl2int.sed`
#  set spect = `echo $sptype | sed -f spec2int.sed`
#  set y = `echo "scale = 10;(($fit_t - 30000) / 10000) +1" | bc`

  set type = 20
  if ($lumcl > 3) set type = 4
  
  set file_g = logg.cmd
  set file_l = lumc.cmd
  set file_p = prob.cmd
  touch $file_g $file_l $file_p
  if ("$ocn" == "c") then
    set fill = 1
  else if ("$ocn" == "n") then
    set fill = 5
  else
    unset fill
  endif
  if ($?fill) then
    echo sci $fill >> $file_g
    echo dot $fit_g $fit_y 1 $type >> $file_g
    echo sci 1 >> $file_g
  endif
  echo dot $fit_g $fit_y 2 $type >> $file_g
  echo $fit_g $fit_y >> $file_p

  # This stuff is all to do with the luminosity class file
  set ptfile=${lumcl}_${fit_y}.pt
  if (-e $ptfile) then
    set inp = `cat $ptfile`
    set num = $inp[1];set cnum = $inp[2];set nnum = $inp[3]
  else
    set num = 0; set cnum = 0; set nnum = 0
  endif

  @ num++

  if ("$ocn" == "c") then
    @ cnum++
  else if ("$ocn" == "n") then
    @ nnum++
  endif

  echo $num $cnum $nnum>! $ptfile
end

# Get correlation coeffs
$prog/lincor < $file_p >! lincor.out
set op = `cat lincor.out |grep Spear`
set rs1 = `printf "%5.1f" $op[2]`
set ps1 = `printf "%3.2f" $op[3]`
set op = `cat lincor.out |grep Ken`
set t1 = `printf "%5.4f" $op[2]`
set pt1 = `printf "%3.2f" $op[4]`

rm $file_p

set sep = 0.15
foreach f (*.pt)
  set inp = `cat $f`
  set num = $inp[1]; set cnum = $inp[2]; set nnum = $inp[3]
  set l = `echo $f:r | cut -d_ -f1`
  set y = `echo $f:r | cut -d_ -f2`
  if ($l > 3) then
    set type = "4"
  else
    set type = "20"
  endif
  set c = 1
  set off = `echo "scale=3;($num/2) * $sep + $sep/2" | bc`
  while ($c <= $num)
    set p = `echo "scale=3; $l - $c * $sep + $off" | bc`
    
    if ($cnum >= 1) then
      set fill = 1
      @ cnum--
    else if ($nnum >= 1) then
      set fill = 5
      @ nnum--
    else 
      unset fill
    endif

    if ($?fill) then
      echo sci $fill >> $file_l
      echo dot $p $y 1 $type >> $file_l
      echo sci 1 >> $file_l
    endif
    echo dot $p $y 2 $type >> $file_l
    echo $l $y >> $file_p
    @ c ++
  end
end
rm *.pt

$prog/lincor < $file_p >! lincor.out
cat $file_p
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
window 2.8 4.5 0.08 0.21
sch 1.25
box bcnst 0 0 bcnst 0 0
mtext B 3.0 0.5 0.5 "log\d10\u \fig\fr"
mtext L 3.0 0.5 0.5 "Helium number fraction, \fiy"
sch 0.75
mtext T -2.0 0.05 0.0 "\fir\fr\ds\u = $rs1 (\fip\fr = $ps1)"
mtext T -3.0 0.05 0.0 "\gt = $t1 (\fip\fr = $pt1)"
sch 1.0

input $file_g

page
window 0 6 0.08 0.21
sch 1.25
box bct 0 0 bcnst 0 0
mtext B 3.0 0.5 0.5 "Luminosity Class"
mtext L 3.0 0.5 0.5 "Helium number fraction, \fiy"
%mtext T -2.0 0.05 0.5 "b)"
mtext B 1.0 0.16 0.5 "I"
mtext B 1.0 0.33 0.5 "II"
mtext B 1.0 0.5 0.5 "III"
mtext B 1.0 0.67 0.5 "IV"
mtext B 1.0 0.83 0.5 "V"

sch 0.75
mtext T -2.0 0.05 0.0 "\fir\fr\ds\u = $rs2 (\fip\fr = $ps2)"
mtext T -3.0 0.05 0.0 "\gt = $t2 (\fip\fr = $pt2)"

sch 1.0

input $file_l

end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps loggplot.eps
endif

rm *.cmd lincor*
















