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
make -C $prog interp star2 lincor eddington

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
  set cat = `echo $cat | tr 'A-Z' ' '`
  set star = `echo $star | tr 'A-z' ' '`
  echo $star $temp $fit_g $Mv > junk.$$
  if ($lumcl == 1) then
    set mode = 1
  else
    set mode = 2
  endif
  set op = `$prog/star2 $mode junk.$$ |grep $star`
  # Get evolutionary masses
  $prog/interp $prog/evol_mods $temp $op[5] >! junk.$$
  set m_0 = `grep 'M_0' junk.$$`
  set m_e = `grep 'M_e' junk.$$`
  set dm = `echo "scale=2;$m_e[3] - $op[7]" | bc`

# Distance from eddington limit
  set edd = `$prog/eddington $fit_t`
  set dg = `echo "scale=3;$fit_g - $edd" | bc`

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

  echo sch $sch >> $file
  echo sch $sch >> b_$file

  if ($?fill) then
    echo sci $fill >> $file
    echo dot $fit_g $dm 1 $type >> $file
    echo sci 1 >> $file
    echo sci $fill >> b_$file
    echo dot $dg $dm 1 $type >> b_$file
    echo sci 1 >> b_$file
  endif

  echo dot $fit_g $dm 2 $type >> $file
  echo sch 1 >> $file
  echo dot $dg $dm 2 $type >> b_$file
  echo sch 1 >> b_$file

  echo $fit_g $dm >> prob1.asc
  echo $dg $dm >> prob2.asc
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
window 2.7 4.5 -15 30
sch 1.25
box bcnst 0 0 bcnst 0 0
mtext B 3.0 0.5 0.5 "log\d10\u \fig"
mtext L 3.0 0.5 0.5 "\fiM\fr\de\u - \fiM\fr\ds\u (\fiM\fr\d\(2281)\u)"
sch 0.75
mtext T -2.0 0.05 0.0 "\fir\fr\ds\u = $rs1 (\fip\fr = $ps1)"
mtext T -3.0 0.05 0.0 "\gt = $t1 (\fip\fr = $pt1)"
sch 1.0

input $file

sls 4
move 2.7 0
draw 4.5 0
sls 1

page
window 0 1.5 -15 30
sch 1.25
box bcnst 0 0 bcnst 0 0
mtext B 3.0 0.5 0.5 "log\d10\u \fig\fr - log\d10\u \fig\fr\dedd"
mtext L 3.0 0.5 0.5 "\fiM\fr\de\u - \fiM\fr\ds\u (\fiM\fr\d\(2281)\u)"
sch 0.75
mtext T -2.0 0.05 0.0 "\fir\fr\ds\u = $rs2 (\fip\fr = $ps2)"
mtext T -3.0 0.05 0.0 "\gt = $t2 (\fip\fr = $pt2)"
sch 1.0

input b_$file

sls 4
move 0 0
draw 1.5 0
sls 1


%%%%%%% KEY %%%%%%%%%%%%%
window 0 6 25000 45000
move 1.3 25000
draw 1.3 31000
draw 0.0 31000

sch 0.9
dot 0.35 30200 2 20
dot 0.15 30200 2 4
sch 1.0
ptext 0.0 "\fiy\fr = 0.09" 0.5 30000 0.0

sch 1.2
dot 0.35 28200 2 20
dot 0.15 28200 2 4
sch 1.0
ptext 0.0 "\fiy\fr = 0.12" 0.5 28000 0.0

sch 1.5
dot 0.35 26200 2 20
dot 0.15 26200 2 4
sch 1.0
ptext 0.0 "\fiy\fr = 0.15" 0.5 26000 0.0

end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps dm_g.eps
endif

rm *.cmd *.asc junk.$$

















