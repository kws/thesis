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
    l = $5;
    r = $6;
    m = $7;
    lmin=l<lmin?l:lmin;
    lmax=l>lmax?l:lmax;
    rmin=r<rmin?r:rmin;
    rmax=r>rmax?r:rmax;
    mmin=m<mmin?m:mmin;
    mmax=m>mmax?m:mmax;
  }
}
END {
  if (debug > 0) {
    print "L: ", lmin,lmax, "+/-", (lmax-lmin)/2;
    print "R: ", rmin,rmax, "+/-", (rmax-rmin)/2;
    print "M: ", mmin,mmax, "+/-", (mmax-mmin)/2;
  } else {
    printf "%3.1f %2.0f %2.0f\n", (lmax-lmin)/2, (rmax-rmin)/2, (mmax-mmin)/2;
  }
}
