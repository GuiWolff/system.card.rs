# Resumo da tarefa

## Tarefa solicitada
- Gerar planejamento para ajustar o compartilhamento do PDF do recibo.
- Remover a opção específica `WhatsApp` do popup aberto por `Compartilhar`.
- Adicionar uma opção genérica chamada `Compartilhar`, que cobre WhatsApp e demais destinos pela folha de compartilhamento do sistema.
- Garantir que o PDF seja o arquivo compartilhado, e não apenas um título/texto.

## Arquivos de prompt criados
- `.codex/recibo/recibo-26-05-18-1-analise.md`
- `.codex/recibo/recibo-26-05-18-1.md`
- `.codex/recibo/recibo-26-05-18-1-resumo.md`

## Slices
- Não foram criados slices.
- A tarefa deve ser executada em uma única etapa, porque enum, diálogo, página, serviço e testes precisam permanecer sincronizados.

## Ordem correta de execução
1. Executar `.codex/recibo/recibo-26-05-18-1.md`.
2. Ler o contrato `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
3. Aplicar a mudança no diálogo, na página, no serviço e nos testes.
4. Atualizar o contrato da `PedidoPage` com o resultado real da implementação.
5. Rodar validações.

## Validações esperadas
- `flutter test test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter analyze`

## Contratos de tela criados, atualizados ou revisados
- Revisado e atualizado no planejamento:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- A execução da implementação deve atualizar o mesmo contrato com o resultado real.

## Regras e skills aplicáveis registradas
- `AGENTS.md`
- `.codex/rules/RULE.md`
- `.codex/skills/argo-flutter-dev/SKILL.md`
- `.codex/skills/argo-flutter-dev/references/tema.md`

## Observações importantes para continuidade
- O nome de pasta informado foi `recebo`, mas o planejamento foi salvo em `.codex/recibo` para manter consistência com os artefatos e a feature existentes.
- A implementação real do recibo está em `lib/features/pedido_page/`.
- O comportamento anterior que preservava a opção `WhatsApp` fica substituído por esta nova tarefa.
- O primeiro arquivo a executar é `.codex/recibo/recibo-26-05-18-1.md`.

## Execução realizada em 2026-05-18
- `ReciboCompartilhamentoDialog` passou a exibir `E-mail`, `Compartilhar` e `Salvar arquivo`.
- A opção visual `WhatsApp` foi removida do popup de compartilhamento do recibo.
- `ReciboCompartilhamentoOpcao` passou a usar `compartilhar` para a ação genérica.
- `PedidoPage._executarCompartilhamento` passou a chamar `ReciboCompartilhamentoService.compartilharGenerico` para a opção genérica.
- `ReciboCompartilhamentoService.compartilharGenerico` envia o PDF por `ShareParams.files` com `XFile.fromData`, MIME type `application/pdf` e `fileNameOverrides` com `recibo-[numero].pdf`.
- O compartilhamento genérico não envia `title`, `text` nem `subject`.
- `compartilharPorWhatsapp` foi preservado como API legada interna, delegando para o compartilhamento genérico.
- Os fluxos de `E-mail`, `Salvar arquivo`, `Gerar PDF` e `Imprimir` foram preservados.
- O PDF continua sendo gerado por `ReciboPdfService.gerarPdfA4`.

## Arquivos alterados na execução
- `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Impacto em UI
- Houve impacto em UI no popup `ReciboCompartilhamentoDialog`.
- O contrato atualizado foi `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Não foi criada nova Page/View/Tela.

## Validações executadas
- `flutter test test/features/pedido_page/services/recibo_compartilhamento_service_test.dart` passou.
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart` passou.
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart` passou.
- `flutter analyze` passou sem issues.

## Regras e skills lidas na execução
- `AGENTS.md`
- `.codex/rules/RULE.md`
- `.codex/skills/argo-flutter-dev/SKILL.md`
- `.codex/skills/argo-flutter-dev/references/tema.md`
- `.codex/recibo/recibo-26-05-18-1-analise.md`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Bloqueios
- Nenhum bloqueio encontrado.
