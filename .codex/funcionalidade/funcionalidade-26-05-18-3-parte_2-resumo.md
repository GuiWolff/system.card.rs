# Resumo do Slice 2/5 - Remoção do último item acidental

## O que foi feito
- Adicionada normalização em `PedidoPageViewModel.salvarRecibo()` antes da validação de domínio e da persistência.
- Criado helper privado `_normalizarReciboParaSalvar` para remover somente o último item quando:
  - `descricao.trim().isEmpty`;
  - `valorUnitarioCentavos == 0`.
- O estado `reciboEmEdicao` passa a refletir a remoção antes de salvar, mantendo a UI sincronizada com o recibo persistido.
- A persistência usa o recibo normalizado, sem alterar repository, DTOs ou schema SQLite.
- Adicionados testes de ViewModel para:
  - salvar removendo o último item vazio com valor zero;
  - preservar a ordem dos itens remanescentes;
  - não remover item intermediário vazio;
  - não remover último item quando ele tem descrição preenchida;
  - não remover último item quando ele tem valor maior que zero.

## Próximos pontos
- Slice 3/5: adicionar pesquisa de clientes durante a digitação no campo `Cliente`, com sugestões estilo combobox.
- Preservar a seleção de cliente existente da `PedidoPageViewModel` e o painel `ClientesPainel`.

## Impacto em UI
- Não houve alteração visual de layout ou tema.
- Há impacto de fluxo: o salvamento deixa de ser bloqueado quando o único problema é um último item acidental vazio com valor `0,00`.
- Itens intermediários ou últimos itens parcialmente preenchidos continuam exibindo os erros de validação existentes.

## Contrato
- Atualizado `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Justificativa: o slice altera comportamento observável do fluxo de salvamento da `PedidoPage`.

## Regras, skills e referências lidas
- `AGENTS.md`
- `.codex/rules/RULE.md`
- `.codex/skills/argo-flutter-dev/SKILL.md`
- `.codex/skills/argo-flutter-dev/references/tema.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-analise.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_1-resumo.md`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_2.md`

## Validações executadas
- `dart format lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter analyze`

## Bloqueios
- Nenhum bloqueio encontrado.
