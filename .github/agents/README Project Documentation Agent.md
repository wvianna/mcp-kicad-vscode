# AGENTS.md

Guia de contexto para agentes de IA que trabalham neste repositório.
**Repositório raiz:** `/home/william/git/mcp-kicad-vscode` (symlink para `/home/william/Nextcloud/git/mcp-kicad-vscode`).

## Visão geral do projeto

Este workspace combina **dois projetos**:

1. **`KiCAD-MCP-Server/`** — Servidor MCP que permite design de PCB assistido por IA com KiCad. Backend em **Node.js/TypeScript** (`src/`) + **Python** (`python/`, interface `pcbnew`/SWIG e IPC). É um clone do repositório upstream `https://github.com/mixelpixx/KiCAD-MCP-Server.git` com **`.git` próprio (repositório embutido)**.
2. **`project-kicad/`** — Projeto de hardware KiCad: placa 4 camadas `seguidor_de_linhas_4camada2-2026-1` (ESP32 + MPPT + ponte H + USB-C). Arquivos `.kicad_pro`, `.kicad_pcb`, `.kicad_sch` devem ser **versionados**; artefatos gerados são ignorados (ver `.gitignore`).

Tecnologias: Node.js ≥20, TypeScript 5.9, Vitest 2, ESLint 10, Prettier 3, Python ≥3.9 (venv `.venv`, 3.12.3), pytest, Black/Isort/MyPy/Flake8, KiCad 9.0.7 (instalação **snap** em `/snap/kicad/22`).

## Estrutura do repositório

```text
mcp-kicad-vscode/
├── AGENTS.md                 # este arquivo
├── .gitignore                # raiz (Node/Python/KiCad/VS Code)
├── docs/
│   ├── setup-mcp.txt         # passo a passo de instalação local (pt-BR)
│   ├── create-agente-readme.md  # guia do agente de README (pt-BR)
│   └── images/               # imagens de suporte
├── .vscode/mcp.json          # configuração MCP — MÁQUINA-ESPECÍFICA (gitignorado)
├── KiCAD-MCP-Server/         # repo aninhado (upstream mixelpixx/KiCAD-MCP-Server)
│   ├── src/                  # TypeScript (servidor + tools)
│   ├── python/               # interface pcbnew (SWIG)/IPC
│   ├── tests/                # pytest
│   ├── tests-ts/             # vitest
│   ├── config/               # exemplos de configuração MCP
│   ├── docs/                 # documentação detalhada do servidor
│   ├── package.json / pyproject.toml / tsconfig.json
│   └── run-kicad-mcp.sh      # launcher com env do KiCad snap (NÃO versionado no repo aninhado)
└── project-kicad/            # projeto KiCad (PCB)
```

## Comandos de setup

```bash
# Dependências Node + build (dentro de KiCAD-MCP-Server/)
cd KiCAD-MCP-Server
npm ci            # ou npm install
npm run build     # tsc -> dist/

# Python (venv já existente; recriar se necessário)
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt -r requirements-dev.txt
```

**Importante (ambiente KiCad snap):** o módulo `pcbnew`/`kicad-cli` exige `PYTHONPATH` e `LD_LIBRARY_PATH` do snap. Use o launcher `KiCAD-MCP-Server/run-kicad-mcp.sh` (ou replique as variáveis do `.vscode/mcp.json`):

```bash
export PYTHONPATH=/snap/kicad/22/usr/lib/python3/dist-packages
export LD_LIBRARY_PATH=/snap/kicad/22/usr/lib/x86_64-linux-gnu:/snap/kicad/22/usr/lib/i386-linux-gnu:/snap/kicad/22/usr/lib:/snap/kicad/22/gnome-platform/usr/lib/x86_64-linux-gnu:/snap/kicad/22/gnome-platform/usr/lib:/snap/kicad/22/gnome-platform/lib
export PATH=/snap/kicad/22/usr/bin:/snap/kicad/22/bin:$PATH
```

Sem essas variáveis, `import pcbnew` falha com `libwx_gtk3u_gl-3.2.so.0: cannot open shared object file`.

## Workflow de desenvolvimento

```bash
cd KiCAD-MCP-Server
npm run dev           # tsc --watch + nodemon dist/index.js
npm run build         # compilar para dist/
npm run build:watch   # apenas watch
node dist/index.js    # execução direta (sem env do KiCad: modo "headless" SWIG ainda funciona)
```

- **Servidor MCP no VS Code:** iniciar via `MCP: Start Server` (usa `.vscode/mcp.json`). Variáveis relevantes: `KICAD_BACKEND=auto` (tenta IPC, cai para SWIG se `kicad-python` não estiver instalado), `KICAD_AUTO_LAUNCH=false`, `KICAD_PYTHON` (aponta para o venv).
- **Backend atual:** SWIG (`realtime: false`, `ipcConnected: false`) — alterações exigem reload manual do board na UI do KiCad.
- **Inventário de ferramentas:** `npm run docs:tools` regenera `docs/TOOL_INVENTORY.md` (233 ferramentas registradas). O CI exige `npm run docs:tools:check` — sempre rode após adicionar/remover tools em `src/tools/`.

## Instruções de teste

```bash
cd KiCAD-MCP-Server
npm run test          # ts + py
npm run test:ts       # vitest run (tests-ts/)
npm run test:py       # pytest tests/ -v
pytest                # sem argumentos: segue pytest.ini (testpaths = tests/)
pytest tests/test_x.py -k "nome"   # subconjunto específico
vitest run -t "nome do teste"      # foco em um teste TS
```

- **TS:** Vitest, convenção `*.test.ts` em `tests-ts/`.
- **Python:** pytest, convenção `test_*.py` em `tests/`.
- **Cobertura:** `npm run test:coverage` (pytest-cov — `--cov=python --cov-report=html`).
- O CI (`.github/workflows/ci.yml`) valida: build TS + lint:ts + test:ts + `docs:tools:check` (matrix Node 20/22 × Ubuntu/Win/macOS) e pytest (matrix Python 3.9–3.12 em Ubuntu, com JRE 21 para suites de freerouting).

## Estilo de código

```bash
cd KiCAD-MCP-Server
npm run lint          # eslint src/ + black --check + mypy + flake8 (python/)
npm run lint:ts       # eslint src/ apenas
npm run format        # prettier 'src/**/*.ts' && black python/
npm run format:py     # black + isort (python/ e tests/)
```

- **TS:** TypeScript estrito, sem `any` novas; Prettier; ESLint (`eslint.config.js`); módulos ES (`"type": "module"`), imports com extensão `.js` em projetos Node ESM.
- **Python:** Black `line-length=100`, Isort `profile=black`, MyPy (config em `pyproject.toml`, `mypy_path = ".:python"`, ignores para `pcbnew` etc.), Flake8.
- **Pre-commit:** `.pre-commit-config.yaml` — rode `pre-commit run --all-files` antes de commitar.

## Build e distribuição

- Build TS: `npm run build` → `dist/` (não versionado).
- Testes/docs gated no CI: `npm run docs:tools:check` e `npm run lint:ts` são portões reais.
- **Não commitar:** `dist/`, `node_modules/`, `.venv/`, `__pycache__/`, `.pytest_cache/` (ver `.gitignore` da raiz e do servidor).

## Projeto KiCad (project-kicad/)

- **Arquivos a versionar:** `.kicad_pro`, `.kicad_pcb`, `.kicad_sch`, `mylib/`, `fp-lib-table` (com caminhos absolutos do snap atualmente), `BOM.csv`.
- **Ignorados:** `fp-info-cache`, `*.kicad_prl`, `*.lck`, `~*`, `*-backups/`, `production/`, `*_drc_violations.json`, `temp-*.dsn`, `datasheet.zip`.
- **DRC/validação** (com o env do snap):
  ```bash
  cd project-kicad
  kicad-cli pcb drc --output /tmp/drc.json --format json seguidor_de_linhas_4camada2-2026-1.kicad_pcb
  ```
- **Refill de zonas / edições via pcbnew:** executar com o venv + env do snap (ver seção de setup). O `kicad-cli` é a forma confiável de validar sem abrir a UI.
- **AVISO:** não edite o `.kicad_pcb` enquanto o pcbnew estiver aberto no mesmo arquivo (existência de `*.lck`). Backups de trabalho: `/tmp/*.kicad_pcb`.

## Estrutura Git — atenção

- A raiz é um repositório Git **novo** (`git init`); `KiCAD-MCP-Server/` é um **repositório embutido** (`.git` próprio, com upstream `mixelpixx/KiCAD-MCP-Server`). Na raiz, o Git o trata como "embedded repository" (gitlink).
- **Não** rodar comandos Git do repo aninhado a partir da raiz; use `git -C KiCAD-MCP-Server ...` para o servidor.
- Arquivos **máquina-específicos**: `.vscode/mcp.json` (gitignorado), `KiCAD-MCP-Server/run-kicad-mcp.sh` (contém caminhos absolutos; hoje é untracked no repo aninhado). Ajuste caminhos conforme a instalação (`docs/setup-mcp.txt`).

## Segurança

- Nunca commitar `.env` ou segredos; use `.env.example` como referência.
- Não expor credenciais (DigiKey/JLC) em exemplos ou commits.
- Não copiar valores de variáveis de ambiente para documentação.

## Solução de problemas

| Sintoma | Causa provável | Solução |
|---|---|---|
| `ImportError: libwx_gtk3u_gl-3.2.so.0` | `LD_LIBRARY_PATH` ausente | Exportar as variáveis do snap (seção Setup) ou usar `run-kicad-mcp.sh` |
| `pcbnew validation failed: No module named 'pcbnew'` | `PYTHONPATH` errado | `export PYTHONPATH=/snap/kicad/22/usr/lib/python3/dist-packages` |
| MCP responde `backend: swig`, sem realtime | `kicad-python` não instalado | `pip install kicad-python` (ou aceitar SWIG) |
| `kicad-cli: error while loading shared libraries: libkicommon.so` | env do snap ausente no shell | Exportar `LD_LIBRARY_PATH` antes de chamar o `kicad-cli` |
| DRC acusa clearance de zona | fill de zona desatualizado | Refill via `pcbnew.ZONE_FILLER` + Save (ou tecla B no KiCad) |
| `docs/TOOL_INVENTORY.md` desatualizado | tools novas | `npm run docs:tools` |
