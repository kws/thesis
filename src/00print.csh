#!/bin/csh -f

if ($#argv != 2) then
  echo -n 'First page> '
  set fip = $<
  echo -n 'Last page> '
  set lap = $<
else
  set fip = $1
  set lap = $2
endif

if ($fip > $lap) then
  echo 'Cannot print in reverse order - sorry'
  exit 1
endif

set p = $fip

while ($p <= $lap) 
  echo "Attempting to print page $p"
  echo -n 'Waiting for empty queue .'
loop:
  lpq | grep -i 'no entries' >& /dev/null
  if ($status == 1) then
    sleep 10
    echo -n '.'
    goto loop
  endif
  echo ''
  echo "Printing page $p"
  dvips -Z -D 600 -pp $p-$p thesis
  lpr thesis.ps
  sleep 30
  rm thesis.ps
  @ p++
endif

end
