#!/bin/csh -f

set conf = ../../wht_config
set prog = ../../programs

### Change errors as appropriate ###
set dt = 1.0
set dg = 0.1
set dM = 0.3  # error on Mv

make -C $prog star2

set ofile = params.tex

echo -n "% Automatically generate tex table " >! $ofile
date >> $ofile
echo "% cat spec teff logg y Mv logl err r/rsol err m/msol err" >> $ofile

#Create file
set files = `ls $conf/hd*; ls $conf/BD*`
foreach f ($files)
  echo Reading config $f
  source $f
  set fit_t = `echo "scale=2;$fit_t / 1000" | bc`
  set cat = `echo $cat | tr 'A-Z' ' '`
  set star = `echo $star | tr 'A-z' ' '`
  echo $star $fit_t $fit_g $Mv > junk.$$
  foreach temp (`awk -vVAL=$fit_t -vERR=$dt -f err.awk`)
    foreach logg (`awk -vVAL=$fit_g -vERR=$dg -f err.awk`)
      foreach mv (`awk -vVAL=$Mv -vERR=$dM -f err.awk`)
        echo "junk  " $temp $logg $mv >> junk.$$
      end
    end
  end

  set lc  = `echo $lumcl  | tr 'a-z' ' '`
  if ($#lc != 1) set lc = $lc[1]
  if ("$lc" == "I") then
    set mode = 1
  else
    set mode = 2
  endif
  $prog/star2 $mode junk.$$ >! junk_2.$$
  set op = `grep $star junk_2.$$`
  set err = `awk -f err_print.awk junk_2.$$`
  echo $err

  set spec = "$sptype ${lumcl}"
  if ($?othclass) then
    set spec = "${spec}${othclass}"
  endif
  unset othclass
#  echo -n "$cat & $spec & $fit_t & $fit_g & " >> $ofile
#  echo " $Mv & $op[5] & $op[6] & $op[7] \\\\" >> $ofile
  set note = ""
  if ("$cat" == "34078") set note = '^*'
  printf '%8s & %13s & %4.1f & %4.1f & $%4.1f%1s$ &' \
         "$cat" "$spec" $fit_t $fit_g $Mv "$note" >>$ofile
  printf '%4.1f & %3.1f & %2.0f & %2.0f & %2.0f & %2.0f \\\\\n' \
         $op[5] $err[1] $op[6] $err[2] $op[7] $err[3]>> $ofile
end





