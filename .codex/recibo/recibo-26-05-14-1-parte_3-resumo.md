# Resumo do Slice 3/9 - SQLite embarcado desktop

## Escopo executado
- O slice foi aplicado conforme o prompt mestre `docs/codex/recibo/recibo-26-05-14-1.md`, mantendo recibo integrado à feature `pedido_page`.
- Não foi criada ou evoluída `ReciboPage`, rota própria, `Scaffold` próprio ou entrada própria para recibo.
- Não houve alteração em `lib/main.dart`.
- Não foi implementado repository completo, histórico, formulário final ou visualização final.

## O que foi feito
- Adicionadas dependências para SQLite embarcado compatível com Flutter Desktop:
  - `sqflite_common_ffi`;
  - `path`;
  - `path_provider`.
- Criado o datasource `ReciboDatabase` em `lib/features/pedido_page/data/datasources/`.
- Implementada abertura de banco via `databaseFactoryFfi`, com inicialização FFI encapsulada no datasource.
- Implementada abertura desktop usando `ApplicationSupportDirectory` quando o caminho do banco for relativo.
- Implementada abertura em memória para testes.
- Definido schema versionado inicial na versão `1`.
- Criadas as tabelas:
  - `recibos`;
  - `recibo_itens`.
- Criados índices para:
  - `numero`;
  - `cliente_nome`;
  - `atualizado_em`;
  - `recibo_id` dos itens.
- Configurada chave estrangeira de `recibo_itens` para `recibos` com exclusão em cascata.
- Mantido o armazenamento planejado de datas como texto ISO-8601 e valores monetários como centavos inteiros.
- Criado teste de datasource com banco em memória cobrindo schema, versão, índices e cascata.

## Arquivos alterados/criados
- Alterado `pubspec.yaml`.
- Alterado `pubspec.lock`.
- Criado `lib/features/pedido_page/data/datasources/recibo_database.dart`.
- Criado `test/features/pedido_page/data/datasources/recibo_database_test.dart`.
- Revisado `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Criado `docs/codex/recibo/recibo-26-05-14-1-parte_3-resumo.md`.

## Validações executadas
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/data/datasources/recibo_database_test.dart`: passou, 4 testes.

## Impacto em UI
- Não houve impacto visual direto.
- A justificativa é que este slice preparou apenas infraestrutura de persistência na camada `data` da feature `pedido_page`.
- `PedidoPage`, `ReciboPedido` e `PedidoPageViewModel` ainda não acessam SQLite diretamente.
- Estados visuais de carregamento, histórico, erro e dados persistidos ficam para slices posteriores.

## Contrato de tela
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` foi revisado.
- O contrato agora registra a existência do `ReciboDatabase`, o schema SQLite versionado, o uso de FFI, a ausência de mudança visual direta e a regra de não acoplar banco à UI.

## Próximos pontos para o Slice 4
- Criar o contrato `ReciboRepository` dentro de `lib/features/pedido_page/domain/repositories/`.
- Criar DTOs e mapeadores para `Recibo` e `ItemRecibo`.
- Implementar `ReciboRepositorySqlite` consumindo `ReciboDatabase`.
- Garantir operações transacionais para salvar/atualizar recibo e itens.
- Cobrir salvar, atualizar, listar, carregar e excluir recibos com testes.
- Manter a integração visual da `PedidoPage` para slices posteriores, sem criar `ReciboPage`.
