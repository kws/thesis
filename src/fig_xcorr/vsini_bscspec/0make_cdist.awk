BEGIN{c = 0}
{ 
  v[++c] = $1
}
END{
  max = c
  sort(v,max)
  for (c=1;c<=max;c++) {
    print v[c],(c-1),(c-1)/max
    print v[c],c,c/max
  }
}

function sort(arr,max) {
  for (i1=1;i1<=max;i1++) {
    for (i2=i1+1;i2<=max;i2++) {
      if (arr[i1] > arr[i2]) {
        tmp = arr[i2]
        arr[i2] = arr[i1]
        arr[i1] = tmp
      }
    }
  }
}



