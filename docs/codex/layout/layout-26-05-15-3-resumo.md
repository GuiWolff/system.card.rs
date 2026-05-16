# Resumo geral da tarefa

## Tarefa solicitada
- Planejar a migração dos ícones da interface para o pacote `font_awesome_flutter`, incluindo Instagram, WhatsApp e os demais ícones visíveis da feature `pedido_page`.

## Arquivos de prompt criados
- `docs/codex/layout/layout-26-05-15-3-analise.md`
- `docs/codex/layout/layout-26-05-15-3.md`
- `docs/codex/layout/layout-26-05-15-3-parte_1.md`
- `docs/codex/layout/layout-26-05-15-3-parte_2.md`
- `docs/codex/layout/layout-26-05-15-3-parte_3.md`
- `docs/codex/layout/layout-26-05-15-3-resumo.md`

## Lista de slices
- Slice 1/3: `docs/codex/layout/layout-26-05-15-3-parte_1.md`
- Slice 2/3: `docs/codex/layout/layout-26-05-15-3-parte_2.md`
- Slice 3/3: `docs/codex/layout/layout-26-05-15-3-parte_3.md`

## Ordem correta de execução
1. Executar `docs/codex/layout/layout-26-05-15-3-parte_1.md`.
2. Ler `docs/codex/layout/layout-26-05-15-3-parte_1-resumo.md`.
3. Executar `docs/codex/layout/layout-26-05-15-3-parte_2.md`.
4. Ler `docs/codex/layout/layout-26-05-15-3-parte_2-resumo.md`.
5. Executar `docs/codex/layout/layout-26-05-15-3-parte_3.md`.
6. Ler `docs/codex/layout/layout-26-05-15-3-parte_3-resumo.md`.

## Validações esperadas
- `flutter pub get`
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test`

## Contratos de tela criados, atualizados ou revisados
- Nenhum contrato foi alterado por este gerador.
- O contrato existente que deve ser lido e atualizado durante os slices com impacto de UI é:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Observações importantes para continuidade
- A tarefa deve preservar o worktree atual, que já contém alterações em andamento.
- Não remover os assets SVG de Instagram/WhatsApp sem confirmação explícita.
- Não usar `FontAwesomeIcons` diretamente dentro de `ReciboPdfService`, porque a geração de PDF usa o pacote `pdf` e não widgets Flutter.
- O primeiro arquivo a executar é `docs/codex/layout/layout-26-05-15-3-parte_1.md`.
