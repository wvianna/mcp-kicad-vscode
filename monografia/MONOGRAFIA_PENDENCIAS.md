# Pendências e informações ausentes — Monografia mcp-kicad-vscode

Registro do controle de integridade: nenhuma informação ausente foi inventada;
os itens abaixo estão marcados explicitamente no texto ou dependem de
validação com o autor.

## Dados do trabalho (marcadores visíveis no PDF)

| ID | Item | Local no PDF | Situação |
|---|---|---|---|
| D-01 | Curso/título de graduação a que a monografia se vincula | Folha de rosto | `[CURSO/TÍTULO A CONFIRMAR]` |
| D-01b | Orientador(a) | Folha de rosto | `[ORIENTADOR A CONFIRMAR]` |

## Divergências de documentação do projeto

| ID | Item | Situação |
|---|---|---|
| D-02 | A soma das contagens por categoria no inventário (148) difere do total indexado informado pelo próprio inventário (173) | Registrado no Apêndice A; conciliar em versão futura do inventário |

## Resultados não obtidos / fora do escopo (não fabricados)

| ID | Item | Situação |
|---|---|---|
| R-01 | Validação do backend IPC em tempo real | Não executada: `enable_server` desabilitado no KiCad do ambiente (`kicad_common.json`) e ausência de soquete IPC; registrado como limitação |
| R-02 | Medições de produtividade com usuários (tempo de projeto, retrabalho) | Não realizadas; propostas em trabalhos futuros |
| R-03 | Fabricação física da placa do estudo de caso | Não realizada; DRC possui 11 violações residuais (9 erros) a corrigir |
| R-04 | Cobertura de mutação dos testes | Não executada; contagem de casos usada como proxy |

## Observações de precisão

- Os resultados de teste referem-se à execução local de 10/09/2026, no
  ambiente documentado (Ubuntu 24.04.4, KiCad 9.0.7 snap, Node 22.23.2,
  Python 3.12.3); os logs originais estão em `../evidencias/`.
- As dimensões da placa referem-se à caixa envolvente da camada Edge.Cuts
  (82,1 mm × 80,2 mm); valores de documentação prévia citavam
  82,2 mm × 80,3 mm — adotou-se a medição verificada.
- O README do workspace afirmava “DRC limpo (0 violações)”; a verificação de
  10/09/2026 reportou 11 violações (9 erros + 2 avisos). O README foi
  corrigido para refletir a medição.

## Correções de atribuição aplicadas

| ID | Item | Correção |
|---|---|---|
| A-01 | Autoria do servidor MCP estudado | O projeto `KiCAD-MCP-Server` é de autoria de `mixelpixx` (conforme a citação sugerida no final de `KiCAD-MCP-Server/README.md`). Em 11/09/2026, o artigo e a monografia foram ajustados para: (i) creditar o autor do servidor e citar o projeto; (ii) descrever o trabalho como análise/avaliação do servidor, e não como sua especificação/implementação; (iii) explicitar que o estudo de caso com a placa seguidora de linhas é a contribuição empírica do autor do trabalho. Os PDFs finais mantêm os nomes `artigo-mcp-kicad-vscode.pdf` e `monografia-mcp-kicad-vscode.pdf`. |
