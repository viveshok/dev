#!/bin/bash

# Triple-compile a LaTeX file to get bibliography and in-document references
# rendered, then clean the directory of scruff files and finally open resulting
# PDF in Evince.
#
# Usage:
#     $ bash latex.sh TARGET.tex

filename=$1
tex=${filename/".tex"/""}

latex -halt-on-error $tex
bibtex $tex
latex -halt-on-error $tex
latex -halt-on-error $tex

dvipdf $tex".dvi" $tex".pdf"

rm -vf *.aux
rm -vf *.out
rm -vf *.log
rm -vf *.bbl
rm -vf *.blg
rm -vf *.loa
rm -vf *.lof
rm -vf *.lot
rm -vf *.synctex.gz
rm -vf *.toc
rm -vf *.dvi

evince $tex".pdf"

