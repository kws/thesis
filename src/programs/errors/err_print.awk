BEGIN{
  lmin = 9999;
  lmax = 0;
  rmin = 9999;
  rmax = 0;
  mmin = 9999;
  mmax = 0;
}
{
  if ($1 != "HD") { 
    l = $4;
    r = $5;
    m = $6;
    lmin=l<lmin?l:lmin;
    lmax=l>lmax?l:lmax;
    rmin=r<rmin?r:rmin;
    rmax=r>rmax?r:rmax;
    mmin=m<mmin?m:mmin;
    mmax=m>mmax?m:mmax;
  }
}
END {
  print "L: ", lmin,lmax, "+/-", (lmax-lmin)/2
  print "R: ", rmin,rmax, "+/-", (rmax-rmin)/2;
  print "M: ", mmin,mmax, "+/-", (mmax-mmin)/2;
}
