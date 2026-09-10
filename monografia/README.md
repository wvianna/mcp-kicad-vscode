# Monografia — mcp-kicad-vscode

Monografia sobre o servidor MCP (`KiCAD-MCP-Server`) do workspace, com foco no
detalhamento do protocolo, da arquitetura e do catálogo de ferramentas,
seguindo a skill `skill-monografia-engenharia-latex` (ABNT, citações
numéricas).

- **Autor:** William da Silva Vianna — Instituto Federal Fluminense (IFF)
- **PDF final:** [`monografia-mcp-kicad-vscode.pdf`](monografia-mcp-kicad-vscode.pdf)
- **Fonte:** `main.tex` (memoir) + `pretextual.tex` + `chapters/` +
  `references.bib`

## Compilação

```bash
./build.sh          # pdflatex -> bibtex -> pdflatex -> pdflatex
```

O script gera `main.pdf` e o renomeia para
`monografia-mcp-kicad-vscode.pdf`.

## Estrutura

```
monografia/
├── main.tex              # memoir (ABNT manual), inclusão dos capítulos
├── pretextual.tex        # capa, folha de rosto, resumo, abstract, siglas
├── chapters/             # 10 capítulos + 2 apêndices
├── figures/              # figuras reais do projeto (renders, esquemáticos)
├── references.bib        # referências verificadas (citações numéricas, unsrt)
├── MONOGRAFIA_PENDENCIAS.md
└── build.sh
```

## Fontes de dados (evidências)

| Dado | Fonte |
|---|---|
| 233 ferramentas / 173 indexadas / 24 módulos | `KiCAD-MCP-Server/docs/TOOL_INVENTORY.md` |
| LOC por componente | `src/` (TS) e `python/` (medição direta) |
| Testes (2.451 casos executados) | `../evidencias/testes-*.log` (10/09/2026) |
| DRC (11 violações; 0 não conectados) | `../evidencias/drc-seguidor-de-linhas-2026-09-10.json` |
| Placa (97 footprints; 83 nets; 82,1 × 80,2 mm) | `../project-kicad/*.kicad_pcb` |

## Pendências

Informações ausentes no workspace (curso, orientação etc.) estão marcadas
explicitamente no texto e listadas em
[`MONOGRAFIA_PENDENCIAS.md`](MONOGRAFIA_PENDENCIAS.md).
