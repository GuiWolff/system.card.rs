# Resumo do slice 1 - ViewModel reativa da PedidoPage

## O que foi feito
- Migrada `PedidoPageViewModel` para usar `Rx<T>` internamente no lugar de `ChangeNotifier`.
- Removidas as chamadas a `notifyListeners()`.
- Preservados os getters e métodos públicos úteis:
  - `totalPedidoCentavos`;
  - `valorEntradaCentavos`;
  - `valorAPagarEntregaCentavos`;
  - valores formatados;
  - `ultimaAcaoCabecalho`;
  - `atualizarTotalPedidoCentavos`;
  - `atualizarValorEntradaCentavos`;
  - `atualizarDadosDoRecibo`;
  - `registrarAcaoCabecalho`;
  - `dispose()`.
- Os getters agora leem `.value` dos `Rx`, permitindo rastreamento por `Obx` no próximo slice.
- Implementado `dispose()` descartando os `Rx` internos.
- Ajustado o teste unitário da ViewModel para validar notificação por observador reativo rastreado, sem depender de `addListener` da ViewModel.
- Ajustada a `PedidoPage` apenas no ponto mínimo necessário para compilação: o `AnimatedBuilder` passa a observar a ponte transitória `viewModel.atualizacoes`.

## Impacto em UI
- Não houve alteração visual planejada neste slice.
- A `PedidoPage` ainda usa `AnimatedBuilder` temporariamente; a troca visual para `Obx` fica para o slice 2.
- A ponte `atualizacoes` existe apenas para manter compatibilidade enquanto a Page ainda não foi migrada para `Obx`.

## Contrato de tela
- Contrato atualizado: `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- O contrato agora registra que a `PedidoPageViewModel` já usa `Rx<T>` internamente e que a Page mantém uma ponte transitória para o `AnimatedBuilder` até o próximo slice.
- Contrato revisado e não alterado: `lib/features/recibo/presentation/pages/recibo_page-contrato.md`.

## Validações executadas e resultado
- `dart format lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart lib/features/pedido_page/presentation/pages/pedido_page.dart test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`: executado com sucesso.
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`: passou.
- `flutter analyze`: passou, sem issues.
- Validação adicional por ajuste mínimo na Page: `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`: passou.

## Arquivos principais alterados
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `docs/codex/pedido_page/pedido_page-26-05-15-2-parte_1-resumo.md`

## Bloqueios e pendências
- Não houve bloqueio externo neste slice.
- Continuidade esperada: executar `docs/codex/pedido_page/pedido_page-26-05-15-2-parte_2.md` para trocar a observação visual da `PedidoPage` de `AnimatedBuilder` para `Obx` e remover a ponte transitória se ela deixar de ser necessária.
