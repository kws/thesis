#!/bin/csh -f

##### CONFIG
set dev = epsf_p
set spec = ~/new/new/spectra/
set closeness = 1.9
set xc = (3805 4495 4686 4861 5000 5695 6563 6610)
set num = 8
set dx = 20
set ymax = (1.3 1.3 1.3 1.3 1.3 1.3 1.5 1.3)
set ymin = (0.6 0.6 0.6 0.6 0.6 0.6 0.8 0.6)

##### SETUP
source /user/kcs/pgpixf3/pgpixf3_setup
rm gks74* >& /dev/null

##### CREATE LINES

set c = 1
while ($c <= $num)
  @ xmin = $xc[$c] - $dx
  @ xmax = $xc[$c] + $dx
  set xr = "$xmin $xmax"
  printf "%s\n%e\n%e\n%e\n" ~/new/scr/lines/lines.scholtz72 $xr $closeness | ~/new/scr/lines/lines
  mv fort.15 lines_$c.cmd
  @ c++
end

##### MAKE DIAGRAM
cat <<EOF >! pgp.cmd
begin $dev 2 4
magic
paper 1200 1400
vport 0.05 0.95 0.15 0.95
scf 2

EOF

set c = 1
while ($c <= $num)
  @ xmin = $xc[$c] - $dx
  @ xmax = $xc[$c] + $dx
  set xr = "$xmin $xmax"
  set yr = "$ymin[$c] $ymax[$c]"

cat <<EOF >> pgp.cmd

page
sch 1.25
window $xr $yr
box bcnst 0 0  bcnst 0 0
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"

rdsdf $spec/hd195592
clipx
bin t

sch 1.1
window $xr 0.5 1.2
input lines_$c.cmd
EOF

  @ c++
end

cat <<EOF >> pgp.cmd

end
quit

EOF

cat pgp.cmd | pgpixf3

if (-e gks74.ps) then
  gks_convert gks74.ps
  mv gks74.ps hd195592.eps
endif

rm *.cmd


