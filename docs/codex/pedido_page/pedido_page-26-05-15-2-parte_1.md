# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/3 derivado de `docs/codex/pedido_page/pedido_page-26-05-15-2.md`.

## Análise da tarefa
- `docs/codex/pedido_page/pedido_page-26-05-15-2-analise.md`

## Continuidade
- Este é o primeiro slice desta tarefa; não há resumo anterior.
- Considere o estado deixado pela tarefa anterior da `PedidoPage`, especialmente `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_4-resumo.md`.

## Arquivos
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/pedido_page.dart`
- `lib/observable/rx.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Este slice altera estado da tela por meio da ViewModel.
- Atualize `pedido_page-contrato.md` somente se a migração da ViewModel mudar o contrato público relevante da tela.

## Regras
- Migrar `PedidoPageViewModel` para usar `Rx<T>`.
- Remover herança de `ChangeNotifier`.
- Remover chamadas a `notifyListeners()`.
- Manter getters atuais como fachada pública sempre que possível.
- Os getters devem ler `.value` dos `Rx` para permitir rastreamento quando usados dentro de `Obx` no próximo slice.
- Manter métodos:
  - `atualizarTotalPedidoCentavos`;
  - `atualizarValorEntradaCentavos`;
  - `atualizarDadosDoRecibo`;
  - `registrarAcaoCabecalho`.
- Implementar `dispose()` descartando todos os `Rx` internos.
- Não usar `setState()`.
- Não alterar `PedidoPage` neste slice, salvo ajuste mínimo inevitável para compilação.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não alterar `rx.dart` sem necessidade direta.
- Não introduzir pacote externo.

## Entregáveis
1. `PedidoPageViewModel` usando `Rx<T>`.
2. Testes unitários da ViewModel atualizados.
3. Criar ou atualizar `[nome-da-tela]-contrato.md` quando houver alteração em Page/View/Tela.
4. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
5. Justificar explicitamente no resumo do slice quando não houver impacto em UI.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/pedido_page/pedido_page-26-05-15-2-parte_1-resumo.md`.

# Descrição
- Troque o mecanismo interno de estado da `PedidoPageViewModel` de `ChangeNotifier` para `Rx<T>`, mantendo o comportamento de cálculo e formatação já existente.
- Atualize os testes que hoje dependem de `addListener`, pois esse método vem de `ChangeNotifier` e não deve permanecer como base da ViewModel.

## Objetivo
- Ao final deste slice, a ViewModel deve compilar sem `ChangeNotifier`, expor os mesmos dados principais e ter testes unitários passando.
