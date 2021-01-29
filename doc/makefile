
make:
	lualatex -shell-escape -interaction nonstopmode main.tex ;\
	makeglossaries main ;\
	lualatex -shell-escape -interaction nonstopmode main.tex
clean:
	rm -rf -- main.aux main.fdb_latexmk main.fls main.lol main.out main.pdf main.toc .auctex-auto texput.log

# end
