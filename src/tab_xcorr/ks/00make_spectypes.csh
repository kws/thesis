#!/bin/csh -f

set prog  = ../../programs
set vsini = ../../fig_xcorr 
set of    = spectypes.tex

make -C $prog ks

set files = `cd $vsini/vsini;ls vsini_B*dat`
echo "% Type Type  N1 N2 D P" >! $of

foreach f ($files)
  $prog/ks $vsini/vsini/$f $vsini/vsini_bscspec/$f >! tmp
  set d = `grep 'd=' tmp | cut -d= -f2`
  set p = `grep 'prob=' tmp | cut -d= -f2`

  echo $f | grep III >& /dev/null
  if (!($status)) goto skip

  set lc = "MS"
  echo $f | grep V >& /dev/null
  if ($status) set lc = "SG"
  set type = 'early'
  echo $f | grep e >& /dev/null
  if ($status) set type = 'late'

  set nums = `cat tmp`
  set n1 = $nums[1]
  set n2 = $nums[2]
  printf "%1s & %5s & %3i & %3i & %4.2f & %4.2f \\\\ \n" \
         $lc $type $n1 $n2 $d $p >> $of
skip:
end

rm tmp
