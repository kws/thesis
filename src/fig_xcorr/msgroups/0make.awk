BEGIN{
  FIELDLENGTHS = "18 5 5 5 5 5";
# Read and store adopted velocities
  CORRFILE = "/mnt/bstars/vsini/vsini.op.corr";
  while (getline < CORRFILE) {
    split($1,catarr,"_");
    hd = catarr[1];gsub("[A-z]","",hd);hd = int(hd);
    best = $6;
    best++;
    vel = $best;

    if (vel > 0 && vel < 600) {
       vels_c[hd] += vel;
      nums[hd]++;
    }
  }
  for (hd in vels_c) {
    vels_c[hd] = int(vels_c[hd]/nums[hd]);
#    print hd,vels_c[hd];
  }
}

{
  FS = "|";
  # Only interested in B main-sequence stars

  if ($4 != "B") next;
  if ($6 != "  V" && $6 != " IV"  && $7 != "e") next;
  hd = $1;while(gsub("^ ","",hd));while(gsub(" $","",hd));
  st = $5; # subtype

  if (vels_c[hd] <= 0 || vels_c[hd] > 600) next;

  if ($6 == "  V" || $6 == " IV") {
    if (st < 2) gr = 1;
    else if (st < 4) gr = 2;
    else if (st < 7) gr = 3;
    else gr = 4;
    
    if ($7 != "e") {
      printf "%4d %6d %s\n",vels_c[hd],hd,$2 > "vsini_gr"gr".dat";
    } else { 
      printf "%4d %6d %s\n",vels_c[hd],hd,$2 > "vsini_e.dat";
    } 
  }
}
