BEGIN{
  FIELDLENGTHS = "18 5 5 5 5 5";
# Read and store adopted velocities
#  CORRFILE = "/mnt/bstars/vsini/vsini.op.corr";
  while (getline < CORRFILE) {
    split($1,catarr,"_");
    hd = catarr[1];gsub("[A-z]","",hd);hd = int(hd);
    best = $6;
    best++;
    vel = $best;

    if (vel != 0 && vel < 600) {
       vels_c[hd] += vel;
      nums[hd]++;
    }
  }
  for (hd in vels_c) {
    vels_c[hd] = vels_c[hd]/nums[hd];
#    print hd,vels_c[hd];
  }

# Read in the different swps
#  VSINIFILE = "/mnt/bstars/vsini/vsini.op";
  while (getline < VSINIFILE) {
    split($1,catarr,"_");
    hd = catarr[1];gsub("[A-z]","",hd);hd = int(hd);
    if (swps[hd] == null) {
      swps[hd] = 1;
    }else{
      swps[hd]++;
    }
    tmp = catarr[2];gsub("[A-z]","",tmp);tmp = int(tmp);
    swpnum[hd,swps[hd]] = tmp;
    bestvel[hd,swps[hd]] = $6;
    for (t=1;t<=4;t++) vels[hd,swps[hd],t] = $(t+1);
  }
#  for (hd in swps) {
#    print hd, "has",swps[hd],"swps";
#    for (s=1;s<=swps[hd];s++)
#      for (t=1;t<=4;t++) print vels[hd,s,t];
#  }
}

{
  FS = "|";
  hd = $1;while(gsub("^ ","",hd));while(gsub(" $","",hd));

# Get next record if the star is a binary, or it doesn't exists
# in the current dataset
  if (substr(hd,10,1)!="") next;
  gsub("[A-z]","",hd);hd=int(hd);
  if (swps[hd] < 1) next;

  sp = $2;while(gsub("^ ","",sp));while(gsub(" $","",sp));
  vel = $4;
  gsub(":","",vel);

  if (vel > 0) {
    printf "%6d & %-20s & %3d & %5d &",
      hd,sp,vel,swpnum[hd,1];
  }else{
    printf "%6d & %-20s &\\ldots& %5d &",
      hd,sp,swpnum[hd,1];
  }
  for (t=1;t<=4;t++) {
    if (vels[hd,1,t] > 0 && vels[hd,1,t] < 600) {
      if (bestvel[hd,1]==t) flag = "\\textbf"; else flag = "";
      printf "%7s{%3d} &", flag, vels[hd,1,t];
    } else {
      printf "\\ldots       &";
    }
  }
  printf "%3.0f \\\\ \n", vels_c[hd];
  for (s=2;s<=swps[hd];s++) {
    printf "%6s & %20s & %3s & %5d &", "","","",swpnum[hd,s];
    for (t=1;t<=4;t++) {
      if (vels[hd,s,t] > 0 && vels[hd,s,t] < 600) {
	if (bestvel[hd,s]==t) flag = "\\textbf"; else flag = "";
	printf "%7s{%3d} &", flag, vels[hd,s,t];
      } else {
	printf "\\ldots       &";
      }
    }
    printf "    \\\\ \n";
  }
}


  


