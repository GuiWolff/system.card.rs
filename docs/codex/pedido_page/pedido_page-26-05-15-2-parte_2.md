# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior.
Este é o slice 2/3 derivado de `docs/codex/pedido_page/pedido_page-26-05-15-2.md`.

## Análise da tarefa
- `docs/codex/pedido_page/pedido_page-26-05-15-2-analise.md`

## Continuidade
- Slice anterior: `docs/codex/pedido_page/pedido_page-26-05-15-2-parte_1-resumo.md`

## Arquivos
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`
- `lib/observable/obx.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Este slice impacta a Page e deve atualizar:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Regras
- Substituir `AnimatedBuilder` por `Obx`.
- Garantir que as leituras reativas aconteçam dentro do builder do `Obx`.
- Não usar `setState()` na feature `pedido_page`.
- Não alterar `obx.dart` para remover o `setState` interno dele; esse é detalhe da infraestrutura reativa existente.
- Manter a `PedidoPage` como agregadora.
- Manter os encaixes temporários de Cabeçalho, Recibo e Resumo.
- Manter a injeção opcional de `PedidoPageViewModel` para testes.
- Se `StatefulWidget` continuar existindo, ele deve servir apenas para ciclo de vida da ViewModel.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não duplicar regras internas de Cabeçalho, Recibo ou Resumo.

## Entregáveis
1. `PedidoPage` observando a ViewModel com `Obx`.
2. Remoção do uso de `AnimatedBuilder` na `PedidoPage`.
3. Testes de widget atualizados para o comportamento reativo.
4. Atualização de `pedido_page-contrato.md`.
5. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/pedido_page/pedido_page-26-05-15-2-parte_2-resumo.md`.

# Descrição
- Migre a observação visual da `PedidoPage` para `Obx`, mantendo o layout e os textos atuais.
- Ajuste os testes para aguardar a atualização reativa quando callbacks alterarem a ViewModel.

## Objetivo
- Ao final deste slice, a Page deve atualizar o resumo temporário por meio de `Obx`, sem `AnimatedBuilder` e sem `setState()` na feature.
