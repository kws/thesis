#!/bin/csh -f

foreach f (*.tex)
  # extract start and end of figures
  set startline = `grep -n 'begin{fig' $f | cut -d: -f1`
  set endline = `grep -n 'end{fig' $f | cut -d: -f1`

  # If the numbers don't match then something is wrong
  if ($#startline != $#endline) then
    echo "begin/end mismatch in $f"
    exit 1
  endif

  # If there are no begin lines in file then skip it
  if ($#startline == 0) goto nextfile

  # Extract line numbers and find caption
  set c = 1
  while ($c <= $#startline) 
    sed -ne "$startline[$c],$endline[$c]p" $f | grep -i caption >& /dev/null
    if ($status == 0) then
      sed -ne "$startline[$c],$endline[$c]p" $f | grep -i fcfont >& /dev/null
      if ($status != 0) then
        echo "** Checkfigs error: FCFONT not found in $f lines $startline[$c] : $endline[$c]"
      endif
      sed -ne "$startline[$c],$endline[$c]p" $f | grep -i 'caption\[' >& /dev/null
      if ($status != 0) then
        echo "* Checkfigs warning: LOF caption not found in $f lines $startline[$c] : $endline[$c]"
      endif
    endif
    @ c++
  end



nextfile:
end
