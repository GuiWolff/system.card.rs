# Resumo do slice 4 - Estado compartilhado e callbacks da PedidoPage

## O que foi feito
- Criada `PedidoPageViewModel` para concentrar a coordenação mínima de estado da `PedidoPage`.
- A ViewModel passou a expor:
  - `totalPedidoCentavos`;
  - `valorEntradaCentavos`;
  - `valorAPagarEntregaCentavos`;
  - valores formatados para o resumo temporário;
  - última ação temporária do cabeçalho.
- A `PedidoPage` passou a observar a ViewModel com `AnimatedBuilder`.
- O encaixe temporário de recibo atualiza a mesma ViewModel consumida pelo encaixe temporário de resumo.
- O encaixe temporário de cabeçalho registra callback mínimo na ViewModel.
- O barrel `lib/features/pedido_page/pedido_page.dart` passou a exportar a ViewModel.
- Criados testes específicos de ViewModel e ampliados os testes de Page para validar a fonte compartilhada.

## Validações executadas e resultado
- `dart format lib/features/pedido_page/pedido_page.dart lib/features/pedido_page/presentation/pages/pedido_page.dart lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart test/features/pedido_page/presentation/pages/pedido_page_test.dart test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`: executado com sucesso.
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`: passou.
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`: passou.

## Impacto em UI
- Houve impacto visual controlado nos encaixes temporários:
  - o cabeçalho agora exibe uma ação temporária para validar callback;
  - o recibo agora exibe uma ação temporária para atualizar dados compartilhados;
  - o resumo agora exibe total, entrada e valor a pagar na entrega a partir da ViewModel.
- A ordem visual e o layout responsivo da `PedidoPage` foram preservados.

## Contrato de tela
- Contrato atualizado: `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- O contrato agora registra a `PedidoPageViewModel`, a fonte de verdade do resumo, os callbacks temporários e os limites da coordenação atual.
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md` foi lido, mas não alterado, porque este slice não redefiniu responsabilidades da `ReciboPage`.

## Arquivos principais alterados
- `lib/features/pedido_page/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_4-resumo.md`

## Limites por componentes ausentes
- Cabeçalho real ainda ausente; o callback atual é apenas um encaixe temporário para validar coordenação.
- Recibo real ainda ausente; não foram implementadas regras internas de formulário, produtos, validação, persistência, PDF ou impressão.
- Resumo real ainda ausente; o resumo temporário apenas exibe os valores expostos pela ViewModel.
- A regra definitiva para `Valor Entrada` maior que `Total do Pedido` continua pendente; a ViewModel expõe a diferença simples entre total e entrada.

## Continuidade para o próximo slice
- Próximo slice: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_5.md`.
- Revisar fechamento, compatibilidade e testes finais.
- Substituir os encaixes temporários por componentes reais somente quando Cabeçalho, Recibo e Resumo estiverem implementados.
- Manter a `PedidoPage` como agregadora, sem mover regra interna dos blocos para a Page.
