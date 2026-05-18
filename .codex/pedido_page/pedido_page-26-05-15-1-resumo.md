# Resumo geral da tarefa

## Tarefa solicitada
- Criar os slices para a feature `pedido_page`.
- A `PedidoPage` deve juntar Cabeçalho, Recibo e Resumo.
- O usuário informou que irá começar por esta parte, então os slices priorizam a criação da tela agregadora antes da implementação final de todos os blocos internos.

## Arquivos de prompt criados
- `docs/codex/pedido_page/pedido_page-26-05-15-1-analise.md`
- `docs/codex/pedido_page/pedido_page-26-05-15-1.md`
- `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_1.md`
- `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_2.md`
- `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_3.md`
- `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_4.md`
- `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_5.md`
- `docs/codex/pedido_page/pedido_page-26-05-15-1-resumo.md`

## Lista de slices
1. `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_1.md` - Page base e contrato público.
2. `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_2.md` - Layout responsivo da composição.
3. `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_3.md` - Integração dos blocos Cabeçalho, Recibo e Resumo.
4. `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_4.md` - Estado compartilhado e callbacks.
5. `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_5.md` - Fechamento, testes e compatibilidade.

## Ordem correta de execução
1. Executar `pedido_page-26-05-15-1-parte_1.md`.
2. Conferir `pedido_page-26-05-15-1-parte_1-resumo.md`.
3. Executar `pedido_page-26-05-15-1-parte_2.md`.
4. Repetir o fluxo até o slice 5.
5. Não executar slices em paralelo.
6. Não avançar sem resumo válido do slice anterior.

## Validações esperadas
- `flutter analyze`
- `flutter test`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- Verificação responsiva em larguras próximas de 390, 768, 1024 e 1366 pixels.

## Contratos de tela criados, atualizados ou revisados
- Criado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `recibo_page-contrato.md` deve ser atualizado somente se a implementação mover ou redefinir responsabilidades da `ReciboPage`.

## Observações importantes para continuidade
- A `PedidoPage` deve ser agregadora, não dona da implementação interna de Cabeçalho, Recibo ou Resumo.
- Se os componentes internos ainda não existirem durante a execução, os slices devem criar encaixes mínimos e registrar pendências.
- O resumo deve ficar abaixo do recibo dentro da composição principal.
- O primeiro arquivo a executar é `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_1.md`.
