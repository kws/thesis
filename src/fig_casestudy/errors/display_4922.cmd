vport 0.12 0.95 0.12 0.95
scf 2
sch 1.25
kpoly
%
% THIS WINDOW IS ONLY FOR THE DISPLAY OF THE TITLES
% DO NOT CHANGE
window 45 17 4.5 2.5
%
label "\fiT\fr\deff\u (10\u3\d\(0698)K)" " " " "
mtext L   3 0.5 0.5 "log\(0698)\fig"
%
mtext LV -3 0.90 0.0 "He\(0698)I \gl4922"
%
sch 1.00
%
% CHANGE THE DISPLAY SIZE HERE
%
window 41 26 4.6 3.1
box bcnst 0 0 bcnstv 0 0
%
data 4922.dat
%
lines 1 0
xc 1
yc 2
angle 0
sci 1
kpoint 2 3
sci 1
kjoinp 3
angle 0
%
sls 2
data 4922_pls.dat
%
lines 1 0
xc 1
yc 2
conect
%
sls 4
data 4922_mns.dat
%
lines 1 0
xc 1
yc 2
conect
sls 1









