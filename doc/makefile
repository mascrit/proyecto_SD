
make:
	lualatex -shell-escape -interaction nonstopmode  main.tex &&\
	latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -f main.tex

clean:
	rm -rf -- main.aux main.fdb_latexmk main.fls main.lol main.out main.pdf main.toc .auctex-auto texput.log

# end
