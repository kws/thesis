#!/bin/csh -f

source ../00bsconfig

set vsinid = $bsdir/vsini
set specd   = $bsdir/spec

set catfile = $bsdir/cats/idh/catalog.dat
set lines = `wc $catfile`
set lines = $lines[1]

set c = 1

rm idhcomp*.dat

while ($c <= $lines)
  set inp   = `sed -ne "$c p" $catfile`
  set cat   = `echo "$inp" | cut -d\| -f1`
#  set spec  = `echo "$inp" | cut -d\| -f2`
  set vsini = `echo "$inp" | cut -d\| -f4`

  set cat = `echo $cat | tr -d 'A-z'`
  set vidh = `echo $vsini| tr -d ':'`
  
  set star = `printf 'hd%6i' $cat|tr ' ' '0'`

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



  if (($num > 0) & ("$vidh" != "" )) then
    set avg_v = `echo "$v / $num" | bc`
    printf '%5.0f %5.0f %10s\n'  $avg_v $vidh $star >> idhcomp_$n.dat
  endif

  @ c++
end






