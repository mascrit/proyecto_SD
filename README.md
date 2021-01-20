Para generar el pdf, ubicarse en `./doc`
y ejecutar `make`(Se usa luatex como backend para generar el pdf).

Se requiere instalar [pygments](https://pygments.org/languages/),
[minted](https://www.overleaf.com/learn/latex/Code_Highlighting_with_minted)
para remarcar el código:
- Arch Linux
``` shell
sudo pacman -S python-pygments minted
```

- Debian
```shell
sudo apt-get install python-pygments install texlive-latex-extra # minted incluido
```

Para ejecutar podemos usar `latexmk` o el [makefile](./doc/makefile), ambos en 
la ubicación [doc/](./doc/).

```shell
latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -f main.tex
```

```shell
make
```
