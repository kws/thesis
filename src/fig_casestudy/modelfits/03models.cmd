scf 2
sch 1.25

page

vport 0.1 0.9 0.1 0.9
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"

%##################1#################
vport 0.1 0.3 0.1 0.9
window 4004 4014 0.6 1.05
box bcnst 0 0 bcnst 0 0

mtext "LV" -2 .10 0.0 "HeI \gl4009\A "

rdsdf he1_4009modnorm
bin t

sls 2
rdsdf he1_4009modnorm_mod
bin t
sls 1

%###################2##################
vport 0.3 0.5 0.1 0.9
window 4021 4031 0.6 1.05
box bcmst 0 0 bcst 0 0

mtext "LV" -2 .10 0.0 "HeI \gl4026\A "

rdsdf he1_4026modnorm
bin t

sls 2
rdsdf he1_4026modnorm_mod
bin t
sls 1

%####################3##################
vport 0.5 0.7 0.1 0.9
window 4138 4148 0.6 1.05
box bcnst 0 0 bcst 0 0

mtext "LV" -2 .10 0.0 "HeI \gl4143\A "

rdsdf he1_4143modnorm
bin t

sls 2
rdsdf he1_4143modnorm_mod
bin t
sls 1

%##################4###################
vport 0.7 0.9 0.1 0.9
window 4383 4393 0.6 1.05
box bcmst 0 0 bcst 0 0

mtext "LV" -2 .10 0.0 "HeI \gl4388\A "

rdsdf he1_4388modnorm
bin t

sls 2
rdsdf he1_4388modnorm_mod
bin t
sls 1

page

vport 0.1 0.9 0.1 0.9
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"

%##################1#################
vport 0.1 0.3 0.1 0.9
window 4466 4476 0.6 1.05
box bcnst 0 0 bcnst 0 0

mtext "LV" -2 .10 0.0 "HeI \gl4471\A "

rdsdf he1_4471modnorm
bin t

sls 2
rdsdf he1_4471modnorm_mod
bin t
sls 1

%###################2##################
vport 0.3 0.5 0.1 0.9
window 4708 4718 0.6 1.05
box bcmst 0 0 bcst 0 0

mtext "LV" -2 .10 0.0 "HeI \gl4713\A "

rdsdf he1_4713modnorm
bin t

sls 2
rdsdf he1_4713modnorm_mod
bin t
sls 1

%####################3##################
vport 0.5 0.7 0.1 0.9
window 4917 4927 0.6 1.05
box bcnst 0 0 bcst 0 0

mtext "LV" -2 .10 0.0 "HeI \gl4922\A "

rdsdf he1_4922modnorm
bin t

sls 2
rdsdf he1_4922modnorm_mod
bin t
sls 1

%##################4###################
vport 0.7 0.9 0.1 0.9
window 5042 5052 0.6 1.05
box bcmst 0 0 bcst 0 0

mtext "LV" -2 .10 0.0 "HeI \gl5047\A "

rdsdf he1_5047modnorm
bin t

sls 2
rdsdf he1_5047modnorm_mod
bin t
sls 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
page

vport 0.1 0.9 0.1 0.9
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"

%##################1#################
vport 0.1 0.3 0.1 0.9
window 4195 4205 0.6 1.05
box bcnst 0 0 bcnst 0 0

mtext "LV" -2 .10 0.0 "HeII \gl4200\A "

rdsdf he2_4200modnorm
bin t

sls 2
rdsdf he2_4200modnorm_mod
bin t
sls 1

%###################2##################
vport 0.3 0.5 0.1 0.9
window 4536 4546 0.6 1.05
box bcmst 0 0 bcst 0 0

mtext "LV" -2 .10 0.0 "HeII \gl4541\A "

rdsdf he2_4541modnorm
bin t

sls 2
rdsdf he2_4541modnorm_mod
bin t
sls 1

%####################3##################
vport 0.5 0.7 0.1 0.9
window 4680 4690 0.6 1.05
box bcnst 0 0 bcst 0 0

mtext "LV" -2 .10 0.0 "HeII \gl4686\A "

rdsdf he2_4685modnorm
bin t

sls 2
rdsdf he2_4685modnorm_mod
bin t
sls 1

%##################4###################
vport 0.7 0.9 0.1 0.9
window 5406 5416 0.6 1.05
box bcmst 0 0 bcst 0 0

mtext "LV" -2 .10 0.0 "HeII \gl5411\A "

rdsdf he2_5411modnorm
bin t

sls 2
rdsdf he2_5411modnorm_mod
bin t
sls 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
page

vport 0.1 0.9 0.1 0.9
mtext L 3 0.5 0.5 "Rectified Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"

%##################1#################
vport 0.1 0.3 0.1 0.9
window 3787 3807 0.6 1.05
box bcnst 0 0 bcnst 0 0

mtext "LV" -2 .10 0.0 "HI \gl3797\A "

rdsdf h1_3797modnorm
bin t

sls 2
rdsdf h1_3797modnorm_mod
bin t
sls 1

%###################2##################
vport 0.3 0.5 0.1 0.9
window 3825 3845 0.6 1.05
box bcmst 0 0 bcst 0 0

mtext "LV" -2 .10 0.0 "HI \gl3835\A "

rdsdf h1_3835modnorm
bin t

sls 2
rdsdf h1_3835modnorm_mod
bin t
sls 1

%####################3##################
vport 0.5 0.7 0.1 0.9
window 3879 3899 0.6 1.05
box bcnst 0 0 bcst 0 0

mtext "LV" -2 .10 0.0 "HI \gl3889\A "

rdsdf h1_3889modnorm
bin t

sls 2
rdsdf h1_3889modnorm_mod
bin t
sls 1

%##################4###################
vport 0.7 0.9 0.1 0.9
window 3960 3980 0.6 1.05
box bcmst 0 0 bcst 0 0

mtext "LV" -2 .10 0.0 "HI \gl3970\A "

rdsdf h1_3970modnorm
bin t

sls 2
rdsdf h1_3970modnorm_mod
bin t
sls 1


