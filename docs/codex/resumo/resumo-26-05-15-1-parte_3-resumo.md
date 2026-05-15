# Resumo do slice 3/4 - Widget visual abaixo do recibo

## O que foi feito
- Foi criado `ResumoPedido` em `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`.
- A `PedidoPage` passou a usar o widget real de resumo no slot abaixo do recibo/produtos, substituindo o encaixe temporário.
- O widget renderiza `RESUMO`, `Total do Pedido:`, `Valor Entrada:` e `Valor a pagar na Entrega:`.
- O saldo de entrega recebeu destaque visual com a cor terciária do tema.
- O campo `Valor Entrada` é editável quando recebe callback e envia o valor convertido em centavos para a ViewModel.
- O layout usa `LayoutBuilder` e `Wrap` para distribuir os três campos lado a lado em telas amplas e empilhar em larguras compactas.
- `lib/resources/resumo.png` foi usado apenas como referência visual, não como imagem final.

## Contratos de tela
- Revisados:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`;
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Houve impacto visual em UI, com substituição do resumo temporário pelo bloco real.

## Validações
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`: passou.
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`: passou.

## Continuidade
- O próximo slice deve revisar a integração final, remover expectativas antigas do resumo temporário e executar as validações completas.
