# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise desta tarefa antes de executar qualquer alteração.
Esta tarefa foi dividida em 3 slices.

## Análise da tarefa
- `docs/codex/usabilidade/usabilidade-26-05-15-1-analise.md`

## Objetivo geral
- Corrigir a usabilidade da edição de recibos na `PedidoPage`, mantendo foco dos campos durante digitação, permitindo adicionar item por Enter no campo `Valor unitário` com bloqueio para valor zero e impedindo edição de recibos carregados do histórico.

## Arquivos principais envolvidos
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
- `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/historico_recibos_painel.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Antes de alterar UI, leia o contrato existente e preserve o papel da `PedidoPage` como tela agregadora única da feature `pedido_page`.
- Cada slice que alterar comportamento visual/interativo deve atualizar ou revisar `pedido_page-contrato.md`.
- Não há nova Page/View/Tela a criar, então não há novo contrato de tela.

## Slices da tarefa

### Slice 1/3 - Estabilizar foco dos campos
Arquivo: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_1.md`
Resumo esperado: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_1-resumo.md`

Atividades:
1. Remover dependência de valor atual nas chaves dos campos de `ReciboFormulario`, `ProdutosServicosTabela` e `ResumoPedido`.
2. Garantir que campos editáveis mantenham foco durante digitação usando estado local de UI com `TextEditingController`/`FocusNode` quando necessário.
3. Atualizar testes que dependem das chaves antigas.
4. Revisar `pedido_page-contrato.md` com o comportamento de foco preservado.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`

### Slice 2/3 - Adicionar item por Enter com guarda de valor zero
Arquivo: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_2.md`
Resumo esperado: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_2-resumo.md`

Atividades:
1. Criar fluxo para solicitar novo item ao pressionar Enter no campo `Valor unitário`.
2. Impedir nova linha quando o valor unitário da linha atual ou do último item de referência for zero.
3. Preservar a possibilidade de criar a primeira linha vazia quando a lista ainda não tiver itens.
4. Atualizar testes de widget e ViewModel para cobrir Enter e bloqueio de valor zero.
5. Atualizar `pedido_page-contrato.md` com a nova regra de interação.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

### Slice 3/3 - Bloquear edição de recibo carregado do histórico
Arquivo: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_3.md`
Resumo esperado: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_3-resumo.md`

Atividades:
1. Introduzir estado explícito de recibo carregado do histórico/somente leitura na `PedidoPageViewModel`.
2. Bloquear mutações de campos, itens, valor de entrada e salvamento quando o recibo estiver em modo somente leitura.
3. Refletir o modo somente leitura na UI, desabilitando edição e deixando `Duplicar` como caminho para editar uma cópia.
4. Garantir que `Novo recibo` e `Duplicar` voltem ao modo editável.
5. Atualizar testes e `pedido_page-contrato.md`.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test`

## Regras gerais
- Executar apenas um slice por vez.
- Nunca executar slices em paralelo.
- Nunca avançar para o próximo slice sem o resumo do slice atual.
- Se um resumo de slice já existir e estiver válido, não repetir esse slice.
- Cada slice deve considerar o estado atualizado do código produzido pelo slice anterior.
- Cada slice que alterar UI deve criar ou atualizar o respectivo `[nome-da-tela]-contrato.md`.
- Preservar alterações existentes no worktree.
- Não fazer commit automaticamente.
- Não mover regra de negócio para widgets.
- Não colocar `TextEditingController` ou `FocusNode` na ViewModel.
- Não alterar contratos públicos de repository, DTO ou banco sem necessidade direta.

## Resultado esperado
- A `PedidoPage` mantém o foco dos campos durante digitação.
- O usuário consegue adicionar novo item pressionando Enter no campo `Valor unitário`, desde que o valor unitário seja maior que zero.
- A UI não cria novas linhas repetidas com valor unitário zero.
- Recibos carregados pelo histórico ficam em visualização somente leitura; para editar, o usuário deve usar `Duplicar` ou iniciar um novo recibo.
