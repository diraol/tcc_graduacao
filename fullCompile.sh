#!/bin/bash
function makeTable() {
  if [ ! -f tabRequisitos.aux ]
  then
    echo "RF2 & Realizar login \\\\" > tabRequisitos.aux
    #echo "RF3 & Realizar login social \\" >> tabRequisitos.aux
  fi
  cat tabRequisitos.aux | sed -e 's@^\([a-zA-Z0-9]*\)@\\hyperlink{\1}{\1}@' > tabRequisitos2.aux
}

makeTable
pdflatex monografia.tex || { exit 1; }
bibtex monografia || { exit 1; }
makeglossaries monografia || { exit 1; }
makeTable
pdflatex monografia.tex || { exit 1; }
makeTable
pdflatex monografia.tex || { exit 1; }

