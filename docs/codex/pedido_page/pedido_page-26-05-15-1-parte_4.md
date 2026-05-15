# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 4/5 derivado de `docs/codex/pedido_page/pedido_page-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/pedido_page/pedido_page-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_3-resumo.md`
- Leia os resumos dos slices anteriores antes de alterar arquivos.

## Arquivos
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/pedido_page.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar `pedido_page-contrato.md` com estados, callbacks e fonte de verdade do resumo.

## Regras
- Criar `PedidoPageViewModel` apenas se houver responsabilidade real de coordenação.
- Se já existir `ReciboPageViewModel` ou estado equivalente, reutilizar ou adaptar em vez de duplicar estado.
- A Page pode coordenar:
  - callbacks de ações do cabeçalho;
  - mudanças do recibo;
  - dados consumidos pelo resumo.
- O resumo deve refletir a mesma fonte de dados do recibo.
- ViewModel não deve acessar `BuildContext`.
- Criar testes de estado com fake/stub quando dependências reais ainda não existirem.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não mover regra de negócio para widgets.
- Não implementar persistência, PDF ou impressão real.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Estado compartilhado criado ou reutilizado.
2. Callbacks principais conectados.
3. Testes de ViewModel/estado criados ou atualizados.
4. `pedido_page-contrato.md` atualizado.
5. Validações específicas executadas.
6. Salvar resumo em `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_4-resumo.md`.

# Descrição
- Coordenar o estado mínimo necessário para que Recibo e Resumo sejam consistentes dentro da `PedidoPage`.

## Objetivo
- Ao final deste slice, a `PedidoPage` deve ter uma fonte de estado clara para integrar dados editados no recibo e valores exibidos no resumo.
