# Resumo do Slice 5/5 - Rolagem estável da PedidoPage

## O que foi feito
- Corrigido o `PedidoPageLayout` para usar um `ScrollController` explícito.
- O mesmo controller passou a ser compartilhado entre `Scrollbar` e `SingleChildScrollView`.
- O `SingleChildScrollView` passou a usar `primary: false` por ter controller explícito.
- `PedidoPageLayout` foi convertido para `StatefulWidget` somente para gerenciar o ciclo de vida do controller.
- O controller é descartado em `dispose()`.
- Adicionado teste que monta o layout com conteúdo maior que a área visível e executa rolagem sem lançar exceção.

## Impacto em UI
- Não há mudança visual intencional.
- O impacto é de estabilidade da rolagem da `PedidoPage` em Web/Desktop/Mobile, evitando a exceção `The Scrollbar's ScrollController has no ScrollPosition attached`.
- Foram preservados `SafeArea`, padding responsivo, largura máxima, resumo lateral e ordem visual de cabeçalho, recibo e resumo.

## Contrato atualizado
- Atualizado `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Justificativa: o slice altera o comportamento público de rolagem da `PedidoPage`.

## Regras, skills e referências lidas
- `AGENTS.md`
- `.codex/rules/RULE.md`
- `.codex/skills/argo-flutter-dev/SKILL.md`
- `.codex/skills/argo-flutter-dev/references/tema.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-analise.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_4-resumo.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_5.md`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Validações executadas
- `dart format lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter analyze`

## Bloqueios
- Nenhum bloqueio encontrado.
