# Resumo do Slice 4/9 - Repository SQLite e histórico

## Escopo executado
- O slice foi aplicado conforme o prompt mestre `docs/codex/recibo/recibo-26-05-14-1.md`, mantendo recibo integrado à feature `pedido_page`.
- Não foi criada ou evoluída `ReciboPage`, rota própria, `Scaffold` próprio ou entrada própria para recibo.
- Não houve alteração em `lib/main.dart`.
- Não foi implementado estado da `PedidoPageViewModel`, formulário final, visualização final ou painel visual de histórico.

## O que foi feito
- Criado o contrato `ReciboRepository` dentro de `lib/features/pedido_page/domain/repositories/`.
- Criados DTOs para isolar SQLite dos modelos de domínio:
  - `ReciboDto`;
  - `ItemReciboDto`.
- Implementado `ReciboRepositorySqlite` consumindo o `ReciboDatabase` criado no slice 3.
- Implementadas operações de histórico persistido:
  - salvar novo recibo;
  - atualizar recibo existente;
  - buscar recibo por id;
  - listar histórico por `atualizado_em DESC`;
  - pesquisar por número, cliente ou telefone;
  - excluir recibo.
- Salvar e atualizar recibos usam transação.
- A atualização substitui os itens relacionados dentro da mesma transação para manter consistência.
- A exclusão usa a cascata definida no schema do slice 3 para evitar itens órfãos.
- O barrel público de `pedido_page` passou a exportar o contrato `ReciboRepository`.
- Criado teste de repository cobrindo round-trip domínio -> SQLite -> domínio, atualização, listagem, pesquisa, exclusão e validações básicas.

## Arquivos alterados/criados
- Criado `lib/features/pedido_page/domain/repositories/recibo_repository.dart`.
- Criado `lib/features/pedido_page/data/dtos/recibo_dto.dart`.
- Criado `lib/features/pedido_page/data/dtos/item_recibo_dto.dart`.
- Criado `lib/features/pedido_page/data/repositories/recibo_repository_sqlite.dart`.
- Criado `test/features/pedido_page/data/repositories/recibo_repository_sqlite_test.dart`.
- Alterado `lib/features/pedido_page/pedido_page.dart`.
- Revisado `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Criado `docs/codex/recibo/recibo-26-05-14-1-parte_4-resumo.md`.

## Validações executadas
- `flutter test test/features/pedido_page/data/repositories/recibo_repository_sqlite_test.dart`: passou, 6 testes.
- `flutter analyze`: passou, sem issues.

## Impacto em UI
- Não houve impacto visual direto.
- A justificativa é que este slice atuou apenas nas camadas `domain` e `data` da feature `pedido_page`.
- A `PedidoPage`, o `ReciboPedido` e a `PedidoPageViewModel` ainda não consomem o repository nem exibem histórico persistido.
- Estados visuais de carregamento, erro, ações de salvar/carregar e painel de histórico ficam para slices posteriores.

## Contrato de tela
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` foi revisado.
- O contrato agora registra o `ReciboRepository`, os DTOs, o `ReciboRepositorySqlite`, as operações persistidas disponíveis e a ausência de impacto visual direto neste slice.
- O contrato reforça que DTOs e mapas de SQLite não devem vazar para UI, ViewModel ou contrato público da tela.

## Próximos pontos para o Slice 5
- Evoluir `PedidoPageViewModel` para concentrar o estado do recibo, itens, resumo e histórico.
- Integrar o `ReciboRepository` ao fluxo de estado da `PedidoPage`.
- Expor estados de carregamento, salvamento, erro e lista de histórico sem acessar `BuildContext`.
- Fazer a ViewModel consumir os modelos de domínio para evitar duplicação de regra de cálculo.
- Manter recibo como bloco integrado à `PedidoPage`, sem criar `ReciboPage` ou rota própria.
