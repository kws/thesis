BEGIN{
  MINVEL = 20;


  FIELDLENGTHS = "18 5 5 5 5 5";
# Read and store adopted velocities
  CORRFILE = "/mnt/bstars/vsini/vsini.op.corr";
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
    vels_c[hd] = sprintf("%3.0f",vels_c[hd]);
  }

# Read in reference preference... :)
  FS = " ";
  PREFILE = "/mnt/bstars/spec/ref.pref";
  c = 0;
  while (getline < PREFILE) {
    ref = $2;while(gsub("^ ","",ref));while(gsub(" $","",ref));
    prefref[ref]=c++;
  }

  FS = "|";
# Read proper spectral types
  SPFILE = "/mnt/bstars/spec/spectypes.ref";
  while (getline < SPFILE) {
    hd = $1;gsub("[A-z, ]","",hd);hd=int(hd);
    split($3,tmparr,"_");
    ref = $2;while(gsub("^ ","",ref));while(gsub(" $","",ref));
    spec = sprintf("%s%s %s%s",tmparr[1],tmparr[2],tmparr[3],tmparr[4]);
    if (gspec[hd] != null) {
#      print "Multiple: ",hd;
      if (prefref[ref] < prefref[gspecr[hd]]) {
#	print "Replacing", gspecr[hd], "with",ref;
	gspec[hd]=spec;
	gspecr[hd]=ref;	
      } else {
#	print "Prefering",gspecr[hd], "to",ref ;
      }
    } else {
      gspec[hd]=spec;
      gspecr[hd]=ref;
    }
  }

# Read in BSC spectral types
  BSCFILE = "/mnt/bstars/cats/bsc5/bsc5.asc.sptype";
  while (getline < BSCFILE) {
    hd = $1;gsub("[A-z, ]","",hd);hd=int(hd);
    if($4 == "B") {
      bspec[hd]=$2;while(gsub("^ ","",bspec[hd]));while(gsub(" $","",bspec[hd]));
#      print hd,bspec[hd];
      # Read in binary info
      if (substr($8,1,2) == "SB") {
        bsSB2[hd]=$8;
	while(gsub("^ ","",bsSB2[hd]));while(gsub(" $","",bsSB2[hd]));
	if (bsSB2[hd] != "SB") bsSB2[hd] = substr(bsSB2[hd],3); 
      }
    }
  }
  FS = " ";
}


{
  id = $1;
  split(id,idarr,"_");
  hd = idarr[1];gsub("[A-z]","",hd);hd=int(hd);
  swp = idarr[2];gsub("[A-z]","",swp);swp=int(swp);
  for(t=1;t<=4;t++) vels[t] = $(t+1);
  best = $6;

  if (hd == lasthd) {
    phd = "";
    sp1 = "";
    spr = "";
    sp2 = "";
    avel = "";
    SB2 = "";
  } else {
    phd = hd;
    sp1 = gspec[hd];
    spr = gspecr[hd];
    sp2 = bspec[hd];
    avel = vels_c[hd];
    if (avel == "") avel = "\\ldots";
    SB2 = bsSB2[hd];
  }
  
  ##### Long spectral types....
  comm = "";
  if (length(sp1) > 13) {
    comm = comm sprintf("%s spectral type is %s. ", spr, sp1);
    sp1 = sprintf("%s\\ldots *",substr(sp1,1,6));
  }
  if (length(sp2) > 13) {
    comm = comm sprintf("BSC spectral type is %s.", sp2);
    sp2 = sprintf("%s\\ldots *",substr(sp2,1,6));
  }
  if (comm != "")
    printf ("\\emph{HD %d}. %s\\\\\n",hd,comm) > "comments.tex";

  printf "%6s & %-10s & %3s & %-10s &%2s& %6d &", 
    phd, sp1, spr, sp2, SB2,  swp;

  for (t=1;t<=4;t++) {
    if (best==t) flag = "\\textbf";else flag="";
    if (vels[t] > 600 || vels[t] == 0) v="\\ldots";
    else if (vels[t]<=MINVEL) v=flag"{$\\leq$ "MINVEL"}";
    else v = flag"{"vels[t]"}";
    printf "%-16s&",v;
  }

  if (hd != lasthd) {
    if (int(avel)<=MINVEL && avel != "\\ldots") {
      printf "$\\leq$%3s",MINVEL;
    } else {
      printf "%3s",avel;
    }
  }
  printf "\\\\\n";

  lasthd = hd;

}



  


