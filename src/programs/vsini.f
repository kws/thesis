      PROGRAM v

      IMPLICIT NONE

      INTEGER i, nmax,nm
      PARAMETER (nmax=100)
      REAL fwhm(nmax),vsini(nmax),y2(nmax)
      REAL inpFWHM,inpVSINI

      CHARACTER*80 func,xarx

      CALL GETARG(1,func)
      CALL GETARG(2,xarx)
      READ(xarx,*,ERR=10,END=10) inpFWHM

      goto 20

 10   write (*,*) "Blah! Didn't understand that..."
      write (*,*) "Usage: vsini broadfunc FWHM"
      stop

 20   continue


      do i = 1, nmax
         open(unit=10,file=func,status='old')
         read(10,*,end=100) vsini(i),fwhm(i)
      enddo

 100  continue
      nm = i - 1

C      call sort2(nm,fwhm,vsini)

C      write (*,*) (vsini(i),i=1,nm)
C      write (*,*) (fwhm(i),i=1,nm)

      call spline(fwhm,vsini,nm,0,0,y2)
      call splint(fwhm,vsini,y2,nm,inpFWHM,inpVSINI)          

      write (*,*) inpFWHM,inpVSINI

      end







