# Resumo do slice 4/6 - Domínio e SQLite de clientes

## Escopo executado
- Criado modelo puro `Cliente` com `id`, `nome` e `telefone`.
- Definida normalização de telefone para apenas dígitos.
- Definida validação de cliente:
  - nome obrigatório;
  - telefone com 10 ou 11 dígitos normalizados.
- Criado contrato `ClienteRepository` com operações de salvar, atualizar, buscar por id, listar, pesquisar e excluir.
- Criado `ClienteDto` para isolar mapas SQLite do domínio.
- Criado `ClienteRepositorySqlite`, recebendo e retornando apenas modelos de domínio.
- Evoluído `ReciboDatabase.version` de `1` para `2`.
- Implementada migração `onUpgrade` para criar a tabela `clientes` sem recriar ou apagar dados de recibos existentes.
- Criada tabela `clientes` com índice único `idx_clientes_telefone` para bloquear telefone duplicado normalizado.
- Criado índice `idx_clientes_nome` para apoiar listagem e pesquisa.
- Exportados `Cliente` e `ClienteRepository` pelo barrel público da feature `pedido_page`.

## Arquivos alterados
- `lib/features/pedido_page/domain/models/cliente.dart`
- `lib/features/pedido_page/domain/repositories/cliente_repository.dart`
- `lib/features/pedido_page/data/datasources/recibo_database.dart`
- `lib/features/pedido_page/data/dtos/cliente_dto.dart`
- `lib/features/pedido_page/data/repositories/cliente_repository_sqlite.dart`
- `lib/features/pedido_page/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/data/datasources/recibo_database_test.dart`
- `test/features/pedido_page/data/repositories/cliente_repository_sqlite_test.dart`

## Contratos de tela
- Contrato revisado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Nenhum novo contrato de tela foi criado.
- Não houve alteração visual direta neste slice. A ausência de UI é intencional porque o slice entrega somente domínio, schema e repository para clientes; cadastro visual, máscara, busca na tela e seleção ficam para o próximo slice.

## Testes adicionados ou ajustados
- `ReciboDatabase` criando tabela `clientes`.
- `ReciboDatabase` criando índice único de telefone e índice de nome.
- Migração de banco v1 para v2 preservando recibos existentes.
- `ClienteRepositorySqlite` salvando e carregando cliente com telefone normalizado.
- `ClienteRepositorySqlite` atualizando cliente.
- `ClienteRepositorySqlite` listando por nome.
- `ClienteRepositorySqlite` pesquisando por nome e telefone normalizado.
- `ClienteRepositorySqlite` bloqueando telefone duplicado.
- `ClienteRepositorySqlite` excluindo cliente.
- `ClienteRepositorySqlite` rejeitando cliente inválido e atualização sem id.

## Validações
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/data/datasources/recibo_database_test.dart test/features/pedido_page/data/repositories/cliente_repository_sqlite_test.dart`: passou, 13 testes.
- `flutter test`: passou, 74 testes.

## Fora do escopo preservado
- Não foi implementada UI de cadastro de clientes.
- Não foi implementada máscara de telefone.
- Não foi implementada busca/seleção visual de clientes.
- Não foi conectado cliente à `PedidoPageViewModel`.
- Não foi alterado o formulário do recibo.
- Não foi alterado o fluxo visual do cabeçalho editável.
- Não foi executado o próximo slice.
- Não foi feito commit.
