BEGIN {FS = "|"}
{
  gr = "?"
  if ($6 == "  V" || $6 == " IV") gr = "V"
  if ($6 == "  I" || $6 == " II") gr = "I"
  if ($5 >= 5)
    { ty = "l" } else {ty = "e"}

  if ($4 == "B" && gr != "?") 
  printf "hd%06d %s%s%s %s\n", $1, $4, gr, ty, $2
}
