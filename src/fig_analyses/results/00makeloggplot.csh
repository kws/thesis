#!/bin/csh -f

######### CHANGE THIS FOR DIFFERENT DEVICE###
set pgdev = epsf_p
#############################################

rm gks* >& /dev/null

source /user/kcs/pgpixf3/pgpixf3_setup

set conf = ../../wht_config

#Create input file
set files = `ls $conf/hd* $conf/BD*`

rm loggplot*.cmd >& /dev/null

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
  set file = loggplot${lumcl}.cmd
  touch $file
  echo "sch $y" >> $file
  echo dot $spect $fit_g 2 20 >> $file
end

cat <<EOF >! idhloggI.dat
1 3.40
2 3.31 
3 3.37 
4 3.32 
5 3.31 
EOF

cat <<EOF >! idhloggIII.dat
1 3.73 
2 3.70 
3 3.73 
4 3.69 
EOF

cat <<EOF >! idhloggV.dat
1 3.99 
2 4.02 
3 4.03 
4 4.03 
EOF

cat <<EOF |pgpixf3
begin $pgdev 1 3
paper 1200 2700
vport 0.1 0.9 0.15 0.95
scf 2

page
window 0 6 2.5 4.5
sch 1.25
box bct 0 0 bcnst 0 0
mtext L 3.0 0.5 0.5 "log\d10\u \fig\fr"
mtext B 3.0 0.5 0.5 "Spectral Type"
sch 1.0
mtext b 1.5 0.166 0.5 "O8"
mtext b 1.5 0.333 0.5 "O8.5"
mtext b 1.5 0.500 0.5 "O9"
mtext b 1.5 0.666 0.5 "O9.5"
mtext b 1.5 0.833 0.5 "O9.7"

input loggplotI.cmd
data idhloggI.dat
xcol 1
ycol 2
conect

%%%%%%% KEY %%%%%%%%%%%%%
window 0 6 25000 45000
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
window 0 6 2.5 4.5
sch 1.25
box bct 0 0 bcnst 0 0
mtext L 3.0 0.5 0.5 "log\d10\u \fig\fr"
mtext B 3.0 0.5 0.5 "Spectral Type"
sch 1.0
mtext b 1.5 0.166 0.5 "O8"
mtext b 1.5 0.333 0.5 "O8.5"
mtext b 1.5 0.500 0.5 "O9"
mtext b 1.5 0.666 0.5 "O9.5"
mtext b 1.5 0.833 0.5 "O9.7"

input loggplotII.cmd
input loggplotIII.cmd

data idhloggIII.dat
xcol 1
ycol 2
conect

%%%%%%%%%%%%%%%%%%%%%%%%%%%
page
window 0 6 2.5 4.5
box bct 0 0 bcnst 0 0
sch 1.25
mtext L 3.0 0.5 0.5 "log\d10\u \fig\fr"
mtext B 3.0 0.5 0.5 "Spectral Type"
sch 1.0
mtext b 1.5 0.166 0.5 "O8"
mtext b 1.5 0.333 0.5 "O8.5"
mtext b 1.5 0.500 0.5 "O9"
mtext b 1.5 0.666 0.5 "O9.5"
mtext b 1.5 0.833 0.5 "O9.7"

input loggplotIV.cmd
input loggplotV.cmd

data idhloggV.dat
xcol 1
ycol 2
conect

end
quit
EOF

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps loggplot.eps
endif





