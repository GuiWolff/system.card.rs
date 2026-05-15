# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise desta tarefa antes de executar qualquer alteração.
Esta tarefa foi dividida em 3 slices.

## Análise da tarefa
- `docs/codex/pedido_page/pedido_page-26-05-15-2-analise.md`

## Objetivo geral
- Migrar a feature `pedido_page` para usar `Rx<T>` e `Obx` do projeto no lugar de `ChangeNotifier` e `AnimatedBuilder`.
- Não utilizar `setState()` na feature `pedido_page`.
- Preservar o comportamento visual atual da `PedidoPage`, os encaixes temporários e a fonte compartilhada entre recibo temporário e resumo temporário.

## Arquivos principais envolvidos
- `lib/features/pedido_page/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/observable/rx.dart`
- `lib/observable/obx.dart`
- `lib/observable/rx_observer.dart`
- `lib/observable/i_rx_subscribe.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/widget_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que cada slice deve criar, atualizar ou revisar:
  - Slice 1: revisar `pedido_page-contrato.md` somente se a migração da ViewModel alterar o contrato público da tela.
  - Slice 2: atualizar `pedido_page-contrato.md` com a troca de observação para `Obx`.
  - Slice 3: revisar `pedido_page-contrato.md` no fechamento.
- Há impacto em UI indireto: o visual esperado deve permanecer igual, mas o mecanismo de atualização da tela será alterado.

## Slices da tarefa

### Slice 1/3 - ViewModel reativa
Arquivo: `docs/codex/pedido_page/pedido_page-26-05-15-2-parte_1.md`
Resumo esperado: `docs/codex/pedido_page/pedido_page-26-05-15-2-parte_1-resumo.md`

Atividades:
1. Migrar `PedidoPageViewModel` de `ChangeNotifier` para `Rx<T>`.
2. Remover dependência de `package:flutter/foundation.dart` quando ela não for mais necessária.
3. Preservar getters e métodos públicos úteis da ViewModel sempre que possível.
4. Garantir `dispose()` para os valores reativos criados internamente.
5. Atualizar testes unitários da ViewModel para o novo padrão reativo.

Validações:
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter analyze`

### Slice 2/3 - PedidoPage com Obx
Arquivo: `docs/codex/pedido_page/pedido_page-26-05-15-2-parte_2.md`
Resumo esperado: `docs/codex/pedido_page/pedido_page-26-05-15-2-parte_2-resumo.md`

Atividades:
1. Trocar `AnimatedBuilder` por `Obx` em `PedidoPage`.
2. Garantir que a UI leia os getters reativos dentro do builder do `Obx`.
3. Manter `StatefulWidget` apenas se for necessário para ciclo de vida da ViewModel.
4. Não usar `setState()` na feature `pedido_page`.
5. Atualizar testes de widget para aguardar notificações reativas quando necessário.
6. Atualizar `pedido_page-contrato.md` com o novo mecanismo de observação.

Validações:
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter analyze`

### Slice 3/3 - Fechamento e compatibilidade
Arquivo: `docs/codex/pedido_page/pedido_page-26-05-15-2-parte_3.md`
Resumo esperado: `docs/codex/pedido_page/pedido_page-26-05-15-2-parte_3-resumo.md`

Atividades:
1. Revisar imports, barrel público e ausência de `ChangeNotifier`, `AnimatedBuilder` e `setState()` na feature `pedido_page`.
2. Rodar testes relacionados e teste inicial do app.
3. Revisar o contrato da `PedidoPage`.
4. Registrar qualquer bloqueio externo de validação, especialmente falha preexistente envolvendo `lib/utils/tema.dart` e `shared_preferences`.
5. Criar resumo final do slice com validações e pendências.

Validações:
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/widget_test.dart`
- `flutter analyze`

## Regras gerais
- Executar apenas um slice por vez.
- Nunca executar slices em paralelo.
- Nunca avançar para o próximo slice sem o resumo do slice atual.
- Se um resumo de slice já existir e estiver válido, não repetir esse slice.
- Cada slice deve considerar o estado atualizado do código produzido pelo slice anterior.
- Cada slice que alterar UI deve criar ou atualizar o respectivo `[nome-da-tela]-contrato.md`.
- Preservar alterações existentes no worktree.
- Não fazer commit automaticamente.
- Não usar `ChangeNotifier` na `PedidoPageViewModel`.
- Não usar `AnimatedBuilder` para observar a `PedidoPageViewModel`.
- Não usar `setState()` na feature `pedido_page`.
- Não alterar `rx.dart` ou `obx.dart` sem necessidade direta da migração.
- Não duplicar regras internas de Cabeçalho, Recibo ou Resumo dentro da `PedidoPage`.
- Se `flutter analyze` falhar por erro preexistente fora da feature, registrar claramente o bloqueio no resumo.

## Resultado esperado
- `PedidoPageViewModel` usa `Rx<T>` como mecanismo de estado.
- `PedidoPage` observa os valores com `Obx`.
- A tela preserva o comportamento visual atual.
- Testes da ViewModel e da Page passam.
- O contrato da `PedidoPage` registra a migração para `Rx`/`Obx`.
