!Normalised Cumulative Distribution
!Run 'stats' first to create files
!fig5 in paper

paper 2000 1000
page
scf 2

vport 0.1 0.9 0.1 0.9

window 0 500 0 .6

sch 1.3
mtext "B" 2 0.5 0.5 "\fiv\fr\de\usin\fii\fr (km s\u-1\d)"
mtext "L" 2 0.5 0.5 "\fiN\fr/\fiN\fr\dTOT"
sch 1.0

sls 1
data dist_BIe.dat
xcolum 1
ycolum 3
bin t

slw 3
data dist_BIl.dat
xcolum 1
ycolum 3
bin t

slw 1
sls 4
data dist_BVe.dat
xcolum 1
ycolum 3
bin t

slw 3
data dist_BVl.dat
xcolum 1
ycolum 3
bin t
slw 1

sls 1
move 150 .545
draw 200 .545
slw 3
move 150 .505
draw 200 .505
slw 1
sls 4
move 150 .465
draw 200 .465
slw 3
move 150 .425
draw 200 .425
slw 1

sls 1
ptext 0.0 "Early type B supergiants" 210 .54 0
ptext 0.0 "Late type B supergiants" 210 .50 0
ptext 0.0 "Early type B dwarfs" 210 .46 0
ptext 0.0 "Late type B dwarfs" 210 .42 0

sls 2
sls 1

box nbcst 100 5 nbcst 0 0

!NEXT WINDOW
advanc

window 0 500 0 1

box nbcst 100 5 nbcst 0 0

sch 1.3
mtext "B" 2 0.5 0.5 "\fiv\fr\de\usin\fii\fr (km s\u-1\d)"
mtext "L" 2 0.5 0.5 "\fiN\fr/\fiN\fr\dTOT"
sch 1.0

data cdist_BIe.dat 
xcol 1
ycol 3
conect

slw 3
data cdist_BIl.dat 
xcol 1
ycol 3
conect

slw 1
sls 4
data cdist_BVe.dat 
xcol 1
ycol 3
conect

slw 3
data cdist_BVl.dat 
xcol 1
ycol 3
conect

slw 1
sls 1
move 200 .21
draw 250 .21
slw 3
move 200 .16
draw 250 .16
slw 1
ptext 0.0 "Early B supergiants" 260 .2 0
ptext 0.0 "Late B supergiants" 260 .15 0

sls 4

move 200 .11
draw 250 .11
slw 3
move 200 .06
draw 250 .06
slw 1
ptext 0.0 "Early B dwarfs" 260 .1 0
ptext 0.0 "Late B dwarfs" 260 .05 0

sls 1
