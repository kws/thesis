BEGIN {
 FILL = 1
 LIM = 1.5
   }
{
  # Y larger than X
  RAT = $5/$3
  TYPE = 20
  ANG = 0
  if (RAT > LIM) {
    TYPE = 3
    ANG = 0
      }
  # X larger than Y (default triangle points up)
  RAT = $3/$5
  if (RAT > LIM) {
    TYPE = 3
    ANG = 180
      }
  print "%"$0
  print "angle " ANG
  print "dot "$2, $4, FILL, TYPE
  }
