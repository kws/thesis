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
mtext LV -3 0.90 0.0 "HD\(0698)214680   O9\(0698)V"
mtext LV -3 0.85 0.0 "\gc = 15 km\(0698)s\u-1\d"
mtext LV -3 0.80 0.0 "\fiy\fr = 0.09"
%mtext LV -3 0.75 0.0 "Using H-line wings."
sch 1.00
%
% CHANGE THE DISPLAY SIZE HERE
%
window 39 32 4.4 3.5
box bcnst 0 0 bcnstv 0 0
%
% This bit is the fort.20 file
%
sci 3
input fig_hd214680_y09v15r30.imp
sci 1

input fig_hd214680_y09v15r30.con
sch 0.75
ptext 0.5 (1) 40.40 3.93 0.0
ptext 0.5 (2) 37.27 3.48 0.0
ptext 0.5 (3) 40.40 3.87 0.0
ptext 0.5 (4) 38.39 3.48 0.0
sch 1.0
%
% And this is the fort.10
%
data fig_hd214680_y09v15r30.dat
%
%4009
%
lines    5  10
xc 1
yc 2
kpoint 2 20
kjoinp 20
%
%4143
%
lines   21  27
xc 1
yc 2
kpoint 2 5
kjoinp 5
%
%4388
%
lines   35  40
xc 1
yc 2
kpoint 2 4
kjoinp 4
%
%4922
%
lines   50  56
xc 1
yc 2
kpoint 2 3
kjoinp 3
%
%5047
%
lines   65  68
xc 1
yc 2
angle 180
kpoint 2 3
kjoinp 3
angle 0
%
%4026
%
lines   74  84
xc 1
yc 2
angle 180
sci 2
kpoint 1 3
sci 1
kjoinp 3
angle 0
%
%4471
%
lines   92  98
xc 1
yc 2
sci 2
kpoint 1 4
sci 1
kjoinp 3
%
%4713
%
lines  108 110
xc 1
yc 2
sci 2
kpoint 1 20
sci 1
kjoinp 3
angle 0
%
%3797
%
lines  117 126
xc 1
yc 2
angle 180
kpoint 1 3
kjoinp 3
angle 0
%
%3835
%
lines  130 140
xc 1
yc 2
kpoint 1 3
kjoinp 3
%
%3889
%
lines  144 154
xc 1
yc 2
kpoint 1 4
kjoinp 4
%%
%3970
%
lines  158 168
xc 1
yc 2
kpoint 1 20
kjoinp 20
%%
% THESE ARE IN THE PLOT COORDINATES TO MAKE THEM EASY
% TO PLACE
% HeII
%ptext 0.0 "He\(0698)II \gl4200" 37.00 3.650 0
%ptext 0.0 "He\(0698)II \gl4541" 32.00 3.450 0
%ptext 0.0 "He\(0698)II \gl4685" 40.00 3.725 0
%ptext 0.0 "He\(0698)II \gl5411" 34.00 3.450 0
%
% THIS WINDOW IS ONLY FOR THE DISPLAY OF THE TITLES
% DO NOT CHANGE
window 45 17 4.5 2.5
%
%HeI lines
%
dot 22.5 3.20 2 20
dot 22.5 3.30 2 5
dot 22.5 3.40 2 4
dot 22.5 3.50 2 3 
angle 180
dot 22.5 3.60 2 3
angle 0
sci 2
angle 180
dot 22.5 3.70 1 3
angle 0
dot 22.5 3.80 1 4
dot 22.5 3.90 1 20
sci 1
%
% HI lines
%
angle 180
dot 22.5 4.00 1 3
angle 0
dot 22.5 4.10 1 3
dot 22.5 4.20 1 4
dot 22.5 4.30 1 20
%
% delta-y + 0.005
%
sch .75
ptext 1.0 "(1)" 22.15 2.81 0.
ptext 1.0 "(2)" 22.15 2.91 0.
ptext 1.0 "(3)" 22.15 3.01 0.
ptext 1.0 "(4)" 22.15 3.11 0.
sch 1.0
ptext 0.0 "He\(0698)II \gl4200" 22.0 2.81 0.
ptext 0.0 "He\(0698)II \gl4541" 22.0 2.91 0.
ptext 0.0 "He\(0698)II \gl4685" 22.0 3.01 0.
ptext 0.0 "He\(0698)II \gl5411" 22.0 3.11 0.
%
ptext 0.0 "He\(0698)I \gl4009" 22.0 3.21 0.
ptext 0.0 "He\(0698)I \gl4143" 22.0 3.31 0.
ptext 0.0 "He\(0698)I \gl4388" 22.0 3.41 0.
ptext 0.0 "He\(0698)I \gl4922" 22.0 3.51 0.
ptext 0.0 "He\(0698)I \gl5047" 22.0 3.61 0.
%
ptext 0.0 "He\(0698)I \gl4026" 22.0 3.71 0.
ptext 0.0 "He\(0698)I \gl4471" 22.0 3.81 0.
ptext 0.0 "He\(0698)I \gl4713" 22.0 3.91 0.
%
% HI
ptext 0.0 "H\(0698)I \gl3797"  22.0 4.01 0.
ptext 0.0 "H\(0698)I \gl3835"  22.0 4.11 0.
ptext 0.0 "H\(0698)I \gl3889"  22.0 4.21 0.
ptext 0.0 "H\(0698)I \gl3970"  22.0 4.31 0.
%

