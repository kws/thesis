BEGIN{
  FS = "&";
  c=0;
  while(getline < "ian.tab") {
    for (i=1;i<=4;i++) 
      {while(gsub("^ ","",$i));while(gsub(" $","",$i));}
    styp[++c]=$1;
    styp_r[$1]=c;
    idh_n[$1] = $2;
    idh_v[$1] = $3;
    idh_r[$1] = $4;
  }
  max = c;

  FS = " ";
  st = getline < "../../fig_xcorr/cor/tausco.corr";
  if (st < 1)
    {
      print "FATAL ERROR: could not find correction factor";
      fail = 1
      exit 1;
    }
  corr = $4;
  FS = "&";
}
{
  if (fail) exit fail;
  for (i=1;i<=4;i++) 
    {while(gsub("^ ","",$i));while(gsub(" $","",$i));}
  if (styp_r[$1] < 1) 
    print "Error",$1,"does not exists in setup file";
  kws_n[$1] = $2;
  kws_v[$1] = $3;
  kws_r[$1] = $4;
}
END{
  if (fail) exit fail;
  for (c=1;c<=max;c++) {
    s = styp[c];
    split(idh_r[s],range,"--");
    if (idh_v[s] != null) {
      idh_c[s] = int(idh_v[s]/corr);
      idh_rc[s] = sprintf("%3s--%-3s",int(range[1]/corr),int(range[2]/corr));
    }
    printf "%-8s & %4s & %4s & %8s & %4s & %8s & %4s & %4s & %8s\\\\\n",
      s, 
      idh_n[s], idh_v[s],idh_r[s],
      idh_c[s],idh_rc[s],
      kws_n[s],kws_v[s],kws_r[s];
    if (c/5 == int(c/5)) print "&&&&&&&&\\\\";
  }
}

