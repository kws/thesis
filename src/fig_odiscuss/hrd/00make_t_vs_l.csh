#!/bin/csh -f

######### CHANGE THIS FOR DIFFERENT DEVICE###
set pgdev = epsf_p
#############################################

rm gks* >& /dev/null

source /user/kcs/pgpixf3/pgpixf3_setup

set conf = ../../wht_config

#Create input file
set files = `ls $conf/hd* $conf/BD*`
make -C ../../programs interp star2

#Create evolutionary tracks
rm *.asc >& /dev/null
#./read
../../programs/interp ../../programs/evol_mods 35.0 5.5

# Get positions of mass labels...
set m20 = `head -1 20msol.asc | awk -v HS=.005 '{print $1-.03,$2-.015}'`
set m25 = `head -1 25msol.asc | awk -v HS=.005 '{print $1+HS,$2}'`
set m40 = `head -1 40msol.asc | awk -v HS=.005 '{print $1+HS,$2}'`
set m60 = `head -1 60msol.asc | awk -v HS=.005 '{print $1+HS,$2}'`
set m85 = `head -1 85msol.asc | awk -v HS=.005 '{print $1-HS,$2+.04}'`


foreach f ($files)
  set type = 20
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
#  set sptype = `echo $sptype | tr 'A-Z' ' '`
#  set lumcl  = `echo $lumcl  | tr 'a-z' ' '`
#  if ($#lumcl != 1) set lumcl=$lumcl[1]
#  set spect = `echo $sptype | sed -f spec2int.sed`
#  set y = `echo "scale = 10;(($fit_t - 30000) / 10000) +1" | bc`
  set y = `echo "$fit_y * 10" | bc`


# Get luminosity 
  set temp = `echo "scale=2;$fit_t / 1000" | bc`
  set cat = `echo $cat | tr 'A-Z' ' '`
  set star = `echo $star | tr 'A-z' ' '`
  echo $star $temp $fit_g $Mv > junk.$$
  set lc  = `echo $lumcl  | tr 'a-z' ' '`
  if ($#lc != 1) set lc = $lc[1]
  if ("$lc" == "I") then
    set mode = 1
  else
    set mode = 2
  endif
  set op = `../../programs/star2 $mode junk.$$ |grep $star`
  rm junk.$$
  set L = $op[5]

# Plot MS stars as squares
  if ("$lc" == "V") set type = 4

  set file = hrd.cmd
  touch $file
  echo "sch $y" >> $file

    if ("$ocn" == "c") then
    set fill = 1
  else if ("$ocn" == "n") then
    set fill = 5
  else
    unset fill
  endif
  if ($?fill) then
    echo sci $fill >> $file
    echo dot $op[8] $L 1 $type >> $file
    echo sci 1 >> $file
  endif

  echo "dot $op[8] $L 2 $type" >> $file
end

cat <<EOF |pgpixf3
begin $pgdev
paper 1200 900
vport 0.1 0.9 0.15 0.95
scf 2

window 4.73 4.33 4.5 6.3
sch 1.25
box bcnst 0 0 bcnst 0 0
mtext B 3.0 0.5 0.5 "log (\fiT\fr\deff\u)"
mtext L 3.0 0.5 0.5 "log (\fiL\fr/\fiL\fr\d\(2281)\u)"
sch 0.8

ptext 1.0 "20 \fiM\d\(2281)\u" $m20 0.0
ptext 1.0 "25 \fiM\d\(2281)\u" $m25 0.0
ptext 1.0 "40 \fiM\d\(2281)\u" $m40 0.0
ptext 1.0 "60 \fiM\d\(2281)\u" $m60 0.0
ptext 1.0 "85 \fiM\d\(2281)\u" $m85 0.0
sch 1.0

input hrd.cmd

rdalas zams.asc
conect
sls 2
rdalas tams.asc
conect
sls 1

rdalas 85msol.asc
conect
rdalas 60msol.asc
conect
rdalas 40msol.asc
conect
rdalas 25msol.asc
conect
rdalas 20msol.asc
conect

%%%%%%% TYP. ERRORS %%%%%%%%
move 4.7 5.1
draw 4.69 5.25
draw 4.7 5.4
draw 4.71 5.25
draw 4.7 5.1
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
  mv gks74.ps hrd.eps
endif

rm *.cmd
rm *.asc


