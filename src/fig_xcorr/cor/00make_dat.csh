#!/bin/csh -f

source ../00bsconfig
set vsinid = $bsdir/vsini

cp $vsinid/*.func.corr .
cp $vsinid/tausco.corr $vsinid/iother.corr $vsinid/picet.corr \
   $vsinid/alplyr.corr .

set swps = `cat $vsinid/vsini.op | cut -d' ' -f1`

rm *w.dat

foreach sw ($swps)
  echo $sw
  set l1 = `grep $sw $vsinid/vsini.inp`
  set l2 = `grep $sw $vsinid/vsini.op.corr`
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

