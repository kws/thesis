BEGIN{
  if (mode == "he2") {
    c = 0;
  } else {
    c = 100;
  }
}
{
  if (mode == "he2") {
    if (ypos == null) ypos = 4.5;
    ypos = 4.55;
    if ($2 == "Equivalent") {
      if (xstart > 28 && xstart < 39.8) 
	print "ptext 0.0 \""c" m\\A\"",xstart,ypos,330;
      xstart = null;
      c += 100;
    } else if ($1 == "draw") {
      xstart = $2*1000;
    }
  } else {
    if (xpos == null) xpos =$1;
    if ($2 > 2.6 && $2 < 4.4) print "ptext 0.0 \""c" m\\A\"",xpos,$2,0.0;
    c += 100;
  }
}



