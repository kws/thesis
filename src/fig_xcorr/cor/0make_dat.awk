BEGIN {
 FILL = 1
 LIM = 1.5
   }
{
  STAR = $1
  RAT = $3/$5
  TYPE = 20
  ANG = 0
  if (RAT > LIM) {
    TYPE = 3
    ANG = 0
      }
  RAT = $5/$3
  if (RAT > LIM) {
    TYPE = 3
    ANG = 180
      }
  RAT = $3/$5
  print "%"STAR
  print "angle " ANG
  print "dot "$2, $4, FILL, TYPE
  }
