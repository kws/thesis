BEGIN{
  diffsum = 0;
  r = 0;
}
{
  diff = $1 - $2;

  d = sqrt(diff^2);
 
  if (d != 379) {
    p = (100*d)/(2*$1);
    psum += p;

    sqrsum += (diff/2)^2;
  
#    print $1,$2,diff,p;
    num++;
  }
}
END{
  print psum/num,"% or ",sqrt(sqrsum/num),"km/s";
}
