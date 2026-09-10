#!/usr/bin/env bash
# Compila o artigo e gera artigo-mcp-kicad-vscode.pdf
set -euo pipefail
cd "$(dirname "$0")"

rm -f main.aux main.bbl main.blg main.log main.out main.toc

pdflatex -interaction=nonstopmode -halt-on-error main.tex > /dev/null
bibtex main > /dev/null
pdflatex -interaction=nonstopmode -halt-on-error main.tex > /dev/null
pdflatex -interaction=nonstopmode -halt-on-error main.tex > /dev/null

cp -f main.pdf artigo-mcp-kicad-vscode.pdf
echo "==> artigo-mcp-kicad-vscode.pdf gerado"
pdfinfo artigo-mcp-kicad-vscode.pdf | grep -E "Pages|Page size" || true
echo "--- overfull hbox: $(grep -c 'Overfull \\\\hbox' main.log || true)"
echo "--- undefined refs/cites: $(grep -ci 'undefined' main.log || true)"
grep -i "undefined" main.log | head -5 || true
