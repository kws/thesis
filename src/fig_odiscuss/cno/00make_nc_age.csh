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
  set st = `echo $star | tr 'A-z' ' '`
  echo $st $temp $fit_g $Mv > junk.$$
  if ($lumcl == 1) then
    set mode = 1
  else
    set mode = 2
  endif
  set op = `$prog/star2 $mode junk.$$ |grep $st`
  rm junk.$$
  set L = $op[5]
  set op = `$prog/interp $prog/evol_mods $temp $L | grep -i age`
  set age = $op[3]
  set agefrac = $op[5]

  set type = 20
  if ($lumcl > 3) set type = 4
  
# Get n/c ratio
  set op = `cat mes/$star.mes | grep 'N/C' | awk -f 0log_ratio.awk`
  echo $op
  set n_c = $op[2]
  set n_c_err = $op[4]

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

  set sch = `echo "$fit_y * 10" | bc`

  echo sch $sch >> $file_a
  echo sch $sch >> $file_f
  if ($?fill) then
    echo sci $fill >> $file_a
    echo sci $fill >> $file_f
    echo dot $age $n_c 1 $type >> $file_a
    echo dot $agefrac $n_c 1 $type >> $file_f
    echo sci 1 >> $file_a
    echo sci 1 >> $file_f
  endif

  echo $age $n_c $n_c_err >> 0$sch.$type.pta
  echo $agefrac $n_c $n_c_err >> 0$sch.$type.ptb

  echo $age $n_c >> prob1.asc
  echo $agefrac $n_c >> prob2.asc
end

# Get correlation coeff
set op = `cat prob1.asc | $prog/lincor`
set r1 = `printf "%3.2f" $op[2]`
set prob1 = `printf "%3.2f" $op[3]`

set op = `cat prob2.asc | $prog/lincor`
set r2 = `printf "%3.2f" $op[2]`
set prob2 = `printf "%3.2f" $op[3]`

cat <<EOF >> junk.pgp
begin $pgdev 2 1
paper 1600 600
vport 0.1 0.9 0.15 0.95
scf 2

page
window 0 6.E6 0 2
sch 1
box bcnst 0 0 bcnst 0 0
sch 1.25
mtext B 3.0 0.5 0.5 "Age (yr)"
mtext L 3.0 0.5 0.5 "log\d10\u (N II 4630 / C II 4267)"
sch 0.75
%mtext T -2.0 0.05 0.0 "\fir\fr = $r1 ($prob1)"
sch 1.0

input $file_a

EOF

foreach f (*.pta)
  set file = $f:r
  set type = $file:e
  set sch  = $file:r

  cat <<EOF >> junk.pgp

sch $sch
data $f
xcolum 1
ycolum 2
kpoint 2 $type
dycolm 3
kerry 1 $type 1

EOF
end
  
cat <<EOF >> junk.pgp
page
window 0.0 1.0 0.0 2.0
sch 1.25
box bcnst 0 0 bcnst 0 0
mtext B 3.0 0.5 0.5 "Age / H-burning lifetime"
mtext L 3.0 0.5 0.5 "log\d10\u (N II 4630 / C II 4267)"
sch 0.75
%mtext T -2.0 0.05 0.0 "\fir\fr = $r2 ($prob2)"

sch 1.0

input $file_f

EOF

foreach f (*.ptb)
  set file = $f:r
  set type = $file:e
  set sch  = $file:r

  cat $f

  cat <<EOF >> junk.pgp

sch $sch
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
  mv gks74.ps nc_age.eps
endif

rm *.cmd *.asc *.pt* junk*

















