# Program definitions

TEX = 	latex
DVIPS = dvips
XDVI = 	xdvi
GS = 	ghostview
LPR = 	lpr -Psys_laser2

TEXFILES1 := $(shell find . -name '*.tex')
PSFILES := $(TEXFILES1:.tex=.ps)
TEXFILES = $(filter-out ./thesis.tex, $(TEXFILES1) )
APPDIRS := $(wildcard fig_app*)
FIGDIRS := $(wildcard fig_*)

DATE := $(shell date +%m%d)

OS := $(shell uname -s)

ifeq ($(OS), Linux)
  APPEX := --exclude fig_app\*
  FIGEX := --exclude fig_\*
else
  APPEX := $(foreach JUNK,$(APPDIRS),-e $(JUNK))
  FIGEX := $(foreach JUNK,$(FIGDIRS),-e $(JUNK))
endif



%.ps: %.dvi
	$(DVIPS) $<

%.gs: %.ps
	$(GS) $<

%.lpr: %.ps
	$(LPR) $<

%.xdvi: %.dvi
	$(XDVI) $<

%.x: %.xdvi

all: thesis.dvi
	checkfigs.csh

test:
	@echo Exclude is $(APPEX)
	@echo and $(FIGEX)

thesis.tex: $(TEXFILES)
	-@touch thesis.tex

thesis.q: thesis.tex
	$(TEX) thesis

thesis.dvi: thesis.tex
	$(TEX) thesis
	bibtex thesis
	$(TEX) thesis
	$(TEX) thesis
	$(TEX) thesis

tar: clean fig
	tar -cv $(FIGEX) -f - . | gzip > ../thesis$(DATE).tgz

fig:
	tar -cv $(APPEX) -f - fig_* | gzip > ../figs$(DATE).tgz

tar_app: fig_app

fig_app:
	tar -cvf - fig_app* | gzip > /dosf/figs_app_$(DATE).tgz

clean:
	-$(RM) $(shell find . -name '*.aux')
	-$(RM) $(shell find . -name '*~')        
	-$(RM) *.toc *.dvi *.log *.lof *.lot *.bbl *.blg *.tar.* *.tgz
	-$(RM) $(PSFILES)
	-$(MAKE) -C programs clean

