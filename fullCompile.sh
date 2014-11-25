#!/bin/bash
function makeTable() {
  # requisitos funcionais
  if [ ! -f tabRequisitosFunc.aux ]
  then
    echo "RF2 & Realizar login \\\\" > tabRequisitosFunc.aux
  fi
  cat tabRequisitosFunc.aux | sed -e 's@^##\(.*\)##\(.*\)##@\\hyperlink{\2}{\1}@' > tabRequisitosFunc2.aux
  # requisitos não funcionais
  if [ ! -f tabRequisitosNFunc.aux ]
  then
    echo "RF2 & Realizar login \\\\" > tabRequisitosNFunc.aux
  fi
  cat tabRequisitosNFunc.aux | sed -e 's@^##\(.*\)##\(.*\)##@\\hyperlink{\2}{\1}@' > tabRequisitosNFunc2.aux
}

makeTable
pdflatex -synctex=1 -interaction=nonstopmode monografia.tex || { exit 1; }
pdflatex -synctex=1 -interaction=nonstopmode monografia.tex || { exit 1; }
bibtex monografia || { exit 1; }
# Glossary
makeindex  -s "monografia.ist" -t "monografia.glg" -o "monografia.gls" "monografia.glo" || { exit 1; }
# Acronym List
makeindex  -s "monografia.ist" -t "monografia.alg" -o "monografia.acr" "monografia.acn" || { exit 1; }
makeTable
pdflatex -synctex=1 -interaction=nonstopmode monografia.tex || { exit 1; }
makeTable
pdflatex -synctex=1 -interaction=nonstopmode monografia.tex || { exit 1; }

