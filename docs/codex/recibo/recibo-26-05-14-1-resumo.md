# Resumo geral da tarefa

## Tarefa solicitada
- Planejar a feature de recibo para Flutter Desktop.
- Usar `lib/resources/recibo.png` como referência do formulário editável.
- Usar `lib/resources/visualizacao.png` como referência da visualização final do recibo.
- Persistir o histórico de recibos com SQLite embarcado.
- Criar slices adequados para um orquestrador iniciar, executar, finalizar e limpar contexto a cada slice.

## Arquivos de prompt criados
- `docs/codex/recibo/recibo-26-05-14-1-analise.md`
- `docs/codex/recibo/recibo-26-05-14-1.md`
- `docs/codex/recibo/recibo-26-05-14-1-parte_1.md`
- `docs/codex/recibo/recibo-26-05-14-1-parte_2.md`
- `docs/codex/recibo/recibo-26-05-14-1-parte_3.md`
- `docs/codex/recibo/recibo-26-05-14-1-parte_4.md`
- `docs/codex/recibo/recibo-26-05-14-1-parte_5.md`
- `docs/codex/recibo/recibo-26-05-14-1-parte_6.md`
- `docs/codex/recibo/recibo-26-05-14-1-parte_7.md`
- `docs/codex/recibo/recibo-26-05-14-1-parte_8.md`
- `docs/codex/recibo/recibo-26-05-14-1-parte_9.md`
- `docs/codex/recibo/recibo-26-05-14-1-resumo.md`

## Lista de slices
1. `recibo-26-05-14-1-parte_1.md` - Base da feature e entrada do app.
2. `recibo-26-05-14-1-parte_2.md` - Domínio e cálculos.
3. `recibo-26-05-14-1-parte_3.md` - SQLite embarcado desktop.
4. `recibo-26-05-14-1-parte_4.md` - Repository SQLite e histórico.
5. `recibo-26-05-14-1-parte_5.md` - ViewModel da tela.
6. `recibo-26-05-14-1-parte_6.md` - Formulário e tabela de produtos.
7. `recibo-26-05-14-1-parte_7.md` - Visualização do recibo.
8. `recibo-26-05-14-1-parte_8.md` - Histórico e ações da tela.
9. `recibo-26-05-14-1-parte_9.md` - Fechamento, desktop e validação final.

## Ordem correta de execução
1. Executar `docs/codex/recibo/recibo-26-05-14-1-parte_1.md`.
2. Aguardar a criação de `docs/codex/recibo/recibo-26-05-14-1-parte_1-resumo.md`.
3. Encerrar a sessão do slice 1.
4. Abrir nova sessão limpa na raiz do projeto.
5. Executar `docs/codex/recibo/recibo-26-05-14-1-parte_2.md`.
6. Repetir o ciclo até o slice 9.
7. Nunca executar slices em paralelo.
8. Nunca avançar sem resumo válido do slice anterior.

## Validações esperadas
- `flutter analyze`
- `flutter test`
- `flutter test test/features/recibo/domain/models/recibo_test.dart`
- `flutter test test/features/recibo/data/datasources/recibo_database_test.dart`
- `flutter test test/features/recibo/data/repositories/recibo_repository_sqlite_test.dart`
- `flutter test test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`
- `flutter test test/features/recibo/presentation/widgets/recibo_page_test.dart`
- `flutter test test/features/recibo/presentation/widgets/visualizacao_recibo_test.dart`

## Contratos de tela criados, atualizados ou revisados
- Atualizado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Nenhum contrato adicional foi criado, porque o histórico foi planejado como painel/dialog/widget dentro da `ReciboPage`.
- Se algum slice criar uma nova Page/View/Tela, ele deve criar o respectivo `[nome-da-tela]-contrato.md`.

## Observações importantes para continuidade
- O worktree atual ainda contém o template Flutter; o slice 1 deve migrar a entrada do app.
- A feature deve persistir histórico com SQLite embarcado compatível com Flutter Desktop.
- Valores monetários devem ser persistidos como centavos inteiros.
- Datas devem ser persistidas em ISO-8601 e exibidas no formato brasileiro.
- O formulário editável e a visualização devem usar a mesma fonte de dados.
- O primeiro arquivo a executar é `docs/codex/recibo/recibo-26-05-14-1-parte_1.md`.
- O orquestrador deve limpar contexto entre slices, conforme `docs/codex/orquestrador.md`.
