MAINS = $(shell find . -maxdepth 3 -type f -name main.tex)

PDFS = $(MAINS:.tex=.pdf)

all: doc

doc: $(PDFS)

$(PDFS): %.pdf: $(dir %)/*.tex
	cd $(dir $<) && pdflatex main.tex || echo "error"

beamer.tex:
	if hue; then sed -i \
			-e "s/mDarkBrown.*/mDarkBrown\}\{RGB\}{$$(hue .18 .81 --format '{r}, {g}, {b}')}/" \
			-e "s/mDarkTeal.*/mDarkTeal\}\{RGB\}{$$(hue .18 .81 --format '{r}, {g}, {b}')}/" \
			-e "s/mLightBrown.*/mLightBrown\}\{RGB\}{$$(hue .9 --format '{r}, {g}, {b}')}/" \
			-e "s/mLightGreen.*/mLightGreen\}\{RGB\}{$$(hue .9 --format '{r}, {g}, {b}')}/" \
		beamer.tex; fi


purge:
	rm $(MAINS:.tex=.fls) || echo "fine"
	rm $(MAINS:.tex=.ist) || echo "fine"
	rm $(MAINS:.tex=.aux) || echo "fine"
	rm $(MAINS:.tex=.fdb_latexmk) || echo "fine"
	rm $(MAINS:.tex=.log) || echo "fine"
	rm $(MAINS:.tex=.lol) || echo "fine"
	rm $(MAINS:.tex=.out) || echo "fine"

clean: purge
	rm $(MAINS:.tex=.pdf) || echo "fine"

.PHONY: all purge clean
