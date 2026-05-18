# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 3/3 derivado de `docs/codex/usabilidade/usabilidade-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/usabilidade/usabilidade-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_2-resumo.md`
- Antes de iniciar, confirme que a adição por Enter e a guarda de valor zero estão funcionando.

## Arquivos
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
- `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/historico_recibos_painel.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Este slice deve atualizar o contrato para registrar o estado visual e funcional de recibo carregado do histórico em modo somente leitura.

## Regras
- `carregarRecibo` deve deixar o recibo em modo somente leitura.
- `duplicarRecibo` deve criar uma cópia editável e sair do modo somente leitura.
- `iniciarNovoRecibo` deve sair do modo somente leitura.
- Métodos públicos de mutação da `PedidoPageViewModel` devem respeitar o modo somente leitura, não apenas os widgets.
- Em modo somente leitura, campos do recibo, tabela de itens e valor de entrada não devem ser editáveis.
- Em modo somente leitura, salvar o recibo carregado deve ser bloqueado ou desabilitado.
- O usuário deve ter caminho claro para editar uma cópia via `Duplicar` no histórico.
- Não remover a ação `Carregar`; ela passa a significar visualizar o recibo salvo sem edição.
- Não alterar repository, DTOs ou schema SQLite para esta regra.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não altere comportamento de exclusão do histórico fora do necessário.
- Não remova `Duplicar`.
- Não faça commit.

## Entregáveis
1. Estado reativo ou getter público indicando recibo carregado do histórico/somente leitura.
2. Guardas de ViewModel impedindo mutações quando o recibo estiver somente leitura.
3. UI refletindo modo somente leitura nos campos, tabela, resumo e ação de salvar.
4. Testes de ViewModel para bloquear edição/salvamento de recibo carregado.
5. Testes de widget/page para confirmar campos desabilitados e duplicação editável.
6. Atualizar `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
7. Rodar validações específicas.
8. Salvar resumo em `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_3-resumo.md`.

# Descrição
- Hoje um recibo carregado pelo histórico continua com `id` original e pode ser editado e salvo, atualizando o registro histórico. Este slice transforma `Carregar` em visualização somente leitura e preserva `Duplicar` como fluxo de edição de cópia.

## Objetivo
- Ao final deste slice, não será possível editar diretamente um pedido/recibo carregado do histórico, reduzindo risco de sobrescrever registros já salvos.
