BEGIN {oldnum = -99}
{
 if ($1 != oldnum) {
   if (oldnum != -99) {
     if (oldnum == int(oldnum)) {
       printf "%1d   ", oldnum
     } else {
       printf "%3.1f ",oldnum
     }
     median(arr,1,c-1)
     printf "%2d %d--%d\n", c-1, arr[1], arr[c-1]
   }
   c = 1
 } 
 arr[c++] = $2
 oldnum = $1
}




function median(arr,min,max) {
  sort(arr,min,max)
#  while (arr[min] == 0) {min++;sort(arr,min,max)}
  half = (max-min)/2 + min
  if (half != int(half)) {
    med = (arr[int(half-0.5)] + arr[int(half+0.5)])/2
      }else{
    med = arr[half]
      }
  printf "%4d ", med
}

function sort(arr,min,max) {
  for (c1=min;c1<=max;c1++) {
    for (c2=c1+1;c2<=max;c2++) {
      tmp1 = arr[c1] 
      tmp2 = arr[c2]
      if (tmp1 <= tmp2) {
        arr[c1]=tmp1;arr[c2]=tmp2
                       } else {
        arr[c1]=tmp2;arr[c2]=tmp1
      }
    }
  }
}
