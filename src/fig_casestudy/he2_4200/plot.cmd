paper 1200 900
vport 0.1 0.9 0.1 0.9

scf 2
sch 1.25

window 4192 4208 0.8 1.05
box bcnst 0 0 bcnst 0 0

mtext L 2.8 0.5 0.5 "Rectified Intensity"
mtext B 2.8 0.5 0.5 "Wavelength (\A)"

sch 1.0

rdsdf he2_4200_obs
bin t

sls 2

rdsdf he2_4200_fit
conect

sls 4

rdsdf he2_4200_fit1
conect

sls 1









