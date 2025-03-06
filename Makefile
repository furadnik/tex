MAIN = main
TEX_FILES = $(shell find . -type f -name '*.tex')

$(MAIN).pdf: $(MAIN).tex $(TEX_FILES)
	lualatex $(MAIN).tex
	bibtex $(MAIN) || echo "no references"
	lualatex $(MAIN).tex
	lualatex $(MAIN).tex

beamer.tex:
	if hue; then sed -i \
			-e "s/mDarkBrown.*/mDarkBrown\}\{RGB\}{$$(hue .18 .81 --format '{r}, {g}, {b}')}/" \
			-e "s/mDarkTeal.*/mDarkTeal\}\{RGB\}{$$(hue .18 .81 --format '{r}, {g}, {b}')}/" \
			-e "s/mLightBrown.*/mLightBrown\}\{RGB\}{$$(hue .9 --min_contrast AAA --format '{r}, {g}, {b}')}/" \
			-e "s/mLightGreen.*/mLightGreen\}\{RGB\}{$$(hue .9 --min_contrast AAA --format '{r}, {g}, {b}')}/" \
		beamer.tex; fi


purge:
	rm $(MAIN).fls || echo "fine"
	rm $(MAIN).ist || echo "fine"
	rm $(MAIN).aux || echo "fine"
	rm $(MAIN).fdb_latexmk || echo "fine"
	rm $(MAIN).log || echo "fine"
	rm $(MAIN).lol || echo "fine"
	rm $(MAIN).out || echo "fine"

clean: purge
	rm $(MAIN).pdf || echo "fine"

.PHONY: all purge clean beamer.tex
