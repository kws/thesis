#!/bin/csh -f

set dev = epsf_p

set name = (oV oI ocV ocI onV onI)
source /user/kcs/pgpixf3/pgpixf3_setup
rm gks74* >& /dev/null

pgpixf3 <<EOF
begin $dev
paper 10 10
window 0 2 0 2
sch 50.0
dot 1 1 2 4
page
dot 1 1 2 20
page
dot 1 1 1 4
page 
dot 1 1 1 20
page
sci 5
dot 1 1 1 4
sci 1
dot 1 1 2 4
page 
sci 5
dot 1 1 1 20
sci 1
dot 1 1 2 20
end
quit
EOF

set c = 1
foreach f (gks74*)
  gks_convert $f
  mv $f $name[$c].eps
  @ c++
end

