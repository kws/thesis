BEGIN{binsize = 25;maxbin=600/binsize}
{ 
  thisbin = int($1/binsize);
  bin[thisbin]++;
  num++;
}
END{
  for (i=0;i<=maxbin;i++) 
    {
      if (bin[i] == null) bin[i] = 0;
      printf "%5.1f %2d %5.4f\n", i*binsize+(binsize/2),bin[i],bin[i]/num;
    }
}

function sort(arr,max) {
  for (i1=1;i1<=max;i1++) {
    for (i2=i1+1;i2<=max;i2++) {
      if (arr[i1] > arr[i2]) {
        tmp = arr[i2];
	arr[i2] = arr[i1];
	arr[i1] = tmp;
      }
    }
  }
}



