# Resumo geral - Número incremental e data de criação do recibo

## Tarefa solicitada
- Pasta: `recibo`.
- Fazer o número do recibo ser incremental.
- Garantir que o objeto persistido tenha `DateTime` de data de criação.

## Arquivos de prompt criados
- `docs/codex/recibo/recibo-26-05-15-1-analise.md`
- `docs/codex/recibo/recibo-26-05-15-1.md`
- `docs/codex/recibo/recibo-26-05-15-1-parte_1.md`
- `docs/codex/recibo/recibo-26-05-15-1-parte_2.md`
- `docs/codex/recibo/recibo-26-05-15-1-resumo.md`

## Slices
1. `docs/codex/recibo/recibo-26-05-15-1-parte_1.md`
   - Base de repository/SQLite para próximo número incremental.
   - Garantia de `criadoEm` no objeto persistido.
   - Sem alteração visual direta.
2. `docs/codex/recibo/recibo-26-05-15-1-parte_2.md`
   - Integração da numeração incremental na `PedidoPageViewModel`.
   - Ajuste visual/comportamental do campo de número no formulário.
   - Fechamento com testes de UI e `flutter test`.

## Ordem correta de execução
1. Executar `docs/codex/recibo/recibo-26-05-15-1-parte_1.md`.
2. Validar e criar `docs/codex/recibo/recibo-26-05-15-1-parte_1-resumo.md`.
3. Executar `docs/codex/recibo/recibo-26-05-15-1-parte_2.md`.
4. Validar e criar `docs/codex/recibo/recibo-26-05-15-1-parte_2-resumo.md`.

## Validações esperadas
- Slice 1:
  - `flutter analyze`
  - `flutter test test/features/pedido_page/data/repositories/recibo_repository_sqlite_test.dart`
  - `flutter test test/features/pedido_page/data/datasources/recibo_database_test.dart`
- Slice 2:
  - `flutter analyze`
  - `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
  - `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
  - `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
  - `flutter test`

## Contratos de tela
- Contrato revisado/atualizado pelo planejamento:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Nenhum novo contrato foi criado.

## Observações importantes para continuidade
- A implementação deve permanecer em `lib/features/pedido_page/`.
- Não criar `ReciboPage`, rota própria ou feature paralela.
- A ViewModel não deve acessar `BuildContext`.
- O número incremental deve considerar recibos persistidos e lidar com números antigos não numéricos.
- O objeto retornado por persistência deve ter `criadoEm` preenchido como `DateTime`.
- Não executar slices em paralelo.
- Não fazer commit.
