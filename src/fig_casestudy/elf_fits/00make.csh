#!/bin/csh

#############################
set dev = epsf_p
#############################

source /user/kcs/pgpixf3/pgpixf3_setup

set yr = "0.55 1.05"

rm gks74.ps

cat <<EOF | pgpixf3
begin $dev 2 3
paper 2400 2700
scf 2

magic

page

window 4016 4036 $yr
box bcnst 0 0 bcmst 0 0
sch 1.4
mtext T 1.5 0.5 0.5 "HD 214680"
mtext L 1.5 0.5 0.5 "He I \gl4026\A"
sch 1.0
mtext B 2.8 0.5 0.5 "Wavelength (\A)"
rdsdf hd214680/he1_4026
bin t
sls 4
rdsdf hd214680/he1_4026_elf
bin t
sls 1

page 

box bcnst 0 0 bcnst 0 0
sch 1.4
mtext T 1.5 0.5 0.5 "HD 195592"
sch 1.00
mtext L 4.0 0.5 0.5 "Rectified Intensity"
mtext B 2.8 0.5 0.5 "Wavelength (\A)"
rdsdf hd195592/he1_4026
bin t
sls 4
rdsdf hd195592/he1_4026_elf
bin t
sls 1

page

window 4912 4932 $yr
box bcnst 0 0 bcmst 0 0
sch 1.4
mtext L 1.5 0.5 0.5 "He I \gl4922\A"
sch 1.0
mtext B 2.8 0.5 0.5 "Wavelength (\A)"
rdsdf hd214680/he1_4922
bin t
sls 4
rdsdf hd214680/he1_4922_elf
bin t
sls 1

page 

box bcnst 0 0 bcnst 0 0
mtext L 4.0 0.5 0.5 "Rectified Intensity"
mtext B 2.8 0.5 0.5 "Wavelength (\A)"
rdsdf hd195592/he1_4922
bin t
sls 4
rdsdf hd195592/he1_4922_elf
bin t
sls 1

page

window 4531 4551 $yr
box bcnst 0 0 bcmst 0 0
sch 1.4
mtext L 1.5 0.5 0.5 "He II \gl4541\A"
sch 1.0
mtext B 2.8 0.5 0.5 "Wavelength (\A)"
rdsdf hd214680/he2_4541
bin t
sls 4
rdsdf hd214680/he2_4541_elf
bin t
sls 1

page 

box bcnst 0 0 bcnst 0 0
mtext L 4.0 0.5 0.5 "Rectified Intensity"
mtext B 2.8 0.5 0.5 "Wavelength (\A)"
rdsdf hd195592/he2_4541
bin t
sls 4
rdsdf hd195592/he2_4541_elf
bin t
sls 1


end
quit

EOF

if (-e gks74.ps) then
  mv gks74.ps elf_fits.eps
  gks_convert elf_fits.eps
endif

