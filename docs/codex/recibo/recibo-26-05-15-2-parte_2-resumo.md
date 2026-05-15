# Resumo do slice 2/4 - Visualização em AlertDialog

## Entregue
- Criado `ReciboPdfPreviewDialog` em `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`.
- O diálogo usa `AlertDialog` e renderiza a prévia do PDF A4 gerado no slice 1.
- A prévia usa `PdfPreview` do pacote `printing`, com impressão, compartilhamento e mudança de formato desativados neste slice.
- A ação `Gerar PDF` do `ReciboPedido` foi conectada ao fluxo real de geração e abertura do diálogo.
- A ação `GERAR PDF` do cabeçalho da `PedidoPage` foi conectada ao mesmo fluxo.
- A geração usa `ReciboPdfService.gerarPdfA4`, consumindo `reciboEmEdicao` e `cabecalhoEmpresa` da `PedidoPageViewModel`.
- A `PedidoPageViewModel` continua sem acesso a `BuildContext`; a abertura de `showDialog` ficou na camada de apresentação.
- Adicionado estado reativo de geração de PDF na ViewModel:
  - `gerandoPdf`;
  - validação antes da geração;
  - início, conclusão e erro da geração.
- Quando o recibo é inválido, o PDF não é aberto e a primeira validação de domínio é exposta em `erro`.
- O botão do recibo exibe `Gerando PDF...` durante o processamento e fica desabilitado.
- O contrato da tela foi atualizado em `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- O barrel `lib/features/pedido_page/pedido_page.dart` passou a exportar o diálogo de prévia.

## Dependências
- Adicionada a dependência `printing` em `pubspec.yaml`.
- `pubspec.lock` foi atualizado pelo `flutter pub add printing`.

## Testes ajustados
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
  - cobre o acionamento do callback de `Gerar PDF`.
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
  - cobre abertura do `AlertDialog` pelo botão `Gerar PDF` do recibo;
  - cobre abertura do `AlertDialog` pelo botão `GERAR PDF` do cabeçalho;
  - cobre bloqueio da prévia quando o recibo está inválido.

## Validações executadas
- `flutter analyze` concluído sem issues.
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart` concluído com sucesso.
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart` concluído com sucesso.

## Observações
- Durante os testes que geram o PDF real, o pacote `pdf` mantém o aviso informativo já registrado no slice 1 sobre fontes Helvetica sem suporte Unicode amplo.
- Impressão real, compartilhamento e salvamento com escolha de caminho não foram implementados neste slice e permanecem reservados aos slices 3 e 4.
