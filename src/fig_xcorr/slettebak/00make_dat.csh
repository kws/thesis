#!/bin/csh -f

source ../00bsconfig

set vsinid = $bsdir/vsini
set specd   = $bsdir/spec

set catfile = $bsdir/vsini/pubvsini.ref
set stars = `grep S75 $catfile | cut -d'|' -f1`

rm vslet*.dat

foreach star ($stars)
  set cat = `echo $star | tr -d 'A-z'`
  set vslet = `grep "$star | S75" $catfile | cut -d'|' -f3`
  
  echo Star: $star

  set swps = `grep $star $vsinid/vsini.op.corr | cut -d' ' -f1`
  echo Found $#swps swps

  set v = 0
  set num = 0
  foreach sw ($swps)
    set swp = `echo $sw | cut -d_ -f2 | tr -d 'a-z'`
    set vsinis = `grep $sw $vsinid/vsini.op.corr|tr -d '+,-'`

    set n = $vsinis[6]
    @ nplus = $n + 1
    set vs = $vsinis[$nplus]
    if (($vs > 0) && ($vs < 999)) then
      @ v = $v + $vs
      @ num++
    endif
  end

  if (($num > 0) & ("$vslet" != "" )) then
    set avg_v = `echo "$v / $num" | bc`
    printf '%5.0f %5.0f %10s\n'  $avg_v $vslet $star >> vslet_$n.dat
  endif

  @ c++
end






