PDF := $(patsubst %.tex,%.pdf,$(wildcard *.tex))

.PHONY: all clean backup

all: $(PDF)

$(PDF): %.pdf: %.tex
	@echo Making $@
	@pdflatex -halt-on-error $^ > /dev/null
	@pdflatex -halt-on-error $^ > /dev/null
	@pdflatex -halt-on-error $^ > /dev/null
	@pdfcrop --clip $@ $@ > /dev/null

clean: 
	rm $(shell ls | grep -v '\.tex' | grep -v Makefile)
