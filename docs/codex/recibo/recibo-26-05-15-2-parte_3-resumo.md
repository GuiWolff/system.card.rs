# Resumo do slice 3/4 - Impressão com o mesmo PDF

## Entregue
- A impressão real foi conectada ao fluxo da `PedidoPage`.
- O botão `Imprimir` do `ReciboPedido` gera o PDF A4 atual com `ReciboPdfService` e envia os bytes para `ReciboImpressaoService`.
- O botão `IMPRIMIR` do `CabecalhoApp` usa o mesmo fluxo de impressão da tela.
- `ReciboImpressaoService` usa `Printing.layoutPdf` com `PdfPageFormat.a4`, sem criar layout paralelo de impressão.
- A `PedidoPageViewModel` passou a controlar estado reativo de impressão:
  - `imprimindoPdf`;
  - `validarReciboParaImpressao`;
  - `iniciarImpressao`;
  - `concluirImpressao`;
  - `registrarErroImpressao`.
- A `PedidoPageViewModel` continua sem acessar `BuildContext`, widgets, diálogos ou APIs de plataforma.
- O fluxo valida o recibo antes de gerar e imprimir.
- Falhas de geração ou impressão são exibidas em `erro` com mensagem clara.
- Cancelamento retornado pelo serviço de impressão é tratado como cancelamento, não como erro.
- O nome do arquivo enviado ao plugin segue `recibo-[numero].pdf`, com sanitização do número.

## UI
- Houve impacto em UI.
- O botão `Imprimir` do recibo deixou de ser apenas preparatório e passou a executar impressão real.
- Durante impressão, o botão exibe `Imprimindo...` e os botões de impressão/PDF ficam desabilitados.
- O recibo exibe feedbacks:
  - `Preparando impressão...`;
  - `Recibo enviado para impressão.`;
  - `Impressão cancelada.`;
  - mensagem de erro quando houver falha.
- A ação `IMPRIMIR` do cabeçalho usa o mesmo fluxo e registra feedback no cabeçalho quando acionada por lá.

## Contrato de tela
- Contrato atualizado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.

## Testes ajustados
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
  - cobre impressão pelo botão do recibo com serviço fake;
  - cobre impressão pelo cabeçalho com o mesmo PDF;
  - cobre erro do serviço de impressão exposto na UI.
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
  - cobre estados de impressão em andamento, conclusão e erro.

## Validações executadas
- `flutter analyze` concluído sem issues.
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart` concluído com sucesso.
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart` concluído com sucesso.

## Observações
- A prévia em `AlertDialog` do slice 2 foi preservada.
- A impressão reutiliza a mesma base de PDF A4 da prévia.
- Compartilhamento e salvamento com escolha de caminho permanecem reservados ao slice 4.
