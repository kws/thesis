#!/bin/csh

foreach d (chap_*/)
  set d = $d:h
  set new = `echo $d | sed -e "s/chap/fig/g"`
  mv $d $new
end
