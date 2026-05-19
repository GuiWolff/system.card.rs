# Resumo do Slice 4/5 - Ações de saída na prévia do PDF

## O que foi feito
- Removidas as ações visuais `Imprimir` e `Compartilhar` da linha de ações rápidas do `ReciboPedido`.
- Mantida a ação `Gerar PDF` como entrada principal para abrir a prévia.
- Adicionada a ação `Imprimir` em `ReciboPdfPreviewDialog`.
- A impressão pela prévia reutiliza os `pdfBytes` e o `nomeArquivo` já gerados para a visualização, sem chamar novamente `ReciboPdfService.gerarPdfA4`.
- As ações `Compartilhar` e `Salvar arquivo` da prévia continuam usando `ReciboCompartilhamentoService` com o PDF já gerado.
- `ReciboCompartilhamentoDialog`, `ReciboImpressaoService` e `ReciboCompartilhamentoService` foram preservados.
- A API pública de `ReciboPedido` foi preservada; os parâmetros legados `onImprimir` e `onCompartilharPdf` não foram removidos para evitar quebra no barrel público da feature.

## Impacto em UI
- Sim.
- A barra de ações rápidas do recibo ficou reduzida a ações de edição/gestão e `Gerar PDF`.
- A prévia do PDF passou a concentrar `Imprimir`, `Compartilhar`, `Salvar arquivo` e `Fechar`.

## Contrato atualizado
- Atualizado `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Justificativa: o slice altera o fluxo público de PDF, a localização das ações visuais e o comportamento da prévia.

## Regras, skills e referências lidas
- `AGENTS.md`
- `.codex/rules/RULE.md`
- `.codex/skills/argo-flutter-dev/SKILL.md`
- `.codex/skills/argo-flutter-dev/references/tema.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-analise.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_3-resumo.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_4.md`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Validações executadas
- `dart format lib/features/pedido_page/presentation/pages/pedido_page.dart lib/features/pedido_page/presentation/widgets/recibo_pedido.dart lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart test/features/pedido_page/presentation/pages/pedido_page_test.dart test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter analyze`

## Bloqueios
- Nenhum bloqueio encontrado.
