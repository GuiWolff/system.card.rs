# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 3/4 derivado de `docs/codex/layout/layout-26-05-15-2.md`.

## Análise da tarefa
- `docs/codex/layout/layout-26-05-15-2-analise.md`

## Continuidade
- Slice anterior: `docs/codex/layout/layout-26-05-15-2-parte_2-resumo.md`
- Antes de alterar, leia os resumos dos slices anteriores e preserve os ajustes de cabeçalho, recibo e tabela.

## Arquivos
- `lib/features/pedido_page/domain/models/cliente.dart`
- `lib/features/pedido_page/domain/repositories/cliente_repository.dart`
- `lib/features/pedido_page/data/dtos/cliente_dto.dart`
- `lib/features/pedido_page/data/datasources/recibo_database.dart`
- `lib/features/pedido_page/data/repositories/cliente_repository_sqlite.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/data/datasources/recibo_database_test.dart`
- `test/features/pedido_page/data/repositories/cliente_repository_sqlite_test.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

## Contratos de tela
- Ler antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Atualizar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Este slice tem impacto principalmente em domínio/persistência, mas prepara dado que será exibido na UI no slice 4. Registre isso no contrato.

## Regras
- Adicionar `email` opcional ao modelo `Cliente`, preservando compatibilidade sempre que possível:
  - preferir parâmetro opcional com valor padrão vazio;
  - normalizar com `trim`;
  - validar formato apenas quando preenchido.
- Não tornar e-mail obrigatório.
- Atualizar `copyWith`, DTO e mapeamento SQLite.
- Atualizar `ClienteRepositorySqlite.pesquisar` para considerar e-mail quando houver termo textual compatível.
- Incrementar `ReciboDatabase.version` de forma segura.
- Criar migração incremental para adicionar coluna `email` à tabela `clientes`, preservando dados de bancos existentes.
- A tabela `clientes` deve manter telefone único como regra atual.
- Se adicionar índice para e-mail, justificar no resumo; se não adicionar, justificar que o campo é opcional e pesquisa por `LIKE` é suficiente para o volume esperado.
- Atualizar `PedidoPageViewModel.salvarCliente` de forma aditiva, preferindo parâmetro opcional `email` para não quebrar chamadas existentes.
- Não alterar UI do `ClientesPainel` neste slice.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não altere widgets de UI neste slice, exceto contrato da tela.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. `Cliente` com e-mail opcional.
2. DTO/repository/datasource SQLite suportando e-mail.
3. Migração de banco preservando dados existentes.
4. ViewModel preparada para receber e-mail sem quebrar chamadas antigas.
5. Testes de datasource, repository e ViewModel atualizados.
6. Contrato `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` atualizado.
7. Rodar validações específicas.
8. Salvar resumo em `docs/codex/layout/layout-26-05-15-2-parte_3-resumo.md`.

# Descrição
- Este slice cria a base técnica para e-mail no cadastro de clientes/usuários, isolando domínio e persistência antes da alteração visual.

## Objetivo
- Ao final deste slice, o projeto deve persistir e pesquisar e-mail de cliente de forma opcional e compatível com bancos existentes.
