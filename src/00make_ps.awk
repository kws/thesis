BEGIN {
  FS = "{";

  if (DIR == "") {
    fail = 1;
    print "Bollox - you have to specify the DIR variable";
    exit;
  }

  c = 1;
  pbeg[c] = 1;
  tit[c] = "PRE";
}
{
  if (fail) exit;
  if ($3 == "\\numberline ") {
    split($4,arr,"}");
    chap = arr[1];
    split($5,arr,"}");
    page = arr[1];

    pend[c] = page-1;
    c++;
    pbeg[c] = page;
    if (int(chap) == chap) type = "CH"; else type = "AP";
    tit[c] = sprintf("%s%s",type,chap);
  } else if ($3 == "Bibliography}") {
    split($4,arr,"}");
    page = arr[1];    

    pend[c] = page -1;
    c++;
    pbeg[c] = page;
    tit[c] = "BIB";
  }

}
END {
  if (fail) exit;
  for (i=1;i<c;i++) {
    com1 = "dvips -Z -D 600 -pp "
    com2 = sprintf("%d-%d -o %s/%02d%s.PS thesis",pbeg[i],pend[i],DIR,i,tit[i]);
    comm = com1 com2;
    print comm;
    system(comm);
  }
  com1 = "dvips -Z -D 600 -p "
  com2 = sprintf("%d -o %s/%02d%s.PS thesis",pbeg[i],DIR,i,tit[i]);
  comm = com1 com2;
  print comm;
  system(comm);
  
}
