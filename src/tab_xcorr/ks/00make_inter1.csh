#!/bin/csh -f

set prog  = ../../programs
set vsini = ../../fig_xcorr 
set of    = goodspec.tex

make -C $prog ks

set files = (vsini_BIe.dat vsini_BIl.dat vsini_BVe.dat vsini_BVl.dat)
#echo -n "&" >! $of
# Replaced with:
echo -n "" >! $of

foreach f ($files)
  set lc = "MS"
  echo $f | grep V >& /dev/null
  if ($status) set lc = "SG"
  set type = 'early'
  echo $f | grep e >& /dev/null
  if ($status) set type = 'late'
  echo -n "& $lc $type " >> $of
skip:
end

echo ' \\\\ \hline' >> $of
set c1 = 1
foreach f1 ($files)
#  if ($c1 == 1) then
#    echo '\\multirow{4}{4mm}{\\begin{sideways}K-S p\\end{sideways}} & ' >> $of
#  else
#    echo -n ' & ' >> $of
#  endif

  set lc = "MS"
  echo $f1 | grep V >& /dev/null
  if ($status) set lc = "SG"
  set type = 'early'
  echo $f1 | grep e >& /dev/null
  if ($status) set type = 'late'
  echo -n "$lc $type & " >> $of

  set c2 = 1
  foreach f2 ($files)
    $prog/ks $vsini/vsini/$f1 $vsini/vsini/$f2 >! tmp
    set d = `grep 'd=' tmp | cut -d= -f2`
    set p = `grep 'prob=' tmp | cut -d= -f2`

    if ($c1 == $c2) then
      echo -n "      " >> $of
    else if ($c1 < $c2) then
      printf ' $D=%4.4f$ ' $d >> $of
    else
      printf ' $P=%4.4f$ ' $p >> $of
    endif

    if ($c2 < 4) echo -n " & " >> $of
    @ c2++
  end
  echo ' \\\\' >> $of
  @ c1++
end

rm tmp
