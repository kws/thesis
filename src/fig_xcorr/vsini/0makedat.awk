BEGIN{FS ="|"}
{
  gsub(" ","",$4)
  print "Working on",$1
  if ($4 == "BIe" || $4 == "BIl" ||
      $4 == "BVe" || $4 == "BVl") print $5, $1, $3 > "vsini_"$4".dat"
}
 
