{
  num = $2
  err = $4

  max = num + err
  min = num - err

  lnum = log(num)/log(10)
  lerr = ((log(max)/log(10))-(log(min)/log(10)))/2

  print $1,lnum,"+/-",lerr
  }
