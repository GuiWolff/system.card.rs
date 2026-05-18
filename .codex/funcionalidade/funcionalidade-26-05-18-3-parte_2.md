# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise da tarefa e o resumo do slice anterior.
Este é o slice 2/5 derivado de `.codex/funcionalidade/funcionalidade-26-05-18-3.md`.

## Análise da tarefa
- `.codex/funcionalidade/funcionalidade-26-05-18-3-analise.md`

## Regras e skills aplicáveis
- Leia `AGENTS.md`.
- Leia `.codex/rules/RULE.md`.
- Leia as skills e referências listadas na análise antes de alterar código.
- Se houver conflito entre este slice e uma regra ou skill aplicável, pare e reporte o bloqueio.

## Continuidade
- Slice anterior: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_1-resumo.md`
- Se o resumo anterior existir e estiver válido, não refaça o slice 1.

## Arquivos
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`, se for necessário cobrir o fluxo pela UI.
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Leia e atualize `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- O impacto é comportamental no salvamento da tela de pedido/recibo.
- Nenhum contrato novo deve ser criado.

## Regras
- Antes de validar e persistir o recibo, remover somente o último item se:
  - `descricao.trim().isEmpty`;
  - `valorUnitarioCentavos == 0`.
- Não remover item intermediário vazio.
- Não remover último item se ele tiver descrição preenchida.
- Não remover último item se ele tiver valor unitário maior que zero.
- Preservar a ordem dos itens remanescentes.
- Preservar as validações existentes para os demais casos.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit automaticamente.
- Não altere repository ou schema SQLite se a normalização puder ficar na ViewModel antes de salvar.

## Entregáveis
1. Normalização do recibo no fluxo de `salvarRecibo()`.
2. Testes cobrindo remoção do último item acidental e preservação dos demais itens.
3. Atualização de `pedido_page-contrato.md`.
4. Resumo em `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_2-resumo.md`.

# Descrição
- Evitar que um item vazio criado acidentalmente pelo Enter no valor unitário bloqueie o salvamento do recibo.

## Objetivo
- Salvar o recibo normalmente quando o único problema for um último item acidental com descrição vazia e valor `0,00`.
