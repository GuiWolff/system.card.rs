# Análise da tarefa

## Pedido original
- Ajustar o fluxo de recibos para que o número do recibo seja incremental.
- Garantir que o objeto persistido tenha `DateTime` de data de criação.

## Feature correspondente
- Feature real: `pedido_page`.
- Caminho provável: `lib/features/pedido_page/`.
- Justificativa: o recibo, seu formulário, histórico, ViewModel e persistência SQLite já estão concentrados na composição da `PedidoPage`; não deve ser criada `ReciboPage` ou estrutura paralela.

## Arquivos relacionados
- Produção:
  - `lib/features/pedido_page/domain/models/recibo.dart`
  - `lib/features/pedido_page/domain/repositories/recibo_repository.dart`
  - `lib/features/pedido_page/data/datasources/recibo_database.dart`
  - `lib/features/pedido_page/data/dtos/recibo_dto.dart`
  - `lib/features/pedido_page/data/repositories/recibo_repository_sqlite.dart`
  - `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
  - `lib/features/pedido_page/presentation/widgets/historico_recibos_painel.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Testes:
  - `test/features/pedido_page/domain/models/recibo_test.dart`
  - `test/features/pedido_page/data/datasources/recibo_database_test.dart`
  - `test/features/pedido_page/data/repositories/recibo_repository_sqlite_test.dart`
  - `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
  - `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
  - `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Estado atual
- `Recibo` possui `numero` obrigatório, porém o número começa vazio no recibo novo criado pela `PedidoPageViewModel`.
- O formulário permite edição manual do número do recibo.
- `Recibo.validar()` exige número preenchido antes de salvar.
- `Recibo` já possui `criadoEm`, mas esse campo é opcional no domínio.
- `ReciboDto` persiste `criado_em` como texto ISO-8601 e reconstrói `DateTime` ao carregar.
- `ReciboRepositorySqlite.salvar` define `criadoEm` com `DateTime.now()` quando o recibo ainda não possui data de criação.
- `ReciboRepositorySqlite.atualizar` preserva `criadoEm` existente, usando o valor já salvo quando necessário.
- Não existe regra central para gerar próximo número de recibo.
- O índice atual `idx_recibos_numero` não garante unicidade.
- Como o número é livre, dados antigos podem conter números não numéricos, como recibos duplicados com sufixo textual.

## Estado esperado
- Recibos novos devem receber número incremental automaticamente.
- A regra de incremento deve usar os recibos já persistidos como fonte de verdade.
- O número incremental deve ter formato estável e previsível, preferencialmente com preenchimento à esquerda, preservando o padrão visual já usado nos testes, como `0001`, `0002`, `0003`.
- O usuário não deve precisar digitar manualmente o número para criar um recibo novo.
- A ViewModel deve expor recibo novo já preparado com o próximo número quando houver repository configurado.
- Ao iniciar novo recibo, o próximo número deve ser recalculado a partir do banco.
- Ao salvar um recibo novo, a persistência deve garantir `criadoEm` não nulo no objeto retornado.
- Ao atualizar recibo existente, `criadoEm` deve ser preservado.
- Recibos carregados do histórico devem continuar trazendo `criadoEm` como `DateTime`.
- Dados antigos com `criado_em` no banco devem continuar compatíveis.

## Riscos e dependências
- A ViewModel hoje cria recibo inicial de forma síncrona; carregar próximo número a partir do SQLite exige operação assíncrona.
- Adicionar método ao `ReciboRepository` altera contrato público da feature e exigirá atualização dos fakes em testes.
- Números antigos podem não ser puramente numéricos; a query de próximo número deve considerar apenas valores numéricos válidos ou tratar conversão com cuidado.
- Se a UI permitir edição manual do número, o comportamento incremental pode ficar inconsistente; o slice de UI deve decidir se o campo fica somente leitura ou se mantém edição controlada.
- Se houver múltiplos salvamentos simultâneos, a geração do número precisa ser feita dentro do fluxo transacional de inserção ou protegida por validação suficiente para reduzir duplicidade.
- Tornar `criadoEm` obrigatório no construtor de `Recibo` pode ter impacto alto nos testes e no fluxo de edição; a mudança deve ser avaliada com cuidado. O requisito mínimo é que o objeto persistido e retornado pelo repository tenha `DateTime` de criação.

## Contratos de tela
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md` apenas como referência legada.
- Contratos que precisam ser criados:
  - Nenhum.
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Impacto em UI:
  - Há impacto direto no formulário do recibo, pois o número deixa de ser um dado essencialmente manual e passa a ser gerado incrementalmente pelo fluxo da `PedidoPage`.

## Estratégia
- Primeiro consolidar a regra de número incremental e a garantia de `criadoEm` na camada de domínio/repository, mantendo widgets fora do banco.
- Depois conectar a regra à `PedidoPageViewModel` e à UI, preservando `Rx`/`Obx`, evitando `BuildContext` na ViewModel e atualizando testes de fluxo.
- Preservar compatibilidade com recibos existentes, inclusive números antigos digitados manualmente.

## Decisão sobre slices
- Haverá 2 slices.
- Motivo: a tarefa cruza persistência SQLite/repository, contrato de domínio, estado assíncrono da ViewModel e comportamento visual do formulário. Separar dados e UI reduz risco de regressão e permite validações intermediárias.

## Validações recomendadas
- `flutter analyze`
- `flutter test test/features/pedido_page/data/repositories/recibo_repository_sqlite_test.dart`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test` no fechamento.
