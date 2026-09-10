# Artigo — mcp-kicad-vscode

Artigo científico/tecnológico sobre o servidor MCP (`KiCAD-MCP-Server`) do
workspace, seguindo a skill `artigo-cientifico-latex`.

- **Autor:** William da Silva Vianna — Instituto Federal Fluminense (IFF)
- **PDF final:** [`artigo-mcp-kicad-vscode.pdf`](artigo-mcp-kicad-vscode.pdf)
- **Fonte:** `main.tex` + `sections/` + `references.bib`

## Compilação

```bash
./build.sh          # pdflatex -> bibtex -> pdflatex -> pdflatex
```

O script gera `main.pdf` e o renomeia para `artigo-mcp-kicad-vscode.pdf`.

## Estrutura

```
artigo/
├── main.tex              # preâmbulo, metadados, resumo, inclusão das seções
├── sections/             # 01-introducao ... 06-conclusao
├── figures/              # figuras reais do projeto (renders, esquemático)
├── references.bib        # referências verificadas (ABNT autor-ano via natbib)
└── build.sh
```

## Dados e evidências

Todas as métricas do artigo têm origem verificável no workspace:

| Dado | Fonte |
|---|---|
| 233 ferramentas / 173 indexadas / 16 categorias | `KiCAD-MCP-Server/docs/TOOL_INVENTORY.md` (gerado 06/09/2026) |
| LOC (TS e Python) | contagem direta em `src/` e `python/` |
| Testes (2.451 casos; 2.412 aprovados) | `evidencias/testes-*.log` (execução 10/09/2026) |
| DRC (11 violações; 0 não conectados) | `evidencias/drc-seguidor-de-linhas-2026-09-10.json` |
| Placa (97 footprints, 83 nets, 82,1 × 80,2 mm) | `project-kicad/*.kicad_pcb` |
| Renders 3D e esquemático | `kicad-cli` 9.0.7 (figuras em `figures/`) |
