scf 2
sch 1.25

page

vport 0.15 0.85 0.15 0.85


%##################1#################
window 3787 3807 0.5 1.05
box bcnst 0 0 bcnst 0 0
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"
mtext "LV" -2 .10 0.0 "HI \gl3797\A "

rdsdf h1_3797modnorm
bin t

sls 2
rdsdf h1_3797modnorm_mod
bin t
sls 1

page
%###################2##################
window 3825 3845 0.5 1.05
box bcnst 0 0 bcnst 0 0
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"
mtext "LV" -2 .10 0.0 "HI \gl3835\A "

rdsdf h1_3835modnorm
bin t

sls 2
rdsdf h1_3835modnorm_mod
bin t
sls 1

page
%####################3##################
window 3879 3899 0.6 1.05
box bcnst 0 0 bcnst 0 0
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"
mtext "LV" -2 .10 0.0 "HI \gl3889\A "

rdsdf h1_3889modnorm
bin t

sls 2
rdsdf h1_3889modnorm_mod
bin t
sls 1

page
%##################4###################
window 3960 3980 0.6 1.05
box bcnst 0 0 bcnst 0 0
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"
mtext "LV" -2 .10 0.0 "HI \gl3970\A "

rdsdf h1_3970modnorm
bin t

sls 2
rdsdf h1_3970modnorm_mod
bin t
sls 1








