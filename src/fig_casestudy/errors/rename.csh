set pls = `ls *pls*`

foreach f ($pls)
  set new = `echo $f | sed -e 's/pls/tmp/g'`
  mv $f $new
end

foreach f (`ls *mns*`)
  set new = echo $f | sed -e 's/mns/pls/g'`
  mv $f $new
end

foreach f (ls *tmp*)
  set new = echo $f | sed -e 's/tmp/mns/g'`
  mv $f $new
end
  
