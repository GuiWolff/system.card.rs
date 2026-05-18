# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 2/2 derivado de `docs/codex/recibo/recibo-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/recibo/recibo-26-05-15-1-parte_1-resumo.md`
- Antes de iniciar, leia o resumo do slice 1 e preserve a regra de geração incremental criada no repository.

## Arquivos
- `lib/features/pedido_page/domain/repositories/recibo_repository.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/widget_test.dart`, se o fluxo inicial do app for impactado.

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar `pedido_page-contrato.md` com o comportamento final do número incremental no formulário da `PedidoPage`.

## Regras
- Conectar a geração do próximo número à `PedidoPageViewModel`.
- A ViewModel não deve acessar `BuildContext`.
- Se o repository estiver configurado, o recibo novo deve receber o próximo número incremental por comando assíncrono da ViewModel.
- `iniciarNovoRecibo` deve preparar um novo recibo com próximo número quando possível.
- O fluxo de salvar recibo novo deve continuar retornando o objeto persistido com `criadoEm` preenchido.
- O campo de número no `ReciboFormulario` deve comunicar que o número é gerado automaticamente, evitando edição manual quando isso for coerente com o comportamento definido no slice 1.
- Carregar recibo do histórico deve preservar o número já salvo.
- Duplicar recibo não deve criar conflito com a numeração incremental. Se a duplicação persistir como novo recibo, ela deve receber novo número no momento adequado ou ficar claramente fora do fluxo de salvamento até ser ajustada.
- Preservar os demais campos e regras de cálculo do recibo.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não altere schema SQLite neste slice, salvo se o resumo do slice 1 indicar pendência real.
- Não implemente impressão real, PDF real ou exportação.
- Não crie `ReciboPage`.
- Não execute automaticamente outro prompt.
- Não faça commit.

## Entregáveis
1. ViewModel preparando número incremental para recibos novos.
2. UI do formulário ajustada para número gerado automaticamente.
3. Testes de ViewModel cobrindo inicialização, novo recibo e salvamento com número incremental.
4. Testes de widget/Page cobrindo exibição do número e fluxo de novo recibo.
5. Atualizar `pedido_page-contrato.md`.
6. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
7. Rodar validações específicas.
8. Salvar resumo em `docs/codex/recibo/recibo-26-05-15-1-parte_2-resumo.md`.

# Descrição
- Integrar a numeração incremental ao estado e à UI da `PedidoPage`.

## Objetivo
- Ao final deste slice, o usuário deve ver recibos novos com número incremental automático, e os recibos persistidos devem manter `criadoEm` como data de criação real.
