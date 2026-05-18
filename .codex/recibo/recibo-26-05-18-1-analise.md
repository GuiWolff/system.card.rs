# Análise da tarefa

## Pedido original
- Pasta informada pelo usuário: `recebo`; para manter consistência com a feature e os artefatos existentes, a tarefa será registrada em `.codex/recibo`.
- Ao clicar em `Compartilhar`, o popup atual exibe `E-mail`, `WhatsApp` e `Salvar arquivo`.
- Remover a opção específica `WhatsApp` e colocar uma opção chamada `Compartilhar`, porque essa opção genérica cobre WhatsApp e demais destinos de compartilhamento.
- Corrigir o problema percebido no fluxo de WhatsApp, em que somente o título chega ao destino e o arquivo PDF não é enviado.

## Regras e skills aplicáveis
- `AGENTS.md`
- `.codex/rules/RULE.md`
- `.codex/skills/argo-flutter-dev/SKILL.md`
- `.codex/skills/argo-flutter-dev/references/tema.md`
- `.codex/base-prompt-tarefas.md`
- A skill `argo-rule-manager` não é aplicável, porque a tarefa não altera regras persistentes, skills ou referências de governança.

## Feature correspondente
- Feature funcional: recibo.
- Implementação atual: `lib/features/pedido_page/`.
- A tela agregadora do fluxo é `PedidoPage`, em `lib/features/pedido_page/presentation/pages/pedido_page.dart`.

## Arquivos relacionados
- `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`

## Estado atual
- `ReciboPedido` já possui o botão principal `Compartilhar`.
- Ao acionar esse botão, `PedidoPage._abrirCompartilhamentoPdf` abre `ReciboCompartilhamentoDialog`.
- O diálogo usa `ReciboCompartilhamentoOpcao { email, whatsapp, salvarArquivo }`.
- As opções visíveis são `E-mail`, `WhatsApp` e `Salvar arquivo`.
- A seleção de `WhatsApp` chama `ReciboCompartilhamentoService.compartilharPorWhatsapp`.
- O serviço já monta um `XFile.fromData` com `mimeType: application/pdf`, mas a opção ainda é direcionada semanticamente para WhatsApp e o usuário relata que o destino recebe apenas o título, sem o PDF.
- O contrato da `PedidoPage` contém registros anteriores que preservavam a opção específica `WhatsApp`; esta nova tarefa substitui esse comportamento.

## Estado esperado
- O popup de compartilhamento deve exibir exatamente:
  - `E-mail`;
  - `Compartilhar`;
  - `Salvar arquivo`.
- A opção `WhatsApp` não deve aparecer no popup.
- A opção `Compartilhar` deve abrir o compartilhamento do sistema com o PDF como payload principal.
- O compartilhamento genérico não deve depender de rótulo, canal, deep link ou texto específico de WhatsApp.
- O PDF deve continuar sendo gerado por `ReciboPdfService.gerarPdfA4`.
- O arquivo compartilhado deve manter:
  - bytes reais do PDF;
  - MIME type `application/pdf`;
  - nome previsível no padrão `recibo-[numero].pdf`.
- E-mail e salvamento de arquivo devem preservar o comportamento atual.

## Riscos e dependências
- O comportamento final da folha de compartilhamento depende da plataforma e do aplicativo escolhido pelo usuário.
- `share_plus` pode tratar `title`, `text`, `subject` e arquivos de maneira diferente conforme plataforma; por isso, o compartilhamento genérico deve priorizar `files` e evitar texto/assunto quando o objetivo for enviar o PDF.
- Alterar enum e nomes de opções pode quebrar testes e switches se a mudança não for feita de forma coordenada.
- Evitar remover APIs legadas do serviço sem necessidade; se alguma API pública interna for substituída, atualizar todos os usos e testes relacionados no mesmo passo.
- `PedidoPageViewModel` não deve acessar `BuildContext`, widgets, `share_plus`, `file_picker` ou APIs de plataforma.

## Contratos de tela
- Contrato existente lido e revisado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não há nova Page/View/Tela a criar.
- O contrato da `PedidoPage` precisa ser atualizado porque o popup de compartilhamento muda visualmente e funcionalmente.

## Estratégia
- Tratar a opção genérica como uma ação de compartilhamento de PDF independente de aplicativo.
- Atualizar primeiro o enum e a UI do `ReciboCompartilhamentoDialog`.
- Atualizar a seleção em `PedidoPage._executarCompartilhamento` para chamar um método genérico de compartilhamento.
- Ajustar `ReciboCompartilhamentoService` para expor/usar um canal genérico que compartilhe o arquivo PDF sem texto ou assunto de WhatsApp.
- Atualizar testes unitários e de widget para validar que `WhatsApp` sumiu e `Compartilhar` envia o PDF.
- Revisar o contrato da `PedidoPage` com o comportamento planejado e, na implementação, atualizar com o resultado real.

## Decisão sobre slices
- Não haverá slices.
- A mudança é pequena e localizada em um único fluxo; dividir em slices aumentaria o risco de deixar enum, switch, UI e testes temporariamente inconsistentes.

## Validações recomendadas
- `flutter test test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter analyze`
