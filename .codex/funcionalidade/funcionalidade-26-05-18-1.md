# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise desta tarefa antes de executar qualquer alteração.

## Análise da tarefa
- `.codex/funcionalidade/funcionalidade-26-05-18-1-analise.md`

## Regras e skills aplicáveis
- Leia `AGENTS.md`.
- Leia `.codex/rules/RULE.md`.
- Leia `.codex/skills/argo-flutter-dev/SKILL.md`.
- Leia `.codex/skills/argo-flutter-dev/references/tema.md` apenas se alterar UI visual, tema, cores, tipografia, textos visíveis ou mensagens de erro.
- Se houver conflito entre este prompt e uma regra ou skill aplicável, pare e reporte o bloqueio.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
- `lib/features/pedido_page/pedido_page.dart`
- `test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Referência externa: `E:\projetos\argo\argo.portal.cliente\lib\service\compartilhamento\compartilhamento_service_web.dart`

## Contratos de tela
- Leia o contrato existente:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não crie contrato novo para o diálogo se ele continuar sendo apenas widget interno da `PedidoPage`.
- Atualize `pedido_page-contrato.md` somente se houver mudança real no comportamento da tela, no fluxo do diálogo de prévia ou nas ações disponíveis ao usuário.
- Se a execução apenas confirmar que o comportamento já existe e não alterar UI, registre no resumo final que o contrato foi revisado sem alteração.

## Regras
- Trabalhe dentro da feature `pedido_page`.
- Não crie estrutura horizontal global como `lib/services/`.
- Reaproveite `ReciboCompartilhamentoService` se ele já cumprir o papel de serviço de compartilhamento de PDF.
- Preserve `ReciboPdfPreviewDialog` como widget de apresentação sempre que possível; ele deve acionar `onCompartilharPdf`, e a página deve coordenar o serviço.
- Não remova o callback `onCompartilharPdf` nem quebre o contrato público do widget.
- Não remova fluxos existentes de salvar arquivo, imprimir, gerar PDF, e-mail ou compartilhamento principal.
- Use `share_plus` por `ShareParams` e arquivo PDF em memória.
- Preserve nome de arquivo previsível, usando o nome recebido pela prévia.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não faça commit automaticamente.
- Não duplique serviço se `ReciboCompartilhamentoService` já atender ao pedido.
- Não copie cegamente código Web com `dart:js_interop` para esta feature, porque o projeto já usa `share_plus` e precisa manter compatibilidade Web/Desktop/Mobile.
- Não faça `PedidoPageViewModel` depender de `BuildContext`, widgets, `share_plus`, `file_picker` ou APIs de plataforma.

## Entregáveis
1. Confirmar ou ajustar o serviço de compartilhamento de PDF da feature.
2. Garantir que o botão `recibo-pdf-preview-compartilhar` compartilhe o PDF da prévia usando `pdfBytes` e `nomeArquivo`.
3. Preservar ou ajustar testes de serviço para validar bytes, nome do arquivo, MIME type `application/pdf` e resultado de compartilhamento.
4. Preservar ou ajustar teste de página garantindo que a prévia chama o serviço com os bytes do PDF gerado.
5. Criar ou atualizar `pedido_page-contrato.md` quando houver alteração real em Page/View/Tela.
6. Registrar no resumo final quais contratos foram criados, atualizados ou revisados.
7. Rodar validações conforme a skill aplicável, incluindo `flutter analyze`.
8. Salvar resumo em `.codex/funcionalidade/funcionalidade-26-05-18-1-resumo.md`.

# Descrição
- Implementar ou confirmar a integração de compartilhamento de PDF no diálogo de prévia do recibo.
- A referência externa mostra um método `compartilharPdf` que cria `ShareParams` com arquivo PDF em bytes e chama `SharePlus.instance.share(params)`.
- No projeto atual, a adaptação deve respeitar a arquitetura vertical por feature e o serviço existente.

## Objetivo
- Ao clicar em `Compartilhar` dentro do `ReciboPdfPreviewDialog`, o usuário deve abrir a folha de compartilhamento do sistema com o PDF já gerado anexado.
- A solução deve ser testável, localizada em `pedido_page`, compatível com Web/Desktop/Mobile e sem duplicar responsabilidades.
