# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 2/4 derivado de `docs/codex/layout/layout-26-05-15-2.md`.

## Análise da tarefa
- `docs/codex/layout/layout-26-05-15-2-analise.md`

## Continuidade
- Slice anterior: `docs/codex/layout/layout-26-05-15-2-parte_1-resumo.md`
- Antes de alterar, leia o resumo do slice 1 e preserve o cabeçalho no estado deixado por ele.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
- `lib/features/pedido_page/presentation/widgets/visualizacao_recibo.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Ler antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Atualizar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não criar novo contrato. O impacto visual continua na `PedidoPage`.

## Regras
- Fazer `_ReciboAcoes` ocupar `double.infinity` ou equivalente dentro do pai, sem depender da largura do conteúdo do `Wrap`.
- Preservar botões e callbacks existentes em `Ações do recibo`: salvar, novo recibo, histórico, clientes, imprimir, gerar PDF e compartilhar.
- Reorganizar `ReciboPedido` para que `Dados do Recibo` e `Visualização do Recibo` fiquem lado a lado em larguras amplas.
- Em larguras compactas, manter empilhamento vertical sem overflow horizontal.
- Evitar lógica pesada dentro de `build`; usar `LayoutBuilder` apenas para cálculo simples de responsividade.
- Corrigir a tabela `Produtos / Serviços`:
  - em layout amplo, cabeçalho e linha devem usar a mesma estrutura de colunas;
  - centralizar/alinhação dos títulos deve bater com os campos abaixo;
  - usar larguras compartilhadas para quantidade, valor unitário, total e ação de remover;
  - deixar a descrição como área flexível em larguras amplas;
  - manter comportamento compacto com campos empilhados.
- Manter `ListView.separated` para itens.
- Não alterar regras de cálculo de total, formatadores ou ViewModel neste slice.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não altere cabeçalho, cadastro de clientes, SQLite nem compartilhamento neste slice.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. `Ações do recibo` ocupando toda a largura disponível.
2. `Dados do Recibo` e `Visualização do Recibo` em row responsiva.
3. Grid `Produtos / Serviços` com cabeçalho alinhado às colunas das linhas.
4. Testes de widget atualizados ou adicionados para cobrir a nova composição.
5. Contrato `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` atualizado.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/layout/layout-26-05-15-2-parte_2-resumo.md`.

# Descrição
- Este slice ajusta a área operacional do recibo e a tabela de itens, atacando diretamente os problemas visuais apontados na captura anexada.

## Objetivo
- Ao final deste slice, o recibo deve aproveitar melhor a largura disponível e a tabela de produtos/serviços deve ter alinhamento consistente entre cabeçalho e linhas.
