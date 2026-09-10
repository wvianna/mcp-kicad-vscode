#!/usr/bin/env bash
# Compila a monografia e gera monografia-mcp-kicad-vscode.pdf
set -euo pipefail
cd "$(dirname "$0")"

rm -f main.aux main.bbl main.blg main.log main.out main.toc main.lof main.lot main.loq

pdflatex -interaction=nonstopmode -halt-on-error main.tex > /dev/null
bibtex main > /dev/null
pdflatex -interaction=nonstopmode -halt-on-error main.tex > /dev/null
pdflatex -interaction=nonstopmode -halt-on-error main.tex > /dev/null

cp -f main.pdf monografia-mcp-kicad-vscode.pdf
echo "==> monografia-mcp-kicad-vscode.pdf gerado"
pdfinfo monografia-mcp-kicad-vscode.pdf | grep -E "Pages|Page size" || true
echo "--- overfull hbox: $(grep -c 'Overfull \\\\hbox' main.log || true)"
echo "--- undefined refs/cites: $(grep -ci 'undefined' main.log || true)"
grep -i "undefined" main.log | head -8 || true
