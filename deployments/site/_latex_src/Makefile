OUTDIR=out
LATEXS=$(wildcard *.tex)
HTMLS=$(patsubst %.tex,$(OUTDIR)/%.html, $(LATEXS))

.PHONY : all files dir

all   : dir files
files : $(HTMLS)
dir   : $(OUTDIR)

$(OUTDIR) :
	mkdir $(OUTDIR)
	cp * $(OUTDIR)

$(OUTDIR)/%.html : %.tex $(TXTDIR)
	pandoc -f latex -t html -s $< -o $@
