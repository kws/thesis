      PROGRAM star

      IMPLICIT NONE

      INTEGER i

      DOUBLE PRECISION m, l, r, teff, logg, mbol1,mbol2,bc1,bc2,mv,logl
      DOUBLE PRECISION sigma,pi,g
      DOUBLE PRECISION lsol,rsol,msol

      CHARACTER*80 line

      PARAMETER ( sigma = 5.669556E-5 )
      PARAMETER ( pi = 3.14159 )
      PARAMETER ( g = 6.67E-8 )

      PARAMETER ( lsol = 3.826E33 )
      PARAMETER ( rsol = 6.9599E10 )
      PARAMETER ( msol = 1.989E33 )

C      PARAMETER ( lsol = 3.826E26 )
C      PARAMETER ( rsol = 6.9599E8 )
C      PARAMETER ( msol = 1.989E33 )

C      WRITE (*,'("Absolute magnitude > ",$)')
C      READ (*,*) mv

C      WRITE (*,'("Effective temperature (kK) > ",$)')
C      READ (*,*) teff

C      WRITE (*,'("Surface gravity (log g) > ",$)')
C      READ (*,*) logg

C      WRITE (*,*) mv,teff,logg

      CALL GETARG(1,line)

      READ(line,'(I10)',ERR=10) i

      if (i.ge.1 .and. i.le.2) goto 20
     

 10   CONTINUE
      WRITE(*,*) "ERROR!!!!! You must specify a mode!"
      WRITE(*,*) "  Type <star2 1 filename> to run in supergiant mode"
      WRITE(*,*) "  or   <star2 2 filename> to run in 'other' mode"

      GOTO 999

 20   CONTINUE
      CALL GETARG(2,line)
      OPEN(unit=11,name=line,status='old')

      WRITE(*,*) 'HD      Teff    Log(g)  Mv' //
     &  '   log(l) r/rsol m/msol  log(Teff)'

      DO WHILE(.true.)
        READ(11,'(A80)',ERR=101,END=101) line
        READ(line(8:80),*,ERR=101) teff,logg,mv
        if (i.eq.1) then
          bc1 = -0.6 - 0.08*teff
        else
          bc1 = -0.5 - 0.08*teff
        endif
C        bc2 = -0.5 - 0.08*teff
        mbol1 = mv + bc1
C        mbol2 = mv + bc2
        WRITE(*,'(A7,$)') line(1:7)
        call calc(teff,logg,mbol1,logl,r,m)
C        WRITE (*,'("L = ", F7.2)') logl
C        WRITE (*,'("R = ",F7.2)') r/rsol
C        WRITE (*,'("M = ",F7.2)') m/msol
        WRITE(*,'(7F7.2)') teff,logg,mv,logl, r/rsol, m/msol, 
     &  log(teff*1.E3)/log(10.)

C        WRITE(*,'("For other stars: ")')
C        call calc(teff,logg,mbol2,logl,r,m)
C        WRITE (*,'("L = ", F7.2)') logl
C        WRITE (*,'("R = ",F7.2)') r/rsol
C        WRITE (*,'("M = ",F7.2)') m/msol
C        WRITE(*,'(3F7.2)') logl, r/rsol, m/msol
C        WRITE (*,'()')
      END DO

 101  CONTINUE

      CLOSE(11)

C      WRITE (*,'()')
C      WRITE (*,'("L is log(L/Lsun), R is R/Rsun and M is M/Msun")')

 999  continue

      end


      subroutine calc(teff,logg,mbol,logl,r,m)

      IMPLICIT NONE

      DOUBLE PRECISION teff,logg,mbol,l,r,m,logl

      DOUBLE PRECISION sigma,pi,g
      DOUBLE PRECISION  lsol,rsol,msol
      PARAMETER ( sigma = 5.669556E-5 )
      PARAMETER ( pi = 3.14159 )
      PARAMETER ( g = 6.67E-8 )

      PARAMETER ( lsol = 3.826E33 )
      PARAMETER ( rsol = 6.9599E10 )
      PARAMETER ( msol = 1.989E33 )

C      PARAMETER ( lsol = 3.826E26 )
C      PARAMETER ( rsol = 6.9599E8 )
C      PARAMETER ( msol = 1.989E33 )
     
      logl = -0.4 * (mbol - 4.75)
      l = lsol * 10**logl
      r = sqrt (l / (4. * pi * sigma * ((teff*1.E3)**4)) )
      m = (10**logg) / (g * (r**(-2.)) )

      end























