#!/bin/csh -f

source ../00bsconfig

set catfile = $bsdir/cats/idh/catalog.dat

awk -v CORRFILE=$bsdir/vsini/vsini.op.corr \
    -v VSINIFILE=$bsdir/vsini/vsini.op -f 0make_new.awk $catfile >! tab.tex
