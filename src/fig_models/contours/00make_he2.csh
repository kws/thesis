#!/bin/csh -f

source /user/kws/tgkiel/tgkiel3_setup
source /user/kcs/pgpixf3/pgpixf3_setup
set tf = tmp.cmd

set tmin = 27.00
set tmax = 40.00
set gmin = 2.5
set gmax = 4.5
set step = `echo "$tmax $tmin"|awk '{print (($1 - $2) + 1)}'`

set lines = (4200 4541 4686 5411)
#set lines = (4686 5411)
set vs = (00 15)

foreach v ($vs)
  foreach l ($lines)
    echo "loadf" >! $tf
    echo "pgdev xw " >> $tf
    @ min = $l - 10
    @ max = $l + 10

    echo "ewgrid $tmin $tmax $gmin $gmax $min $max $step" >> $tf
    echo "wrchsq ${l}_v$v" >> $tf
    set c = 100
    while ($c <= 2000)
#      echo "pewg $c" >> $tf
      echo "pgemap $c" >> $tf
      @ c = $c + 100
    end
    echo "quit" >> $tf
    tgset old v$v y09 $tmin $tmax $gmin $gmax 1 0.1
    tgkiel < $tf
    mv fort.20  ${l}_v${v}_lab
  end
end




