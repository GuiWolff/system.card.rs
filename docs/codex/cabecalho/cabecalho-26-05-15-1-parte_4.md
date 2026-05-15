# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 4/6 derivado de `docs/codex/cabecalho/cabecalho-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_3-resumo.md`
- Antes de iniciar, leia os resumos anteriores e preserve o cabeçalho editável já integrado.

## Arquivos
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
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar `pedido_page-contrato.md`.
- Este slice não deve alterar UI diretamente; se não houver alteração visual, justificar isso no resumo.

## Regras
- Criar modelo puro `Cliente` com `id`, `nome` e `telefone`.
- Normalizar telefone para comparação e persistência, preferencialmente apenas dígitos.
- Validar nome obrigatório e telefone válido conforme regra definida no slice.
- Evoluir `ReciboDatabase.version` e implementar `onUpgrade` sem perder dados existentes.
- Criar tabela `clientes` com telefone normalizado único.
- Criar repository SQLite com operações de salvar, atualizar, buscar por id, listar/pesquisar e excluir quando aplicável.
- DTOs e mapas SQLite não devem vazar para ViewModel/UI.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente UI de cadastro de clientes neste slice.
- Não altere fluxo de recibos fora do necessário para compartilhar o banco.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Modelo e repository de clientes.
2. Schema SQLite versionado com tabela `clientes` e índice único de telefone.
3. Testes de schema, CRUD, busca e bloqueio de telefone duplicado.
4. Revisar `pedido_page-contrato.md` com justificativa de ausência de UI direta.
5. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_4-resumo.md`.

# Descrição
- Criar a base de domínio e persistência SQLite para cadastro de clientes.

## Objetivo
- Ao final deste slice, clientes devem poder ser persistidos e pesquisados no SQLite com telefone único, sem alterar ainda a interface.
