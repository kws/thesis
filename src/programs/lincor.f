      PROGRAM lincor

C     reads x and y column data from standard input
C     and calculates the linear correlation coefficient

      IMPLICIT none

      INTEGER maxpt
      PARAMETER (maxpt=100)
      REAL x(maxpt),y(maxpt)
      REAL work1(maxpt),work2(maxpt)
      INTEGER i,npt
      REAL r,prob,z,tau           !r - correlation coeff, prob and z other stat. vals.
      REAL d,zd,probd,rs,probrs

      do i=1,maxpt
         READ (*,*,ERR=101,END=101) x(i),y(i)
C        WRITE (30,*) i,x(i),y(i)
      enddo

 101  continue

      npt = i-1
C     write(30,*) "Read ",npt," points"

      call pearsn(x,y,npt,r,prob,z)

      write (*,*) "Pearson: ", r, prob

      call spear(x,y,npt,work1,work2,d,zd,probd,rs,probrs)
 
      write (*,*) "Spearman: ",d,probd,rs,probrs

      call kendl1(x,y,npt,tau,zd,prob)

      write (*,*) "Kendall: ",tau,zd,prob

      END
