#!/bin/tcsh -f

if ($#argv != 2) then 
  echo Usage: errors.csh line ew
  exit 1
endif

set line = $1
set ew   = $2

@ lmin = $line - 10
@ lmax = $line + 10

@ err = $ew / 20 + 1

@ min = $ew - $err
@ max = $ew + $err

source /user/kws/tgkiel/tgkiel3_setup

tgset old v15 y09 30000 40000 3.5 4.5 1000. 0.1

tgkiel << EOF

pgdev x2w
loady
yint .09

ewgrid 30000 40000 3.5 4.5 $lmin $lmax 11
pgemap $ew

pga 
pgsc 2

pgemap $min
pgemap $max

quit
EOF

set l = `grep -n map fort.20 | awk 'BEGIN{FS=":"}{print $1}'`
@ l1 = $l[1] + 1
@ l2 = $l[2] + 1 
@ l3 = $l[3] + 1

cat <<EOF >! tmp.sed
$l1 a\
% Calulated for $ew\
%\
sls 1

$l2 a\
% Calulated for $min\
%\
sls 4

$l3 a\
% Calulated for $max\
%\
sls 2

\$ a\
%\
%\
sls 1
EOF

sed -f tmp.sed fort.20 >! ${line}.con

rm tmp.sed fort.20













