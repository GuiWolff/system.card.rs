# Análise da tarefa

## Pedido original
- Corrigir o fluxo em que `Compartilhar` o PDF por WhatsApp envia apenas o texto `Recibo em PDF` e não envia o arquivo PDF.

## Feature correspondente
- Feature: `pedido_page`.
- Caminho provável: `lib/features/pedido_page/`.
- Área funcional: geração e compartilhamento do recibo em PDF a partir da `PedidoPage`.

## Arquivos relacionados
- `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
- `lib/features/pedido_page/services/recibo_pdf_service.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `pubspec.yaml`

## Estado atual
- A `PedidoPage` abre `ReciboCompartilhamentoDialog` ao clicar em `Compartilhar`.
- A opção `WhatsApp` chama `ReciboCompartilhamentoService.compartilharPorWhatsapp`.
- Antes de compartilhar, a tela gera os bytes reais do PDF por `ReciboPdfService.gerarPdfA4`.
- O serviço monta `ShareParams` em um fluxo comum para e-mail e WhatsApp.
- Para WhatsApp, o serviço envia:
  - `title: Compartilhar recibo por WhatsApp`;
  - `subject: Recibo em PDF`;
  - `text: Recibo em PDF.`;
  - `files` com `XFile.fromData`;
  - `fileNameOverrides` com o nome do PDF.
- O sintoma informado pelo usuário combina com o receptor priorizando o texto do compartilhamento e ignorando o arquivo anexado.
- Os testes atuais verificam o payload de e-mail e cancelamento do WhatsApp, mas não garantem que o payload do WhatsApp contenha PDF e não contenha texto.
- O projeto usa `share_plus: ^12.0.2`. A implementação local do plugin já suporta `XFile.fromData`, grava arquivo temporário quando necessário e usa `fileNameOverrides` para nomear arquivos criados em memória.

## Estado esperado
- Ao selecionar `WhatsApp`, o payload de compartilhamento deve priorizar o PDF como arquivo.
- O fluxo de WhatsApp não deve enviar `text` nem `subject` com `Recibo em PDF`, para evitar que o app receptor compartilhe somente a mensagem.
- O PDF deve continuar sendo o mesmo gerado por `ReciboPdfService.gerarPdfA4`.
- O arquivo deve manter:
  - bytes do PDF;
  - nome previsível `recibo-[numero].pdf`;
  - MIME type `application/pdf`;
  - `fileNameOverrides` consistente com o nome do arquivo.
- O fluxo de e-mail deve continuar com texto, assunto e destinatário sugerido quando existir.
- O fluxo de salvar arquivo não deve ser alterado.
- A UI pode continuar abrindo a folha de compartilhamento do sistema; o app não deve prometer envio direto ou confirmação final do WhatsApp.

## Riscos e dependências
- `share_plus` depende do comportamento do sistema operacional e do app receptor. Mesmo com payload correto, o app final pode ignorar anexos em algumas plataformas.
- Não deve ser implementado deep link `whatsapp://` para este caso, porque deep links de mensagem não carregam anexos PDF de forma confiável.
- Remover texto do payload de WhatsApp pode reduzir a descrição visual no app receptor, mas evita o comportamento observado de enviar apenas texto.
- No Windows, o plugin usa `DataTransferManager` e pode precisar de `title` para exibir a folha de compartilhamento; o título não deve ser confundido com `text`.
- A alteração deve preservar o comportamento de e-mail, salvamento, geração de PDF, impressão e estado reativo da `PedidoPageViewModel`.
- A ViewModel não deve passar a depender de `share_plus`, `BuildContext`, arquivos temporários ou widgets.

## Contratos de tela
- Contrato existente lido/revisado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que precisam ser criados:
  - Nenhum. A tarefa não cria Page/View/Tela nova.
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`, porque a ação de compartilhamento da `PedidoPage` é comportamento visível da tela.
- Contrato legado que não deve ser alterado neste escopo:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`, pois a tarefa não cria nem modifica `ReciboPage`.

## Estratégia
- Separar a correção do payload do serviço da validação do fluxo da tela.
- Primeiro ajustar `ReciboCompartilhamentoService` para construir `ShareParams` específicos por canal.
- Para WhatsApp, enviar o PDF sem `text` e sem `subject`, mantendo o arquivo como payload principal.
- Depois cobrir o caminho da `PedidoPage` selecionando a opção `WhatsApp` no popup e verificando que os bytes gerados e o nome do arquivo chegam ao serviço.
- Atualizar o contrato da `PedidoPage` para registrar que WhatsApp compartilha arquivo PDF como payload principal e que a plataforma ainda decide o app final.

## Decisão sobre slices
- Haverá slices.
- Motivo: a tarefa envolve integração com serviço de plataforma (`share_plus`), comportamento visível na `PedidoPage`, testes unitários e teste de fluxo por widget. Separar em etapas reduz o risco de regressão no e-mail e no salvamento.

## Validações recomendadas
- `flutter analyze`
- `flutter test test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
