BEGIN { FIELDLENGTHS = "18 5 5 5 5 5" }
{ 
  split($1,catarr,"_")
  hd = catarr[1]

  best = $6
  best++
  vel = $best

  if (vel > 0 && vel < 600) {
    vels[hd] += vel
    nums[hd]++
  }
}
END {
  for (hd in vels) {
    print hd,int(vels[hd]/nums[hd])
      }
}
