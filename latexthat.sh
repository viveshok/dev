#!/bin/bash

# Simple script to compile a tex file,
# clean the destination folder and display it

filename=$1
tex=${filename/".tex"/""}

latex -halt-on-error $tex
bibtex $tex
latex -halt-on-error $tex
latex -halt-on-error $tex

dvipdf $tex".dvi" $tex".pdf" 

rm *.aux *.out *.log *.bbl *.blg *.loa *.lof
rm *.lot *.synctex.gz *.toc *.dvi *.~

evince $tex".pdf"

