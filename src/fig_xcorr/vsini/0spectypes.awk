BEGIN{
  FS = "|"
}
{
  HD = $1
  ref = $2
  inp = split($3,typearr,"_")
  gsub("[a-z]","",typearr[1])
  bigtype = substr(typearr[1],2,1)
  rest = $4
  subtype = sprintf("%3.1f",typearr[2])
  subtype = gensub(".0","","g",subtype)

  rest = substr(typearr[3],1,3)

  if (rest == "III")
    { lc = "III" } 
  else if (substr(rest,1,2) == "II")
    { lc = "II" }
  else if (substr(rest,1,2) == "IV")
    { lc = "IV" }
  else if (substr(rest,1,1) == "I")
    {lc = "I"}
  else if (substr(rest,1,1) == "V")
    {lc = "V"}
  else {lc = "?"}

# Check for emission stars
  if (index($0,"e") != 0 && index($0,"He") == 0)
  { em = "e" } else { em = " "}

  type[bigtype]++
  if (bigtype == "B") {
    stype[subtype]++
    ltype[lc]++
  }
#  printf "%s|%1s|%3s|%3s|%1s|\n", $0,bigtype,subtype,lc,em

  if (lc=="II") lc = "I"
  if (lc=="IV") lc = "V"

  if (subtype >=5)
    {subtype = "l"}
  else 
    {subtype = "e"}
  endif

  if (lc != "?") {
    printf "%-30s | %s%s%s |\n", $0,bigtype,lc,subtype
  }
}









