all: interp


interp: interp.o sort2.o spline.o splint.o
	$(FC) -O -o interp \
	       interp.o sort2.o spline.o splint.o  
	strip interp

lincor: lincor.o pearsn.o betai.o gammln.o betacf.o spear.o \
        crank.o erfcc.o sort2.o kendl1.o
	$(FC) -O -o lincor lincor.o pearsn.o betai.o \
	       gammln.o betacf.o crank.o erfcc.o sort2.o \
	       spear.o kendl1.o
	strip lincor


vsini: vsini.o sort2.o spline.o splint.o
	$(FC) -O -fno-second-underscore -o vsini \
	       vsini.o sort2.o spline.o splint.o  
	strip vsini
clean:
	-$(RM) *.o
	-$(RM) star2 interp lincor vsini eddington flow ks


