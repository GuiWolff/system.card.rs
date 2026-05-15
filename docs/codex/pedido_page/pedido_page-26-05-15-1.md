# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise desta tarefa antes de executar qualquer alteração.
Esta tarefa foi dividida em 5 slices.

## Análise da tarefa
- `docs/codex/pedido_page/pedido_page-26-05-15-1-analise.md`

## Objetivo geral
- Criar a `PedidoPage`, responsável por juntar os blocos de Cabeçalho, Recibo e Resumo em uma tela responsiva.
- A `PedidoPage` deve ser uma tela agregadora: ela compõe componentes, coordena layout e passagem de estado/callbacks, mas não deve duplicar regras internas de cabeçalho, recibo ou resumo.

## Arquivos principais envolvidos
- Existentes:
  - `AGENTS.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1.md`
  - `docs/codex/recibo/recibo-26-05-14-1.md`
  - `docs/codex/resumo/resumo-26-05-15-1.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
  - `lib/main.dart`
  - `pubspec.yaml`
  - `test/widget_test.dart`
  - `lib/resources/cabecalho.png`
  - `lib/resources/recibo.png`
  - `lib/resources/resumo.png`
  - `lib/resources/tema.jpeg`
- Esperados durante a execução:
  - `lib/features/pedido_page/pedido_page.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`
  - `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
  - `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
  - `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que cada slice deve criar, atualizar ou revisar:
  - Slice 1: revisar `pedido_page-contrato.md` após criar a Page base.
  - Slice 2: atualizar `pedido_page-contrato.md` com layout e responsividade.
  - Slice 3: atualizar `pedido_page-contrato.md` com as regras de integração dos componentes.
  - Slice 4: atualizar `pedido_page-contrato.md` com estados compartilhados e callbacks.
  - Slice 5: revisar `pedido_page-contrato.md` após testes e fechamento.
  - Atualizar `recibo_page-contrato.md` apenas se a implementação redefinir responsabilidades da `ReciboPage`.

## Slices da tarefa

### Slice 1/5 - Page base e contrato público
Arquivo: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_1.md`
Resumo esperado: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_1-resumo.md`

Atividades:
1. Criar a estrutura vertical da feature `pedido_page`.
2. Criar `PedidoPage` mínima e barrel público.
3. Decidir integração inicial com `main.dart` sem quebrar os planejamentos de `recibo`.
4. Atualizar teste inicial ou criar teste mínimo da Page.
5. Revisar o contrato da tela.

Validações:
- `flutter analyze`
- `flutter test`

### Slice 2/5 - Layout responsivo da composição
Arquivo: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_2.md`
Resumo esperado: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_2-resumo.md`

Atividades:
1. Criar `PedidoPageLayout`.
2. Definir regiões para cabeçalho, recibo e resumo.
3. Garantir layout desktop amplo e desktop estreito sem overflow.
4. Criar testes de widget para ordem visual e responsividade.
5. Atualizar o contrato da tela.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`

### Slice 3/5 - Integração dos blocos Cabeçalho, Recibo e Resumo
Arquivo: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_3.md`
Resumo esperado: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_3-resumo.md`

Atividades:
1. Integrar componentes reais existentes de cabeçalho, recibo e resumo.
2. Se algum componente ainda não existir, usar encaixe mínimo controlado e registrar pendência no resumo.
3. Evitar duplicar implementação interna dos componentes.
4. Preservar contratos dos blocos existentes.
5. Atualizar o contrato da `PedidoPage`.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`

### Slice 4/5 - Estado compartilhado e callbacks
Arquivo: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_4.md`
Resumo esperado: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_4-resumo.md`

Atividades:
1. Criar ou reutilizar ViewModel para coordenar estado compartilhado entre recibo e resumo.
2. Conectar callbacks do cabeçalho e mudanças do recibo ao estado da tela.
3. Garantir que o resumo reflita a mesma fonte de dados do recibo.
4. Criar testes de estado com fake/stub quando necessário.
5. Atualizar o contrato da tela.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`

### Slice 5/5 - Fechamento, testes e compatibilidade
Arquivo: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_5.md`
Resumo esperado: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_5-resumo.md`

Atividades:
1. Revisar integração final da `PedidoPage`.
2. Garantir compatibilidade com os planejamentos de cabeçalho, recibo e resumo.
3. Remover dependência do teste de contador do template, se ainda existir.
4. Rodar validações finais.
5. Revisar contratos e registrar pendências.

Validações:
- `flutter analyze`
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
- Não duplicar implementação de Cabeçalho, Recibo ou Resumo dentro da `PedidoPage`.
- Se um componente necessário ainda não existir, registrar a dependência no resumo do slice e criar somente um encaixe mínimo, quando indispensável para manter a Page compilando.
- Seguir `AGENTS.md`, mantendo português pt-BR, UTF-8 e arquitetura vertical feature-first.

## Resultado esperado
- Ao final dos slices, a `PedidoPage` deve existir como tela agregadora, renderizando Cabeçalho, Recibo e Resumo em uma composição responsiva.
- A tela deve ter contrato próprio, testes relacionados e integração compatível com os planejamentos já criados para cabeçalho, recibo e resumo.
