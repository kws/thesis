vport 0.1 0.9 0.1 0.9

scf 2
sch 1.25

window 3782 3814 0.9 1.03
box bcnst 0 0 bcnst 0 0


mtext L 3 0.5 0.5 "Intensity"
mtext B 3 0.5 0.5 "Wavelength (\A)"

sch 0.75

ptext 0.0 "\fiT\fr\deff\u = 38000 K, log\fig\fr = 4.2, \fiy\fr = 0.09" 3783 1.02 0.0


sls 1
move 3783 1.015
draw 3785 1.015
ptext 0.0 " \fiv\de\u\frsin\fii\fr = 30 km/s" 3786 1.015 0.0

sls 2
move 3783 1.01
draw 3785 1.01
ptext 0.0 " \fiv\de\u\frsin\fii\fr = 100 km/s" 3786 1.01 0.0

sch 1.0


sls 1
rdsdf t38g42r30y09
conect

sls 2
rdsdf t38g42r100y09
conect

sls 1




