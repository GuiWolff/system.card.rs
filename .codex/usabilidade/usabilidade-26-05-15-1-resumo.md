# Resumo geral da tarefa

## Tarefa solicitada
- Corrigir perda de foco dos inputs de texto/número durante digitação.
- Permitir adicionar item por Enter no campo `Valor unitário`.
- Impedir criação de novo item quando o valor unitário de referência for zero.
- Impedir edição direta de pedido/recibo carregado do histórico.

## Arquivos de prompt criados
- `docs/codex/usabilidade/usabilidade-26-05-15-1-analise.md`
- `docs/codex/usabilidade/usabilidade-26-05-15-1.md`
- `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_1.md`
- `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_2.md`
- `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_3.md`
- `docs/codex/usabilidade/usabilidade-26-05-15-1-resumo.md`

## Lista de slices
- Slice 1/3: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_1.md`
- Slice 2/3: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_2.md`
- Slice 3/3: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_3.md`

## Ordem correta de execução
1. Executar `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_1.md`.
2. Conferir/criar `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_1-resumo.md`.
3. Executar `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_2.md`.
4. Conferir/criar `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_2-resumo.md`.
5. Executar `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_3.md`.
6. Conferir/criar `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_3-resumo.md`.

## Validações esperadas
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `flutter test` no fechamento da tarefa.

## Contratos de tela criados, atualizados ou revisados
- Revisado/atualizado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Nenhum novo contrato foi criado, porque a tarefa não cria nova Page/View/Tela.

## Observações importantes para continuidade
- O primeiro arquivo a executar é `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_1.md`.
- Não executar slices em paralelo.
- Não repetir slice que já tenha resumo válido.
- A correção de foco deve vir antes do Enter, porque o Enter depende de campos estáveis.
- O bloqueio de histórico deve vir por último para não misturar read-only com a refatoração dos campos.
- O worktree já possui alterações em vários arquivos da feature; preservar essas alterações e evitar reescritas amplas.

## Resultado da execução
- Slice 1/3 executado e resumido em `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_1-resumo.md`.
- Slice 2/3 executado e resumido em `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_2-resumo.md`.
- Slice 3/3 executado e resumido em `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_3-resumo.md`.
- Os campos editáveis preservam foco durante digitação.
- O campo `Valor unitário` cria novo item por Enter quando o valor de referência é maior que zero.
- A criação de nova linha é bloqueada quando o valor unitário de referência é zero.
- Recibos carregados pelo histórico entram em modo somente leitura; `Duplicar` e `Novo recibo` retornam ao modo editável.
- Contrato de tela revisado: `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Validações executadas no fechamento: `flutter analyze` e `flutter test`.
