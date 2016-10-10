PDF := $(shell ls | sed -n 's|^\(hw[0-9]\+\.\)tex$$|\1pdf|p')
CLEAN := $(patsubst %.pdf,clean_%,$(PDF))

.PHONY: all clean $(CLEAN)

all: $(PDF)

.SECONDEXPANSION:

$(PDF): %.pdf: %.tex hw.sty $$(shell sed -n 's/\\input{\(.*\)}/\1/gp' %.tex)
	@pdflatex -interaction=batchmode $* > /dev/null && \
	pdflatex -interaction=batchmode $* > /dev/null || \
	echo -e "\033[0;31mCompilation failed\033[0m"
	@awk '/Warning/{a=1}/^$$/{a=0}a' $*.log | sed "s/.*Warning.*/\x1b[33m&\x1b[0m/"
	@awk '/^!/{a=1}/}$$/{print;a=0}a' $*.log | sed "s/^!.*/\x1b[31m&\x1b[0m/"

clean:
	@rm -fv *.aux *.toc *.out *.log *.nav *.snm *.bbl *.blg *.bcf *.run.xml $(PDF)

$(CLEAN): clean_%:
	@rm -fv $*.aux $*.log $*.out $*.pdf

