# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/2 derivado de `docs/codex/recibo/recibo-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-15-1-analise.md`

## Continuidade
- Este é o primeiro slice. Não há resumo anterior.

## Arquivos
- `lib/features/pedido_page/domain/models/recibo.dart`
- `lib/features/pedido_page/domain/repositories/recibo_repository.dart`
- `lib/features/pedido_page/data/datasources/recibo_database.dart`
- `lib/features/pedido_page/data/dtos/recibo_dto.dart`
- `lib/features/pedido_page/data/repositories/recibo_repository_sqlite.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/data/datasources/recibo_database_test.dart`
- `test/features/pedido_page/data/repositories/recibo_repository_sqlite_test.dart`
- `test/features/pedido_page/domain/models/recibo_test.dart`, se o contrato do modelo for ajustado.

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar `pedido_page-contrato.md`.
- Este slice não deve alterar UI diretamente. Justifique no resumo que a alteração visual fica para o slice 2.

## Regras
- Criar uma forma testável de obter o próximo número incremental pelo `ReciboRepository`.
- A fonte de verdade do próximo número deve ser o banco SQLite.
- O formato recomendado para o número gerado é `0001`, `0002`, `0003`, preservando preenchimento à esquerda.
- Tratar números antigos não numéricos sem quebrar a geração do próximo número.
- Ao salvar um recibo novo sem número preenchido, o repository deve atribuir o próximo número incremental.
- Ao salvar um recibo novo com número já definido por fluxo legado/teste, avaliar preservação controlada sem quebrar compatibilidade.
- Todo recibo persistido e retornado por `salvar`, `atualizar`, `buscarPorId`, `listarHistorico` e `pesquisarHistorico` deve expor `criadoEm` como `DateTime`.
- `atualizar` deve preservar a data de criação original.
- DTOs e mapas SQLite não devem vazar para ViewModel/UI.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture integração de ViewModel/UI neste slice.
- Não altere cálculo financeiro do recibo.
- Não crie `ReciboPage`.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Contrato de repository ajustado para geração incremental.
2. Implementação SQLite do próximo número.
3. Persistência garantindo `criadoEm` no objeto retornado.
4. Testes de repository/datasource cobrindo incremento, números antigos e preservação da data de criação.
5. Revisar `pedido_page-contrato.md`.
6. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
7. Justificar explicitamente no resumo do slice que não houve impacto visual direto.
8. Rodar validações específicas.
9. Salvar resumo em `docs/codex/recibo/recibo-26-05-15-1-parte_1-resumo.md`.

# Descrição
- Criar a base de dados e repository para número incremental do recibo e reforçar a garantia de data de criação persistida.

## Objetivo
- Ao final deste slice, a camada de dados deve conseguir gerar e persistir recibos com número incremental e `criadoEm` não nulo, sem alterar a apresentação.
