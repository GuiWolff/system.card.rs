# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 4/9 derivado de `docs/codex/recibo/recibo-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-14-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/recibo/recibo-26-05-14-1-parte_3-resumo.md`

## Arquivos
- `lib/features/recibo/domain/repositories/recibo_repository.dart`
- `lib/features/recibo/data/dtos/recibo_dto.dart`
- `lib/features/recibo/data/dtos/item_recibo_dto.dart`
- `lib/features/recibo/data/repositories/recibo_repository_sqlite.dart`
- `lib/features/recibo/data/datasources/recibo_database.dart`
- `lib/features/recibo/recibo.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `test/features/recibo/data/repositories/recibo_repository_sqlite_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar o contrato registrando operações de histórico usadas pela tela.
- Este slice impacta indiretamente UI porque viabiliza carregar, salvar e listar recibos na tela.

## Protocolo do orquestrador
- Iniciar este slice em uma sessão limpa na raiz do projeto.
- Ler o resumo do slice 3 antes de qualquer alteração.
- Executar somente as atividades deste arquivo.
- Ao finalizar, criar `docs/codex/recibo/recibo-26-05-14-1-parte_4-resumo.md`.
- Parar após criar o resumo. O orquestrador deve encerrar a sessão e limpar o contexto antes do slice 5.

## Regras
- Criar contrato `ReciboRepository` na camada domain.
- Operações mínimas:
  - salvar novo recibo;
  - atualizar recibo existente;
  - buscar por id;
  - listar histórico ordenado por atualização decrescente;
  - pesquisar por número, cliente ou telefone;
  - excluir recibo.
- Implementar DTOs para isolar SQLite do domínio.
- Salvar recibo e itens em transação.
- Ao atualizar recibo, garantir consistência dos itens relacionados.
- Usar exclusão em cascata ou transação explícita para evitar itens órfãos.
- Testar round-trip completo domínio -> SQLite -> domínio.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente ViewModel ou UI neste slice.
- Não altere regras de domínio sem necessidade.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Contrato de repository criado.
2. DTOs e mapeadores criados.
3. Repository SQLite implementado.
4. Testes de persistência e histórico criados.
5. Contrato de tela revisado.
6. Validações executadas.
7. Resumo salvo em `docs/codex/recibo/recibo-26-05-14-1-parte_4-resumo.md`.

# Descrição
- Conectar o domínio ao SQLite por meio de um repository testável e transacional.

## Objetivo
- Ao final deste slice, a feature deve salvar, listar, carregar e excluir recibos no SQLite sem envolver UI.
