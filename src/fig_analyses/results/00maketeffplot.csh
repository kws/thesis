#!/bin/csh -f

######### CHANGE THIS FOR DIFFERENT DEVICE###
set pgdev = epsf_p
#############################################

rm gks* >& /dev/null

source /user/kcs/pgpixf3/pgpixf3_setup

set conf = ../../wht_config

#Create input file
set files = `ls $conf/hd* $conf/BD*`

rm teffplot*.cmd >& /dev/null

foreach f ($files)
  set type = "2 20"
  echo Reading config $f
  source $f
  echo $sptype | grep "ON" >& /dev/null
  if (!($status)) set type = "1 3"
  echo $sptype | grep "OC" >& /dev/null
  if (!($status)) set type = "1 4"
  set sptype = `echo $sptype | tr 'A-Z' ' '`
  set lumcl  = `echo $lumcl  | tr 'a-z' ' '`
  if ($#lumcl != 1) set lumcl=$lumcl[1]
  set spect = `echo $sptype | sed -f spec2int.sed`
  set y = `echo "$fit_y * 10" | bc`
  set file = teffplot${lumcl}.cmd
  touch $file
  echo "sch $y" >> $file
  echo dot $spect $fit_t 2 20 >> $file
end

cat <<EOF >! idhteffI.dat
1 33000
2 32000
3 31000
4 30000
5 29000
EOF

cat <<EOF >! idhteffIII.dat
1 35000
2 33500
3 32500
4 31500
EOF

cat <<EOF >! idhteffV.dat
1 36500
2 35000
3 34000
4 33000
EOF

cat <<EOF |pgpixf3
begin $pgdev 1 3
paper 1200 2700
vport 0.1 0.9 0.15 0.95
scf 2

page
window 0 6 25 45
sch 1.25
box bct 0 0 bcnst 0 0
mtext L 3.0 0.5 0.5 "\fiT\fr\deff\u (kK)"
mtext B 3.0 0.5 0.5 "Spectral Type"
sch 1.0
mtext b 1.5 0.166 0.5 "O8"
mtext b 1.5 0.333 0.5 "O8.5"
mtext b 1.5 0.500 0.5 "O9"
mtext b 1.5 0.666 0.5 "O9.5"
mtext b 1.5 0.833 0.5 "O9.7"

window 0 6 25000 45000
input teffplotI.cmd
data idhteffI.dat
xcol 1
ycol 2
conect

move 4.7 45000
draw 4.7 37000
draw 6 37000

sch 0.9
dot 5.0 43200 2 20
sch 1.0
ptext 0.0 "\fiy\fr = 0.09" 5.2 43000 0.0

sch 1.2
dot 5.0 41200 2 20
sch 1.0
ptext 0.0 "\fiy\fr = 0.12" 5.2 41000 0.0

sch 1.5
dot 5.0 39200 2 20
sch 1.0
ptext 0.0 "\fiy\fr = 0.15" 5.2 39000 0.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
page
window 0 6 25 45
sch 1.25
box bct 0 0 bcnst 0 0
mtext L 3.0 0.5 0.5 "\fiT\fr\deff\u (kK)"
mtext B 3.0 0.5 0.5 "Spectral Type"
sch 1.0
mtext b 1.5 0.166 0.5 "O8"
mtext b 1.5 0.333 0.5 "O8.5"
mtext b 1.5 0.500 0.5 "O9"
mtext b 1.5 0.666 0.5 "O9.5"
mtext b 1.5 0.833 0.5 "O9.7"

window 0 6 25000 45000

input teffplotII.cmd
input teffplotIII.cmd

data idhteffIII.dat
xcol 1
ycol 2
conect

%%%%%%%%%%%%%%%%%%%%%%%%%%%
page
window 0 6 25 45
box bct 0 0 bcnst 0 0
sch 1.25
mtext L 3.0 0.5 0.5 "\fiT\fr\deff\u (kK)"
mtext B 3.0 0.5 0.5 "Spectral Type"
sch 1.0
mtext b 1.5 0.166 0.5 "O8"
mtext b 1.5 0.333 0.5 "O8.5"
mtext b 1.5 0.500 0.5 "O9"
mtext b 1.5 0.666 0.5 "O9.5"
mtext b 1.5 0.833 0.5 "O9.7"

window 0 6 25000 45000
input teffplotIV.cmd
input teffplotV.cmd


data idhteffV.dat
xcol 1
ycol 2
conect

end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps teffplot.eps
endif





