scf 2
sch 1.25

page

vport 0.15 0.85 0.15 0.85

%##################1#################
window 4195 4205 0.5 1.05
box bcnst 0 0 bcnst 0 0
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"
mtext "LV" -2 .10 0.0 "HeII \gl4200\A "

rdsdf he2_4200modnorm
bin t

sls 2
rdsdf he2_4200modnorm_mod
bin t
sls 1

page
%###################2##################
window 4536 4546 0.5 1.05
box bcnst 0 0 bcnst 0 0
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"
mtext "LV" -2 .10 0.0 "HeII \gl4541\A "

rdsdf he2_4541modnorm
bin t

sls 2
rdsdf he2_4541modnorm_mod
bin t
sls 1

page
%####################3##################
window 4680 4690 0.5 1.05
box bcnst 0 0 bcnst 0 0
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"
mtext "LV" -2 .10 0.0 "HeII \gl4686\A "

rdsdf he2_4685modnorm
bin t

sls 2
rdsdf he2_4685modnorm_mod
bin t
sls 1

page
%##################4###################
window 5406 5416 0.5 1.05
box bcnst 0 0 bcnst 0 0
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"
mtext "LV" -2 .10 0.0 "HeII \gl5411\A "

rdsdf he2_5411modnorm
bin t

sls 2
rdsdf he2_5411modnorm_mod
bin t
sls 1


