#!/bin/csh -f

set pdir = ../../programs

make -C $pdir star2 interp

set conf = ../../wht_config

set ofile = mass_disc.tex

echo -n "% Automatically generate tex table " >! $ofile
date >> $ofile
echo "% cat spec teff logg y M_s M_0 Me dM " >> $ofile

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
  set op = `$pdir/star2 $mode junk.$$ |grep $star`

  set spec = "$sptype ${lumcl}"
  if ($?othclass) then
    set spec = "${spec}${othclass}"
  endif
  unset othclass

  # Get evolutionary masses
  $pdir/interp $pdir/evol_mods $fit_t $op[5] >! junk.$$
  set m_0 = `grep 'M_0' junk.$$`
  set m_e = `grep 'M_e' junk.$$`

  set dm = `echo "scale=2;$m_e[3] - $op[7]" | bc`

  printf '%8s & %13s & %4.1f & %4.1f & %4.2f &' \
         "$cat" "$spec" $fit_t $fit_g $fit_y  >>$ofile
  printf '%4.1f & %4.1f & %4.1f & $%4.1f$\\\\\n' \
          $op[7] $m_0[3] $m_e[3] $dm >> $ofile
end

rm *.cmd *.asc
rm junk.$$




