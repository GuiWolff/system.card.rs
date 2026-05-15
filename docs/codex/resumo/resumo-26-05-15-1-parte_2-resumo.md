# Resumo do slice 2/4 - Estado da tela e atualização reativa

## O que foi feito
- `PedidoPageViewModel` passou a expor:
  - `resumoFinanceiro`;
  - `errosResumoFinanceiro`;
  - `resumoFinanceiroValido`;
  - `mensagemValorEntrada`;
  - `valorEntradaValido`.
- O resumo continua derivado de `reciboEmEdicao`, preservando a fonte única de verdade para itens, total, entrada e saldo.
- `salvarRecibo` agora valida o domínio antes de persistir e expõe a primeira falha em `erro`.
- Foram adicionados testes de ViewModel para o resumo exposto e para entrada maior que o total.

## Contratos de tela
- Revisados:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`;
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Houve impacto em estado de UI, pois o widget visual futuro deve ler a validação da ViewModel e não recalcular regra no `build`.
- Não houve alteração visual neste slice.

## Validações
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`: passou.

## Continuidade
- O próximo slice deve criar o widget visual `ResumoPedido` na feature real `pedido_page` e substituir o encaixe temporário de resumo da `PedidoPage`.
