# Resumo - Usabilidade 2026-05-15 - Parte 1/3

## Slice executado
- `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_1.md`

## O que foi feito
- Estabilizadas as chaves dos campos editáveis em `ReciboFormulario`, `ProdutosServicosTabela` e `ResumoPedido`.
- Removida a dependência de texto digitado, quantidade, valor formatado ou centavos nas chaves dos campos.
- Adicionado estado local de apresentação com `TextEditingController` e `FocusNode` para preservar foco durante reconstruções reativas.
- Sincronização de valor externo ajustada para não sobrescrever texto enquanto o campo está com foco.
- Testes atualizados para usar chaves estáveis.
- Adicionados testes cobrindo foco preservado no formulário, na tabela de produtos/serviços e no resumo financeiro.

## Arquivos alterados
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
- `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Impacto em UI
- Sim. O comportamento interativo dos campos editáveis da `PedidoPage` foi alterado para manter foco durante digitação.
- O contrato revisado foi `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Não foi criada nova Page/View/Tela.

## Validações executadas
- `flutter analyze` passou.
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart` passou.
- `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart` passou.
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart` passou.
- `flutter test test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart` passou.

## Continuidade
- Próximo slice: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_2.md`.
- A parte 2 deve implementar adicionar item por Enter no campo `Valor unitário` com guarda para valor unitário zero.
- A parte 2 deve preservar os controladores locais e chaves estáveis criados nesta parte.
