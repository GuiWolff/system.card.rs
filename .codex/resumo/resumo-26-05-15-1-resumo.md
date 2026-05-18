# Resumo geral da tarefa

## Tarefa solicitada
- Criar slices para implementar o bloco de resumo financeiro baseado em `lib/resources/resumo.png`.
- O bloco deve ficar abaixo do widget de recibo, dentro da coluna da `ReciboPage`.
- O bloco deve conter `Total do Pedido`, `Valor Entrada` e `Valor a pagar na Entrega`.

## Arquivos de prompt criados
- `docs/codex/resumo/resumo-26-05-15-1-analise.md`
- `docs/codex/resumo/resumo-26-05-15-1.md`
- `docs/codex/resumo/resumo-26-05-15-1-parte_1.md`
- `docs/codex/resumo/resumo-26-05-15-1-parte_2.md`
- `docs/codex/resumo/resumo-26-05-15-1-parte_3.md`
- `docs/codex/resumo/resumo-26-05-15-1-parte_4.md`
- `docs/codex/resumo/resumo-26-05-15-1-resumo.md`

## Lista de slices
1. `docs/codex/resumo/resumo-26-05-15-1-parte_1.md` - Modelo e cálculo do resumo.
2. `docs/codex/resumo/resumo-26-05-15-1-parte_2.md` - Estado da tela e atualização reativa.
3. `docs/codex/resumo/resumo-26-05-15-1-parte_3.md` - Widget visual abaixo do recibo.
4. `docs/codex/resumo/resumo-26-05-15-1-parte_4.md` - Integração, contrato e fechamento.

## Ordem correta de execução
1. Executar `resumo-26-05-15-1-parte_1.md`.
2. Conferir o resumo `resumo-26-05-15-1-parte_1-resumo.md`.
3. Executar `resumo-26-05-15-1-parte_2.md`.
4. Conferir o resumo `resumo-26-05-15-1-parte_2-resumo.md`.
5. Executar `resumo-26-05-15-1-parte_3.md`.
6. Conferir o resumo `resumo-26-05-15-1-parte_3-resumo.md`.
7. Executar `resumo-26-05-15-1-parte_4.md`.
8. Conferir o resumo `resumo-26-05-15-1-parte_4-resumo.md`.
9. Não executar slices em paralelo.

## Validações esperadas
- `flutter analyze`
- `flutter test`
- `flutter test test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`
- `flutter test test/features/recibo/presentation/widgets/resumo_pedido_test.dart`
- Verificação responsiva em larguras próximas de 390, 768, 1024 e 1366 pixels.

## Contratos de tela criados, atualizados ou revisados
- Atualizado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Nenhum contrato novo de Page/View/Tela foi criado, porque a tela impactada continua sendo `ReciboPage`.

## Observações importantes para continuidade
- O worktree atual ainda não contém a implementação real da `ReciboPage`; o executor deve verificar se os slices anteriores de base/cabeçalho foram concluídos antes de integrar o resumo.
- `lib/resources/resumo.png` deve ser usado como referência visual, não como imagem final única.
- O cálculo do resumo deve ter uma única fonte de verdade no estado/modelo, evitando duplicação no widget visual.
- O primeiro arquivo a executar é `docs/codex/resumo/resumo-26-05-15-1-parte_1.md`.
