# Análise da tarefa

## Pedido original
- Ver a documentação oficial do pacote `share_plus` em `https://pub.dev/packages/share_plus`.
- Corrigir o compartilhamento do recibo em PDF para que o documento seja enviado ao escolher WhatsApp, especialmente na versão Windows Desktop.
- Sintoma atual informado: no momento do compartilhamento via WhatsApp, chega somente o título, sem o arquivo PDF.

## Regras e skills aplicáveis
- `AGENTS.md`: idioma pt-BR, uso canônico de `.codex/`, arquitetura vertical feature-first, mudanças pequenas e validação com `flutter analyze`.
- `.codex/rules/RULE.md`: preservar padrões existentes, não reescrever arquivos inteiros, não remover legado sem confirmação, não fazer commit automático.
- `.codex/skills/argo-flutter-dev/SKILL.md`: aplicável por envolver Dart/Flutter, service, Page, testes, compatibilidade Web/Desktop/Mobile e validações Flutter.
- `.codex/skills/argo-flutter-dev/references/tema.md`: não é leitura obrigatória para a execução se não houver alteração visual, tema, cores, tipografia ou mensagens visíveis. Se a execução alterar textos de feedback, deve ser lida antes da alteração.
- `.codex/skills/argo-rule-manager/SKILL.md`: não aplicável, pois a tarefa não pede alteração em regras persistentes, skills ou referências de skills.
- Documentação externa consultada: `https://pub.dev/packages/share_plus`, página oficial do pacote `share_plus` no pub.dev.

## Feature correspondente
- Feature: `pedido_page`.
- Caminho principal: `lib/features/pedido_page/`.
- Justificativa: o compartilhamento do PDF pertence ao fluxo do recibo/pedido e já é centralizado em serviço da feature.

## Arquivos relacionados
- `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
- Possível novo helper dentro da feature, se necessário para compatibilidade Web/Desktop/Mobile:
  - `lib/features/pedido_page/services/recibo_pdf_compartilhavel.dart`
  - `lib/features/pedido_page/services/recibo_pdf_compartilhavel_io.dart`
  - `lib/features/pedido_page/services/recibo_pdf_compartilhavel_web.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`
- `test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `pubspec.yaml`
- `pubspec.lock`

## Estado atual
- O projeto usa `share_plus` declarado no `pubspec.yaml`.
- A documentação oficial atual do `share_plus` informa suporte a arquivos no Windows e orienta passar arquivos em `ShareParams.files`.
- A documentação também informa que dados gerados em memória podem usar `XFile.fromData`, mas que o nome deve ser preservado por `fileNameOverrides`.
- A documentação registra que `XFile.fromData` gera arquivo temporário no cache do app e sugere escrever um `File` manualmente quando for importante controlar esse arquivo.
- O serviço atual usa `SharePlus.instance.share(params)` por função injetável.
- `ReciboCompartilhamentoService.compartilharGenerico` monta `ShareParams` com:
  - `title: Compartilhar recibo`;
  - `files` contendo `XFile.fromData`;
  - `mimeType: application/pdf`;
  - `fileNameOverrides` com nome previsível;
  - sem `text`;
  - sem `subject`.
- A `PedidoPage` chama `compartilharGenerico` tanto pelo popup `Compartilhar` quanto pelo botão `recibo-pdf-preview-compartilhar` da prévia.
- O popup principal exibe `E-mail`, `Compartilhar` e `Salvar arquivo`, sem opção direta `WhatsApp`.
- O contrato da `PedidoPage` já registra que WhatsApp é destino escolhido pela folha do sistema e que o app não deve prometer envio direto para aplicativo específico.
- Apesar disso, o usuário informa que no WhatsApp chega apenas o título, sem arquivo PDF.

## Estado esperado
- Ao acionar `Compartilhar` e escolher WhatsApp na folha do sistema no Windows Desktop, o payload entregue pelo app deve conter o PDF como arquivo principal.
- O payload não deve enviar `text` nem `subject` no canal genérico, para não induzir WhatsApp a receber apenas mensagem textual.
- O PDF deve manter:
  - bytes reais gerados por `ReciboPdfService.gerarPdfA4`;
  - MIME type `application/pdf`;
  - nome previsível `recibo-[numero].pdf`;
  - compatibilidade Web/Desktop/Mobile.
- No Windows Desktop, a execução deve avaliar trocar o `XFile.fromData` por um `XFile` apontando para arquivo temporário real gravado explicitamente pelo app, seguindo a alternativa citada pela documentação do `share_plus`.
- A ViewModel deve continuar sem depender de `BuildContext`, `share_plus`, `file_picker`, `dart:io` ou APIs de plataforma.

## Riscos e dependências
- O pacote `share_plus` não garante que todo aplicativo receptor aceite todo tipo de payload. A documentação registra que apps de terceiros podem implementar o recebimento de compartilhamento de forma incompleta.
- WhatsApp Desktop pode ignorar `StorageItems` da folha nativa do Windows mesmo quando o app entrega corretamente `ShareParams.files`.
- Importar `dart:io` diretamente em arquivo compartilhado com Web quebra compilação Web; se for necessário gravar arquivo temporário no Windows/Desktop, use implementação condicional ou helper isolado.
- Não deve haver cópia cega de código nativo ou dependência direta de WhatsApp.
- Atualizar `share_plus` para a versão mais recente não deve ser feito automaticamente sem avaliar compatibilidade com Flutter/Dart do projeto; a tarefa deve priorizar correção localizada com a versão atual, salvo necessidade comprovada.
- A criação manual de arquivo temporário exige cuidado para não apagar o arquivo antes do app receptor consumi-lo.
- A limpeza de arquivos temporários deve ser conservadora e não bloquear o compartilhamento.

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que precisam ser criados:
  - Nenhum contrato novo é necessário, pois não há nova Page/View/Tela.
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`, se a execução alterar o comportamento público da ação `Compartilhar`, mensagens de feedback, opções do diálogo ou regra de payload documentada para Windows/WhatsApp.
- Impacto em UI:
  - Não há necessidade prevista de alteração visual.
  - Há impacto comportamental na ação de compartilhamento da `PedidoPage`; por isso o contrato existente deve ser revisado e atualizado quando o comportamento final for confirmado.

## Estratégia
- Manter a solução dentro da feature `pedido_page`.
- Reaproveitar `ReciboCompartilhamentoService`; não criar serviço horizontal global.
- Preservar o `ReciboPdfPreviewDialog` como widget de apresentação que chama `onCompartilharPdf`.
- Preservar a `PedidoPage` como coordenadora do serviço.
- Ajustar o serviço para construir o `XFile` de forma mais robusta para Windows Desktop:
  - preferencialmente por helper injetável/testável;
  - usando arquivo temporário real no ambiente IO quando isso for necessário para WhatsApp Desktop;
  - mantendo fallback Web com `XFile.fromData`.
- Preservar `ShareParams.files`, MIME type `application/pdf` e `fileNameOverrides`.
- Manter `text` e `subject` ausentes no canal genérico.
- Cobrir por testes unitários que o canal genérico envia arquivo PDF com nome, MIME type e título, sem texto/assunto.
- Cobrir por teste de página que os bytes gerados chegam ao serviço quando o usuário escolhe `Compartilhar` ou aciona a prévia.

## Decisão sobre slices
- Não haverá slices.
- Justificativa: embora exista risco de plataforma, a alteração esperada é localizada no serviço de compartilhamento e nos testes relacionados. A tarefa é validável em uma execução única com testes específicos e `flutter analyze`.

## Validações recomendadas
- `flutter analyze`
- `flutter test test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- Se viável no ambiente da execução, validar manualmente no Windows Desktop:
  - abrir a `PedidoPage`;
  - gerar um recibo válido;
  - clicar em `Compartilhar`;
  - escolher WhatsApp na folha do sistema;
  - confirmar que o PDF aparece como anexo, não apenas o título.
