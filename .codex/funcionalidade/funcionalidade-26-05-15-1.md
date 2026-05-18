# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise desta tarefa antes de executar qualquer alteração.
Esta tarefa foi dividida em 2 slices.

## Análise da tarefa
- `docs/codex/funcionalidade/funcionalidade-26-05-15-1-analise.md`

## Objetivo geral
- Corrigir o compartilhamento do recibo em PDF por WhatsApp para que o arquivo PDF seja enviado como payload principal, evitando o comportamento atual em que apenas o texto `Recibo em PDF` é compartilhado.

## Arquivos principais envolvidos
- `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contrato que cada slice deve criar, atualizar ou revisar:
  - Slice 1: revisar o contrato como referência, sem alteração obrigatória se o ajuste ficar restrito ao serviço.
  - Slice 2: atualizar `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` com o comportamento esperado do WhatsApp.
- Não criar contrato novo, porque a tarefa não cria Page/View/Tela.

## Slices da tarefa

### Slice 1/2 - Payload do WhatsApp no serviço
Arquivo: `docs/codex/funcionalidade/funcionalidade-26-05-15-1-parte_1.md`
Resumo esperado: `docs/codex/funcionalidade/funcionalidade-26-05-15-1-parte_1-resumo.md`

Atividades:
1. Ajustar `ReciboCompartilhamentoService` para montar payload específico para WhatsApp.
2. Garantir que WhatsApp envie o PDF em `files` com `application/pdf` e `fileNameOverrides`.
3. Remover `text` e `subject` do payload de WhatsApp para evitar envio apenas da mensagem.
4. Preservar o comportamento de e-mail e salvar arquivo.
5. Criar ou ajustar testes unitários do serviço para cobrir o payload do WhatsApp.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`

### Slice 2/2 - Fluxo da tela e contrato
Arquivo: `docs/codex/funcionalidade/funcionalidade-26-05-15-1-parte_2.md`
Resumo esperado: `docs/codex/funcionalidade/funcionalidade-26-05-15-1-parte_2-resumo.md`

Atividades:
1. Validar na `PedidoPage` que a opção `WhatsApp` do popup usa o PDF gerado e o nome esperado do arquivo.
2. Ajustar ou criar teste de widget selecionando `WhatsApp` em `ReciboCompartilhamentoDialog`.
3. Preservar os fluxos de e-mail, salvar arquivo, imprimir e gerar PDF.
4. Atualizar o contrato da `PedidoPage` com o comportamento corrigido.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`

## Regras gerais
- Executar apenas um slice por vez.
- Nunca executar slices em paralelo.
- Nunca avançar para o próximo slice sem o resumo do slice atual.
- Se um resumo de slice já existir e estiver válido, não repetir esse slice.
- Cada slice deve considerar o estado atualizado do código produzido pelo slice anterior.
- Cada slice que alterar UI deve criar ou atualizar o respectivo `[nome-da-tela]-contrato.md`.
- Preservar alterações existentes no worktree.
- Não fazer commit automaticamente.
- Não implementar envio direto nativo para WhatsApp por deep link.
- Não remover a opção `WhatsApp` do popup.
- Não alterar a geração do PDF A4 se o problema estiver restrito ao compartilhamento.

## Resultado esperado
- O usuário seleciona `Compartilhar > WhatsApp` e o fluxo entrega à folha de compartilhamento um PDF real com nome previsível.
- O payload de WhatsApp deixa de enviar a mensagem `Recibo em PDF` como conteúdo textual principal.
- O e-mail continua com assunto, texto e destinatário sugerido quando disponível.
- O salvamento de arquivo continua gravando os mesmos bytes do PDF.
- Os testes cobrem o payload de WhatsApp e o caminho da `PedidoPage`.
