# Análise da tarefa

## Pedido original
- Utilizar `lib/observable/rx.dart` e `lib/observable/obx.dart` na feature `pedido_page`, substituindo o uso atual de `ChangeNotifier`.
- Não utilizar `setState()` na feature.

## Feature correspondente
- Feature: `pedido_page`.
- Caminho principal: `lib/features/pedido_page/`.

## Arquivos relacionados
- Produção:
  - `lib/features/pedido_page/pedido_page.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page.dart`
  - `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`
  - `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/observable/rx.dart`
  - `lib/observable/obx.dart`
  - `lib/observable/rx_observer.dart`
  - `lib/observable/i_rx_subscribe.dart`
- Testes:
  - `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
  - `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
  - `test/widget_test.dart`
- Contexto de planejamento anterior:
  - `docs/codex/pedido_page/pedido_page-26-05-15-1.md`
  - `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_4-resumo.md`

## Estado atual
- A `PedidoPage` existe como tela agregadora de Cabeçalho, Recibo e Resumo.
- A tela ainda usa encaixes temporários, porque os componentes reais de Cabeçalho, Recibo e Resumo não existem em `lib/`.
- A `PedidoPageViewModel` herda de `ChangeNotifier`.
- A `PedidoPage` observa a ViewModel com `AnimatedBuilder`.
- A `PedidoPage` é `StatefulWidget` para criar e descartar a ViewModel quando ela não é injetada externamente.
- Os testes atuais validam:
  - renderização dos encaixes temporários;
  - resumo derivado da ViewModel compartilhada;
  - callbacks temporários;
  - ordem visual e ausência de overflow.
- A API reativa do projeto já existe em `lib/observable/`, com `Rx<T>` e `Obx`.
- `Obx` usa `setState` internamente como detalhe da infraestrutura reativa. A tarefa deve evitar `setState()` na feature `pedido_page`, não reimplementar `Obx`.

## Estado esperado
- `PedidoPageViewModel` deve deixar de herdar de `ChangeNotifier`.
- O estado coordenado da `PedidoPageViewModel` deve usar `Rx<T>`.
- A `PedidoPage` deve observar estado com `Obx`, não com `AnimatedBuilder`.
- A feature `pedido_page` não deve chamar `setState()`.
- A `PedidoPage` pode continuar sendo `StatefulWidget` somente para ciclo de vida da ViewModel, caso necessário, desde que não use `setState`.
- A API pública útil da ViewModel deve ser preservada quando possível:
  - getters de valores em centavos;
  - getters formatados;
  - métodos de atualização do recibo e callback do cabeçalho;
  - `dispose()`.
- Os testes devem ser ajustados para o comportamento assíncrono de notificação por microtask do `Rx`, usando `pump` ou `pumpAndSettle` quando necessário.
- O contrato da `PedidoPage` deve registrar que a tela usa `Rx`/`Obx` como mecanismo de estado.

## Riscos e dependências
- `Rx<T>` notifica por microtask por padrão; testes que verificam atualização visual precisam aguardar novo frame.
- Remover `ChangeNotifier` quebra diretamente testes que usam `addListener`. Esses testes devem ser migrados para validar estado reativo ou comportamento observado por `Obx`.
- A troca para `Obx` deve evitar rebuild amplo desnecessário. O ideal é envolver apenas a região que depende dos valores reativos.
- A `PedidoPageViewModel` deve descartar todos os `Rx` criados internamente.
- O uso de getters que leem `.value` dentro de `Obx` é importante para registrar dependência no `RxDependencyTracker`.
- Não alterar a implementação de `rx.dart` e `obx.dart` salvo se houver erro real e diretamente relacionado à migração.
- Há um bloqueio de validação conhecido fora do escopo desta tarefa: `lib/utils/tema.dart` importa `shared_preferences`, mas essa dependência não está disponível no `pubspec.yaml`. Se `flutter analyze` falhar apenas por esse ponto preexistente, o executor deve registrar o bloqueio no resumo sem corrigir arquivos fora da feature sem autorização explícita.

## Contratos de tela
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não é esperado atualizar `recibo_page-contrato.md`, pois a tarefa altera apenas o mecanismo de estado da `PedidoPage` e não redefine responsabilidades da `ReciboPage`.
- Há impacto em UI indireto: a renderização deve continuar igual, mas o mecanismo de atualização passa de `AnimatedBuilder`/`ChangeNotifier` para `Obx`/`Rx`.

## Estratégia
- Fazer a migração em etapas pequenas.
- Primeiro migrar a ViewModel para `Rx<T>`, mantendo getters e métodos atuais sempre que possível.
- Depois trocar a observação da `PedidoPage` para `Obx`, removendo `AnimatedBuilder` e evitando `setState`.
- Por fim, revisar testes, contrato e validações finais, registrando qualquer bloqueio externo ao escopo.

## Decisão sobre slices
- Haverá slices.
- Justificativa:
  - a tarefa altera ViewModel, UI e testes;
  - envolve estado reativo;
  - há risco de regressão em callbacks e atualização do resumo;
  - é necessário validar cada etapa antes de avançar.

## Validações recomendadas
- `dart format lib/features/pedido_page/pedido_page.dart lib/features/pedido_page/presentation/pages/pedido_page.dart lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart test/features/pedido_page/presentation/pages/pedido_page_test.dart test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/widget_test.dart`
- `flutter analyze`
- Se `flutter analyze` falhar apenas por `lib/utils/tema.dart` e `shared_preferences`, registrar como bloqueio preexistente fora do escopo.
