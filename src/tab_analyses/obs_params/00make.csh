#!/bin/csh -f

set conf = ../../wht_config
set prog = ../../programs

set ofile = obs_par.tex
#make -C $prog star2

echo -n "% Automatically generate tex table " >! $ofile
date >> $ofile
echo "% cat spec teff logg y Mv logl r/rsol m/msol" >> $ofile

#Create file
set files = `ls $conf/hd*; ls $conf/BD*`
foreach f ($files)
  echo Reading config $f
  source $f
  set fit_t = `echo "scale=2;$fit_t / 1000" | bc`
  set cat = `echo $cat | tr 'A-Z' ' '`
  set star = `echo $star | tr 'A-z' ' '`
  echo $star $fit_t $fit_g $Mv > junk.$$
  set lc  = `echo $lumcl  | tr 'a-z' ' '`
  if ($#lc != 1) set lc = $lc[1]
  if ("$lc" == "I") then
    set mode = 1
  else
    set mode = 2
  endif
#  set op = `$prog/star2 $mode junk.$$ |grep $star`
  rm junk.$$

  set spec = "$sptype ${lumcl}"
  if ($?othclass) then
    set spec = "${spec}${othclass}"
  endif
  unset othclass
  printf '%8s & %13s & %4.1f & %4.1f & %4.2f & %4s \n' \
         "$cat" "$spec" $fit_t $fit_g $fit_y $rot  >>$ofile
end





