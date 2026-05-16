# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 2/2 derivado de `docs/codex/funcionalidade/funcionalidade-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/funcionalidade/funcionalidade-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/funcionalidade/funcionalidade-26-05-15-1-parte_1-resumo.md`
- Antes de executar, confirme que o serviço já possui teste cobrindo o payload de WhatsApp com PDF e sem texto/assunto.

## Arquivos
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contrato que este slice deve atualizar ou revisar:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não criar contrato novo, porque a tarefa não cria nova Page/View/Tela.

## Regras
- Validar o caminho real da tela: botão `Compartilhar`, popup, opção `WhatsApp`, geração do PDF e chamada do serviço.
- Preferir teste de widget com serviço fake, sem depender de folha nativa do sistema.
- Garantir que a opção `WhatsApp` recebe os mesmos bytes retornados por `ReciboPdfService.gerarPdfA4`.
- Garantir que o nome do arquivo segue `recibo-[numero].pdf`.
- Não alterar a UI se o fluxo já estiver correto.
- Se alterar texto de feedback, manter a mensagem honesta: o app abriu/enviou para compartilhamento, sem prometer que o WhatsApp concluiu o envio.
- Preservar e-mail, salvar arquivo, imprimir, gerar PDF, histórico e clientes.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não criar `ReciboPage`, rota nova ou feature paralela.
- Não adicionar dependência nova para WhatsApp sem necessidade.

## Entregáveis
1. Teste de `PedidoPage` cobrindo seleção da opção `WhatsApp` no popup.
2. Garantia de que o serviço fake recebe `destino: whatsapp`, bytes do PDF e nome do arquivo.
3. Ajustes mínimos na tela somente se os testes mostrarem falha de integração.
4. Atualização/revisão de `pedido_page-contrato.md`.
5. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/funcionalidade/funcionalidade-26-05-15-1-parte_2-resumo.md`.

# Descrição
- Fechar a correção pelo fluxo visível da `PedidoPage`, garantindo que o usuário que escolhe WhatsApp compartilha o PDF gerado pelo recibo atual.

## Objetivo
- Ao final deste slice, a tela deve ter teste cobrindo a opção WhatsApp e o contrato da `PedidoPage` deve registrar o comportamento esperado do compartilhamento com anexo PDF.
