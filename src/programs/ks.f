      PROGRAM KolmogorovSmirnov
      IMPLICIT NONE
	
      REAL D1(500), D2(500)
      INTEGER N1,N2
      REAL PROB,D,junk
      CHARACTER*50 filename1,filename2

C      WRITE (*,*) 'Input filename for distribution 4'
C      READ (*,'(A)') filename1
C      WRITE (*,*) 'Input filename for distribution 2'
C      READ (*,'(A)') filename2
      CALL GETARG(1,filename1)
      CALL GETARG(2,filename2)

      OPEN (unit=1,file=filename1,status='old')
      OPEN (unit=2,file=filename2,status='old')

      DO 10 N1=1,500
	READ (1,*,END=15) D1(N1)
10    CONTINUE
      WRITE (*,*) "Possible array overflow in D1, please check filesize"

15    DO 20 N2=1,500
	READ (2,*,END=25) D2(N2)
20    CONTINUE
      WRITE (*,*) "Possible array overflow in D2, please check filesize"

25    CONTINUE
      n1 = n1 - 1
      n2 = n2 - 1

      WRITE (*,*) N1,N2
      CLOSE(1)
      CLOSE(2)
      WRITE (*,*)
      CALL KSTWO(D1,N1,D2,N2,D,PROB)
      WRITE (*,'(A2,X,F8.6)') 'd=',D
      WRITE (*,'(A5,X,F14.12)') 'prob=',PROB
      END

      SUBROUTINE sort(n,arr)
      INTEGER n,M,NSTACK
      REAL arr(n)
      PARAMETER (M=7,NSTACK=50)
      INTEGER i,ir,j,jstack,k,l,istack(NSTACK)
      REAL a,temp
      jstack=0
      l=1
      ir=n
1     if(ir-l.lt.M)then
        do 12 j=l+1,ir
          a=arr(j)
          do 11 i=j-1,1,-1
            if(arr(i).le.a)goto 2
            arr(i+1)=arr(i)
11        continue
          i=0
2         arr(i+1)=a
12      continue
        if(jstack.eq.0)return
        ir=istack(jstack)
        l=istack(jstack-1)
        jstack=jstack-2
      else
        k=(l+ir)/2
        temp=arr(k)
        arr(k)=arr(l+1)
        arr(l+1)=temp
        if(arr(l+1).gt.arr(ir))then
          temp=arr(l+1)
          arr(l+1)=arr(ir)
          arr(ir)=temp
        endif
        if(arr(l).gt.arr(ir))then
          temp=arr(l)
          arr(l)=arr(ir)
          arr(ir)=temp
        endif
        if(arr(l+1).gt.arr(l))then
          temp=arr(l+1)
          arr(l+1)=arr(l)
          arr(l)=temp
        endif
        i=l+1
        j=ir
        a=arr(l)
3       continue
          i=i+1
        if(arr(i).lt.a)goto 3
4       continue
          j=j-1
        if(arr(j).gt.a)goto 4
        if(j.lt.i)goto 5
        temp=arr(i)
        arr(i)=arr(j)
        arr(j)=temp
        goto 3
5       arr(l)=arr(j)
        arr(j)=a
        jstack=jstack+2
        if(jstack.gt.NSTACK)pause 'NSTACK too small in sort'
        if(ir-i+1.ge.j-l)then
          istack(jstack)=ir
          istack(jstack-1)=i
          ir=j-1
        else
          istack(jstack)=j-1
          istack(jstack-1)=l
          l=i
        endif
      endif
      goto 1
      END
C  (C) Copr. 1986-92 Numerical Recipes Software "*"(',+*'(.

      FUNCTION probks(alam)
      REAL probks,alam,EPS1,EPS2
      PARAMETER (EPS1=0.001, EPS2=1.e-8)
      INTEGER j
      REAL a2,fac,term,termbf
      a2=-2.*alam**2
      fac=2.
      probks=0.
      termbf=0.
      do 11 j=1,100
        term=fac*exp(a2*j**2)
        probks=probks+term
        if(abs(term).le.EPS1*termbf.or.abs(term).le.EPS2*probks)return
        fac=-fac
        termbf=abs(term)
11    continue
      probks=1.
      return
      END
C  (C) Copr. 1986-92 Numerical Recipes Software "*"(',+*'(.

      SUBROUTINE kstwo(data1,n1,data2,n2,d,prob)
      INTEGER n1,n2
      REAL d,prob,data1(n1),data2(n2)
CU    USES probks,sort
      INTEGER j1,j2
      REAL d1,d2,dt,en1,en2,en,fn1,fn2,probks
      call sort(n1,data1)
      call sort(n2,data2)
      en1=n1
      en2=n2
      j1=1
      j2=1
      fn1=0.
      fn2=0.
      d=0.
1     if(j1.le.n1.and.j2.le.n2)then
        d1=data1(j1)
        d2=data2(j2)
        if(d1.le.d2)then
          fn1=j1/en1
          j1=j1+1
        endif
        if(d2.le.d1)then
          fn2=j2/en2
          j2=j2+1
        endif
        dt=abs(fn2-fn1)
        if(dt.gt.d)d=dt
      goto 1
      endif
      en=sqrt(en1*en2/(en1+en2))
      prob=probks((en+0.12+0.11/en)*d)
      return
      END

C  (C) Copr. 1986-92 Numerical Recipes Software "*"(',+*'(.
