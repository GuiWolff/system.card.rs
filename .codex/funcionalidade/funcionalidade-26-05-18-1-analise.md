# Análise da tarefa

## Pedido original
- Analisar o serviço externo `E:\projetos\argo\argo.portal.cliente\lib\service\compartilhamento\compartilhamento_service_web.dart`.
- Copiar/adaptar o sistema de compartilhamento de PDF para este projeto.
- Criar ou ajustar um serviço de compartilhamento de PDF.
- Usar o compartilhamento no botão `Compartilhar` do `ReciboPdfPreviewDialog`, identificado pela chave `recibo-pdf-preview-compartilhar`.

## Regras e skills aplicáveis
- `AGENTS.md`: regras gerais do projeto, idioma pt-BR, arquitetura vertical feature-first, preservação de padrões existentes e validação com `flutter analyze`.
- `.codex/rules/RULE.md`: mudança pequena, localizada, sem reescrever arquivos inteiros, sem commit automático e preservando alterações existentes no worktree.
- `.codex/skills/argo-flutter-dev/SKILL.md`: aplicável por envolver Dart/Flutter, feature, service, widget, testes e validações.
- `.codex/skills/argo-flutter-dev/references/tema.md`: não é leitura obrigatória para a execução se não houver mudança visual, tema, cores, tipografia ou mensagens de erro. Se a execução alterar textos visíveis, feedback visual ou snackbar, deve ser lida antes da alteração.
- `.codex/skills/argo-rule-manager/SKILL.md`: não aplicável, pois a tarefa não pede alteração em regras, skills ou prompts persistentes.
- `.codex/base-prompt-tarefas.md`: usado como gerador dos artefatos de planejamento desta tarefa.

## Feature correspondente
- Feature: `pedido_page`.
- Caminho principal: `lib/features/pedido_page/`.
- Justificativa: o PDF, a prévia do recibo e o compartilhamento pertencem ao fluxo do pedido/recibo.

## Arquivos relacionados
- `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
- `lib/features/pedido_page/services/recibo_pdf_service.dart`
- `lib/features/pedido_page/pedido_page.dart`
- `pubspec.yaml`
- `pubspec.lock`
- `test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Referência externa analisada: `E:\projetos\argo\argo.portal.cliente\lib\service\compartilhamento\compartilhamento_service_web.dart`

## Estado atual
- O projeto já possui `share_plus` no `pubspec.yaml` e no `pubspec.lock`.
- A feature `pedido_page` já possui `ReciboCompartilhamentoService`.
- O serviço atual já usa `SharePlus.instance.share(params)` por injeção de função testável.
- O compartilhamento genérico já monta `ShareParams` com arquivo PDF em memória por `XFile.fromData`, `mimeType: 'application/pdf'` e `fileNameOverrides`.
- A `PedidoPage` já injeta `ReciboCompartilhamentoService` e passa um callback `onCompartilharPdf` para `ReciboPdfPreviewDialog`.
- O botão `recibo-pdf-preview-compartilhar` já chama `onCompartilharPdf?.call()`.
- Existem testes cobrindo `compartilharGenerico` e o compartilhamento pela prévia do PDF.
- O contrato `pedido_page-contrato.md` já registra comportamento relacionado ao compartilhamento genérico por `share_plus`.

## Estado esperado
- O botão `Compartilhar` da prévia do PDF deve acionar o compartilhamento do PDF já gerado, usando os bytes e o nome do arquivo exibido no diálogo.
- O serviço de compartilhamento deve centralizar a integração com `share_plus`, sem acoplar o widget diretamente a APIs de plataforma quando o padrão atual já usa callback injetado pela página.
- O PDF deve ser enviado como arquivo, com nome previsível e MIME type `application/pdf`.
- A implementação deve preservar o fluxo existente de geração, prévia, salvar arquivo, imprimir e compartilhar pelo popup principal.
- Se o código atual já atender ao comportamento pedido, a execução deve evitar duplicar serviço ou trocar APIs sem ganho real; deve apenas ajustar lacunas comprovadas, testes ou contrato.

## Riscos e dependências
- `share_plus` pode ter comportamento diferente por plataforma, especialmente Web/Desktop, e o app receptor pode ignorar nome, assunto, texto ou anexo.
- O exemplo externo usa `XFile(fileName, bytes: bytes, name: fileName)`, enquanto o projeto atual usa `XFile.fromData` com `mimeType` e `fileNameOverrides`; a execução deve escolher a forma mais compatível com a versão instalada e com os testes existentes.
- Acoplar `ReciboPdfPreviewDialog` diretamente ao serviço pode piorar testabilidade e misturar responsabilidade visual com integração de plataforma. O padrão atual de callback deve ser preservado, salvo necessidade técnica clara.
- `PedidoPageViewModel` não deve acessar `BuildContext`, `share_plus`, `file_picker` ou widgets.
- A tarefa toca arquivos já modificados no worktree; a execução deve preservar alterações existentes e fazer mudanças pequenas.

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que precisam ser criados:
  - Nenhum contrato novo é necessário, pois não há nova Page/View/Tela.
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`, caso a execução altere comportamento real da `PedidoPage` ou do `ReciboPdfPreviewDialog`.
- Revisão feita nesta análise:
  - O contrato existente já contém registros sobre `ReciboPdfPreviewDialog`, `ReciboCompartilhamentoService`, `share_plus`, `XFile.fromData`, nome previsível do PDF e testes relacionados ao compartilhamento. Por isso, este gerador não alterou o contrato neste momento.

## Estratégia
- Validar o comportamento existente antes de alterar código.
- Reaproveitar `ReciboCompartilhamentoService` como serviço da feature, em vez de criar estrutura horizontal ou serviço duplicado.
- Se houver lacuna, ajustar somente o método de compartilhamento genérico ou a conexão da `PedidoPage` com o `ReciboPdfPreviewDialog`.
- Manter `ReciboPdfPreviewDialog` como componente visual que recebe callback, preservando o contrato público atual.
- Atualizar ou adicionar testes apenas se a lacuna não estiver coberta pelos testes existentes.
- Atualizar `pedido_page-contrato.md` somente se a execução fizer alteração comportamental.

## Decisão sobre slices
- Não haverá slices.
- Motivo: a tarefa é pequena, localizada na feature `pedido_page`, validável com testes específicos de serviço/página e `flutter analyze`.

## Validações recomendadas
- `flutter analyze`
- `flutter test test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- Verificar imports não utilizados em arquivos alterados.
