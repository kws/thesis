#!/bin/csh -f

source /user/kws/tgkiel/tgkiel3_setup
source /user/kcs/pgpixf3/pgpixf3_setup
set tf = tmp.cmd

set tmin = 27.00
set tmax = 40.00
set gmin = 2.5
set gmax = 4.5
set step = `echo "$tmax $tmin"|awk '{print (($1 - $2) + 1)}'`

set lines = (4009 4026 4143 4388 4471 4713 4922 5047)
#set lines = (4922)
set vs = (00 15)

foreach v ($vs)
  echo "loadf" >! $tf
  echo "pgdev xw " >> $tf
  foreach l ($lines)
    @ min = $l - 5
    @ max = $l + 5

    echo "ewgrid $tmin $tmax $gmin $gmax $min $max $step" >> $tf
    echo "wrchsq ${l}_v$v" >> $tf
    set c = 100
    while ($c <= 2000)
      echo "pewt $c" >> $tf
      @ c = $c + 100
    end
  end
  echo "quit" >> $tf
  tgset old v$v y09 $tmin $tmax $gmin $gmax 1 0.1
  tgkiel < $tf
  grep $tmin fort.10 |grep -v map| split -l 20
  set c = 1
  foreach f (x*)
    mv $f $lines[$c]_v${v}_lab
    @ c++
  end
  rm fort.10
end




