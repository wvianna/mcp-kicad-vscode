# Evidências — execução de 10/09/2026

Registros brutos utilizados pelo artigo e pela monografia deste workspace.

| Arquivo | Origem | Conteúdo |
|---|---|---|
| [`testes-vitest-2026-09-10.log`](testes-vitest-2026-09-10.log) | `npm run test:ts` (KiCAD-MCP-Server) | 10 arquivos, 84 testes — 84 aprovados (1,5 s) |
| [`testes-pytest-2026-09-10.log`](testes-pytest-2026-09-10.log) | `python -m pytest tests/ -q -o addopts=""` | 2.367 casos: 2.328 aprovados, 8 falhas, 31 ignorados (45,0 s) |
| [`drc-seguidor-de-linhas-2026-09-10.json`](drc-seguidor-de-linhas-2026-09-10.json) | `kicad-cli pcb drc --format json --severity-all` | 11 violações (9 erros + 2 avisos); 0 itens não conectados; 0 divergências de paridade |

Ambiente: Ubuntu 24.04.4 LTS, KiCad 9.0.7 (snap rev. 22), Node.js v22.23.2,
Python 3.12.3, pytest 9.1.1. Comandos completos no Apêndice B da monografia
(`monografia/chapters/apendice-b.tex`).

> Nota: a execução do pytest usou `-o addopts=""` para desabilitar os
> argumentos de cobertura do `pytest.ini` (a estação não possuía
> `pytest-cov` instalado no momento da execução).
