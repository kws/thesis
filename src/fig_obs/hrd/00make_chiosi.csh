#!/bin/csh -f

######### CHANGE THIS FOR DIFFERENT DEVICE###
set pgdev = epsf_p
#############################################

rm gks* >& /dev/null

source /user/kcs/pgpixf3/pgpixf3_setup

set here = /home/kws/latex/thesis/fig_obs/hrd
set conf = $here/../../wht_config
set prog = $here/../../programs

#Create input file
set files = `ls $conf/hd* $conf/BD*`
make -C $prog interp star2

# Getting scale of chiosi
gunzip chiosi*.gz
set data = `hdstrace chiosi | grep 'DATA('`
set data = `echo $data[1]| tr '(,),\,' ' '`
set chiX = $data[2]
set chiY = $data[3]

#Create evolutionary tracks
rm *.asc >& /dev/null
#./read
${prog}/interp ${prog}/evol_mods 35.0 5.5

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
  set op = `$prog/star2 $mode junk.$$ |grep $star`
  rm junk.$$
  set L = $op[5]

# Plot MS stars as squares
  if ("$lc" == "V") set type = 4

  set file = hrd.cmd
  touch $file
#  echo "sch $y" >> $file

    if ("$ocn" == "c") then
    set fill = 1
  else if ("$ocn" == "n") then
    set fill = 5
  else
    unset fill
  endif
#  if ($?fill) then
#    echo sci $fill >> $file
#    echo dot $op[8] $L 1 $type >> $file
#    echo sci 1 >> $file
#  endif

  echo "dot $op[8] $L 2 $type" >> $file
end

cat <<EOF |pgpixf3
begin $pgdev
paper 1500 1500
vport 0.12 0.95 0.12 0.95
scf 2

window 0 $chiX $chiY 0
rd2sdf chiosi
gray 0 1

window 5.2 3.1 -1.0 7.0
sch 1.0
box bcnst 0 0 bcnst 0 0
mtext B 3.0 0.5 0.5 "log (\fiT\fr\deff\u)"
mtext L 3.0 0.5 0.5 "log (\fiL\fr/\fiL\fr\d\(2281)\u)"
sch 1.0

input hrd.cmd

end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  echo Compressing file
  gs -dBATCH -dNOPAUSE -q -sDEVICE=epswrite -sOutputFile=hrd.eps gks74.ps
  set bb2 = `grep -i boundingbox gks74.ps`
  set bb1 = `grep -i boundingbox hrd.eps`
  sed -e "s\$bb1\$bb2\g" hrd.eps >! gks74.ps
  mv gks74.ps hrd.eps
endif

rm *.cmd
rm *.asc
gzip *.sdf
