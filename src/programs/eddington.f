      PROGRAM eddington


      REAL t,g,const,kf
      PARAMETER (const=5.E-16)
      PARAMETER (kf = 0.347)

      CHARACTER*80 inp

      CALL GETARG(1,inp)
      READ(inp,*,ERR=10,END=10) t

      goto 20

 10   continue
      write (*,*) "Error!"
      stop


 20   continue
      g = const * (t**4)
C      write (*,*) log(g)/log(10.)
      write (*,*) 3.25 - ((40000.-t)/1000.)*0.045

C Eddington limit from Table 2 in Lamers and Fitzpatrick, 1988ApJ 324 279
      end








