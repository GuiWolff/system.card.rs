# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/2 derivado de `docs/codex/funcionalidade/funcionalidade-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/funcionalidade/funcionalidade-26-05-15-1-analise.md`

## Continuidade
- Este é o primeiro slice. Não há resumo anterior.

## Arquivos
- `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
- `test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- Referência de contrato a ler:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Neste slice, o ajuste deve ficar no serviço de compartilhamento.
- Se não houver alteração de Page/View/Tela neste slice, não atualize o contrato agora, mas registre no resumo que a atualização ficará para o slice 2.

## Regras
- Construir o `ShareParams` do WhatsApp separadamente do e-mail.
- Para WhatsApp, manter o PDF em `files` usando `XFile.fromData` ou caminho equivalente suportado pelo projeto.
- Para WhatsApp, manter `mimeType: application/pdf`.
- Para WhatsApp, manter `fileNameOverrides: [nomeArquivo]`.
- Para WhatsApp, não preencher `text` com `Recibo em PDF`.
- Para WhatsApp, não preencher `subject` com `Recibo em PDF`.
- Se for necessário manter `title` para compatibilidade da folha de compartilhamento, o título não deve ser usado como texto da mensagem.
- Preservar o fluxo de e-mail com assunto, texto e destinatário sugerido.
- Preservar o fluxo `salvarArquivo` sem mudança de comportamento.
- Não adicionar dependência nova sem necessidade.
- Não mover regra de compartilhamento para a `PedidoPage` ou para a ViewModel.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não alterar `ReciboPdfService`.
- Não alterar `ReciboCompartilhamentoDialog`.
- Não criar integração nativa específica do WhatsApp por deep link.

## Entregáveis
1. `ReciboCompartilhamentoService` ajustado para WhatsApp enviar PDF sem texto/assunto.
2. Teste unitário garantindo que `compartilharPorWhatsapp` envia bytes, nome e MIME type do PDF.
3. Teste unitário garantindo que `compartilharPorWhatsapp` não envia `text` nem `subject`.
4. Testes existentes de e-mail e salvamento preservados.
5. Registrar no resumo do slice que não houve alteração direta de UI, se o contrato não for atualizado neste slice.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/funcionalidade/funcionalidade-26-05-15-1-parte_1-resumo.md`.

# Descrição
- Corrigir o payload usado pelo serviço de compartilhamento quando o canal selecionado é WhatsApp. O foco é impedir que o receptor compartilhe apenas o texto `Recibo em PDF` e ignore o arquivo.

## Objetivo
- Ao final deste slice, o serviço deve produzir um `ShareParams` de WhatsApp cujo payload principal seja o arquivo PDF, mantendo e-mail e salvamento sem regressão.
