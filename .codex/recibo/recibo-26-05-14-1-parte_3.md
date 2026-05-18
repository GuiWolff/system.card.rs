# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 3/9 derivado de `docs/codex/recibo/recibo-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-14-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/recibo/recibo-26-05-14-1-parte_2-resumo.md`

## Arquivos
- `pubspec.yaml`
- `lib/main.dart`
- `lib/features/recibo/data/datasources/recibo_database.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `test/features/recibo/data/datasources/recibo_database_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar o contrato indicando que este slice não altera visualmente a tela, mas prepara a persistência usada por ela.

## Protocolo do orquestrador
- Iniciar este slice em uma sessão limpa na raiz do projeto.
- Ler o resumo do slice 2 antes de qualquer alteração.
- Executar somente as atividades deste arquivo.
- Ao finalizar, criar `docs/codex/recibo/recibo-26-05-14-1-parte_3-resumo.md`.
- Parar após criar o resumo. O orquestrador deve encerrar a sessão e limpar o contexto antes do slice 4.

## Regras
- Adicionar dependências SQLite compatíveis com Flutter Desktop.
- Preferir `sqflite_common_ffi` para desktop, com `path` e `path_provider` quando necessário para montar o caminho do banco.
- Inicializar o suporte FFI no ponto apropriado antes de abrir o banco.
- Criar `ReciboDatabase` como datasource da feature.
- Criar schema versionado com migrations.
- Schema mínimo:
  - tabela `recibos`;
  - tabela `recibo_itens`;
  - índices para `numero`, `cliente_nome` e `atualizado_em`;
  - chave estrangeira de itens para recibos com exclusão em cascata.
- Armazenar datas em ISO-8601.
- Armazenar valores monetários em centavos inteiros.
- Criar teste usando banco temporário ou em memória quando possível.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente repository completo neste slice.
- Não altere UI além de eventual ajuste mínimo de inicialização do app.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Dependências adicionadas.
2. Datasource SQLite criado.
3. Schema e migrations criados.
4. Teste do datasource criado.
5. Contrato de tela revisado com justificativa de ausência de mudança visual direta.
6. Validações executadas.
7. Resumo salvo em `docs/codex/recibo/recibo-26-05-14-1-parte_3-resumo.md`.

# Descrição
- Preparar o banco SQLite embarcado para persistir o histórico da feature em Flutter Desktop.

## Objetivo
- Ao final deste slice, o projeto deve conseguir abrir/criar o banco SQLite da feature com schema versionado e testado.
