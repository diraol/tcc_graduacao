#!/bin/bash
function makeTable() {
  # requisitos funcionais
  if [ ! -f tabRequisitosFunc.aux ]
  then
    echo "RF2 & Realizar login \\\\" > tabRequisitosFunc.aux
  fi
  cat tabRequisitosFunc.aux | sed -e 's@^\([a-zA-Z0-9]*\)@\\hyperlink{\1}{\1}@' > tabRequisitosFunc2.aux
  # requisitos não funcionais
  if [ ! -f tabRequisitosNFunc.aux ]
  then
    echo "RF2 & Realizar login \\\\" > tabRequisitosNFunc.aux
  fi
  cat tabRequisitosNFunc.aux | sed -e 's@^\([a-zA-Z0-9]*\)@\\hyperlink{\1}{\1}@' > tabRequisitosNFunc2.aux
}

makeTable
pdflatex monografia.tex || { exit 1; }
bibtex monografia || { exit 1; }
makeglossaries monografia || { exit 1; }
makeTable
pdflatex monografia.tex || { exit 1; }
makeTable
pdflatex monografia.tex || { exit 1; }

