paper 1200 1500
scf 2
sch 1

vport 0.1 0.9 0.28 0.9
window 0 499.9 0 500
box bcst 0 0 bcnst 0 0
mtext L 2.5 0.5 0.5 "Slettebak \fiv\fr\de\u sin\fii\fr (km s\u-1\d)"
!mtext B 2.5 0.5 0.5 "Auto \fiv\fr\de\u sin\fii\fr (km s\u-1\d)"

sls 2
move 0 0
draw 500 500
sls 1

data vslet_1.dat
xcol 1
ycol 2
kpoint 1 3
data vslet_2.dat
xcol 1
ycol 2
kpoint 1 4
data vslet_3.dat
xcol 1
ycol 2
kpoint 1 5
data vslet_4.dat
xcol 1
ycol 2
kpoint 1 6

sch 0.75
ptext 0.0 "HD 142983" 30  396 0.0
sch 1.0

window 0 470 20 500

ptext 0.0 "\gt Sco" 410 100 0.0
ptext 0.0 "\gi Her" 410 80 0.0
ptext 0.0 "\gp Cet" 410 60 0.0
ptext 0.0 "\ga Lyr" 410 40 0.0

dot 400 102 1 3
dot 400  82 1 4
dot 400  62 1 5
dot 400  42 1 6

vport 0.1 0.9 0.1 0.28
window 0 499.9 -0.5 0.5
box bcnst 0 0 bcmst 0 0
mtext R 2.5 0.5 0.5 "log (\fiv\fr\dS\u/\fiv\fr\dA\u)"
mtext B 2.5 0.5 0.5 "Auto \fiv\fr\de\u sin\fii\fr (km s\u-1\d)"

sch 3.4
data vslet_1.rat
xcol 1
ycol 2
kpoint 1 3
data vslet_2.rat
xcol 1
ycol 2
kpoint 1 4
data vslet_3.rat
xcol 1
ycol 2
kpoint 1 5
data vslet_4.rat
xcol 1
ycol 2
kpoint 1 6

sls 2
move 0 0
draw 500 0
sls 1





