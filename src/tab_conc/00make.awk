{
  teff[$2,$3] += $4;
  logg[$2,$3] += $5;
  num[$2,$3]++;
}
END {
  fmt = "& %1d & %4.1f & %3.1f "


  printf "%-4s ", "O8";
  printgroups("8.0");
  printf "\\\\\n";

  printf "%-4s ", "O9";
  printgroups("9.0");
  printf "\\\\\n";

  printf "%-4s ", "O9.5";
  printgroups("9.5");
  printf "\\\\\n";

  printf "%-4s ", "O9.7";
  printgroups("9.7");
  printf "\\\\\n";

}

function printgroups(type) {
  n = num[type,1];
  t = teff[type,1];
  g = logg[type,1];
  printem(n,t,g);

  n = num[type,2] + num[type,3];
  t = teff[type,2] + teff[type,3];
  g = logg[type,2] + logg[type,3];
  printem(n,t,g);

  n = num[type,4] + num[type,5];
  t = teff[type,4] + teff[type,5];
  g = logg[type,4] + logg[type,5];
  printem(n,t,g);


}

function printem(n,t,g) {
  if (t<1) {
    printf "& & & ";
  } else {
    t = t/n;
    g = g/n;
    printf fmt, n,t/1000,g;
  }
}


