#!/bin/csh -f

source ../00bsconfig
set vsinid = $bsdir/vsini

cp $vsinid/*.func .
goto end
set swps = `cat $vsinid/vsini.op | cut -d' ' -f1`

rm *w.dat

foreach sw ($swps)
  echo $sw
  set l1 = `grep $sw $vsinid/vsini.inp`
  set l2 = `grep $sw $vsinid/vsini.op`
  set v1 = $l2[2]
  set v2 = $l2[3]
  set v3 = $l2[4]
  set v4 = $l2[5]

  set w1 = $l1[3]
  set w2 = $l1[5]
  set w3 = $l1[7]
  set w4 = $l1[9]
  if (($v1 != 0) && ($v2 != 0)) echo $sw $v2 $w2 $v1 $w1 >> 1-2w.dat
  if (($v2 != 0) && ($v3 != 0)) echo $sw $v3 $w3 $v2 $w2 >> 2-3w.dat
  if (($v3 != 0) && ($v4 != 0)) echo $sw $v4 $w4 $v3 $w3 >> 3-4w.dat
end
end:
set lines = `wc -l $vsinid/vsini.op.fits`
set lines = $lines[1]

set c = 1
while ($c <= $lines)
  set inp = `sed -ne "$c p" $vsinid/vsini.op.fits`
  set file = `echo "$inp" | cut -d: -f1`_fit.cmd
  set fit = `echo "$inp" | cut -d: -f2`  

  set y = `echo "$fit"|awk '{print $1,($1 + (500*$2))}'`

  echo "sls 4,move 0 $y[1],draw $y[2] 500,sls 1" >! $file
  @ c++
end

