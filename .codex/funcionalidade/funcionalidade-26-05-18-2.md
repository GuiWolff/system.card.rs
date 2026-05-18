# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise desta tarefa antes de executar qualquer alteração.

## Análise da tarefa
- `.codex/funcionalidade/funcionalidade-26-05-18-2-analise.md`

## Regras e skills aplicáveis
- Leia `AGENTS.md`.
- Leia `.codex/rules/RULE.md`.
- Leia `.codex/skills/argo-flutter-dev/SKILL.md`.
- Leia `.codex/skills/argo-flutter-dev/references/tema.md` apenas se alterar UI visual, tema, cores, tipografia, textos visíveis ou mensagens de erro.
- Consulte a documentação oficial do `share_plus`: `https://pub.dev/packages/share_plus`.
- Se houver conflito entre este prompt e uma regra ou skill aplicável, pare e reporte o bloqueio.

## Arquivos
- `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
- Possíveis helpers dentro da feature, se necessários:
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

## Contratos de tela
- Leia o contrato existente antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não crie contrato novo.
- Atualize `pedido_page-contrato.md` se houver mudança no comportamento público da ação `Compartilhar`, do diálogo de compartilhamento, da prévia de PDF, do payload documentado ou de mensagens ao usuário.
- Se a alteração ficar restrita ao serviço sem alteração visual, registre no resumo que o contrato foi revisado e atualizado apenas quando necessário por impacto comportamental.

## Regras
- Trabalhe dentro da feature `pedido_page`.
- Reaproveite `ReciboCompartilhamentoService`; não crie serviço horizontal global.
- Use `share_plus` com `SharePlus.instance.share(ShareParams(...))`.
- O canal genérico deve priorizar `ShareParams.files`.
- O canal genérico não deve enviar `text` nem `subject`.
- Preserve `title` quando necessário para Windows Desktop.
- Preserve MIME type `application/pdf`.
- Preserve nome previsível por `fileNameOverrides` com `recibo-[numero].pdf`.
- Preserve o callback `onCompartilharPdf` do `ReciboPdfPreviewDialog`.
- Preserve os fluxos existentes de e-mail, salvar arquivo, imprimir, gerar PDF e prévia.
- `PedidoPageViewModel` não deve depender de `BuildContext`, widgets, `share_plus`, `file_picker`, `dart:io` ou APIs de plataforma.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não faça commit automaticamente.
- Não remova código legado sem confirmação explícita.
- Não restaure opção direta `WhatsApp` no popup sem necessidade comprovada; WhatsApp deve continuar como destino escolhido na folha do sistema.
- Não use deep link de WhatsApp para anexo PDF.
- Não importe `dart:io` em arquivo que precise compilar para Web. Se precisar gravar arquivo temporário para Windows/Desktop, isole isso em implementação condicional dentro da feature.
- Não atualize `share_plus` automaticamente sem necessidade comprovada e sem avaliar compatibilidade do projeto.

## Entregáveis
1. Ajustar o compartilhamento genérico para aumentar a confiabilidade do PDF como anexo no Windows Desktop/WhatsApp.
2. Se necessário, criar helper testável dentro de `lib/features/pedido_page/services/` para construir `XFile` a partir de arquivo temporário real em plataformas IO, preservando fallback Web.
3. Garantir que `compartilharGenerico` envie PDF como arquivo principal, com MIME type `application/pdf`, nome previsível e sem `text`/`subject`.
4. Garantir que o botão `recibo-pdf-preview-compartilhar` continue usando os bytes e o nome do PDF já gerado.
5. Ajustar ou adicionar testes de serviço para validar payload do `ShareParams`, nome do arquivo, MIME type e ausência de texto/assunto.
6. Ajustar ou preservar testes de página garantindo que o PDF gerado chega ao serviço pelo popup e pela prévia.
7. Criar ou atualizar `pedido_page-contrato.md` quando houver alteração comportamental da Page/Tela.
8. Registrar no resumo final quais contratos de tela foram criados, atualizados ou revisados.
9. Rodar validações conforme a skill aplicável, incluindo `flutter analyze`.
10. Rodar testes específicos relacionados.
11. Salvar resumo em `.codex/funcionalidade/funcionalidade-26-05-18-2-resumo.md`.

# Descrição
- Corrigir o compartilhamento do documento PDF do recibo quando o usuário escolhe WhatsApp na folha de compartilhamento, especialmente na versão Windows Desktop.
- A documentação oficial do `share_plus` orienta usar `ShareParams.files` para compartilhar arquivos.
- Para dados gerados em memória, a documentação aceita `XFile.fromData`, mas informa que o pacote grava arquivo temporário no cache e que uma alternativa é escrever o arquivo manualmente para controlar esse arquivo.
- Como o sintoma atual é o WhatsApp receber somente o título, a execução deve avaliar uma solução mais robusta para Windows/Desktop, usando arquivo temporário real quando isso aumentar a compatibilidade com o destino.

## Objetivo
- Ao clicar em `Compartilhar` e selecionar WhatsApp na folha nativa do Windows Desktop, o usuário deve receber o PDF como anexo sempre que o app receptor aceitar arquivos pela folha do sistema.
- O app não deve enviar apenas título, texto ou assunto no canal genérico.
- A solução deve continuar compatível com Web/Desktop/Mobile e manter a arquitetura vertical da feature `pedido_page`.
