#!/bin/csh -f

set dir = /mnt/thesis_cd/root/THESIS

if (!(-e thesis.toc)) then
  echo "Have to run latex first..."
  exit 1
endif

grep '\\documentclass' thesis.tex | grep twoside >& /dev/null
if ($status) then
  set sides="SINGLE"
else 
  set sides="DOUBLE"
endif

echo "Creating $dir/$sides"
mkdir $dir/$sides

set dir = $dir/$sides

grep '\\contentsline {chapter}' thesis.toc | awk -vDIR=$dir -f 00make_ps.awk


#  awk 'BEGIN{FS="{"}{inp = $4$5;split(inp,arr,"}");print arr[1],arr[3]}'
