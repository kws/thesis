paper 1200 1500
scf 2
sch 1

vport 0.1 0.9 0.28 0.9
window 0 499.9 0 500
box bcst 0 0 bcnst 0 0
mtext L 2.5 0.5 0.5 "MNRAS \fiv\fr\de\u sin\fii\fr (km s\u-1\d)"
!mtext B 2.5 0.5 0.5 "Auto \fiv\fr\de\u sin\fii\fr (km s\u-1\d)"

sls 2
move 0 0
draw 500 500
sls 1

data idhcomp_1.dat
xcol 1
ycol 2
kpoint 1 20

data idhcomp_2.dat
xcol 1
ycol 2
kpoint 2 20


sch 0.75
ptext 0.0 "HD 219188"  288   193 0.0
ptext 0.0 "HD 75759 (SB2)" 132  46.5 0.0
sch 1.0


vport 0.1 0.9 0.1 0.28
window 0 499.9 -0.5 0.5
box bcnst 0 0 bcmst 0 0
mtext R 2.5 0.5 0.5 "log (\fiv\fr\dMNRAS\u/\fiv\fr\dA\u)"
mtext B 2.5 0.5 0.5 "Auto \fiv\fr\de\u sin\fii\fr (km s\u-1\d)"

sch 3.4
data idhcomp_1.rat
xcol 1
ycol 2
kpoint 1 20
data idhcomp_2.rat
xcol 1
ycol 2
kpoint 2 20

sls 2
move 0 0
draw 500 0
sls 1

sls 4
data tausco.corr
xcol 1,ycol 2
conect
sls 3
data iother.corr
xcol 1,ycol 2
conect
sls 1
