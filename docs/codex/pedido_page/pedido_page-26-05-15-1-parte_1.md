# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/5 derivado de `docs/codex/pedido_page/pedido_page-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/pedido_page/pedido_page-26-05-15-1-analise.md`

## Continuidade
- Este é o primeiro slice. Não há resumo anterior.

## Arquivos
- `AGENTS.md`
- `lib/main.dart`
- `test/widget_test.dart`
- `lib/features/pedido_page/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Contratos relacionados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar `pedido_page-contrato.md` após criar a Page base.
  - Não atualizar `recibo_page-contrato.md`, salvo se este slice alterar responsabilidade da `ReciboPage`.

## Regras
- Criar a estrutura vertical de `lib/features/pedido_page/`.
- Criar `PedidoPage` mínima, com texto/estrutura suficiente para identificar a tela.
- Criar barrel público `lib/features/pedido_page/pedido_page.dart`.
- Se alterar `main.dart`, fazer apenas o necessário para abrir a `PedidoPage`.
- Atualizar ou criar teste mínimo para a nova Page.
- Não implementar ainda os blocos reais de Cabeçalho, Recibo e Resumo.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente lógica de recibo, cálculo de resumo ou persistência.
- Não duplique `ReciboPage`.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Estrutura base da feature `pedido_page`.
2. `PedidoPage` mínima criada.
3. Barrel público criado.
4. Teste mínimo da Page criado ou teste inicial ajustado.
5. `pedido_page-contrato.md` revisado.
6. Validações específicas executadas.
7. Salvar resumo em `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_1-resumo.md`.

# Descrição
- Criar a base pública da `PedidoPage`, preparando a tela agregadora sem implementar os blocos internos.

## Objetivo
- Ao final deste slice, a `PedidoPage` deve existir, compilar e ter um teste mínimo, servindo como ponto inicial para composição dos próximos slices.
