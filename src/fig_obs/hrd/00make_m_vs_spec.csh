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

set file = hrd2.cmd
echo -n "" >! $file

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
  set sptype = `echo $sptype | tr 'A-Z' ' '`
  set lc  = `echo $lumcl  | tr 'a-z' ' '`
  if ($#lumcl != 1) set lc=$lc[1]
  set spect = `echo $sptype | sed -f $prog/spec2int.sed`

# Plot MS stars as squares
  if ("$lc" == "V") set type = 4


  if ("$ocn" == "c") then
    set fill = 1
  else if ("$ocn" == "n") then
    set fill = 5
  else
    unset fill
  endif
  if ($?fill) then
    echo sci $fill >> $file
    echo dot $spect $Mv 1 $type >> $file
    echo sci 1 >> $file
  endif

  echo "dot $spect $Mv 2 $type" >> $file
end

cat <<EOF |pgpixf3
begin $pgdev
paper 1200 900
vport 0.12 0.95 0.12 0.95
scf 2

window  0 6 -3.0 -7.5
sch 1.0
box bct 0 0 bcnst 0 0
mtext "b" 1.2 0.166 .5 "O8"
mtext "b" 1.2 0.333 .5 "O8.5"
mtext "b" 1.2 0.500 .5 "O9"
mtext "b" 1.2 0.666 .5 "O9.5"
mtext "b" 1.2 0.833 .5 "O9.7"
sch 1.25
mtext L 2 0.5 0.5 "M\dv"
mtext B 3 0.5 0.5 "Spectral Type"
sch 1.0

input $file

% HP89 values
rdalas hp89.I
conect
rdalas hp89.III
conect
rdalas hp89.V
conect
ptext 0.5 "V"   0.8 -4.58 0.0
ptext 0.5 "III" 0.8 -5.28 0.0
ptext 0.5 "I"   0.8 -6.38 0.0

end
quit
EOF

if (-e gks74.ps) then
  $prog/gks_convert gks74.ps
  mv gks74.ps hrd2.eps
endif

#rm *.cmd



