FILE	= course

all:
	vi $(FILE).Rmd
	make knit

knit:
	echo "library(knitr); knit2html(\"$(FILE).Rmd\", options = c(getOption(\"markdown.HTML.options\"), \"toc\"))" | R --save -q
	cp course.html index.html

view:
	google-chrome $(FILE).html

www:
	scp $(FILE).html epebe_01@ifgifiles.uni-muenster.de:WWW/R
